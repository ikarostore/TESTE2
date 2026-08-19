return {Name="Dungeon", Chunks={
{Order=16, Code=[========[	RaidTab:Seperator("Dungeon");
	local TimeRaid = RaidTab:Label("Wait For Dungeon");
	local Island = RaidTab:Label("Start Dungeon");
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible == true then
					TimeRaid:Set((game:GetService("Players")).LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Text);
				else
					TimeRaid:Set("Wait For Dungeon");
				end;
			end;
		end);
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if game.Workspace.Map.RaidMap:FindFirstChild("RaidIsland5") then
					Island:Set("ðŸï¸ Island 5");
				elseif game.Workspace.Map.RaidMap:FindFirstChild("RaidIsland4") then
					Island:Set("ðŸï¸ Island 4");
				elseif game.Workspace.Map.RaidMap:FindFirstChild("RaidIsland3") then
					Island:Set("ðŸï¸ Island 3");
				elseif game.Workspace.Map.RaidMap:FindFirstChild("RaidIsland2") then
					Island:Set("ðŸï¸ Island 2");
				elseif game.Workspace.Map.RaidMap:FindFirstChild("RaidIsland1") then
					Island:Set("ðŸï¸ Island 1");
				else
					Island:Set("Start Dungeon");
				end;
			end;
		end);
	end);
	function ChechRaidMapIsland(island)
		return game.Workspace.Map.RaidMap:FindFirstChild(island);
	end;
	function NextRaidIsland()
		local RaidPos = CFrame.new(0, 35, 0);
		if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible == true then
			if (game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Island 5") then
				topos(((game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Island 5")).CFrame * RaidPos);
			elseif (game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Island 4") then
				topos(((game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Island 4")).CFrame * RaidPos);
			elseif (game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Island 3") then
				topos(((game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Island 3")).CFrame * RaidPos);
			elseif (game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Island 2") then
				topos(((game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Island 2")).CFrame * RaidPos);
			elseif (game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Island 1") then
				topos(((game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Island 1")).CFrame * RaidPos);
			end;
		end;
	end;
	function CheckMonRaids()
		for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
			if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 300 then
				return true;
			else
				return false;
			end;
		end;
	end;
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Raid["Auto Dungeon"] then
					if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible == true then
						if CheckMonRaids() then
							for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 300 then
										pcall(function()
											repeat
												wait();
												Attack();
												EquipWeapon(_G.Settings.Main["Selected Weapon"]);
												topos(v.HumanoidRootPart.CFrame * Pos);
												v.HumanoidRootPart.CanCollide = false;
												v.Humanoid.WalkSpeed = 0;
												v.Head.CanCollide = false;
												v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
											until not _G.Settings.Raid["Auto Dungeon"] or (not v.Parent) or v.Humanoid.Health <= 0;
										end);
									end;
								end;
							end;
						else
							NextRaidIsland();
						end;
					end;
				end;
			end;
		end);
	end);
	Raidslist = {};
	RaidsModule = require(game.ReplicatedStorage.Raids);
	for i, v in pairs(RaidsModule.raids) do
		table.insert(Raidslist, v);
	end;
	for i, v in pairs(RaidsModule.advancedRaids) do
		table.insert(Raidslist, v);
	end;
	RaidTab:Dropdown("Choose Chip", Raidslist, _G.Settings.Raid["Selected Chip"], function(value)
		_G.Settings.Raid["Selected Chip"] = value;
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Raid["Auto Dungeon"] then
					if not (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Special Microchip") or (not (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Special Microchip")) then
						if not (game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Island 1") then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.Settings.Raid["Selected Chip"]);
						end;
					end;
				end;
			end;
		end);
	end);
	RaidTab:Toggle("Auto Dungeon ( Fully )", _G.Settings.Raid["Auto Dungeon"], "Start, Buy Chip, Kill Mob, Next Island", function(value)
		_G.Settings.Raid["Auto Dungeon"] = value;
		StopTween(_G.Settings.Raid["Auto Dungeon"]);
		(getgenv()).SaveSetting();
	end);
	RaidTab:Toggle("Auto Awaken", false, "Auto Awaken When Done Raid", function(value)
		_G.Settings.Raid["Auto Awaken"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Raid["Auto Awaken"] then
				pcall(function()
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Awakener", "Awaken");
				end);
			end;
		end;
	end);
	RaidTab:Slider("Price Devil Fruit", 0, 10000000, _G.Settings.Raid["Price Devil Fruit"], function(value)
		_G.Settings.Raid["Price Devil Fruit"] = value;
		(getgenv()).SaveSetting();
	end);
	RaidTab:Toggle("Auto Unstore Fruit", _G.Settings.Raid["Unstore Devil Fruit"], "Unstore Devil Fruit", function(value)
		_G.Settings.Raid["Unstore Devil Fruit"] = value;
		(getgenv()).SaveSetting();
	end);
	function GetFruitsInfo()
		for i, v in pairs((game:GetService("Players")).LocalPlayer.Backpack:GetChildren()) do
			if string.find(v.Name, "Fruit") then
				return true;
			end;
		end;
		for i, v in pairs((game:GetService("Players")).LocalPlayer.Character:GetChildren()) do
			if string.find(v.Name, "Fruit") then
				return true;
			end;
		end;
		return false;
	end;
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.Raid["Unstore Devil Fruit"] then
					fruit = (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("getInventoryFruits");
					for i, v in pairs(fruit) do
						if v.Price < _G.Settings.Raid["Price Devil Fruit"] then
							if not GetFruitsInfo() then
								(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("LoadFruit", v.Name);
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.Raid["Auto Dungeon"] then
					if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible == false then
						if not game.Workspace.Map.RaidMap:FindFirstChild("RaidIsland1") and (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Special Microchip") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Special Microchip") then
							if World2 then
								fireclickdetector((game:GetService("Workspace")).Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector);
							elseif World3 then
								(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5083.26025390625, 314.6056823730469, -3175.673095703125));
								fireclickdetector((game:GetService("Workspace")).Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector);
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	RaidTab:Button("Teleport to Lab", function()
		if World2 then
			topos(CFrame.new(-6438.73535, 250.645355, -4501.50684));
		elseif World3 then
			topos(CFrame.new(-5017.40869, 314.844055, -2823.0127, -0.925743818, 0.0000000448217499, -0.378151238, 0.00000000455503146, 1, 0.000000107377559, 0.378151238, 0.000000097681621, -0.925743818));
		end;
	end);
	if World2 then
		RaidTab:Seperator("Law Raid");
		RaidTab:Toggle("Auto Raid Law", _G.Settings.Raid["Law Raid"], "Law Raid", function(value)
			_G.Settings.Raid["Law Raid"] = value;
			StopTween(_G.Settings.Raid["Law Raid"]);
			(getgenv()).SaveSetting();
		end);
		spawn(function()
			pcall(function()
				while wait(0.2) do
					if _G.Settings.Raid["Law Raid"] then
						if not (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Microchip") and (not (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Microchip")) and (not (game:GetService("Workspace")).Enemies:FindFirstChild("Order")) and (not (game:GetService("ReplicatedStorage")):FindFirstChild("Order")) then
							wait(0.3);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "1");
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2");
						end;
					end;
				end;
			end);
		end);
		spawn(function()
			pcall(function()
				while wait(0.2) do
					if _G.Settings.Raid["Law Raid"] then
						if not (game:GetService("Workspace")).Enemies:FindFirstChild("Order") and (not (game:GetService("ReplicatedStorage")):FindFirstChild("Order")) then
							if (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Microchip") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Microchip") then
								fireclickdetector((game:GetService("Workspace")).Map.CircleIsland.RaidSummon.Button.Main.ClickDetector);
							end;
						end;
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Order") or (game:GetService("Workspace")).Enemies:FindFirstChild("Order") then
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Order") then
								for h, i in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
									if i.Name == "Order" then
										repeat
											(game:GetService("RunService")).Heartbeat:wait();
											Attack();
											AutoHaki();
											EquipWeapon(_G.Settings.Main["Selected Weapon"]);
											topos(i.HumanoidRootPart.CFrame * Pos);
											i.HumanoidRootPart.CanCollide = false;
											i.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
											Attack();
										until not i.Parent or i.Humanoid.Health <= 0 or _G.Settings.Raid["Law Raid"] == false;
									end;
								end;
							elseif (game:GetService("ReplicatedStorage")):FindFirstChild("Order") then
								topos(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875));
							end;
						end;
					end;
				end;
			end);
		end);
	end;
end;
]========]}
}}
