local M = {}

M.Names = {
    Terrorshark = {"Terrorshark", "Terror Shark"}, Piranha = {"Piranha"},
    Shark = {"Shark"}, PirateBrigade = {"Pirate Brigade", "PirateBrigade"},
    PirateGrandBrigade = {"Pirate Grand Brigade", "PirateGrandBrigade"},
    FishBoat = {"Fish Boat", "FishBoat"},
    SeaBeast = {"SeaBeast1", "Sea Beast", "SeaBeast"}
}
M.Order = {"Terrorshark", "SeaBeast", "PirateGrandBrigade", "PirateBrigade", "FishBoat", "Shark", "Piranha"}

local function matches(name, variants, key)
    local lower = string.lower(name)
    if key == "Shark" and string.find(lower, "terrorshark", 1, true) then return false end
    for _, variant in ipairs(variants) do
        local candidate = string.lower(variant)
        if lower == candidate or string.find(lower, candidate, 1, true) then return true end
    end
    return false
end

local function excluded(model)
    if not model or not model.Parent then return true end
    local full, name = string.lower(model:GetFullName()), string.lower(model.Name)
    return string.find(name, "hunter", 1, true) or string.find(name, "dealer", 1, true)
        or string.find(name, "spy", 1, true) or string.find(full, "workspace.map", 1, true)
        or string.find(full, "workspace.npcs", 1, true) or string.find(full, "workspace.boats", 1, true)
        or string.find(full, "players.", 1, true)
end

local function nearby(model, root)
    if not root then return false end
    local ok, pivot = pcall(function() return model:GetPivot() end)
    return ok and (pivot.Position - root.Position).Magnitude <= 2500
end

function M.FindSelected(workspace, selected, root, state)
    -- Mantém todas as contas no mesmo alvo. A ordem de GetChildren varia entre
    -- clientes; ordenar pela prioridade e pela posição evita cada conta escolher
    -- um Sea Event diferente no mesmo grupo.
    local candidates = {}
    local seen = {}

    local function addCandidate(model, onlyKey)
        if not model or seen[model] or not model:IsA("Model")
        or excluded(model) or not nearby(model, root) or not M.Alive(model) then
            return
        end
        for priority, key in ipairs(M.Order) do
            if selected[key] and (not onlyKey or key == onlyKey)
            and matches(model.Name, M.Names[key], key) then
                local ok, pivot = pcall(function() return model:GetPivot() end)
                if ok then
                    seen[model] = true
                    table.insert(candidates, {
                        key = key, model = model, priority = priority,
                        x = math.floor(pivot.Position.X * 10 + 0.5),
                        y = math.floor(pivot.Position.Y * 10 + 0.5),
                        z = math.floor(pivot.Position.Z * 10 + 0.5)
                    })
                end
                return
            end
        end
    end

    local function scan(container, onlyKey)
        if not container then return end
        for _, model in ipairs(container:GetChildren()) do
            addCandidate(model, onlyKey)
        end
    end

    scan(workspace:FindFirstChild("Enemies"))
    scan(workspace:FindFirstChild("SeaBeasts"), "SeaBeast")
    if #candidates == 0 and os.clock() >= (state.NextGlobalEventScan or 0) then
        state.NextGlobalEventScan = os.clock() + 3
        for _, candidate in ipairs(workspace:GetDescendants()) do
            addCandidate(candidate)
        end
    end

    table.sort(candidates, function(a, b)
        if a.priority ~= b.priority then return a.priority < b.priority end
        if a.x ~= b.x then return a.x < b.x end
        if a.z ~= b.z then return a.z < b.z end
        if a.y ~= b.y then return a.y < b.y end
        return a.model.Name < b.model.Name
    end)
    local chosen = candidates[1]
    return chosen and chosen.key or nil, chosen and chosen.model or nil
end

function M.TargetPart(model)
    if not model then return nil end
    if model:IsA("BasePart") then return model end
    local preferred = model:FindFirstChild("HumanoidRootPart", true)
        or model:FindFirstChild("VehicleSeat", true) or model:FindFirstChild("Engine", true)
        or model:FindFirstChild("Root", true) or model.PrimaryPart
    if preferred and preferred:IsA("BasePart") then return preferred end
    local best, volume = nil, -1
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            local score = part.Size.X * part.Size.Y * part.Size.Z + (part.Anchored and 0 or 1000000)
            if score > volume then best, volume = part, score end
        end
    end
    return best
end

function M.Alive(model)
    if not model or not model.Parent then return false end
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid then return humanoid.Health > 0 end
    for _, name in ipairs({"Health", "HP", "ShipHealth"}) do
        local value = model:FindFirstChild(name, true)
        if value and (value:IsA("NumberValue") or value:IsA("IntValue")) then return value.Value > 0 end
        local attribute = model:GetAttribute(name)
        if type(attribute) == "number" then return attribute > 0 end
    end
    return true
end

return M
