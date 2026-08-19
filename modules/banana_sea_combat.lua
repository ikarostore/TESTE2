-- IKARO Sea Events: controlador unificado baseado no pipeline Nox.
local M = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local CREATURES = {Terrorshark = true, Piranha = true, Shark = true}
local SHIPS = {PirateBrigade = true, PirateGrandBrigade = true, FishBoat = true}

local net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
local registerAttack = net:WaitForChild("RE/RegisterAttack")
local registerHit = net:WaitForChild("RE/RegisterHit")

local function alive(model)
    if not model or not model.Parent then return false end
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid then return humanoid.Health > 0 end
    local health = model:FindFirstChild("Health", true)
    return not health or health.Value > 0
end

local function autoHaki(character)
    if character and not character:FindFirstChild("HasBuso") then
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
        end)
    end
end

local function equipWeapon(character, context)
    if context.EquipWeapon then pcall(context.EquipWeapon) end
    return character and character:FindFirstChildOfClass("Tool")
end

local function applyCharacterNoclip(character, cache)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            if cache[part] == nil then cache[part] = part.CanCollide end
            part.CanCollide = false
        end
    end
end

local function restoreCharacterNoclip(cache)
    for part, oldCanCollide in pairs(cache) do
        if part and part.Parent then
            pcall(function() part.CanCollide = oldCanCollide end)
        end
    end
end

-- O rastreamento do cliente que realmente causa dano usa um unico estado de
-- ataque e Head como alvo primario. Disparar 0/1/2/3 em sequencia faz o
-- servidor receber os remotes, mas rejeitar o golpe.
local function verifiedFastAttack(eventModel, playerRoot)
    local primary = eventModel and (eventModel:FindFirstChild("Head", true)
        or eventModel:FindFirstChild("HumanoidRootPart", true))
    if not primary or not playerRoot then return false end
    if (primary.Position - playerRoot.Position).Magnitude >= 60 then return false end

    -- O pacote que o servidor aceitou nos rastreamentos inclui o proprio
    -- alvo principal novamente como {Model, HitPart} no segundo argumento.
    local secondary = {{eventModel, primary}}
    local enemies = Workspace:FindFirstChild("Enemies")
    for _, enemy in ipairs(enemies and enemies:GetChildren() or {}) do
        if enemy ~= eventModel and enemy.Name == eventModel.Name and not enemy:GetAttribute("IsBoat") then
            local humanoid = enemy:FindFirstChildOfClass("Humanoid")
            local enemyHitPart = enemy:FindFirstChild("Head", true)
                or enemy:FindFirstChild("HumanoidRootPart", true)
            if humanoid and humanoid.Health > 0 and enemyHitPart
            and (enemyHitPart.Position - playerRoot.Position).Magnitude < 60 then
                secondary[#secondary + 1] = {enemy, enemyHitPart}
            end
        end
    end

    return pcall(function()
        registerAttack:FireServer(1e-9)
        registerHit:FireServer(primary, secondary)
    end)
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
    local collisionCache = {}
    local creatureSafeY = nil
    local nextCreatureAttack = 0
    local shipSkillsBusy = false
    local shipAimPart = nil
    local shipAimConnection = nil
    local activeShipEngine = nil

    local function cleanup()
        if shipAimConnection then shipAimConnection:Disconnect() end
        if shipAimPart then pcall(function() shipAimPart:Destroy() end) end
        restoreCharacterNoclip(collisionCache)
    end

    local okLoop, loopError = pcall(function()
        while context.Running() and alive(eventModel) and os.clock() - started < 180 do
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if not character or not humanoid or not root or humanoid.Health <= 0 then break end

            local panicFraction = context.PanicHealthFraction
                and context.PanicHealthFraction() or 0.40
            if eventKey == "Terrorshark" then
                panicFraction = math.max(panicFraction, 0.65)
            end
            if humanoid.Health / math.max(humanoid.MaxHealth, 1) <= panicFraction then
                if context.EmergencyEscape then pcall(context.EmergencyEscape) end
                break
            end

            humanoid.Sit = false
            autoHaki(character)
            applyCharacterNoclip(character, collisionCache)

            if CREATURES[eventKey] then
                local enemyRoot = eventModel:FindFirstChild("HumanoidRootPart", true)
                local enemyHumanoid = eventModel:FindFirstChildOfClass("Humanoid")
                if not enemyRoot or not enemyHumanoid or enemyHumanoid.Health <= 0 then break end
                equipWeapon(character, context)

                -- Nox usa +60 no Terror. Usamos 55 para respeitar o filtro
                -- estrito <60. Nos demais, Y fixo evita acompanhar mergulhos.
                if not creatureSafeY then
                    local terror = eventKey == "Terrorshark"
                    local desiredOffset = terror and 54 or 35
                    local minimumY = terror and 45 or 35
                    creatureSafeY = math.max(enemyRoot.Position.Y + desiredOffset, minimumY)
                    creatureSafeY = math.min(creatureSafeY, enemyRoot.Position.Y + 55)
                end
                local desired = Vector3.new(enemyRoot.Position.X, creatureSafeY, enemyRoot.Position.Z)
                root.CFrame = CFrame.lookAt(desired, enemyRoot.Position)
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero

                local now = os.clock()
                if now >= nextCreatureAttack then
                    nextCreatureAttack = now + 0.12
                    verifiedFastAttack(eventModel, root)
                end
                task.wait(0.03)

            elseif SHIPS[eventKey] then
                local engine = eventModel:FindFirstChild("Engine", true)
                    or eventModel:FindFirstChild("VehicleSeat", true)
                    or eventModel.PrimaryPart
                if not engine then break end
                activeShipEngine = engine

                if not shipAimPart then
                    shipAimPart = Instance.new("Part")
                    shipAimPart.Name = "IKARO_NoxShipAim"
                    shipAimPart.Anchored = true
                    shipAimPart.CanCollide = false
                    shipAimPart.CanTouch = false
                    shipAimPart.CanQuery = false
                    shipAimPart.Transparency = 1
                    shipAimPart.Size = Vector3.new(1, 1, 1)
                    shipAimPart.Parent = Workspace
                    shipAimConnection = RunService.Heartbeat:Connect(function()
                        if shipAimPart and shipAimPart.Parent
                        and activeShipEngine and activeShipEngine.Parent then
                            shipAimPart.CFrame = activeShipEngine.CFrame * CFrame.new(0, -15, 0)
                        end
                    end)
                end

                -- Nox fica no Engine e mira 15 studs abaixo. O noclip integral
                -- impede o corpo de transferir força ao casco.
                root.CFrame = engine.CFrame
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                shipAimPart.CFrame = engine.CFrame * CFrame.new(0, -15, 0)
                if context.AimAt then context.AimAt(shipAimPart) end
                if context.UseSkills and not shipSkillsBusy then
                    shipSkillsBusy = true
                    task.spawn(function()
                        pcall(context.UseSkills, shipAimPart)
                        shipSkillsBusy = false
                    end)
                end
                task.wait(0.03)

            else
                local target = targetPart(eventModel)
                if not target then break end
                root.CFrame = target.CFrame * CFrame.new(0, 40, 0)
                root.AssemblyLinearVelocity = Vector3.zero
                if context.AimAt then context.AimAt(target) end
                if context.UseSkills then context.UseSkills(target) end
                task.wait(0.05)
            end
        end
    end)

    cleanup()
    if not okLoop then error(loopError) end
    return not alive(eventModel)
end

return M
