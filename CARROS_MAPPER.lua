local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
if not player then return end

local guiParent = player:WaitForChild("PlayerGui")
local old = guiParent:FindFirstChild("IKAROHUB_JobMapper")
if old then old:Destroy() end

local logs = {}
local connections = {}
local capturing = false
local MAX_LOGS = 500

local function addLog(message)
    message = tostring(message)
    table.insert(logs, os.date("%H:%M:%S") .. " | " .. message)
    if #logs > MAX_LOGS then table.remove(logs, 1) end
    print("[IKAROHUB JOB MAPPER] " .. message)
end

local function fullName(instance)
    local ok, result = pcall(function() return instance:GetFullName() end)
    return ok and result or tostring(instance)
end

local function getHRP()
    local character = player.Character
    return character and character:FindFirstChild("HumanoidRootPart")
end

local function getPromptPart(prompt)
    local parent = prompt.Parent
    if parent and parent:IsA("Attachment") then parent = parent.Parent end
    if parent and parent:IsA("BasePart") then return parent end
    return parent and parent:FindFirstAncestorWhichIsA("BasePart") or nil
end

local function promptDescription(prompt)
    local part = getPromptPart(prompt)
    local hrp = getHRP()
    local distance = "?"
    if part and hrp then distance = string.format("%.1f", (part.Position - hrp.Position).Magnitude) end
    return string.format(
        "PROMPT | Dist=%s | Name=%s | Action=%s | Object=%s | Hold=%.2f | Enabled=%s | Path=%s",
        distance,
        prompt.Name,
        tostring(prompt.ActionText),
        tostring(prompt.ObjectText),
        prompt.HoldDuration,
        tostring(prompt.Enabled),
        fullName(prompt)
    )
end

local function scanNow()
    addLog("=== SCAN START ===")
    addLog("PLAYER=" .. player.Name)
    addLog("TEAM=" .. (player.Team and player.Team.Name or "nil"))
    addLog("NEUTRAL=" .. tostring(player.Neutral))
    local scanHRP = getHRP()
    if scanHRP then
        local p = scanHRP.Position
        addLog(string.format("PLAYER_POSITION=Vector3.new(%.6f, %.6f, %.6f)", p.X, p.Y, p.Z))
    end

    for name, value in pairs(player:GetAttributes()) do
        addLog("PLAYER_ATTRIBUTE | " .. name .. "=" .. tostring(value))
    end

    local gameFolder = Workspace:FindFirstChild("Game")
    local jobs = gameFolder and gameFolder:FindFirstChild("Jobs")
    local container = jobs and jobs:FindFirstChild("JobPadContainer")
    if container then
        for _, jobPad in ipairs(container:GetChildren()) do
            local part = jobPad:IsA("BasePart") and jobPad
                or jobPad:FindFirstChildWhichIsA("BasePart", true)
            if part then
                local p = part.Position
                addLog(string.format(
                    "JOB_PAD | Name=%s | Position=Vector3.new(%.6f, %.6f, %.6f) | Path=%s",
                    jobPad.Name, p.X, p.Y, p.Z, fullName(jobPad)
                ))
            else
                addLog("JOB_PAD_NO_PART | Name=" .. jobPad.Name .. " | Path=" .. fullName(jobPad))
            end
        end
    else
        addLog("JOB_PAD_CONTAINER_NOT_LOADED")
    end

    local values = 0
    for _, descendant in ipairs(player:GetDescendants()) do
        if descendant:IsA("ValueBase") then
            values = values + 1
            addLog("PLAYER_VALUE | " .. fullName(descendant) .. "=" .. tostring(descendant.Value))
        end
    end
    if values == 0 then addLog("PLAYER_VALUE | none") end

    local prompts = {}
    local hrp = getHRP()
    for _, descendant in ipairs(Workspace:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then
            local part = getPromptPart(descendant)
            local distance = part and hrp and (part.Position - hrp.Position).Magnitude or math.huge
            if distance <= 150 then
                table.insert(prompts, {Prompt = descendant, Distance = distance})
            end
        end
    end
    table.sort(prompts, function(a, b) return a.Distance < b.Distance end)
    for _, entry in ipairs(prompts) do addLog(promptDescription(entry.Prompt)) end
    if #prompts == 0 then addLog("PROMPT | none within 150 studs") end

    for _, descendant in ipairs(Workspace:GetDescendants()) do
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
            local text = tostring(descendant.Text or "")
            local lower = string.lower(text)
            if string.find(lower, "shift", 1, true)
                or string.find(lower, "outlaw", 1, true)
                or string.find(lower, "job", 1, true)
                or string.find(lower, "criminal", 1, true) then
                addLog("WORLD_TEXT | Text=" .. text .. " | Path=" .. fullName(descendant))
            end
        end
    end
    addLog("=== SCAN END ===")
end

local screen = Instance.new("ScreenGui")
screen.Name = "IKAROHUB_JobMapper"
screen.ResetOnSpawn = false
screen.Parent = guiParent

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(360, 230)
frame.Position = UDim2.new(0, 25, 0.5, -115)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
frame.BorderSizePixel = 0
frame.Parent = screen
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 9)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -12, 0, 34)
title.Position = UDim2.fromOffset(8, 0)
title.BackgroundTransparency = 1
title.Text = "IKAROHUB • JOB MAPPER"
title.TextColor3 = Color3.fromRGB(255, 145, 35)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -16, 0, 42)
status.Position = UDim2.fromOffset(8, 34)
status.BackgroundTransparency = 1
status.Text = "1. Fique no balcão\n2. Inicie captura e comece a profissão manualmente"
status.TextWrapped = true
status.TextColor3 = Color3.fromRGB(220, 220, 225)
status.Font = Enum.Font.Gotham
status.TextSize = 11
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = frame

