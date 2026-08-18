local M = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local CREATURES = {Terrorshark = true, Piranha = true, Shark = true}
local SHIPS = {PirateBrigade = true, PirateGrandBrigade = true, FishBoat = true}
local OFFSETS = {
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

local function equipSelected(character)
    if not character then return end
    local player = Players.LocalPlayer
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    for _, container in ipairs({character, player:FindFirstChild("Backpack")}) do
        for _, tool in ipairs(container and container:GetChildren() or {}) do
            if tool:IsA("Tool") and (tool.ToolTip == "Melee"
            or tool:GetAttribute("WeaponType") == "Melee") then
                if humanoid and tool.Parent ~= character then humanoid:EquipTool(tool) end
                return tool
            end
        end
    end
end

local function bringSameGroup(model, position, distance)
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return end
    for _, enemy in ipairs(enemies:GetChildren()) do
        if enemy ~= model and enemy.Name == model.Name then
            local root = enemy:FindFirstChild("HumanoidRootPart")
            local humanoid = enemy:FindFirstChildOfClass("Humanoid")
            if root and humanoid and humanoid.Health > 0
            and (root.Position - position.Position).Magnitude <= distance then
                root.CFrame = position
                root.Size = Vector3.new(1, 1, 1)
                root.CanCollide = false
                humanoid.WalkSpeed = 0
            end
        end
    end
end

function M.Combat(eventKey, model, context)
    local player = Players.LocalPlayer
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local characterRoot = character and character:FindFirstChild("HumanoidRootPart")
    if not characterRoot or not humanoid or not model then return false end
    humanoid.Sit = false

    local started = os.clock()
    while context.Running() and alive(model) and os.clock() - started < 180 do
        character = player.Character
        humanoid = character and character:FindFirstChildOfClass("Humanoid")
        characterRoot = character and character:FindFirstChild("HumanoidRootPart")
        if not characterRoot or not humanoid then break end
        humanoid.Sit = false
        autoHaki(character)

        if CREATURES[eventKey] then
            local root = model:FindFirstChild("HumanoidRootPart")
            local enemyHumanoid = model:FindFirstChildOfClass("Humanoid")
            if not root or not enemyHumanoid then break end

            equipSelected(character)
            root.CanCollide = false
            root.Size = Vector3.new(60, 60, 60)
            enemyHumanoid.WalkSpeed = 0

            local offsetIndex = math.floor(os.clock() / 0.2) % #OFFSETS + 1
            characterRoot.CFrame = root.CFrame * OFFSETS[offsetIndex]
            characterRoot.AssemblyLinearVelocity = Vector3.zero
            characterRoot.AssemblyAngularVelocity = Vector3.zero

            -- Bring Mob Normal do Banana: 250 studs, somente mesmo tipo.
            bringSameGroup(model, root.CFrame, 250)

            local fast = getgenv().IKARO_BANANA_COMBAT
            if fast then fast.SeaCreatureAttack(model, character, characterRoot) end
        elseif SHIPS[eventKey] then
            local engine = model:FindFirstChild("Engine", true)
                or model:FindFirstChild("VehicleSeat", true)
                or model.PrimaryPart
            if not engine then break end
            characterRoot.CFrame = engine.CFrame * CFrame.new(0, -20, 0)
            characterRoot.AssemblyLinearVelocity = Vector3.zero
            context.UseSkills(engine)
        else
            local target = context.TargetPart(model)
            if not target then break end
            characterRoot.CFrame = target.CFrame * CFrame.new(0, 40, 0)
            context.UseSkills(target)
        end

        task.wait(0.03)
    end
    return not alive(model)
end

return M
