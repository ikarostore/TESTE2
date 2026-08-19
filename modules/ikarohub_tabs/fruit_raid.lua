return {Name="Fruit and Raid", Chunks={
{Order=19, Code=[========[FruitTab:Seperator("Fruits");
FruitTab:Toggle("Auto Random Fruit", _G.Settings.Fruit["Auto Buy Random Fruit"], "Auto Buy Random Fruit", function(value)
	_G.Settings.Fruit["Auto Buy Random Fruit"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	pcall(function()
		while wait(0.2) do
			if _G.Settings.Fruit["Auto Buy Random Fruit"] then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Cousin", "Buy");
			end;
		end;
	end);
end);
FruitTab:Button("Random Fruit", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Cousin", "Buy");
end);
FruitTab:Button("Open Devil Shop", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("GetFruits");
	(game:GetService("Players")).LocalPlayer.PlayerGui.Main.FruitShop.Visible = true;
end);
local RarityFruits = {
	Common = {
		"Rocket Fruit",
		"Spin Fruit",
		"Chop Fruit",
		"Spring Fruit",
		"Bomb Fruit",
		"Smoke Fruit",
		"Spike Fruit"
	},
	Uncommon = {
		"Flame Fruit",
		"Falcon Fruit",
		"Ice Fruit",
		"Sand Fruit",
		"Diamond Fruit",
		"Dark Fruit"
	},
	Rare = {
		"Light Fruit",
		"Rubber Fruit",
		"Barrier Fruit",
		"Ghost Fruit",
		"Magma Fruit"
	},
	Legendary = {
		"Quake Fruit",
		"Budha Fruit",
		"Love Fruit",
		"Spider Fruit",
		"Sound Fruit",
		"Phoenix Fruit",
		"Portal Fruit",
		"Rumble Fruit",
		"Pain Fruit",
		"Blizzard Fruit"
	},
	Mythical = {
		"Gravity Fruit",
		"Mammoth Fruit",
		"T-Rex Fruit",
		"Dough Fruit",
		"Shadow Fruit",
		"Venom Fruit",
		"Control Fruit",
		"Spirit Fruit",
		"Dragon Fruit",
		"Leopard Fruit",
		"Kitsune Fruit"
	}
};
local SelectRarityFruits = {
	"Common - Mythical",
	"Uncommon - Mythical",
	"Rare - Mythical",
	"Legendary - Mythical",
	"Mythical"
};
local ResultUnstoreFruits = {};
FruitTab:Dropdown("Store Rarity Fruit", SelectRarityFruits, _G.Settings.Fruit["Store Rarity Fruit"], function(value)
	_G.Settings.Fruit["Store Rarity Fruit"] = value;
	(getgenv()).SaveSetting();
end);
function CheckFruits()
	for i, v in pairs(RarityFruits) do
		if _G.Settings.Fruit["Store Rarity Fruit"] == "Common - Mythical" then
			if i == "Common" or i == "Uncommon" or i == "Rare" or i == "Legendary" or i == "Mythical" then
				for _, fruit in ipairs(v) do
					table.insert(ResultStoreFruits, fruit);
				end;
			end;
		elseif _G.Settings.Fruit["Store Rarity Fruit"] == "Uncommon - Mythical" then
			if i == "Uncommon" or i == "Rare" or i == "Legendary" or i == "Mythical" then
				for _, fruit in ipairs(v) do
					table.insert(ResultStoreFruits, fruit);
				end;
			end;
		elseif _G.Settings.Fruit["Store Rarity Fruit"] == "Rare - Mythical" then
			if i == "Rare" or i == "Legendary" or i == "Mythical" then
				for _, fruit in ipairs(v) do
					table.insert(ResultStoreFruits, fruit);
				end;
			end;
		elseif _G.Settings.Fruit["Store Rarity Fruit"] == "Legendary - Mythical" then
			if i == "Legendary" or i == "Mythical" then
				for _, fruit in ipairs(v) do
					table.insert(ResultStoreFruits, fruit);
				end;
			end;
		elseif _G.Settings.Fruit["Store Rarity Fruit"] == "Mythical" then
			if i == "Mythical" then
				for _, fruit in ipairs(v) do
					table.insert(ResultStoreFruits, fruit);
				end;
			end;
		end;
	end;
end;
FruitTab:Toggle("Auto Store Fruit", _G.Settings.Fruit["Auto Store Fruit"], "Store Fruit", function(value)
	_G.Settings.Fruit["Auto Store Fruit"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		pcall(function()
			if _G.Settings.Fruit["Auto Store Fruit"] then
				for i, v in pairs((game:GetService("Players")).LocalPlayer.Backpack:GetChildren()) do
					if string.find(v.Name, "Fruit") then
						ResultStoreFruits = {};
						CheckFruits();
						for z, Res in pairs(ResultStoreFruits) do
							if v.Name == Res then
								local NameFruit = v.Name;
								local FirstNameFruit = string.gsub(v.Name, " Fruit", "");
								if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild(NameFruit) then
									(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("StoreFruit", FirstNameFruit .. "-" .. FirstNameFruit, (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild(NameFruit));
								end;
							end;
						end;
					end;
				end;
			end;
		end);
	end;
end);
FruitTab:Toggle("Fruit Notification", _G.Settings.Fruit["Fruit Notification"], "Add Notification When Fruit Spawn", function(value)
	_G.Settings.Fruit["Fruit Notification"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(2) do
		if _G.Settings.Fruit["Fruit Notification"] then
			for i, v in pairs(game.Workspace:GetChildren()) do
				if string.find(v.Name, "Fruit") then
					Update:Notify("Fruit : " .. v.Nmae, 3);
				end;
			end;
		end;
	end;
end);
FruitTab:Toggle("Teleport To Fruit", _G.Settings.Fruit["Teleport To Fruit"], "Teleport To Fruit Instant", function(value)
	_G.Settings.Fruit["Teleport To Fruit"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.Fruit["Teleport To Fruit"] then
			for i, v in pairs(game.Workspace:GetChildren()) do
				if string.find(v.Name, "Fruit") then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame;
				end;
			end;
		end;
	end;
end);
FruitTab:Toggle("Tween To Fruit", _G.Settings.Fruit["Tween To Fruit"], "Teleport To Fruit Using Tween", function(value)
	_G.Settings.Fruit["Tween To Fruit"] = value;
	StopTween(_G.Settings.Fruit["Tween To Fruit"]);
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.Fruit["Tween To Fruit"] then
			for i, v in pairs(game.Workspace:GetChildren()) do
				if string.find(v.Name, "Fruit") then
					topos(v.Handle.CFrame);
				end;
			end;
		end;
	end;
end);
FruitTab:Button("Grab All Fruits", function()
	for i, v in pairs(game.Workspace:GetChildren()) do
		if v:IsA("Tool") then
			v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;
		end;
	end;
end);
FruitTab:Seperator("Visual");
FruitTab:Button("Rain Fruit", function()
	for h, i in pairs((game:GetObjects("rbxassetid://14759368201"))[1]:GetChildren()) do
		i.Parent = game.Workspace.Map;
		i:MoveTo(game.Players.LocalPlayer.Character.PrimaryPart.Position + Vector3.new(math.random((-50), 50), 100, math.random((-50), 50)));
		if i.Fruit:FindFirstChild("AnimationController") then
			((i.Fruit:FindFirstChild("AnimationController")):LoadAnimation(i.Fruit:FindFirstChild("Idle"))):Play();
		end;
		i.Handle.Touched:Connect(function(cR)
			if cR.Parent == game.Players.LocalPlayer.Character then
				i.Parent = game.Players.LocalPlayer.Backpack;
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(i);
			end;
		end);
	end;
end);
]========]}
}}