local function makeButton(text, x, y, width)
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(width, 32)
    button.Position = UDim2.fromOffset(x, y)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 11
    button.Parent = frame
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
    return button
end

local scanButton = makeButton("ESCANEAR AGORA", 8, 84, 165)
local captureButton = makeButton("CAPTURA: OFF", 181, 84, 171)
local copyButton = makeButton("COPIAR DIAGNÓSTICO", 8, 124, 344)
local closeButton = makeButton("FECHAR", 8, 164, 344)

scanButton.MouseButton1Click:Connect(function()
    scanNow()
    status.Text = "Scan concluído: " .. #logs .. " linhas registradas"
end)

captureButton.MouseButton1Click:Connect(function()
    capturing = not capturing
    captureButton.Text = capturing and "CAPTURA: ON" or "CAPTURA: OFF"
    captureButton.BackgroundColor3 = capturing and Color3.fromRGB(0, 170, 110) or Color3.fromRGB(45, 45, 55)
    if capturing then
        addLog("=== LIVE CAPTURE START ===")
        scanNow()
        status.Text = "Agora inicie manualmente a profissão correta"
    else
        addLog("=== LIVE CAPTURE STOP ===")
    end
end)

copyButton.MouseButton1Click:Connect(function()
    local output = "=== IKAROHUB JOB MAPPER ===\n" .. table.concat(logs, "\n")
    local copied = false
    if setclipboard then copied = pcall(setclipboard, output) end
    if not copied and toclipboard then copied = pcall(toclipboard, output) end
    status.Text = copied and "Diagnóstico copiado. Envie no chat." or "Clipboard indisponível; veja o console."
    print(output)
end)

closeButton.MouseButton1Click:Connect(function()
    for _, connection in ipairs(connections) do connection:Disconnect() end
    screen:Destroy()
end)

table.insert(connections, player:GetPropertyChangedSignal("Team"):Connect(function()
    if capturing then addLog("TEAM_CHANGED=" .. (player.Team and player.Team.Name or "nil")) end
end))

table.insert(connections, player.AttributeChanged:Connect(function(name)
    if capturing then addLog("PLAYER_ATTRIBUTE_CHANGED | " .. name .. "=" .. tostring(player:GetAttribute(name))) end
end))

table.insert(connections, Workspace.DescendantAdded:Connect(function(descendant)
    if not capturing then return end
    if descendant:IsA("ProximityPrompt") then
        addLog("PROMPT_ADDED | " .. promptDescription(descendant))
    elseif descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
        task.defer(function()
            if descendant.Parent then
                local text = tostring(descendant.Text or "")
                local lower = string.lower(text)
                if string.find(lower, "shift", 1, true) or string.find(lower, "outlaw", 1, true) then
                    addLog("WORLD_TEXT_ADDED | Text=" .. text .. " | Path=" .. fullName(descendant))
                end
            end
        end)
    end
end))

addLog("MAPPER LOADED")
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "IKAROHUB Job Mapper",
        Text = "Fique perto do balcão Outlaw e inicie a captura.",
        Duration = 6,
    })
end)

