return {Name="setting farm", Chunks={
{Order=3, Code=[========[SettingsTab:Seperator("Settings");
SettingsTab:Toggle("Spin Position", _G.Settings.Setting["Spin Position"], "Spin Position When Farm", function(value)
	_G.Settings.Setting["Spin Position"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Slider("Farm Distnace", 0, 50, _G.Settings.Setting["Farm Distance"], function(value)
	_G.Settings.Setting["Farm Distance"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Slider("Player Tween Speed", 100, 350, _G.Settings.Setting["Player Tween Speed"], function(value)
	_G.Settings.Setting["Player Tween Speed"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Toggle("Bring Mob", _G.Settings.Setting["Bring Mob"], false, function(value)
	_G.Settings.Setting["Bring Mob"] = value;
	(getgenv()).SaveSetting();
end);
local Bring = {
	"Low",
	"Normal",
	"High"
};
SettingsTab:Dropdown("BringMob Mode", Bring, _G.Settings.Setting["Bring Mob Mode"], function(value)
	_G.Settings.Setting["Bring Mob Mode"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait() do
		if _G.Settings.Setting["Bring Mob Mode"] then
			pcall(function()
				if _G.Settings.Setting["Bring Mob Mode"] == "Low" then
					BringMobDistance = 150;
				elseif _G.Settings.Setting["Bring Mob Mode"] == "Normal" then
					BringMobDistance = 250;
				elseif _G.Settings.Setting["Bring Mob Mode"] == "High" then
					BringMobDistance = 800;
				end;
			end);
		end;
	end;
end);
SettingsTab:Toggle("Fast Attack", _G.Settings.Setting["Fast Attack"], "Fast Attack", function(value)
	_G.Settings.Setting["Fast Attack"] = value;
	(getgenv()).SaveSetting();
end);
local AttackList = {
	"Slow",
	"Normal",
	"Fast",
	"Super Fast"
};
spawn(function()
	while wait() do
		if _G.Settings.Setting["Fast Attack Mode"] == "Slow" then
			_G.Settings.Setting["Fast Attack Delay"] = 0.32;
		elseif _G.Settings.Setting["Fast Attack Mode"] == "Normal" then
			_G.Settings.Setting["Fast Attack Delay"] = 0.22;
		elseif _G.Settings.Setting["Fast Attack Mode"] == "Fast" then
			_G.Settings.Setting["Fast Attack Delay"] = 0.17;
		elseif _G.Settings.Setting["Fast Attack Mode"] == "Super Fast" then
			_G.Settings.Setting["Fast Attack Delay"] = 0.12;
		end;
	end;
end);
SettingsTab:Dropdown("Fast Attack Mode", AttackList, _G.Settings.Setting["Fast Attack Mode"], function(value)
	_G.Settings.Setting["Fast Attack Mode"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Toggle("Attack Aura", _G.Settings.Setting["Attack Aura"], "Attack Mob", function(value)
	_G.Settings.Setting["Attack Aura"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	(game:GetService("RunService")).RenderStepped:Connect(function()
		if _G.Settings.Setting["Attack Aura"] and (not _G.Settings.Main["Auto Farm Fruit Mastery"]) and (not _G.Settings.Main["Auto Farm Gun Mastery"]) then
			pcall(function()
				Attack();
			end);
		end;
	end);
end);
local env = (getgenv or getrenv or getfenv)();
local rs = game:GetService("ReplicatedStorage");
local players = game:GetService("Players");
local client = players.LocalPlayer;
local modules = rs:FindFirstChild("Modules");
local net = modules and modules:FindFirstChild("Net");
local charFolder = workspace:FindFirstChild("Characters");
local enemyFolder = workspace:FindFirstChild("Enemies");
local playerFolder = game:GetService("Players");
function getAllBladeHits(Sizes)
	local Hits = {};
	local Client = game.Players.LocalPlayer;
	local Players = (game:GetService("Players")):GetChildren();
	local Enemies = (game:GetService("Workspace")).Enemies:GetChildren();
	for i = 1, #Enemies do
		local v = Enemies[i];
		local Human = v:FindFirstChildOfClass("Humanoid");
		if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes + 5 then
			table.insert(Hits, Human.RootPart);
		end;
	end;
	for i = 1, #Players do
		local v = Players[i];
		local Human = v.Character:FindFirstChildOfClass("Humanoid");
		if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes + 5 then
			table.insert(Hits, Human.RootPart);
		end;
	end;
	return Hits;
end;
local AttackModule = {};
local RegisterAttack = net and net:FindFirstChild("RE/RegisterAttack");
local RegisterHit = net and net:FindFirstChild("RE/RegisterHit");
function AttackModule:AttackEnemy(EnemyHead, Table)
	if EnemyHead and RegisterAttack and RegisterHit then
		RegisterAttack:FireServer(0);
		RegisterAttack:FireServer(1);
		RegisterAttack:FireServer(2);
		RegisterAttack:FireServer(3);
		RegisterHit:FireServer(EnemyHead, Table or {});
	end;
end;
function AttackModule:AttackNearest()
	if not enemyFolder then
		return;
	end;
	local args = {
		nil,
		{}
	};
	for _, Enemy in enemyFolder:GetChildren() do
		if not args[1] and Enemy:FindFirstChild("HumanoidRootPart", true) and client:DistanceFromCharacter(Enemy.HumanoidRootPart.Position) < 60 then
			args[1] = Enemy:FindFirstChild("HumanoidRootPart");
		elseif Enemy:FindFirstChild("HumanoidRootPart", true) and client:DistanceFromCharacter(Enemy.HumanoidRootPart.Position) < 60 then
			table.insert(args[2], {
				[1] = Enemy,
				[2] = Enemy:FindFirstChild("HumanoidRootPart")
			});
		end;
	end;
	self:AttackEnemy(unpack(args));
end;
function AttackModule:BladeHits()
	self:AttackNearest();
end;
function Attack()
	if not _G.Settings.Main["Auto Farm Fruit Mastery"] or (not _G.Settings.Main["Auto Farm Gun Mastery"]) then
		if _G.Settings.Setting["Fast Attack"] then
			AttackModule:BladeHits();
		else
			AttackModule:BladeHits();
		end;
	end;
end;
SettingsTab:Seperator("Graphic");
SettingsTab:Toggle("Hide Notifications", _G.Settings.Setting["Hide Notification"], "Invisible Notification", function(value)
	_G.Settings.Setting["Hide Notification"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.Setting["Hide Notification"] then
			game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = false;
		else
			game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = true;
		end;
	end;
end);
SettingsTab:Toggle("Hide Damage Text", _G.Settings.Setting["Hide Damage Text"], "Invisible Damage Text", function(value)
	_G.Settings.Setting["Hide Damage Text"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.Setting["Hide Damage Text"] then
			(game:GetService("ReplicatedStorage")).Assets.GUI.DamageCounter.Enabled = false;
		else
			(game:GetService("ReplicatedStorage")).Assets.GUI.DamageCounter.Enabled = true;
		end;
	end;
end);
SettingsTab:Toggle("Black Screen", _G.Settings.Setting["Black Screen"], false, function(value)
	_G.Settings.Setting["Black Screen"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.Setting["Black Screen"] then
			(game:GetService("Players")).LocalPlayer.PlayerGui.Main.Blackscreen.Size = UDim2.new(500, 0, 500, 500);
		else
			(game:GetService("Players")).LocalPlayer.PlayerGui.Main.Blackscreen.Size = UDim2.new(1, 0, 500, 500);
		end;
	end;
end);
SettingsTab:Toggle("White Screen", _G.Settings.Setting["Black Screen"], false, function(value)
	_G.Settings.Setting["White Screen"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.Setting["White Screen"] then
			(game:GetService("RunService")):Set3dRenderingEnabled(false);
		else
			(game:GetService("RunService")):Set3dRenderingEnabled(true);
		end;
	end;
end);
SettingsTab:Toggle("Hide Monsters", _G.Settings.Setting["Hide Monster"], "Invisible Monstera", function(value)
	_G.Settings.Setting["Hide Monster"] = value;
	(getgenv()).SaveSetting();
	while wait(0.2) do
		if _G.Settings.Setting["Hide Monster"] then
			pcall(function()
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetDescendants()) do
					if v.ClassName == "MeshPart" then
						v.Transparency = 1;
					end;
				end;
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetDescendants()) do
					if v.Name == "Head" then
						v.Transparency = 1;
					end;
				end;
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetDescendants()) do
					if v.ClassName == "Accessory" then
						v.Handle.Transparency = 1;
					end;
				end;
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetDescendants()) do
					if v.ClassName == "Decal" then
						v.Transparency = 1;
					end;
				end;
			end);
		else
			pcall(function()
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetDescendants()) do
					if v.ClassName == "MeshPart" then
						v.Transparency = 0;
					end;
				end;
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetDescendants()) do
					if v.Name == "Head" then
						v.Transparency = 0;
					end;
				end;
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetDescendants()) do
					if v.ClassName == "Accessory" then
						v.Handle.Transparency = 0;
					end;
				end;
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetDescendants()) do
					if v.ClassName == "Decal" then
						v.Transparency = 0;
					end;
				end;
			end);
		end;
	end;
end);
SettingsTab:Seperator("Mastery Setting");
SettingsTab:Slider("Kill At %", 1, 100, _G.Settings.Setting["Mastery Health"], function(value)
	_G.Settings.Setting["Mastery Health"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Label("Skill DevilFruit");
SettingsTab:Toggle("Skill Z", _G.Settings.Setting["Fruit Mastery Skill Z"], "Auto Skill Z", function(value)
	_G.Settings.Setting["Fruit Mastery Skill Z"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Toggle("Skill X", _G.Settings.Setting["Fruit Mastery Skill X"], "Auto Skill X", function(value)
	_G.Settings.Setting["Fruit Mastery Skill X"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Toggle("Skill C", _G.Settings.Setting["Fruit Mastery Skill C"], "Auto Skill C", function(value)
	_G.Settings.Setting["Fruit Mastery Skill C"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Toggle("Skill V", _G.Settings.Setting["Fruit Mastery Skill V"], "Auto Skill V", function(value)
	_G.Settings.Setting["Fruit Mastery Skill V"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Toggle("Skill F", _G.Settings.Setting["Fruit Mastery Skill F"], "Auto Skill F", function(value)
	_G.Settings.Setting["Fruit Mastery Skill F"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Label("Skill Gun");
SettingsTab:Toggle("Skill Z", _G.Settings.Setting["Gun Mastery Skill Z"], "Auto Skill Z", function(value)
	_G.Settings.Setting["Gun Mastery Skill Z"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Toggle("Skill X", _G.Settings.Setting["Gun Mastery Skill X"], "Auto Skill X", function(value)
	_G.Settings.Setting["Gun Mastery Skill X"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Seperator("Other");
SettingsTab:Toggle("Auto Set Spawn Point", _G.Settings.Setting["Auto Set Spawn Point"], "Set Spawn Point", function(value)
	_G.Settings.Setting["Auto Set Spawn Point"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(2) do
		if _G.Settings.Setting["Auto Set Spawn Point"] then
			pcall(function()
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("SetSpawnPoint");
			end);
		end;
	end;
end);
SettingsTab:Toggle("Auto Observation", false, "Auto Active Observation", function(value)
	_G.Settings.Setting["Auto Observation"] = value;
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.Setting["Auto Observation"] then
			if not (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
				(game:GetService("VirtualUser")):CaptureController();
				(game:GetService("VirtualUser")):SetKeyDown("0x65");
				wait();
				(game:GetService("VirtualUser")):SetKeyUp("0x65");
			end;
		end;
	end;
end);
SettingsTab:Toggle("Auto Haki", _G.Settings.Setting["Auto Haki"], "Auto Active Buso", function(value)
	_G.Settings.Setting["Auto Haki"] = value;
	(getgenv()).SaveSetting();
end);
SettingsTab:Toggle("Auto Rejoin", _G.Settings.Setting["Auto Rejoin"], "Auto Rejoin if disconnected or get kicked", function(value)
	_G.Settings.Setting["Auto Rejoin"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.Setting["Auto Rejoin"] then
			game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(v)
				if v.Name == "ErrorPrompt" and v:FindFirstChild("MessageArea") and v.MessageArea:FindFirstChild("ErrorFrame") then
					(game:GetService("TeleportService")):Teleport(game.PlaceId);
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.Setting["Auto Haki"] then
			if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
				local args = {
					[1] = "Buso"
				};
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
			end;
		end;
	end;
end);
SettingsTab:Toggle("Bypass Anti Cheat", true, "Reset Flags", function(value)
	_G.Settings.Setting["Bypass Anti Cheat"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		pcall(function()
			if _G.Settings.Setting["Bypass Anti Cheat"] then
				for i, v in pairs((game:GetService("Players")).LocalPlayer.Character:GetDescendants()) do
					if v:IsA("LocalScript") then
						if v.Name == "General" or v.Name == "Shiftlock" or v.Name == "FallDamage" or v.Name == "4444" or v.Name == "CamBob" or v.Name == "JumpCD" or v.Name == "Looking" or v.Name == "Run" then
							v:Destroy();
						end;
					end;
				end;
				for i, v in pairs((game:GetService("Players")).LocalPlayer.PlayerScripts:GetDescendants()) do
					if v:IsA("LocalScript") then
						if v.Name == "RobloxMotor6DBugFix" or v.Name == "Clans" or v.Name == "Codes" or v.Name == "CustomForceField" or v.Name == "MenuBloodSp" or v.Name == "PlayerList" then
							v:Destroy();
						end;
					end;
				end;
			end;
		end);
	end;
end);
]========]},
{Order=13, Code=[========[StatsTab:Seperator("Stats");
local Pointstat = StatsTab:Label("Stat Points");
spawn(function()
	while wait(0.2) do
		pcall(function()
			Pointstat:Set("Stat Points : " .. tostring((game:GetService("Players")).LocalPlayer.Data.Points.Value));
		end);
	end;
end);
StatsTab:Toggle("Melee", _G.Settings.Stats["Auto Add Melee Stats"], "Auto Add Meele Stats", function(value)
	_G.Settings.Stats["Auto Add Melee Stats"] = value;
	(getgenv()).SaveSetting();
end);
StatsTab:Toggle("Defense", _G.Settings.Stats["Auto Add Defense Stats"], "Auto Add Defense Stats", function(value)
	_G.Settings.Stats["Auto Add Defense Stats"] = value;
	(getgenv()).SaveSetting();
end);
StatsTab:Toggle("Sword", _G.Settings.Stats["Auto Add Sword Stats"], "Auto Add Sword Stats", function(value)
	_G.Settings.Stats["Auto Add Sword Stats"] = value;
	(getgenv()).SaveSetting();
end);
StatsTab:Toggle("Gun", _G.Settings.Stats["Auto Add Gun Stats"], "Auto Add Gun Stats", function(value)
	_G.Settings.Stats["Auto Add Gun Stats"] = value;
	(getgenv()).SaveSetting();
end);
StatsTab:Toggle("Devil Fruit", _G.Settings.Stats["Auto Add Devil Fruit Stats"], "Auto Add Fruit Stats", function(value)
	_G.Settings.Stats["Auto Add Devil Fruit Stats"] = value;
	(getgenv()).SaveSetting();
end);
PointStats = 1;
StatsTab:Slider("Point", 1, 100, PointStats, function(value)
	PointStats = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		if game.Players.LocalPlayer.Data.Points.Value >= PointStats then
			if _G.Settings.Stats["Auto Add Melee Stats"] then
				local args = {
					[1] = "AddPoint",
					[2] = "Melee",
					[3] = PointStats
				};
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
			end;
			if _G.Settings.Stats["Auto Add Defense Stats"] then
				local args = {
					[1] = "AddPoint",
					[2] = "Defense",
					[3] = PointStats
				};
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
			end;
			if _G.Settings.Stats["Auto Add Sword Stats"] then
				local args = {
					[1] = "AddPoint",
					[2] = "Sword",
					[3] = PointStats
				};
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
			end;
			if _G.Settings.Stats["Auto Add Gun Stats"] then
				local args = {
					[1] = "AddPoint",
					[2] = "Gun",
					[3] = PointStats
				};
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
			end;
			if _G.Settings.Stats["Auto Add Devil Fruit Stats"] then
				local args = {
					[1] = "AddPoint",
					[2] = "Demon Fruit",
					[3] = PointStats
				};
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
			end;
		end;
	end;
end);
StatsTab:Line();
local Melee = StatsTab:Label("Melee : ");
local Defense = StatsTab:Label("Defense : ");
local Sword = StatsTab:Label("Sword : ");
local Gun = StatsTab:Label("Gun : ");
local Fruit = StatsTab:Label("Fruit : ");
spawn(function()
	while wait(0.2) do
		pcall(function()
			Melee:Set("Melee : " .. game.Players.LocalPlayer.Data.Stats.Melee.Level.Value);
		end);
	end;
end);
spawn(function()
	while wait(0.2) do
		pcall(function()
			Defense:Set("Defense : " .. game.Players.LocalPlayer.Data.Stats.Defense.Level.Value);
		end);
	end;
end);
spawn(function()
	while wait(0.2) do
		pcall(function()
			Sword:Set("Sword : " .. game.Players.LocalPlayer.Data.Stats.Sword.Level.Value);
		end);
	end;
end);
spawn(function()
	while wait(0.2) do
		pcall(function()
			Gun:Set("Gun : " .. game.Players.LocalPlayer.Data.Stats.Gun.Level.Value);
		end);
	end;
end);
spawn(function()
	while wait(0.2) do
		pcall(function()
			Fruit:Set("Fruit : " .. game.Players.LocalPlayer.Data.Stats["Demon Fruit"].Level.Value);
		end);
	end;
end);
if World2 then
]========]}
}}
