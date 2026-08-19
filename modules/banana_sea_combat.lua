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
    local shipCollisionCache = {}
    local nextSharkM1 = 0
    while context.Running() and alive(eventModel) and os.clock() - started < 180 do
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if not character or not humanoid or not root or humanoid.Health <= 0 then break end

        -- Sobrevivência tem prioridade absoluta. O Terrorshark causa dano em
        -- rajadas; esperar apenas HealthChanged pode permitir que o loop de
        -- FastAttack execute novamente antes do Teleport Y assumir controle.
        local panicFraction = context.PanicHealthFraction
            and context.PanicHealthFraction() or 0.40
        if eventKey == "Terrorshark" then
            panicFraction = math.max(panicFraction, 0.65)
        end
        if humanoid.Health / math.max(humanoid.MaxHealth, 1) <= panicFraction then
            if context.EmergencyEscape then
                pcall(context.EmergencyEscape)
            end
            break
        end
        humanoid.Sit = false
        autoHaki(character)

        if CREATURES[eventKey] then
            local enemyRoot = eventModel:FindFirstChild("HumanoidRootPart")
            local enemyHumanoid = eventModel:FindFirstChildOfClass("Humanoid")
            if not enemyRoot or not enemyHumanoid then break end
            local equippedTool = equipBananaWeapon(character, context)
            enemyRoot.CanCollide = false
            enemyRoot.Size = Vector3.new(60, 60, 60)
            enemyHumanoid.WalkSpeed = 0
            if eventKey == "Shark" then
                -- O FastAttack de lista é rejeitado especificamente pelo Shark.
                -- M1 real a curta distância gera o token moderno aceito.
                local sharkHead = eventModel:FindFirstChild("Head", true) or enemyRoot
                root.CFrame = CFrame.lookAt(
                    sharkHead.Position + Vector3.new(0, 8, 0),
                    sharkHead.Position
                )
            elseif eventKey == "Piranha" then
                -- Ataca o grupo sem Bring Mob: prepara todas as Piranhas do
                -- mesmo spawn e posiciona a conta sobre o centro geométrico.
                -- AttackNoCoolDown inclui todas que ficarem no raio de 60.
                local enemies = workspace:FindFirstChild("Enemies")
                local group, center = {}, Vector3.zero
                for _, mob in ipairs(enemies and enemies:GetChildren() or {}) do
                    local mobHumanoid = mob:FindFirstChildOfClass("Humanoid")
                    local mobRoot = mob:FindFirstChild("HumanoidRootPart")
                    if mob.Name == "Piranha" and mobHumanoid and mobRoot
                    and mobHumanoid.Health > 0
                    and (mobRoot.Position - enemyRoot.Position).Magnitude <= 140 then
                        group[#group + 1] = mob
                        center = center + mobRoot.Position
                        mobRoot.CanCollide = false
                        mobRoot.Size = Vector3.new(60, 60, 60)
                        mobHumanoid.WalkSpeed = 0
                    end
                end
                if #group > 0 then
                    center = center / #group
                    root.CFrame = CFrame.lookAt(
                        center + Vector3.new(0, 20, 0),
                        center
                    )
                else
                    root.CFrame = enemyRoot.CFrame * CFrame.new(0, 20, 0)
                end
            else
                local index = math.floor((os.clock() - started) / 0.2) % #POSITIONS + 1
                root.CFrame = enemyRoot.CFrame * POSITIONS[index]
            end
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
            if eventKey == "Shark" then
                local now = os.clock()
                if equippedTool and equippedTool.Parent == character
                and now >= nextSharkM1 then
                    nextSharkM1 = now + 0.12
                    pcall(function()
                        equippedTool:Activate()
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.delay(0.035, function()
                            pcall(function()
                                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                            end)
                        end)
                    end)
                end
            else
                attackNoCooldown(eventModel, character, root)
            end
        elseif SHIPS[eventKey] then
            local engine = eventModel:FindFirstChild("Engine", true)
                or eventModel:FindFirstChild("VehicleSeat", true) or eventModel.PrimaryPart
            if not engine then break end
            -- Banana mantém noclip global durante _G.Ship. Sem isso, partes do
            -- corpo/acessórios encostam no casco e transferem força ao barco.
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    if shipCollisionCache[part] == nil then
                        shipCollisionCache[part] = part.CanCollide
                    end
                    part.CanCollide = false
                end
            end
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
        task.wait(eventKey == "Shark" and 0.03
            or eventKey == "Piranha" and 0.03
            or CREATURES[eventKey] and 1e-9
            or 0.05)
    end
    for part, oldCanCollide in pairs(shipCollisionCache) do
        if part and part.Parent then
            pcall(function()
                part.CanCollide = oldCanCollide
            end)
        end
    end
    return not alive(eventModel)
end

return M
