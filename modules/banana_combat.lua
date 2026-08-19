local M = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local function equipMelee(character)
    if not character then return nil end
    for _, tool in ipairs(character:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == "Melee" then return tool end
    end
    local player = Players.LocalPlayer
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    for _, tool in ipairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.ToolTip == "Melee" then
            if humanoid then humanoid:EquipTool(tool) end
            return tool
        end
    end
end

function M.SeaCreatureAttack(eventModel, character, root)
    if not character or not root then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not character:FindFirstChild("HasBuso") then
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
        end)
    end
    -- O Banana tenta equipar, mas não bloqueia RegisterHit quando o ToolTip
    -- ainda não replicou ou está traduzido no executor.
    equipMelee(character)

    local net = ReplicatedStorage:FindFirstChild("Modules")
    net = net and net:FindFirstChild("Net")
    local registerAttack = net and net:FindFirstChild("RE/RegisterAttack")
    local registerHit = net and net:FindFirstChild("RE/RegisterHit")
    local enemies = Workspace:FindFirstChild("Enemies")
    if not registerAttack or not registerHit or not enemies then return false end

    local targets, lastHitPart, included = {}, nil, {}
    for _, enemy in ipairs(enemies:GetChildren()) do
        local enemyHumanoid = enemy:FindFirstChildOfClass("Humanoid")
        local head = enemy:FindFirstChild("Head")
            or enemy:FindFirstChild("HumanoidRootPart")
            or enemy:FindFirstChildWhichIsA("BasePart", true)
        if (enemy == eventModel or not enemy:GetAttribute("IsBoat")) and enemy ~= character
        and enemyHumanoid and enemyHumanoid.Health > 0 and head
        and (root.Position - head.Position).Magnitude <= 60 then
            targets[#targets + 1] = {enemy, head}
            included[enemy] = true
            -- FindEnemiesInRange do Banana sobrescreve o retorno a cada alvo;
            -- portanto RegisterHit recebe a última peça válida, não a primeira.
            lastHitPart = head
        end
    end

    if eventModel and eventModel.Parent then
        local eventRoot = eventModel:FindFirstChild("HumanoidRootPart", true)
        local eventHumanoid = eventModel:FindFirstChildWhichIsA("Humanoid", true)
		local eventHitPart = eventModel:FindFirstChild("Head", true)
			or eventRoot
			or eventModel:FindFirstChildWhichIsA("BasePart", true)
        local lowerEventName = string.lower(eventModel.Name)
        local isTerror = string.find(lowerEventName, "terror", 1, true) ~= nil
        local isShark = string.find(lowerEventName, "shark", 1, true) ~= nil
        if eventRoot then
            eventRoot.CanCollide = false
            eventRoot.Size = Vector3.new(60, 60, 60)
        end
        if eventHumanoid then eventHumanoid.WalkSpeed = 0 end
		-- Shark/Terrorshark podem estar em um Model aninhado que não aparece em
		-- Workspace.Enemies:GetChildren(). O Banana moderno mantém o alvo atual
		-- no pacote mesmo nessa situação.
		if eventHitPart and eventHumanoid and eventHumanoid.Health > 0
		and not included[eventModel]
		and (root.Position - eventHitPart.Position).Magnitude <= 65 then
			targets[#targets + 1] = {eventModel, eventHitPart}
			lastHitPart = eventHitPart
		end
    end

    if not lastHitPart then return false end
    return pcall(function()
        registerAttack:FireServer(1e-9)
        registerHit:FireServer(lastHitPart, targets)
    end)
end

function M.GetShipAim(eventModel, fallback)
    if not eventModel then return fallback end
    return eventModel:FindFirstChild("Engine", true)
        or eventModel:FindFirstChild("VehicleSeat", true)
        or fallback
end

local redzRemote, redzRemoteId = nil, nil

local function findRedzRemote()
    if redzRemote and redzRemote.Parent and redzRemoteId then return redzRemote, redzRemoteId end
    for _, containerName in ipairs({"Util", "Common", "Remotes", "Assets", "FX"}) do
        local container = ReplicatedStorage:FindFirstChild(containerName)
        for _, remote in ipairs(container and container:GetChildren() or {}) do
            if remote:IsA("RemoteEvent") and remote:GetAttribute("Id") then
                redzRemote, redzRemoteId = remote, remote:GetAttribute("Id")
            end
        end
    end
    return redzRemote, redzRemoteId
end

function M.RedzModernAttack(character, root, preferredModel)
    if not character or not root then return false end
    local tool = character:FindFirstChildOfClass("Tool")
    if not tool or (tool:GetAttribute("WeaponType") ~= "Melee"
    and tool:GetAttribute("WeaponType") ~= "Sword") then
        equipMelee(character)
        tool = character:FindFirstChildOfClass("Tool")
    end
    if not tool then return false end

    local targets = {}
    local preferredHead = nil
    for _, container in ipairs({Workspace:FindFirstChild("Enemies"), Workspace:FindFirstChild("Characters")}) do
        for _, model in ipairs(container and container:GetChildren() or {}) do
            local modelRoot = model:FindFirstChild("HumanoidRootPart")
            local humanoid = model:FindFirstChild("Humanoid")
            if model ~= character and modelRoot and humanoid and humanoid.Health > 0
            and (modelRoot.Position - root.Position).Magnitude <= 60 then
                for _, part in ipairs(model:GetChildren()) do
                    if part:IsA("BasePart") then targets[#targets + 1] = {model, part} end
                end
                if model == preferredModel then
                    preferredHead = model:FindFirstChild("Head")
                        or model:FindFirstChild("HumanoidRootPart")
                end
            end
        end
    end
    if #targets == 0 then return false end

    local head = preferredHead
        or targets[1][1]:FindFirstChild("Head")
        or targets[1][1]:FindFirstChild("HumanoidRootPart")
    if not head then return false end
    return pcall(function()
        local net = require(ReplicatedStorage.Modules.Net)
        net:RemoteEvent("RegisterHit", true)
        ReplicatedStorage.Modules.Net["RE/RegisterAttack"]:FireServer()
        ReplicatedStorage.Modules.Net["RE/RegisterHit"]:FireServer(
            head, targets, {},
            tostring(Players.LocalPlayer.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15)
        )

        local remote, remoteId = findRedzRemote()
        local seed = ReplicatedStorage.Modules.Net:FindFirstChild("seed")
        if remote and remoteId and seed and type(cloneref) == "function" then
            cloneref(remote):FireServer(
                string.gsub("RE/RegisterHit", ".", function(char)
                    return string.char(bit32.bxor(string.byte(char), math.floor(Workspace:GetServerTimeNow() / 10 % 10) + 1))
                end),
                bit32.bxor(remoteId + 909090, seed:InvokeServer() * 2),
                head, targets
            )
        end
    end)
end


M.RedzTerrorAttack = M.RedzModernAttack

return M
