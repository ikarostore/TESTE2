local M = {}

function M.Init(ctx)
    local Tabs, Options, Fluent = ctx.Tabs, ctx.Options, ctx.Fluent
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")
    local HttpService = game:GetService("HttpService")
    local VIM = game:GetService("VirtualInputManager")
    local player = Players.LocalPlayer
    local tab = Tabs.SeaEvent
    local state = {
        Boat = "Guardian", Zone = "Zone 5", Speed = 300, Sail = false,
        AutoMirage = false, AutoLeviathan = false, LeviathanAttack = false,
        WithFriend = false, Friend = "None", Lightning = false,
        SpeedBoat = false, NoclipRock = false, DodgeSeaBeast = true,
        DodgeTerror = true, CombatBusy = false, Drive = nil,
        Events = {Shark=true, Piranha=true, FishCrew=true, FishBoat=true,
            PirateBrigade=true, PirateGrandBrigade=true, Terrorshark=true, SeaBeast=true},
        Skills = {Fruit=true, Melee=true, Sword=true, Gun=true,
            FruitZ=true,FruitX=true,FruitC=true,FruitV=false,FruitF=false,
            MeleeZ=true,MeleeX=true,MeleeC=true,MeleeV=true,
            SwordZ=true,SwordX=true,GunZ=true,GunX=true}
    }
    local configName = "IKAROHUB_sea_" .. tostring(player.UserId) .. ".json"

    local function merge(dst, src)
        if type(src) ~= "table" then return end
        for key, value in pairs(src) do
            if type(value) == "table" and type(dst[key]) == "table" then merge(dst[key], value)
            elseif dst[key] ~= nil then dst[key] = value end
        end
    end
    if type(readfile) == "function" and type(isfile) == "function" and isfile(configName) then
        pcall(function() merge(state, HttpService:JSONDecode(readfile(configName))) end)
    end
    local function save()
        if type(writefile) == "function" then
            pcall(function()
                local stored = {
                    Boat=state.Boat, Zone=state.Zone, Speed=state.Speed, Sail=state.Sail,
                    AutoMirage=state.AutoMirage, AutoLeviathan=state.AutoLeviathan,
                    LeviathanAttack=state.LeviathanAttack, WithFriend=state.WithFriend,
                    Friend=state.Friend, Lightning=state.Lightning, SpeedBoat=state.SpeedBoat,
                    NoclipRock=state.NoclipRock, DodgeSeaBeast=state.DodgeSeaBeast,
                    DodgeTerror=state.DodgeTerror, Events=state.Events, Skills=state.Skills
                }
                writefile(configName, HttpService:JSONEncode(stored))
            end)
        end
    end
    local function notify(text)
        Fluent:Notify({Title="IKAROHUB Sea Event", Content=tostring(text), Duration=5})
    end
    local function character()
        local char = player.Character
        return char, char and char:FindFirstChild("HumanoidRootPart"), char and char:FindFirstChildOfClass("Humanoid")
    end
    local function alive(model)
        if not model or not model.Parent then return false end
        local hum = model:FindFirstChildOfClass("Humanoid")
        if hum then return hum.Health > 0 end
        local hp = model:FindFirstChild("Health", true)
        return not hp or not hp:IsA("ValueBase") or hp.Value > 0
    end
    local function partOf(model)
        if model and model:IsA("BasePart") then return model end
        return model and (model:FindFirstChild("HumanoidRootPart", true)
            or model:FindFirstChild("Head", true) or model:FindFirstChild("Engine", true)
            or model:FindFirstChild("VehicleSeat", true) or model.PrimaryPart
            or model:FindFirstChildWhichIsA("BasePart", true))
    end
    local function setNoclip(model)
        for _, obj in ipairs(model and model:GetDescendants() or {}) do
            if obj:IsA("BasePart") then obj.CanCollide = false end
        end
    end
    local function enableHaki()
        local char = player.Character
        if char and not char:FindFirstChild("HasBuso") then
            pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso") end)
        end
    end
    local function press(key)
        pcall(function()
            VIM:SendKeyEvent(true, Enum.KeyCode[key], false, game)
            task.wait(0.06)
            VIM:SendKeyEvent(false, Enum.KeyCode[key], false, game)
        end)
    end
    local function useSkills(target)
        local char = player.Character
        local backpack = player:FindFirstChild("Backpack")
        if not char or not backpack then return end
        local categories = {{"Melee","Melee"},{"Sword","Sword"},{"Gun","Gun"},{"Blox Fruit","Fruit"}}
        for _, category in ipairs(categories) do
            if state.Skills[category[2]] then
                local tool
                for _, candidate in ipairs(backpack:GetChildren()) do
                    if candidate:IsA("Tool") and candidate.ToolTip == category[1] then tool = candidate break end
                end
                tool = tool or (char:FindFirstChildOfClass("Tool") and char:FindFirstChildOfClass("Tool").ToolTip == category[1]
                    and char:FindFirstChildOfClass("Tool"))
                if tool then
                    tool.Parent = char
                    if workspace.CurrentCamera and target then
                        workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, target.Position)
                    end
                    for _, key in ipairs({"Z","X","C","V","F"}) do
                        if state.Skills[category[2] .. key] then press(key) task.wait(0.08) end
                    end
                end
            end
        end
    end

    local zones = {
        ["Zone 1"] = Vector3.new(-21998,30,-682), ["Zone 2"] = Vector3.new(-26779,30,-823),
        ["Zone 3"] = Vector3.new(-31172,30,-2257), ["Zone 4"] = Vector3.new(-34055,30,-2560),
        ["Zone 5"] = Vector3.new(-38888,30,-2163), ["Zone 6"] = Vector3.new(-44542,30,-1245),
        Infinite = Vector3.new(-148073,30,7721)
    }
    local eventNames = {
        Terrorshark={"Terrorshark"}, SeaBeast={"SeaBeast","Sea Beast"},
        PirateGrandBrigade={"PirateGrandBrigade"}, PirateBrigade={"PirateBrigade"},
        FishBoat={"FishBoat"}, FishCrew={"Fish Crew Member"}, Shark={"Shark"}, Piranha={"Piranha"}
    }
    local order = {"Terrorshark","SeaBeast","PirateGrandBrigade","PirateBrigade","FishBoat","FishCrew","Shark","Piranha"}
    local function match(model, key)
        local lower = string.lower(model.Name)
        if key == "Shark" and string.find(lower,"terror",1,true) then return false end
        for _, name in ipairs(eventNames[key]) do
            if lower == string.lower(name) then return true end
        end
        return false
    end
    local function findEvent()
        for _, key in ipairs(order) do
            if state.Events[key] then
                for _, folderName in ipairs({"Enemies","SeaBeasts"}) do
                    local folder = workspace:FindFirstChild(folderName)
                    for _, model in ipairs(folder and folder:GetChildren() or {}) do
                        if model:IsA("Model") and match(model,key) and alive(model) then return key,model end
                    end
                end
            end
        end
    end
    local function findLeviathan()
        local folder = workspace:FindFirstChild("SeaBeasts")
        for _, model in ipairs(folder and folder:GetChildren() or {}) do
            local n = string.lower(model.Name)
            if model:IsA("Model") and alive(model)
            and (n == "leviathan" or n == "leviathan segment" or n == "leviathan tail") then return model end
        end
    end
    local function findMirage()
        local origin = workspace:FindFirstChild("_WorldOrigin")
        local locations = origin and origin:FindFirstChild("Locations")
        return locations and locations:FindFirstChild("Mirage Island")
    end
    local function myBoat()
        local boats = workspace:FindFirstChild("Boats")
        local _, root = character()
        local best, distance = nil, math.huge
        for _, boat in ipairs(boats and boats:GetChildren() or {}) do
            if boat.Name == state.Boat then
                local seat = boat:FindFirstChild("VehicleSeat",true)
                if seat and seat.Occupant and seat.Occupant.Parent == player.Character then return boat,seat end
                if seat and root and (seat.Position-root.Position).Magnitude < distance then
                    best,distance=boat,(seat.Position-root.Position).Magnitude
                end
            end
        end
        return best, best and best:FindFirstChild("VehicleSeat",true)
    end
    local function friendBoat()
        if not state.WithFriend or state.Friend == "None" then return nil end
        local friend = Players:FindFirstChild(state.Friend)
        local char = friend and friend.Character
        local boats = workspace:FindFirstChild("Boats")
        for _, boat in ipairs(boats and boats:GetChildren() or {}) do
            local seat = boat:FindFirstChild("VehicleSeat",true)
            if seat and seat.Occupant and seat.Occupant.Parent == char then return boat,seat end
        end
    end
    local function stopDrive()
        if state.Drive then
            for _, object in pairs(state.Drive) do if typeof(object)=="Instance" then pcall(function() object:Destroy() end) end end
        end
        state.Drive=nil
    end
    local function completeBoat(instance)
        local boats = workspace:FindFirstChild("Boats")
        local current = instance
        while current and current.Parent ~= boats do current = current.Parent end
        return current and current:IsA("Model") and current or instance:FindFirstAncestorOfClass("Model")
    end
    local function driveBoat(seat,target)
        local drive=seat and (seat.AssemblyRootPart or seat)
        if not drive or not target then return end
        if not state.Drive or state.Drive.Root~=drive then
            stopDrive()
            local att=Instance.new("Attachment",drive)
            local vel=Instance.new("LinearVelocity",drive)
            vel.Attachment0=att
            vel.RelativeTo=Enum.ActuatorRelativeTo.World
            vel.VelocityConstraintMode=Enum.VelocityConstraintMode.Vector
            vel.MaxForce=math.huge
            local gyro=Instance.new("AlignOrientation",drive)
            gyro.Attachment0=att
            gyro.Mode=Enum.OrientationAlignmentMode.OneAttachment
            gyro.Responsiveness=35
            gyro.MaxTorque=math.huge
            state.Drive={Root=drive,Attachment=att,Velocity=vel,Orientation=gyro}
        end
        local delta=Vector3.new(target.X-drive.Position.X,0,target.Z-drive.Position.Z)
        local dir=delta.Magnitude>2 and delta.Unit or Vector3.new(-1,0,0)
        local y=math.clamp((70-drive.Position.Y)*7,-140,140)
        state.Drive.Velocity.VectorVelocity=dir*state.Speed+Vector3.new(0,y,0)
        state.Drive.Orientation.CFrame=CFrame.lookAt(Vector3.zero,dir,Vector3.yAxis)
        if state.NoclipRock or state.Sail or state.AutoMirage or state.AutoLeviathan then
            setNoclip(completeBoat(seat))
        end
        if state.SpeedBoat then seat.MaxSpeed=350 end
    end
    local function goToSeat(seat)
        local char,root,hum=character()
        if not seat or not root or not hum then return end
        setNoclip(char)
        if (root.Position-seat.Position).Magnitude>6 then
            root.CFrame=CFrame.lookAt(root.Position:Lerp(seat.Position+Vector3.new(0,3,0),0.12),seat.Position)
        else seat:Sit(hum) end
    end
    local function buyBoat()
        pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat",state.Boat) end)
    end
    local function combat(key,model)
        if state.CombatBusy then return end
        state.CombatBusy=true stopDrive()
        task.spawn(function()
            local module=getgenv().IKAROHUB_BANANA_SEA_COMBAT
            if module and module.Combat then
                pcall(module.Combat,key,model,{
                    Running=function() return state.CombatBusy and alive(model) end,
                    EquipWeapon=function()
                        local char=player.Character
                        local backpack=player:FindFirstChild("Backpack")
                        for _,tool in ipairs(backpack and backpack:GetChildren() or {}) do
                            if tool:IsA("Tool") and tool.ToolTip=="Melee" then tool.Parent=char return tool end
                        end
                    end,
                    UseSkills=useSkills, AimAt=function() end,
                    PanicHealthFraction=function() return 0.25 end
                })
            else
                while alive(model) and state.CombatBusy do
                    local _,root=character()
                    local target=partOf(model)
                    if not root or not target then break end
                    root.CFrame=CFrame.lookAt(target.Position+Vector3.new(0,35,0),target.Position)
                    useSkills(target) task.wait(0.1)
                end
            end
            state.CombatBusy=false
        end)
    end

    tab:AddSection("Sea Event")
    tab:AddDropdown("IKSeaBoat",{Title="Choose Boat",Values={"Guardian","Beast Hunter","PirateGrandBrigade","MarineGrandBrigade","PirateBrigade","MarineBrigade","PirateSloop","MarineSloop"},Default=state.Boat,Callback=function(v) state.Boat=v save() end})
    tab:AddDropdown("IKSeaZone",{Title="Choose Zone",Values={"Zone 1","Zone 2","Zone 3","Zone 4","Zone 5","Zone 6","Infinite"},Default=state.Zone,Callback=function(v) state.Zone=v save() end})
    tab:AddSlider("IKSeaSpeed",{Title="Boat Tween Speed",Min=100,Max=350,Default=state.Speed,Rounding=0,Callback=function(v) state.Speed=v save() end})
    local function toggle(id,title,path)
        local control=tab:AddToggle(id,{Title=title,Default=path[1][path[2]]})
        control:OnChanged(function(v) path[1][path[2]]=v save() if not v and id=="IKSeaSail" then stopDrive() end end)
        return control
    end
    toggle("IKSeaSail","Auto Sail Boat",{state,"Sail"})
    tab:AddSection("Sea Event Targets")
    toggle("IKSeaShark","Auto Farm Shark",{state.Events,"Shark"})
    toggle("IKSeaPiranha","Auto Farm Piranha",{state.Events,"Piranha"})
    toggle("IKSeaCrew","Auto Farm Fish Crew Member",{state.Events,"FishCrew"})
    toggle("IKSeaFishBoat","Auto Kill Ghost Ship",{state.Events,"FishBoat"})
    toggle("IKSeaBrigade","Auto Kill Pirate Brigade",{state.Events,"PirateBrigade"})
    toggle("IKSeaGrand","Auto Kill Pirate Grand Brigade",{state.Events,"PirateGrandBrigade"})
    tab:AddSection("Boss")
    toggle("IKSeaTerror","Auto Kill Terrorshark",{state.Events,"Terrorshark"})
    toggle("IKSeaBeast","Auto Kill Seabeast",{state.Events,"SeaBeast"})
    tab:AddSection("Mirage / Leviathan")
    toggle("IKSeaFindMirage","Auto Find Mirage",{state,"AutoMirage"})
    toggle("IKSeaFindLevi","Auto Find Leviathan",{state,"AutoLeviathan"})
    toggle("IKSeaLeviAttack","Leviathan Attack",{state,"LeviathanAttack"})
    toggle("IKSeaWithFriend","Sea Events With Friend",{state,"WithFriend"})
    local friendNames={"None"}
    for _,p in ipairs(Players:GetPlayers()) do if p~=player then table.insert(friendNames,p.Name) end end
    tab:AddDropdown("IKSeaFriend",{Title="Select Friend",Values=friendNames,Default=state.Friend,Callback=function(v) state.Friend=v save() end})
    tab:AddButton({Title="Refresh Friend List",Description="Atualiza jogadores do servidor",Callback=function()
        local values={"None"}
        for _,candidate in ipairs(Players:GetPlayers()) do
            if candidate~=player then table.insert(values,candidate.Name) end
        end
        pcall(function() Options.IKSeaFriend:SetValues(values) end)
        notify("Lista de amigos atualizada: "..tostring(#values-1).." jogadores.")
    end})
    tab:AddSection("Ability")
    toggle("IKSeaLightning","Lightning",{state,"Lightning"})
    toggle("IKSeaFastBoat","Speed Boat",{state,"SpeedBoat"})
    toggle("IKSeaNoclip","No Clip Rock",{state,"NoclipRock"})
    toggle("IKSeaDodgeBeast","Dodge Seabeasts Attack",{state,"DodgeSeaBeast"})
    toggle("IKSeaDodgeTerror","Dodge Terrorshark Attack",{state,"DodgeTerror"})
    tab:AddSection("Settings Sea Event / Skills")
    for _,data in ipairs({{"Fruit","Use Skill Devil Fruit"},{"Melee","Use Skill Melee"},{"Sword","Use Skill Sword"},{"Gun","Use Skill Gun"}}) do
        toggle("IKSeaUse"..data[1],data[2],{state.Skills,data[1]})
    end
    for _,category in ipairs({"Fruit","Melee","Sword","Gun"}) do
        for _,key in ipairs({"Z","X","C","V","F"}) do
            if state.Skills[category..key]~=nil then toggle("IKSea"..category..key,category.." Skill "..key,{state.Skills,category..key}) end
        end
    end

    Tabs.Status:AddSection("Sea Status")
    local mirageStatus=Tabs.Status:AddParagraph({Title="Mirage Island",Content="Not spawned"})
    local leviStatus=Tabs.Status:AddParagraph({Title="Leviathan",Content="Not detected"})
    task.spawn(function()
        while task.wait(0.15) do
            local mirage=findMirage()
            local levi=findLeviathan()
            pcall(function() mirageStatus:SetDesc(mirage and "SPAWNED: "..mirage:GetFullName() or "Not spawned") end)
            pcall(function() leviStatus:SetDesc(levi and "DETECTED: "..levi:GetFullName() or "Not detected") end)
            if state.Lightning then Lighting.ClockTime=12 end
            if not state.CombatBusy then
                local key,event=findEvent()
                if event and (state.Sail or state.WithFriend) then combat(key,event)
                elseif levi and state.LeviathanAttack then combat("Leviathan",levi)
                elseif levi and state.AutoLeviathan then
                    stopDrive()
                else
                    local boat,seat=friendBoat()
                    if not boat then boat,seat=myBoat() end
                    if state.Sail or state.AutoMirage or state.AutoLeviathan or state.WithFriend then
                        if not seat then buyBoat()
                        else
                            local _,_,hum=character()
                            if seat.Occupant~=hum and not state.WithFriend then goToSeat(seat)
                            elseif seat.Occupant==hum then
                                local miragePart=state.AutoMirage and mirage and partOf(mirage)
                                local target=(miragePart and miragePart.Position)
                                    or zones[state.AutoLeviathan and "Zone 6" or state.Zone]
                                if miragePart and (state.Drive and state.Drive.Root
                                and (state.Drive.Root.Position-miragePart.Position).Magnitude<=250) then
                                    stopDrive()
                                else
                                    driveBoat(seat,target)
                                end
                            elseif state.WithFriend then
                                local _,root=character()
                                local bp=partOf(boat)
                                if root and bp then setNoclip(player.Character) root.CFrame=root.CFrame:Lerp(bp.CFrame*CFrame.new(0,15,18),0.08) end
                            end
                        end
                    else stopDrive() end
                end
            end
        end
    end)
    notify("Aba Sea Event completa carregada.")
    return state
end

return M
