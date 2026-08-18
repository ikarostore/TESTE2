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
    if not equipMelee(character) then return false end

    local net = ReplicatedStorage:FindFirstChild("Modules")
    net = net and net:FindFirstChild("Net")
    local registerAttack = net and net:FindFirstChild("RE/RegisterAttack")
    local registerHit = net and net:FindFirstChild("RE/RegisterHit")
    local enemies = Workspace:FindFirstChild("Enemies")
    if not registerAttack or not registerHit or not enemies then return false end

    local targets, firstHead = {}, nil
    for _, enemy in ipairs(enemies:GetChildren()) do
        local enemyHumanoid = enemy:FindFirstChildOfClass("Humanoid")
        local head = enemy:FindFirstChild("Head")
        if not enemy:GetAttribute("IsBoat") and enemy ~= character
        and enemyHumanoid and enemyHumanoid.Health > 0 and head
        and (root.Position - head.Position).Magnitude <= 60 then
            targets[#targets + 1] = {enemy, head}
            firstHead = firstHead or head
        end
    end

    if eventModel and eventModel.Parent then
        local eventRoot = eventModel:FindFirstChild("HumanoidRootPart")
        local eventHumanoid = eventModel:FindFirstChildOfClass("Humanoid")
        if eventRoot then
            eventRoot.CanCollide = false
            eventRoot.Size = Vector3.new(60, 60, 60)
        end
        if eventHumanoid then eventHumanoid.WalkSpeed = 0 end
    end

    if not firstHead then return false end
    return pcall(function()
        registerAttack:FireServer(1e-9)
        registerHit:FireServer(firstHead, targets)
    end)
end

function M.GetShipAim(eventModel, fallback)
    if not eventModel then return fallback end
    return eventModel:FindFirstChild("Engine", true)
        or eventModel:FindFirstChild("VehicleSeat", true)
        or fallback
end

return M
