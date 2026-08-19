-- Modelo de Sea Events portado diretamente do Banana Hub.
local M = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CREATURES = {Terrorshark = true, Piranha = true, Shark = true}
local SHIPS = {PirateBrigade = true, PirateGrandBrigade = true, FishBoat = true}
local POSITIONS = {
    CFrame.new(0, 40, 0), CFrame.new(-40, 40, 0), CFrame.new(40, 40, 0),
    CFrame.new(0, 40, 40), CFrame.new(0, 40, -40)
}

local function alive(model)
    if not model or not model.Parent then return false end
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid then return humanoid.Health > 0 end
    local health = model:FindFirstChild("Health", true)
    return not health or health.Value > 0
end

local function autoHaki(character)
    if character and not character:FindFirstChild("HasBuso") then
        pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso") end)
    end
end

local function equipBananaWeapon(character, context)
    local requested
    if context.EquipWeapon then
        local ok, tool = pcall(context.EquipWeapon)
        if ok and typeof(tool) == "Instance" and tool:IsA("Tool") then
            requested = tool
        end
    end
    local player = Players.LocalPlayer
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    -- EquipTool replica de forma assíncrona. Só devolvemos a ferramenta que já
    -- está no Character, pois Tool:Activate em uma Tool no Backpack não ataca.
    local equipped = character and character:FindFirstChildOfClass("Tool")
    if equipped then return equipped end
    if requested and requested.Parent ~= character and humanoid then
        pcall(function() humanoid:EquipTool(requested) end)
    end
    equipped = character and character:FindFirstChildOfClass("Tool")
    if equipped then return equipped end
    for _, container in ipairs({character, player:FindFirstChild("Backpack")}) do
        for _, tool in ipairs(container and container:GetChildren() or {}) do
            if tool:IsA("Tool") and tool.ToolTip == "Melee" then
                if humanoid and tool.Parent ~= character then humanoid:EquipTool(tool) end
                return character:FindFirstChildOfClass("Tool")
            end
        end
    end
    return character and character:FindFirstChildOfClass("Tool")
end

local function attackNoCooldown(model, character, root)
    local combat = getgenv().IKARO_BANANA_COMBAT
    return combat and combat.SeaCreatureAttack(model, character, root) or false
end

local function targetPart(model)
    return model and (model:FindFirstChild("HumanoidRootPart")
        or model:FindFirstChild("Engine", true)
        or model:FindFirstChild("VehicleSeat", true)
        or model.PrimaryPart
        or model:FindFirstChildWhichIsA("BasePart", true))
end

function M.Combat(eventKey, eventModel, context)
    if not eventModel or not context then return false end
    local player = Players.LocalPlayer
    local started = os.clock()
    local nextToolAttack = 0
    while context.Running() and alive(eventModel) and os.clock() - started < 180 do
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if not character or not humanoid or not root or humanoid.Health <= 0 then break end
        humanoid.Sit = false
        autoHaki(character)

        if CREATURES[eventKey] then
            local enemyRoot = eventModel:FindFirstChild("HumanoidRootPart")
            local enemyHumanoid = eventModel:FindFirstChildOfClass("Humanoid")
            if not enemyRoot or not enemyHumanoid then break end
            local tool = equipBananaWeapon(character, context)
            local isShark = eventKey == "Shark" or eventKey == "Terrorshark"
            local hitPart = eventModel:FindFirstChild("Head", true) or enemyRoot

            if isShark then
                -- O trace confirmou RegisterAttack legítimo, mas nenhum
                -- RegisterHit a 40 studs. Para Shark/Terrorshark o detector do
                -- M1 precisa tocar a peça real; não usamos hitbox artificial.
                enemyRoot.CanCollide = false
                hitPart.CanCollide = false
                local desired = Vector3.new(
                    hitPart.Position.X,
                    hitPart.Position.Y + 8,
                    hitPart.Position.Z
                )
                root.CFrame = CFrame.lookAt(desired, hitPart.Position)
            else
                -- Mantém o comportamento já validado para grupos de Piranhas.
                enemyRoot.CanCollide = false
                enemyRoot.Size = Vector3.new(60, 60, 60)
                enemyHumanoid.WalkSpeed = 0
                local index = math.floor((os.clock() - started) / 0.2) % #POSITIONS + 1
                root.CFrame = enemyRoot.CFrame * POSITIONS[index]
            end
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero

            local now = os.clock()
            if isShark then
                -- Cria primeiro o estado legítimo de M1; o próprio jogo gera o
                -- RegisterHit observado no Banana.
                if tool and now >= nextToolAttack then
                    nextToolAttack = now + 0.12
                    pcall(function()
                        tool:Activate()
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.delay(0.035, function()
                            pcall(function()
                                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                            end)
                        end)
                    end)
                end
                -- Sem fallback manual neste teste: o rastreador deve mostrar
                -- somente os pacotes realmente produzidos pelo M1 equipado.
            else
                attackNoCooldown(eventModel, character, root)
            end
        elseif SHIPS[eventKey] then
            local engine = eventModel:FindFirstChild("Engine", true)
                or eventModel:FindFirstChild("VehicleSeat", true) or eventModel.PrimaryPart
            if not engine then break end
            root.CFrame = engine.CFrame * CFrame.new(0, -20, 0)
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
            if context.AimAt then context.AimAt(engine) end
            if context.UseSkills then context.UseSkills(engine) end
        else
            local target = targetPart(eventModel)
            if not target then break end
            root.CFrame = target.CFrame * CFrame.new(0, 40, 0)
            root.AssemblyLinearVelocity = Vector3.zero
            if context.AimAt then context.AimAt(target) end
            if context.UseSkills then context.UseSkills(target) end
        end
        task.wait(CREATURES[eventKey] and 0.03 or 0.05)
    end
    return not alive(eventModel)
end

return M
