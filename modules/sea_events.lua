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
    local function scan(container, onlyKey)
        if not container then return end
        for _, model in ipairs(container:GetChildren()) do
            if model:IsA("Model") and not excluded(model) and nearby(model, root) then
                for _, key in ipairs(M.Order) do
                    if selected[key] and (not onlyKey or key == onlyKey)
                    and matches(model.Name, M.Names[key], key) then return key, model end
                end
            end
        end
    end
    local key, model = scan(workspace:FindFirstChild("Enemies"))
    if key then return key, model end
    key, model = scan(workspace:FindFirstChild("SeaBeasts"), "SeaBeast")
    if key then return key, model end
    if os.clock() < (state.NextGlobalEventScan or 0) then return nil, nil end
    state.NextGlobalEventScan = os.clock() + 3
    for _, candidate in ipairs(workspace:GetDescendants()) do
        if candidate:IsA("Model") and not excluded(candidate) and nearby(candidate, root) then
            for _, eventKey in ipairs(M.Order) do
                if selected[eventKey] and eventKey ~= "SeaBeast"
                and matches(candidate.Name, M.Names[eventKey], eventKey) then
                    return eventKey, candidate
                end
            end
        end
    end
    return nil, nil
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
