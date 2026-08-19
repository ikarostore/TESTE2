-- Modelo de Sea Events portado diretamente do Banana Hub.
local M = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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
    if context.EquipWeapon then
        local ok, tool = pcall(context.EquipWeapon)
        if ok and tool then return tool end
    end
    local player = Players.LocalPlayer
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    for _, container in ipairs({character, player:FindFirstChild("Backpack")}) do
        for _, tool in ipairs(container and container:GetChildren() or {}) do
            if tool:IsA("Tool") and tool.ToolTip == "Melee" then
                if humanoid and tool.Parent ~= character then humanoid:EquipTool(tool) end
                return tool
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
    local nextFallbackHit = 0
    local lastHealth = nil
    local lastDamageAt = started
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
                -- O rastreamento do Banana fica parado e perto do Head. Trocar
                -- offsets invalidava o alcance 3D e fazia o servidor descartar hits.
                local desired = hitPart.Position + Vector3.new(0, 16, 0)
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
                if lastHealth == nil or enemyHumanoid.Health < lastHealth then
                    lastDamageAt = now
                end
                lastHealth = enemyHumanoid.Health

                -- Cria primeiro o estado legítimo de M1; o próprio jogo gera o
                -- RegisterHit observado no Banana.
                if tool and now >= nextToolAttack then
                    nextToolAttack = now + 0.12
                    pcall(function() tool:Activate() end)
                end

                -- Só reproduz Head + {} quando o ataque real ficou mais de um
                -- segundo sem causar dano, com cadência limitada.
                if now - lastDamageAt >= 1.10 and now >= nextFallbackHit then
                    nextFallbackHit = now + 0.24
                    attackNoCooldown(eventModel, character, root)
                end
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
