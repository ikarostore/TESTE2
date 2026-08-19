local M = {}

function M.Init(ctx)
    local Tabs, Options, Fluent = ctx.Tabs, ctx.Options, ctx.Fluent
    local Players=game:GetService("Players")
    local RS=game:GetService("ReplicatedStorage")
    local RunService=game:GetService("RunService")
    local TS=game:GetService("TeleportService")
    local HttpService=game:GetService("HttpService")
    local VIM=game:GetService("VirtualInputManager")
    local player=Players.LocalPlayer
    local comm=RS:WaitForChild("Remotes"):WaitForChild("CommF_")
    local net=RS:FindFirstChild("Modules") and RS.Modules:FindFirstChild("Net")
    local regAttack=net and net:FindFirstChild("RE/RegisterAttack")
    local regHit=net and net:FindFirstChild("RE/RegisterHit")
    local S={
        Main={Weapon="Melee",Mode="Normal",Auto=false,Fast=false,MasteryMode="Quest",FruitMastery=false,GunMastery=false,SwordMastery=false,SelectedSword="None",SelectedMob="None",AutoMob=false,SelectedBoss="None",AutoBoss=false,AllBoss=false},
        Local={Dodge=false,Energy=false,RaceV3=false,RaceV4=false,Ability=false,Geppo=false,Soru=false,Water=false,Noclip=false},
        Setting={Spin=false,Distance=35,TweenSpeed=350,Bring=true,BringMode="Normal",Fast=true,FastMode="Normal",Aura=true,
            HideNotify=false,HideDamage=true,Black=false,White=false,HideMonster=false,MasteryHP=25,
            FruitZ=true,FruitX=true,FruitC=true,FruitV=false,FruitF=false,GunZ=true,GunX=true,
            Spawn=false,Observation=false,Haki=true,Rejoin=false,Bypass=true},
        Hold={MasteryZ=0,MasteryX=0,MasteryC=0,MasteryV=0,MasteryF=0,SeaZ=0,SeaX=0,SeaC=0,SeaV=0,SeaF=0},
        Farm={Elite=false,EliteHop=false,BoneMode="Quest",Bone=false,RandomBone=false,PirateRaid=false,Observation=false,ObservationV2=false,
            Saber=false,ChestTween=false,ChestInstant=false,ChestHop=false,StopItems=false,MirageChest=false,
            Katakuri=false,SpawnCake=false,KillCake=false,KillDough=false,
            Radioactive=false,Mystic=false,Magma=false,Angel=false,Leather=false,Ectoplasm=false,Scrap=false,Cocoa=false,Dragon=false,Gunpowder=false,FishTail=false,MiniTusk=false},
        CurrentTarget=nil, Farming=false
    }
    local path="IKAROHUB_tabs_"..tostring(player.UserId)..".json"
    local function merge(a,b) if type(b)~="table" then return end for k,v in pairs(b) do if type(v)=="table" and type(a[k])=="table" then merge(a[k],v) elseif a[k]~=nil then a[k]=v end end end
    if type(isfile)=="function" and type(readfile)=="function" and isfile(path) then pcall(function() merge(S,HttpService:JSONDecode(readfile(path))) end) end
    getgenv().IKAROHUB_HOLDS=S.Hold
    local function save() if type(writefile)=="function" then pcall(function() writefile(path,HttpService:JSONEncode({Main=S.Main,Local=S.Local,Setting=S.Setting,Hold=S.Hold,Farm=S.Farm})) end) end end
    local function notify(title,text) Fluent:Notify({Title=title,Content=tostring(text or ""),Duration=5}) end
    local function toggle(tab,id,title,t,key,desc)
        local c=tab:AddToggle(id,{Title=title,Description=desc or "",Default=t[key]})
        c:OnChanged(function(v) t[key]=v save() end)
        return c
    end
    local function rootHum()
        local char=player.Character
        return char,char and char:FindFirstChild("HumanoidRootPart"),char and char:FindFirstChildOfClass("Humanoid")
    end
    local function noclip(char) for _,v in ipairs(char and char:GetDescendants() or {}) do if v:IsA("BasePart") then v.CanCollide=false end end end
    local function press(key)
        pcall(function()
            VIM:SendKeyEvent(true,Enum.KeyCode[key],false,game)
            task.wait(0.05)
            VIM:SendKeyEvent(false,Enum.KeyCode[key],false,game)
        end)
    end
    local function haki() local char=player.Character if char and not char:FindFirstChild("HasBuso") then pcall(function() comm:InvokeServer("Buso") end) end end
    local function equip(tip,name)
        local char=player.Character local backpack=player:FindFirstChild("Backpack")
        if not char then return end
        local tool=name and backpack and backpack:FindFirstChild(name)
        if not tool then for _,candidate in ipairs(backpack and backpack:GetChildren() or {}) do if candidate:IsA("Tool") and candidate.ToolTip==tip then tool=candidate break end end end
        if tool then tool.Parent=char return tool end
        for _,candidate in ipairs(char:GetChildren()) do if candidate:IsA("Tool") and (not tip or candidate.ToolTip==tip) then return candidate end end
    end
    local function targetPart(model) return model and (model:FindFirstChild("HumanoidRootPart",true) or model:FindFirstChild("Head",true) or model.PrimaryPart) end
    local function living(model) local h=model and model:FindFirstChildOfClass("Humanoid") return model and model.Parent and h and h.Health>0 end
    local function rawAttack(model)
        local _,root=rootHum() local hit=model and (model:FindFirstChild("Head",true) or targetPart(model))
        if not root or not hit or (root.Position-hit.Position).Magnitude>=60 then return end
        local delay=({Slow=0.32,Normal=0.22,Fast=0.17,["Super Fast"]=0.12})[S.Setting.FastMode] or 0.22
        if os.clock()<(S.NextAttack or 0) then return end
        S.NextAttack=os.clock()+(S.Setting.Fast and delay or 0.32)
        local secondary={{model,hit}}
        pcall(function() regAttack:FireServer(1e-9) regHit:FireServer(hit,secondary) end)
    end
    local function closest(names,condition)
        local folder=workspace:FindFirstChild("Enemies") local _,root=rootHum() local best,dist=nil,math.huge
        for _,m in ipairs(folder and folder:GetChildren() or {}) do
            if living(m) and (not names or names[m.Name]) and (not condition or condition(m)) then
                local p=targetPart(m) if p then local d=root and (p.Position-root.Position).Magnitude or 0 if d<dist then best,dist=m,d end end
            end
        end
        return best
    end
    local function templatePart(names)
        for _,model in ipairs(RS:GetChildren()) do
            if model:IsA("Model") and names[model.Name] then
                local p=targetPart(model) if p then return p end
            end
        end
    end
    local function farm(model)
        local char,root,hum=rootHum() local part=targetPart(model)
        if not char or not root or not hum or not part then return end
        S.CurrentTarget=model haki() noclip(char)
        local tip=S.Main.Weapon=="Fruit" and "Blox Fruit" or S.Main.Weapon
        equip(tip,S.Main.Weapon=="Sword" and S.Main.SelectedSword~="None" and S.Main.SelectedSword or nil)
        local offset=Vector3.new(0,S.Setting.Distance,0)
        if S.Setting.Spin then offset=Vector3.new(math.cos(os.clock()*3)*S.Setting.Distance,10,math.sin(os.clock()*3)*S.Setting.Distance) end
        root.CFrame=CFrame.lookAt(part.Position+offset,part.Position)
        root.AssemblyLinearVelocity=Vector3.zero
        if S.Setting.Bring then
            local radius=({Low=150,Normal=250,High=800})[S.Setting.BringMode] or 250
            local folder=workspace:FindFirstChild("Enemies")
            for _,mob in ipairs(folder and folder:GetChildren() or {}) do
                local mp=targetPart(mob)
                if living(mob) and mp and mob.Name==model.Name and (mp.Position-part.Position).Magnitude<=radius then mp.CFrame=part.CFrame mp.CanCollide=false end
            end
        end
        rawAttack(model)
    end
    local function masteryFarm(model,kind)
        farm(model)
        local hum=model and model:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health/math.max(hum.MaxHealth,1)>S.Setting.MasteryHP/100 then return end
        local tip=kind=="Fruit" and "Blox Fruit" or kind
        equip(tip,kind=="Sword" and S.Main.SelectedSword~="None" and S.Main.SelectedSword or nil)
        local keys=kind=="Gun" and {"Z","X"} or {"Z","X","C","V","F"}
        for _,key in ipairs(keys) do
            if (kind=="Fruit" and S.Setting["Fruit"..key]) or (kind=="Gun" and S.Setting["Gun"..key]) or kind=="Sword" then
                pcall(function()
                    VIM:SendKeyEvent(true,Enum.KeyCode[key],false,game)
                    task.wait(S.Hold["Mastery"..key] and S.Hold["Mastery"..key]>0 and S.Hold["Mastery"..key] or 0.05)
                    VIM:SendKeyEvent(false,Enum.KeyCode[key],false,game)
                end)
            end
        end
    end

    -- Status And Server: mesma ordem do Banana.
    local status=Tabs.Status
    status:AddSection("Server")
    status:AddButton({Title="Rejoin Server",Callback=function() TS:TeleportToPlaceInstance(game.PlaceId,game.JobId,player) end})
    local function hop(low)
        local ok,data=pcall(function() return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder="..(low and "Asc" or "Desc").."&limit=100")) end)
        if ok then for _,server in ipairs(data.data or {}) do if server.id~=game.JobId and server.playing<server.maxPlayers then TS:TeleportToPlaceInstance(game.PlaceId,server.id,player) return end end end
    end
    status:AddButton({Title="Server Hop",Callback=function() hop(false) end})
    status:AddButton({Title="Hop Lower Player",Callback=function() hop(true) end})
    local job=status:AddParagraph({Title="Server Job ID",Content=game.JobId})
    status:AddButton({Title="Copy Server Job ID",Callback=function() if setclipboard then setclipboard(game.JobId) end end})
    local joinId=""
    status:AddInput("IKJoinJob",{Title="Enter Server Job ID",Default="",Placeholder="Job ID",Numeric=false,Finished=true,Callback=function(v) joinId=tostring(v):gsub("`","") end})
    status:AddButton({Title="Join Server",Callback=function() if joinId~="" then TS:TeleportToPlaceInstance(game.PlaceId,joinId,player) end end})
    status:AddSection("Status")
    local moon=status:AddParagraph({Title="Moon",Content="Checking"})
    local kitsune=status:AddParagraph({Title="Kitsune",Content="Checking"})
    local frozen=status:AddParagraph({Title="Frozen",Content="Checking"})
    local mirage=status:AddParagraph({Title="Mirage",Content="Checking"})
    local dealer=status:AddParagraph({Title="Haki Dealer",Content="Checking"})
    local fruit=status:AddParagraph({Title="Devil Fruit",Content="Checking"})
    status:AddSection("Advance Fruit Stock")
    local advance=status:AddParagraph({Title="Advance Stock",Content="Loading"})
    status:AddSection("Normal Fruit Stock")
    local normal=status:AddParagraph({Title="Normal Stock",Content="Loading"})

    -- Localplayer: ordem original.
    local lp=Tabs.LocalPlayer lp:AddSection("Local Player")
    toggle(lp,"IKDodgeNoCD","Dodge No Cooldown",S.Local,"Dodge")
    toggle(lp,"IKInfiniteEnergy","Infinite Energy",S.Local,"Energy")
    toggle(lp,"IKRaceV3","Auto Active Race V3",S.Local,"RaceV3","Auto Active Ability")
    toggle(lp,"IKRaceV4","Auto Active Race V4",S.Local,"RaceV4","Auto Active Awakening")
    toggle(lp,"IKInfiniteAbility","Infinite Ability",S.Local,"Ability")
    toggle(lp,"IKInfiniteGeppo","Infinite Geppo",S.Local,"Geppo")
    toggle(lp,"IKInfiniteSoru","Infinite Soru",S.Local,"Soru")
    toggle(lp,"IKWalkWater","Walk on Water",S.Local,"Water")
    toggle(lp,"IKLocalNoclip","NoClip",S.Local,"Noclip")

    -- setting farm: ordem original.
    local set=Tabs.SettingFarm set:AddSection("Settings")
    toggle(set,"IKSpinFarm","Spin Position",S.Setting,"Spin","Spin Position When Farm")
    set:AddSlider("IKFarmDistance",{Title="Farm Distnace",Min=0,Max=50,Default=S.Setting.Distance,Rounding=0,Callback=function(v) S.Setting.Distance=v save() end})
    set:AddSlider("IKTweenSpeed",{Title="Player Tween Speed",Min=100,Max=350,Default=S.Setting.TweenSpeed,Rounding=0,Callback=function(v) S.Setting.TweenSpeed=v save() end})
    toggle(set,"IKBringMob","Bring Mob",S.Setting,"Bring")
    set:AddDropdown("IKBringMode",{Title="BringMob Mode",Values={"Low","Normal","High"},Default=S.Setting.BringMode,Callback=function(v) S.Setting.BringMode=v save() end})
    toggle(set,"IKFastAttack","Fast Attack",S.Setting,"Fast")
    set:AddDropdown("IKFastMode",{Title="Fast Attack Mode",Values={"Slow","Normal","Fast","Super Fast"},Default=S.Setting.FastMode,Callback=function(v) S.Setting.FastMode=v save() end})
    toggle(set,"IKAttackAura","Attack Aura",S.Setting,"Aura")
    set:AddSection("Graphic")
    toggle(set,"IKHideNotify","Hide Notifications",S.Setting,"HideNotify")
    toggle(set,"IKHideDamage","Hide Damage Text",S.Setting,"HideDamage")
    toggle(set,"IKBlackScreen","Black Screen",S.Setting,"Black")
    toggle(set,"IKWhiteScreen","White Screen",S.Setting,"White")
    toggle(set,"IKHideMonster","Hide Monsters",S.Setting,"HideMonster")
    set:AddSection("Mastery Setting")
    set:AddSlider("IKMasteryHP",{Title="Kill At %",Min=1,Max=100,Default=S.Setting.MasteryHP,Rounding=0,Callback=function(v) S.Setting.MasteryHP=v save() end})
    set:AddSection("Skill DevilFruit")
    for _,k in ipairs({"Z","X","C","V","F"}) do toggle(set,"IKMasteryFruit"..k,"Skill "..k,S.Setting,"Fruit"..k) end
    set:AddSection("Skill Gun")
    for _,k in ipairs({"Z","X"}) do toggle(set,"IKMasteryGun"..k,"Skill "..k,S.Setting,"Gun"..k) end
    set:AddSection("Other")
    toggle(set,"IKSpawnPoint","Auto Set Spawn Point",S.Setting,"Spawn")
    toggle(set,"IKObservation","Auto Observation",S.Setting,"Observation")
    toggle(set,"IKAutoHaki","Auto Haki",S.Setting,"Haki")
    toggle(set,"IKAutoRejoin","Auto Rejoin",S.Setting,"Rejoin")
    toggle(set,"IKBypass","Bypass Anti Cheat",S.Setting,"Bypass")

    -- Hold and select Skill: ordem e valores Banana.
    local hold=Tabs.Skills hold:AddSection("Mastery")
    for _,k in ipairs({"Z","X","C","V","F"}) do hold:AddSlider("IKHoldMastery"..k,{Title="Skill "..k,Min=0,Max=5,Default=S.Hold["Mastery"..k],Rounding=1,Callback=function(v) S.Hold["Mastery"..k]=v save() end}) end
    hold:AddSection("Sea Event")
    for _,k in ipairs({"Z","X","C","V","F"}) do hold:AddSlider("IKHoldSea"..k,{Title="Skill "..k,Min=0,Max=5,Default=S.Hold["Sea"..k],Rounding=1,Callback=function(v) S.Hold["Sea"..k]=v save() end}) end

    -- Farming principal (MainTab do Banana): ordem original.
    local main=Tabs.Farming
    main:AddSection("Main")
    local timeLabel=main:AddParagraph({Title="Executor Time",Content="Loading"})
    local fpsLabel=main:AddParagraph({Title="Client FPS",Content="Loading"})
    local pingLabel=main:AddParagraph({Title="Client Ping",Content="Loading"})
    main:AddButton({Title="Copy Discord Link",Callback=function() if setclipboard then setclipboard("https://discord.com/invite/25ms") end end})
    main:AddSection("Level Farm")
    main:AddDropdown("IKMainWeapon",{Title="Choose Weapon",Values={"Melee","Sword","Fruit"},Default=S.Main.Weapon,Callback=function(v) S.Main.Weapon=v save() end})
    main:AddDropdown("IKMainMode",{Title="Choose Farm Mode",Values={"Normal","Auto Quest","Nearest"},Default=S.Main.Mode,Callback=function(v) S.Main.Mode=v save() end})
    toggle(main,"IKMainAutoFarm","Auto Farm",S.Main,"Auto","Auto Farm Selected Mode")
    toggle(main,"IKMainFastFarm","Auto Farm Fast",S.Main,"Fast","Farm Sky Lv.10-75")
    main:AddSection("Mastery Farm")
    main:AddDropdown("IKMasteryMode",{Title="Choose Mode",Values={"Quest","No Quest","Nearest","Cakeprince","Bones"},Default=S.Main.MasteryMode,Callback=function(v) S.Main.MasteryMode=v save() end})
    toggle(main,"IKFruitMastery","Auto Farm Fruit Mastery",S.Main,"FruitMastery")
    toggle(main,"IKGunMastery","Auto Farm Gun Mastery",S.Main,"GunMastery")
    local swordNames={"None"}
    pcall(function() for _,v in ipairs(comm:InvokeServer("getInventory") or {}) do if type(v)=="table" and v.Type=="Sword" and v.Name then table.insert(swordNames,v.Name) end end end)
    main:AddDropdown("IKMasterySword",{Title="Choose Sword",Values=swordNames,Default=S.Main.SelectedSword,Callback=function(v) S.Main.SelectedSword=v save() end})
    toggle(main,"IKSwordMastery","Auto Farm Sword Mastery",S.Main,"SwordMastery")
    local mobNames={"None"} local bossNames={"None"}
    local enemyFolder=workspace:FindFirstChild("Enemies")
    local seenMob,seenBoss={},{}
    for _,m in ipairs(enemyFolder and enemyFolder:GetChildren() or {}) do
        local boss=m.Name:find("Boss") or m.Name=="Cake Prince" or m.Name=="Dough King"
        local list,seen=boss and bossNames or mobNames,boss and seenBoss or seenMob
        if not seen[m.Name] then seen[m.Name]=true table.insert(list,m.Name) end
    end
    table.sort(mobNames) table.sort(bossNames)
    main:AddSection("Mob Farm")
    main:AddDropdown("IKSelectedMob",{Title="Choose Mob",Values=mobNames,Default=S.Main.SelectedMob,Callback=function(v) S.Main.SelectedMob=v save() end})
    toggle(main,"IKAutoMob","Auto Farm Mob",S.Main,"AutoMob")
    main:AddSection("Boss Farm")
    local bossLabel=main:AddParagraph({Title="Status",Content="Choose Boss"})
    main:AddDropdown("IKSelectedBoss",{Title="Choose Boss",Values=bossNames,Default=S.Main.SelectedBoss,Callback=function(v) S.Main.SelectedBoss=v save() end})
    toggle(main,"IKAutoBoss","Auto Farm Boss",S.Main,"AutoBoss")
    toggle(main,"IKAllBoss","Auto Farm All Boss",S.Main,"AllBoss")

    -- Farming Other: Elite/Bone/Observation/Chest/Cake/Materials.
    local ft=Tabs.FarmingOther
    ft:AddSection("Elite Hunter")
    local eliteStatus=ft:AddParagraph({Title="Status",Content="Waiting"})
    toggle(ft,"IKFarmElite","Auto Elite Hunter",S.Farm,"Elite")
    toggle(ft,"IKFarmEliteHop","Auto Elite Hunter Hop",S.Farm,"EliteHop")
    ft:AddButton({Title="Check Progress",Callback=function() local ok,r=pcall(function() return comm:InvokeServer("EliteHunter","Progress") end) notify("Elite Progress",ok and r or "Unavailable") end})
    ft:AddSection("Bone Farm")
    ft:AddDropdown("IKBoneMode",{Title="Choose Mode",Values={"Quest","No Quest"},Default=S.Farm.BoneMode,Callback=function(v) S.Farm.BoneMode=v save() end})
    local boneStatus=ft:AddParagraph({Title="Bones Owned",Content="0"})
    toggle(ft,"IKFarmBone","Auto Farm Bone",S.Farm,"Bone")
    toggle(ft,"IKRandomBone","Auto Random Surprise",S.Farm,"RandomBone")
    ft:AddSection("Pirate Raid")
    toggle(ft,"IKPirateRaid","Auto Pirate Raid",S.Farm,"PirateRaid")
    ft:AddSection("Observation")
    local observationStatus=ft:AddParagraph({Title="Observation Range",Content="Checking"})
    toggle(ft,"IKFarmObservation","Auto Farm Observation",S.Farm,"Observation")
    toggle(ft,"IKObservationV2","Auto V2 Observation",S.Farm,"ObservationV2")
    toggle(ft,"IKAutoSaber","Auto Get Saber",S.Farm,"Saber")
    ft:AddSection("Chest Farm")
    toggle(ft,"IKChestTween","Auto Farm Chest [ Tween ]",S.Farm,"ChestTween")
    toggle(ft,"IKChestInstant","Auto Farm Chest [ Instant ]",S.Farm,"ChestInstant")
    toggle(ft,"IKChestHop","Auto Chest Hop",S.Farm,"ChestHop")
    toggle(ft,"IKStopItems","Auto Stop Items",S.Farm,"StopItems")
    toggle(ft,"IKMirageChest","Auto Farm Chest Mirage island",S.Farm,"MirageChest")
    ft:AddSection("Cake Farm")
    local cakeStatus=ft:AddParagraph({Title="Cake Prince Status",Content="Checking"})
    toggle(ft,"IKKatakuri","Auto Katakuri",S.Farm,"Katakuri")
    toggle(ft,"IKSpawnCake","Auto Spawn Cake Prince",S.Farm,"SpawnCake")
    toggle(ft,"IKKillCake","Auto Kill Cake Prince Only",S.Farm,"KillCake")
    toggle(ft,"IKKillDough","Auto Kill Dough King Only",S.Farm,"KillDough")
    ft:AddSection("Materials")
    local materials={{"Radioactive","Radioactive"},{"Mystic Droplet","Mystic"},{"Magma Ore","Magma"},{"Angel Wings","Angel"},{"Leather","Leather"},{"Ectoplasm","Ectoplasm"},{"Scrap Metal","Scrap"},{"Conjured Cocoa","Cocoa"},{"Dragon Scale","Dragon"},{"Gunpowder","Gunpowder"},{"Fish Tail","FishTail"},{"Mini Tusk","MiniTusk"}}
    for _,d in ipairs(materials) do toggle(ft,"IKMaterial"..d[2],"Auto Farm "..d[1],S.Farm,d[2]) end

    local materialMobs={Radioactive={"Factory Staff"},Mystic={"Sea Soldier","Water Fighter"},Magma={"Military Soldier","Military Spy","Magma Ninja","Lava Pirate"},Angel={"God's Guard","Shanda","Royal Squad","Royal Soldier"},Leather={"Pirate","Brute","Marine Captain","Jungle Pirate"},Ectoplasm={"Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer"},Scrap={"Pirate","Brute","Swan Pirate","Jungle Pirate"},Cocoa={"Cocoa Warrior","Chocolate Bar Battler","Sweet Thief","Candy Rebel"},Dragon={"Dragon Crew Warrior","Dragon Crew Archer"},Gunpowder={"Pistol Billionaire"},FishTail={"Fishman Warrior","Fishman Commando","Fishman Raider","Fishman Captain"},MiniTusk={"Mythological Pirate"}}
    local function nameset(list) local out={} for _,n in ipairs(list or {}) do out[n]=true end return out end
    local waterPlatform=Instance.new("Part")
    waterPlatform.Name="IKAROHUB_WalkWater"
    waterPlatform.Anchored=true waterPlatform.CanCollide=true waterPlatform.Transparency=1
    waterPlatform.Size=Vector3.new(12,1,12)
    waterPlatform.Parent=workspace
    local blockedCharacterScripts={General=true,Shiftlock=true,FallDamage=true,["4444"]=true,CamBob=true,JumpCD=true,Looking=true,Run=true}
    local blockedPlayerScripts={RobloxMotor6DBugFix=true,Clans=true,Codes=true,CustomForceField=true,MenuBloodSp=true,PlayerList=true}
    local promptGui=game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
    local promptOverlay=promptGui and promptGui:FindFirstChild("promptOverlay")
    if promptOverlay then
        promptOverlay.ChildAdded:Connect(function(child)
            if S.Setting.Rejoin and child.Name=="ErrorPrompt" then
                task.wait(1)
                TS:TeleportToPlaceInstance(game.PlaceId,game.JobId,player)
            end
        end)
    end
    task.spawn(function()
        local lastStatus=0
        local lastSpawnPoint,lastObservation,lastBone,lastCake=0,0,0,0
        local chestMissingSince=nil
        local eliteMissingSince=nil
        while task.wait(0.08) do
            local char,root,hum=rootHum()
            if char then
                if S.Local.Noclip or S.Farming then noclip(char) end
                if S.Local.Energy then local e=char:FindFirstChild("Energy") if e and e:IsA("NumberValue") then e.Value=math.max(e.Value,12000) end end
                if S.Local.RaceV3 then pcall(function() RS.Remotes.CommE:FireServer("ActivateAbility") end) end
                if S.Local.RaceV4 and char:FindFirstChild("RaceEnergy") and char.RaceEnergy.Value==1 and char:FindFirstChild("RaceTransformed") and not char.RaceTransformed.Value then press("Y") end
                if S.Setting.Haki then haki() end
                if S.Local.Water and root then waterPlatform.CFrame=CFrame.new(root.Position.X,math.min(root.Position.Y-3,2),root.Position.Z) else waterPlatform.CFrame=CFrame.new(0,-10000,0) end
                if S.Setting.Bypass then
                    for _,obj in ipairs(char:GetDescendants()) do if obj:IsA("LocalScript") and blockedCharacterScripts[obj.Name] then pcall(function() obj:Destroy() end) end end
                    local playerScripts=player:FindFirstChild("PlayerScripts")
                    for _,obj in ipairs(playerScripts and playerScripts:GetDescendants() or {}) do if obj:IsA("LocalScript") and blockedPlayerScripts[obj.Name] then pcall(function() obj:Destroy() end) end end
                end
            end
            if S.Setting.Spawn and os.clock()-lastSpawnPoint>=2 then lastSpawnPoint=os.clock() pcall(function() comm:InvokeServer("SetSpawnPoint") end) end
            if S.Setting.Observation and os.clock()-lastObservation>=1 then lastObservation=os.clock() press("E") end
            if S.Setting.White then RunService:Set3dRenderingEnabled(false) else RunService:Set3dRenderingEnabled(true) end
            pcall(function()
                local gui=player:FindFirstChild("PlayerGui")
                local notifications=gui and gui:FindFirstChild("Notifications")
                if notifications then notifications.Enabled=not S.Setting.HideNotify end
                local counter=RS:FindFirstChild("Assets") and RS.Assets:FindFirstChild("GUI") and RS.Assets.GUI:FindFirstChild("DamageCounter")
                if counter then counter.Enabled=not S.Setting.HideDamage end
                local black=gui and gui:FindFirstChild("Main") and gui.Main:FindFirstChild("Blackscreen")
                if black then black.Size=S.Setting.Black and UDim2.new(500,0,500,0) or UDim2.new(1,0,1,0) end
                local enemies=workspace:FindFirstChild("Enemies")
                for _,obj in ipairs(enemies and enemies:GetDescendants() or {}) do
                    if obj:IsA("BasePart") or obj:IsA("Decal") then obj.Transparency=S.Setting.HideMonster and 1 or 0 end
                end
            end)
            if S.Setting.Aura and not S.Farming then local m=closest(nil) if m then rawAttack(m) end end
            S.Farming=false local target local activeNames local masteryKind
            if S.Main.Auto or S.Main.Fast then
                if S.Main.Fast then activeNames=nameset({"Shanda"}) target=closest(activeNames)
                elseif S.Main.Mode=="Nearest" then target=closest(nil)
                else
                    local level=player:FindFirstChild("Data") and player.Data:FindFirstChild("Level") and player.Data.Level.Value or 1
                    target=closest(nil,function(m)
                        local mobLevel=tonumber(m.Name:match("[Ll]v%.?%s*(%d+)") or m.Name:match("(%d+)"))
                        return not mobLevel or mobLevel<=level
                    end)
                end
            elseif S.Main.AutoMob and S.Main.SelectedMob~="None" then activeNames=nameset({S.Main.SelectedMob}) target=closest(activeNames)
            elseif S.Main.AutoBoss and S.Main.SelectedBoss~="None" then activeNames=nameset({S.Main.SelectedBoss}) target=closest(activeNames)
            elseif S.Main.AllBoss then target=closest(nil,function(m) return m.Name:find("Boss") or m.Name=="Cake Prince" or m.Name=="Dough King" end)
            elseif S.Main.FruitMastery or S.Main.GunMastery or S.Main.SwordMastery then
                masteryKind=S.Main.FruitMastery and "Fruit" or S.Main.GunMastery and "Gun" or "Sword"
                if S.Main.MasteryMode=="Cakeprince" then activeNames=nameset({"Cake Prince","Cookie Crafter","Cake Guard","Baking Staff","Head Baker"})
                elseif S.Main.MasteryMode=="Bones" then activeNames=nameset({"Reborn Skeleton","Living Zombie","Demonic Soul","Posessed Mummy"}) end
                target=closest(activeNames)
            elseif S.Farm.Elite then activeNames=nameset({"Diablo","Deandre","Urban"}) target=closest(activeNames)
            elseif S.Farm.Bone then activeNames=nameset({"Reborn Skeleton","Living Zombie","Demonic Soul","Posessed Mummy"}) target=closest(activeNames)
            elseif S.Farm.PirateRaid then target=closest(nil,function(m) local p=targetPart(m) return p and (p.Position-Vector3.new(-5495,314,-2840)).Magnitude<1500 end)
            elseif S.Farm.Observation then activeNames=nameset({"Galley Captain","Lava Pirate","Giant Islander"}) target=closest(activeNames) press("E")
            elseif S.Farm.ObservationV2 then activeNames=nameset({"Forest Pirate","Captain Elephant"}) target=closest(activeNames) pcall(function() comm:InvokeServer("CitizenQuestProgress","Citizen") end)
            elseif S.Farm.Saber then activeNames=nameset({"Saber Expert","Mob Leader"}) target=closest(activeNames)
            elseif S.Farm.Katakuri then activeNames=nameset({"Cake Prince","Dough King","Cookie Crafter","Cake Guard","Baking Staff","Head Baker"}) target=closest(activeNames)
            elseif S.Farm.KillCake then activeNames=nameset({"Cake Prince"}) target=closest(activeNames)
            elseif S.Farm.KillDough then activeNames=nameset({"Dough King"}) target=closest(activeNames)
            else for _,d in ipairs(materials) do if S.Farm[d[2]] then activeNames=nameset(materialMobs[d[2]]) target=closest(activeNames) break end end end
            if target then
                eliteMissingSince=nil S.Farming=true
                if masteryKind then masteryFarm(target,masteryKind) else farm(target) end
            else
                S.CurrentTarget=nil
                local spawn=activeNames and templatePart(activeNames)
                if root and spawn then root.CFrame=root.CFrame:Lerp(spawn.CFrame*CFrame.new(0,S.Setting.Distance,0),0.08) noclip(char) end
                if S.Farm.Elite and S.Farm.EliteHop then
                    eliteMissingSince=eliteMissingSince or os.clock()
                    if os.clock()-eliteMissingSince>=12 then eliteMissingSince=os.clock() hop(true) end
                end
            end
            if S.Farm.Bone and S.Farm.BoneMode=="Quest" and os.clock()-lastObservation>=2 then
                lastObservation=os.clock() pcall(function() comm:InvokeServer("StartQuest","HauntedQuest1",1) end)
            end
            if S.Farm.Saber and not target and root then
                pcall(function()
                    local jungle=workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Jungle")
                    local plates=jungle and jungle:FindFirstChild("QuestPlates")
                    if plates and plates:FindFirstChild("Door") and plates.Door.Transparency==0 then
                        for i=1,5 do local plate=plates:FindFirstChild("Plate"..i) local button=plate and plate:FindFirstChild("Button") if button then root.CFrame=button.CFrame task.wait(0.15) end end
                    else
                        comm:InvokeServer("ProQuestProgress","RichSon")
                        comm:InvokeServer("ProQuestProgress","PlaceRelic")
                    end
                end)
            end
            if S.Farm.RandomBone and os.clock()-lastBone>=1 then lastBone=os.clock() pcall(function() comm:InvokeServer("Bones","Buy",1,1) end) end
            if S.Farm.SpawnCake and os.clock()-lastCake>=2 then lastCake=os.clock() pcall(function() comm:InvokeServer("CakePrinceSpawner",true) end) end
            if S.Farm.ChestTween or S.Farm.ChestInstant or S.Farm.MirageChest then
                local mystic=workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("MysticIsland")
                local folder=S.Farm.MirageChest and mystic and mystic:FindFirstChild("Chests") or workspace:FindFirstChild("ChestModels")
                local chest=folder and folder:FindFirstChildWhichIsA("Model")
                local cp=chest and (chest:FindFirstChild("RootPart") or chest.PrimaryPart) or (folder and folder:FindFirstChildWhichIsA("BasePart"))
                if root and cp then
                    if S.Farm.ChestInstant then root.CFrame=cp.CFrame else root.CFrame=root.CFrame:Lerp(cp.CFrame,0.12) end
                    chestMissingSince=nil
                elseif S.Farm.ChestHop then
                    chestMissingSince=chestMissingSince or os.clock()
                    if os.clock()-chestMissingSince>=10 then chestMissingSince=os.clock() hop(true) end
                end
            end
            if S.Farm.StopItems and char then
                local backpack=player:FindFirstChild("Backpack")
                if (backpack and (backpack:FindFirstChild("God's Chalice") or backpack:FindFirstChild("Fist of Darkness")))
                or char:FindFirstChild("God's Chalice") or char:FindFirstChild("Fist of Darkness") then
                    S.Farm.ChestTween=false S.Farm.ChestInstant=false
                    pcall(function() Options.IKChestTween:SetValue(false) Options.IKChestInstant:SetValue(false) end)
                end
            end
            if os.clock()-lastStatus>2 then
                lastStatus=os.clock()
                pcall(function()
                    job:SetDesc(game.JobId)
                    local sky=Lighting:FindFirstChildOfClass("Sky") local id=sky and sky.MoonTextureId or ""
                    local pct=id:find("9709149431") and "Full Moon 100%" or id:find("9709149052") and "Full Moon 75%" or id:find("9709143733") and "Full Moon 50%" or id:find("9709150401") and "Full Moon 25%" or id:find("9709149680") and "Full Moon 15%" or "Full Moon 0%"
                    moon:SetDesc(pct)
                    local locations=workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Locations")
                    kitsune:SetDesc(locations and locations:FindFirstChild("Kitsune Island") and "SPAWNED" or "Not spawned")
                    frozen:SetDesc(locations and locations:FindFirstChild("Frozen Dimension") and "SPAWNED" or "Not spawned")
                    mirage:SetDesc(locations and locations:FindFirstChild("Mirage Island") and "SPAWNED" or "Not spawned")
                    local found="Nothing" for _,v in ipairs(workspace:GetChildren()) do if v.Name:find("Fruit") then found=v.Name break end end fruit:SetDesc(found)
                    local okDealer,res=pcall(function() return comm:InvokeServer("ColorsDealer","1") end) dealer:SetDesc(okDealer and res and "SPAWNED" or "Not spawned")
                    local data=player:FindFirstChild("Data") boneStatus:SetDesc(tostring(data and data:FindFirstChild("Bones") and data.Bones.Value or 0))
                    observationStatus:SetDesc(tostring(data and data:FindFirstChild("Observation") and data.Observation.Value or "Checking"))
                    local okCake,cake=pcall(function() return comm:InvokeServer("CakePrinceSpawner") end) cakeStatus:SetDesc(okCake and tostring(cake) or "Unavailable")
                    eliteStatus:SetDesc(target and target.Name or "Waiting")
                    bossLabel:SetDesc((S.Main.AutoBoss or S.Main.AllBoss) and (target and target.Name or "Waiting boss") or "Choose Boss")
                    local elapsed=math.floor(workspace.DistributedGameTime+0.5)
                    timeLabel:SetDesc(string.format("Hours: %d Min: %d Sec: %d",math.floor(elapsed/3600)%24,math.floor(elapsed/60)%60,elapsed%60))
                    fpsLabel:SetDesc(tostring(math.floor(workspace:GetRealPhysicsFPS())).." FPS")
                    local stats=game:GetService("Stats")
                    pingLabel:SetDesc(stats.Network.ServerStatsItem["Data Ping"]:GetValueString())
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait(1) do
            if (S.Local.Dodge or S.Local.Ability or S.Local.Geppo or S.Local.Soru)
            and type(getgc)=="function" and type(getupvalues)=="function" and type(setupvalue)=="function" then
                pcall(function()
                    for _,fn in ipairs(getgc(true)) do
                        if typeof(fn)=="function" then
                            local env=type(getfenv)=="function" and getfenv(fn)
                            local scriptName=env and env.script and string.lower(env.script.Name) or ""
                            local wanted=(S.Local.Dodge and scriptName:find("dodge"))
                                or (S.Local.Geppo and scriptName:find("geppo"))
                                or (S.Local.Soru and scriptName:find("soru"))
                                or (S.Local.Ability and (scriptName:find("ability") or scriptName:find("race")))
                            if wanted then
                                for index,value in pairs(getupvalues(fn)) do
                                    if type(value)=="number" then pcall(setupvalue,fn,index,0)
                                    elseif type(value)=="table" and value.LastUse then value.LastUse=0 end
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
    task.spawn(function()
        while task.wait(15) do
            pcall(function()
                local function stock(advanced)
                    local list=comm:InvokeServer("GetFruits",advanced) local out={}
                    for _,v in ipairs(list or {}) do if v.OnSale then table.insert(out,v.Name.." - $"..tostring(v.Price)) end end
                    return #out>0 and table.concat(out,"\n") or "Nothing on sale"
                end
                advance:SetDesc(stock(true)) normal:SetDesc(stock(false))
            end)
        end
    end)
    notify("IKAROHUB","Banana tabs loaded")
    return S
end

return M
