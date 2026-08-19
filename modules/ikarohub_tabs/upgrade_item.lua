return {Name="get and upgrade item", Chunks={
{Order=5, Code=[========[	ItemsTab:Seperator("World");
end;
if World1 then
	ItemsTab:Toggle("Auto Second Sea", _G.Settings.Items["Auto Second Sea"], false, function(value)
		_G.Settings.Items["Auto Second Sea"] = value;
		StopTween(_G.Settings.Items["Auto Second Sea"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Second Sea"] then
				pcall(function()
					local MyLevel = (game:GetService("Players")).LocalPlayer.Data.Level.Value;
					if MyLevel >= 700 and World1 then
						if (game:GetService("Workspace")).Map.Ice.Door.CanCollide == false and (game:GetService("Workspace")).Map.Ice.Door.Transparency == 1 then
							local CFrame1 = CFrame.new(4849.29883, 5.65138149, 719.611877);
							repeat
								topos(CFrame1);
								wait();
							until (CFrame1.Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or _G.Settings.Items["Auto Second Sea"] == false;
							wait(1.1);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective");
							wait(0.5);
							EquipWeapon("Key");
							repeat
								topos(CFrame.new(1347.7124, 37.3751602, -1325.6488));
								wait();
							until (Vector3.new(1347.7124, 37.3751602, (-1325.6488)) - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or _G.Settings.Items["Auto Second Sea"] == false;
							wait(0.5);
						elseif (game:GetService("Workspace")).Map.Ice.Door.CanCollide == false and (game:GetService("Workspace")).Map.Ice.Door.Transparency == 1 then
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Ice Admiral") then
								for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
									if v.Name == "Ice Admiral" then
										if not v.Humanoid.Health <= 0 then
											if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												OldCFrameSecond = v.HumanoidRootPart.CFrame;
												repeat
													(game:GetService("RunService")).Heartbeat:wait();
													AutoHaki();
													EquipWeapon(_G.Settings.Main["Selected Weapon"]);
													v.HumanoidRootPart.CanCollide = false;
													v.Humanoid.WalkSpeed = 0;
													v.Head.CanCollide = false;
													v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
													v.HumanoidRootPart.CFrame = OldCFrameSecond;
													topos(v.HumanoidRootPart.CFrame * Pos);
													Attack();
												until not _G.Settings.Items["Auto Second Sea"] or (not v.Parent) or v.Humanoid.Health <= 0;
											end;
										else
											(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelDressrosa");
										end;
									end;
								end;
							elseif (game:GetService("ReplicatedStorage")):FindFirstChild("Ice Admiral") then
								topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Ice Admiral")).HumanoidRootPart.CFrame * CFrame.new(5, 10, 7));
							end;
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World2 then
	ItemsTab:Toggle("Auto Third Sea", _G.Settings.Items["Auto Third Sea"], false, function(value)
		_G.Settings.Items["Auto Third Sea"] = value;
		StopTween(_G.Settings.Items["Auto Third Sea"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Third Sea"] then
				pcall(function()
					if (game:GetService("Players")).LocalPlayer.Data.Level.Value >= 1500 and World2 then
						_G.Settings.Main["Auto Farm"] = false;
						if (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ZQuestProgress", "General") == 0 then
							topos(CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016));
							if ((CFrame.new((-1926.3221435547), 12.819851875305, 1738.3092041016)).Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
								wait(1.5);
								(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin");
							end;
							wait(1.8);
							if (game:GetService("Workspace")).Enemies:FindFirstChild("rip_indra") then
								for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
									if v.Name == "rip_indra" then
										OldCFrameThird = v.HumanoidRootPart.CFrame;
										repeat
											(game:GetService("RunService")).Heartbeat:wait();
											AutoHaki();
											EquipWeapon(_G.Settings.Main["Selected Weapon"]);
											topos(v.HumanoidRootPart.CFrame * Pos);
											v.HumanoidRootPart.CFrame = OldCFrameThird;
											v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
											v.HumanoidRootPart.CanCollide = false;
											v.Humanoid.WalkSpeed = 0;
											Attack();
											(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelZou");
										until _G.Settings.Items["Auto Third Sea"] == false or v.Humanoid.Health <= 0 or (not v.Parent);
									end;
								end;
							elseif not (game:GetService("Workspace")).Enemies:FindFirstChild("rip_indra") and ((CFrame.new((-26880.93359375), 22.848554611206, 473.18951416016)).Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
								topos(CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016));
							end;
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World2 then
	ItemsTab:Toggle("Auto Farm Factory", _G.Settings.Items["Auto Farm Factory"], false, function(value)
		_G.Settings.Items["Auto Farm Factory"] = value;
		StopTween(_G.Settings.Items["Auto Farm Factory"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.Items["Auto Farm Factory"] then
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Core") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Core" and v.Humanoid.Health > 0 then
								repeat
									(game:GetService("RunService")).Heartbeat:wait();
									AutoHaki();
									EquipWeapon(_G.Settings.Main["Selected Weapon"]);
									topos(CFrame.new(448.46756, 199.356781, -441.389252));
									AttackOld();
								until v.Humanoid.Health <= 0 or _G.Settings.Items["Auto Farm Factory"] == false;
							end;
						end;
					else
						topos(CFrame.new(448.46756, 199.356781, -441.389252));
					end;
				end;
			end);
		end;
	end);
elseif World3 then
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
					Kitsunecheck:Set("â›©ï¸ Kitsune Island Spawning");
					_G.KitsuneSpawn = true;
				else
					Kitsunecheck:Set("â›©ï¸ Kitsune Island Not Spawn");
					_G.KitsuneSpawn = false;
				end;
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
					Frozencheck:Set("â„ï¸ Frozen Dimension Spawning");
					_G.FrozenSpawn = true;
				else
					Frozencheck:Set("â„ï¸ Frozen Dimension Not Spawn");
					_G.FrozenSpawn = false;
				end;
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
					Prehistoriccheck:Set("ðŸ¦´ Prehistoric Island Spawning");
					_G.PrehistoricSpawn = true;
				else
					Prehistoriccheck:Set("ðŸ¦´ Prehistoric Island Not Spawn");
					_G.PrehistoricSpawn = false;
				end;
			end;
		end);
	end);
]========]},
{Order=8, Code=[========[	DragonDojoTab:Seperator("Dragon Dojo");
	function getBlazeEmberQuest()
		local ResQuest = ((((game:GetService("ReplicatedStorage")):WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/DragonHunter")):InvokeServer({
			Context = "Check"
		});
		if ResQuest then
			for key, value in pairs(ResQuest) do
				if key == "Text" then
					return value;
				end;
			end;
		end;
	end;
	function getRequestQuest()
		local Req = ((((game:GetService("ReplicatedStorage")):WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/DragonHunter")):InvokeServer({
			Context = "RequestQuest"
		});
		return Req;
	end;
	function getIsOnQuest()
		local ResQuest = ((((game:GetService("ReplicatedStorage")):WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/DragonHunter")):InvokeServer({
			Context = "Check"
		});
		if ResQuest then
			for key, value in pairs(ResQuest) do
				if key == "Text" then
					if string.find(value, "Venomous Assailant") or string.find(value, "Hydra Enforcer") or string.find(value, "Destroy 10 trees") then
						return true;
					end;
				end;
			end;
		end;
		return false;
	end;
	spawn(function()
		while wait(0.2) do
			if _G.Settings.DragonDojo["Auto Farm Blaze Ember"] then
				pcall(function()
					if not _G.OnBlzeQuest and (not getIsOnQuest()) then
						local DragonHunterPos = CFrame.new(5864.86377, 1209.55066, 812.775024, 0.879059196, 0.00000000381980803, 0.476712614, -0.0000000131110456, 1, 0.0000000161639893, -0.476712614, -0.0000000204593036, 0.879059196);
						topos(DragonHunterPos);
						((((game:GetService("ReplicatedStorage")):WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/DragonHunter")):InvokeServer({
							Context = "RequestQuest"
						});
					end;
					SaveBlazeEmberQuest();
					_G.OnBlzeQuest = true;
				end);
			end;
		end;
	end);
	function SaveBlazeEmberQuest()
		if string.find(getBlazeEmberQuest(), "Venomous Assailant") then
			_G.BlazeEmberQuest = "Venomous Assailant";
		elseif string.find(getBlazeEmberQuest(), "Hydra Enforcer") then
			_G.BlazeEmberQuest = "Hydra Enforcer";
		elseif string.find(getBlazeEmberQuest(), "Destroy 10 trees") then
			_G.BlazeEmberQuest = "Destroy 10 trees";
		end;
	end;
	_G.OnBlzeQuest = false;
	spawn(function()
		while wait(0.2) do
			if isQuestCompleated() then
				_G.OnBlzeQuest = false;
			end;
		end;
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.DragonDojo["Auto Farm Blaze Ember"] then
				pcall(function()
					if _G.BlazeEmberQuest == "Venomous Assailant" and _G.OnBlzeQuest then
						autoKillVenemousAssailant();
					elseif _G.BlazeEmberQuest == "Hydra Enforcer" and _G.OnBlzeQuest then
						autoKillHydraEnforcer();
					elseif _G.BlazeEmberQuest == "Destroy 10 trees" and _G.OnBlzeQuest then
						autoDestroyHydraTrees();
					end;
				end);
			end;
		end;
	end);
	function isQuestCompleated()
		for i, v in pairs((game:GetService("Players")).LocalPlayer.PlayerGui.Notifications:GetChildren()) do
			for _, Notif in pairs(v:GetChildren()) do
				if string.find(Notif.Text, "Task completed!") or string.find(Notif.Text, "Head back to the Dojo") then
					return true;
				end;
			end;
		end;
		return false;
	end;
	function CollectBlazeEmber()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (((game:GetService("Workspace")):WaitForChild("EmberTemplate")):FindFirstChild("Part")).CFrame;
	end;
	DragonDojoTab:Toggle("Auto Farm Blaze Ember", _G.Settings.DragonDojo["Auto Farm Blaze Ember"], "Auto Farm Blaze Ember", function(value)
		_G.Settings.DragonDojo["Auto Farm Blaze Ember"] = value;
		StopTween(_G.Settings.DragonDojo["Auto Farm Blaze Ember"]);
		(getgenv()).SaveSetting();
	end);
	function autoKillVenemousAssailant()
		if not (game:GetService("Workspace")).Enemies:FindFirstChild("Venomous Assailant") then
			topos(CFrame.new(4789.29639, 1078.59082, 962.764099, -0.381989956, 0.0000000198627319, 0.924166501, 0.0000000126859874, 1, -0.0000000162490341, -0.924166501, 0.00000000551699708, -0.381989956));
		else
			for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
				if v.Name == "Venomous Assailant" then
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
						repeat
							(game:GetService("RunService")).Heartbeat:wait();
							AutoHaki();
							EquipWeapon(_G.Settings.Main["Selected Weapon"]);
							v.HumanoidRootPart.CanCollide = false;
							v.Humanoid.WalkSpeed = 0;
							v.Head.CanCollide = false;
							v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
							PosMon = v.HumanoidRootPart.CFrame;
							MonFarm = v.Name;
							topos(v.HumanoidRootPart.CFrame * Pos);
							Attack();
						until not v.Parent or v.Humanoid.Health <= 0 or (not _G.Settings.DragonDojo["Auto Farm Blaze Ember"]) or (not _G.OnBlzeQuest);
					end;
				end;
			end;
		end;
	end;
	function autoKillHydraEnforcer()
		if not (game:GetService("Workspace")).Enemies:FindFirstChild("Hydra Enforcer") then
			topos(CFrame.new(4789.29639, 1078.59082, 962.764099, -0.381989956, 0.0000000198627319, 0.924166501, 0.0000000126859874, 1, -0.0000000162490341, -0.924166501, 0.00000000551699708, -0.381989956));
		else
			for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
				if v.Name == "Hydra Enforcer" then
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
						repeat
							(game:GetService("RunService")).Heartbeat:wait();
							AutoHaki();
							EquipWeapon(_G.Settings.Main["Selected Weapon"]);
							v.HumanoidRootPart.CanCollide = false;
							v.Humanoid.WalkSpeed = 0;
							v.Head.CanCollide = false;
							v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
							PosMon = v.HumanoidRootPart.CFrame;
							MonFarm = v.Name;
							topos(v.HumanoidRootPart.CFrame * Pos);
							Attack();
						until not v.Parent or v.Humanoid.Health <= 0 or (not _G.Settings.DragonDojo["Auto Farm Blaze Ember"]) or (not _G.OnBlzeQuest);
					end;
				end;
			end;
		end;
	end;
	function autoDestroyHydraTrees()
		local Pos1 = CFrame.new(5260.28223, 1004.24329, 347.062622, 0.923247099, -0.00000000370291953, 0.384206682, -0.000000000671108058, 1, 0.0000000112505019, -0.384206682, -0.0000000106448379, 0.923247099);
		local Pos2 = CFrame.new(5237.94775, 1004.24329, 429.596344, 0.371416599, 0.00000000207420636, 0.92846632, 0.00000000476562345, 1, -0.00000000414041734, -0.92846632, 0.00000000596254068, 0.371416599);
		local Pos3 = CFrame.new(5320.87793, 1004.24329, 439.152954, 0.136340275, -0.0000000995428806, -0.990662038, 0.0000000610136723, 1, -0.0000000920841288, 0.990662038, -0.0000000478891593, 0.136340275);
		local Pos4 = CFrame.new(5346.70752, 1004.24329, 359.389008, 0.296962529, 0.0000000642768185, -0.954889119, -0.0000000737323518, 1, 0.0000000443832349, 0.954889119, 0.0000000572260639, 0.296962529);
		local myPos = (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame;
		if (myPos.Position - Pos1.Position).Magnitude <= 3 then
			useAllSkill();
		else
			topos(Pos1);
		end;
		if (myPos.Position - Pos2.Position).Magnitude <= 3 then
			useAllSkill();
		else
			topos(Pos2);
		end;
		if (myPos.Position - Pos3.Position).Magnitude <= 3 then
			useAllSkill();
		else
			topos(Pos3);
		end;
		if (myPos.Position - Pos4.Position).Magnitude <= 3 then
			useAllSkill();
		else
			topos(Pos4);
		end;
	end;
	function useAllSkill()
		if DoneSkillFruit == false then
			for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					if v.ToolTip == "Blox Fruit" then
						game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
					end;
				end;
			end;
			(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
			wait(0);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
			(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
			wait(0);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
			(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
			wait(0);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
			(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
			wait(0);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
			(game:service("VirtualInputManager")):SendKeyEvent(true, "F", false, game);
			wait(0);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "F", false, game);
			DoneSkillFruit = true;
		end;
		if DoneSkillMelee == false then
			for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					if v.ToolTip == "Melee" then
						game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
					end;
				end;
			end;
			(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
			wait(0);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
			(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
			wait(0);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
			(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
			wait(0);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
			(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
			wait(0);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
			DoneSkillMelee = true;
		end;
		if DoneSkillSword == false then
			for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					if v.ToolTip == "Sword" then
						game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
					end;
				end;
			end;
			(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
			wait(0);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
			(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
			wait(0);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
			DoneSkillSword = true;
		end;
		if DoneSkillGun == false then
			for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					if v.ToolTip == "Gun" then
						game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
					end;
				end;
			end;
			(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
			wait(0.1);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
			(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
			wait(0.1);
			(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
			DoneSkillGun = true;
		end;
		DoneSkillGun = false;
		DoneSkillSword = false;
		DoneSkillFruit = false;
		DoneSkillMelee = false;
	end;
	DragonDojoTab:Toggle("Auto Collect Blaze Ember", _G.Settings.DragonDojo["Auto Collect Blaze Ember"], false, function(value)
		_G.Settings.DragonDojo["Auto Collect Blaze Ember"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.DragonDojo["Auto Collect Blaze Ember"] then
				pcall(function()
					if ((game:GetService("Workspace")):WaitForChild("EmberTemplate")):FindFirstChild("Part") then
						CollectBlazeEmber();
					end;
				end);
			end;
		end;
	end);
	DragonDojoTab:Line();
	DragonDojoTab:Button("Teleport To Dragon Hunter", function()
		topos(CFrame.new(5864.86377, 1209.55066, 812.775024, 0.879059196, 0.00000000381980803, 0.476712614, -0.0000000131110456, 1, 0.0000000161639893, -0.476712614, -0.0000000204593036, 0.879059196));
	end);
	DragonDojoTab:Button("Craft Volcanic Magnet", function()
		(((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("CraftItem", "Craft", "Volcanic Magnet");
	end);
	CraftTab:Seperator("Scroll Crafts");
	CraftTab:Toggle("Auto Craft Common Scroll", _G.Settings.Craft["Auto Craft Common Scroll"], "Craft Common Scroll", function(value)
		_G.Settings.Craft["Auto Craft Common Scroll"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Craft["Auto Craft Common Scroll"] then
				pcall(function()
					repeat
						wait(1);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "CommonScroll");
					until not _G.Settings.Craft["Auto Craft Common Scroll"];
				end);
			end;
		end;
	end);
	CraftTab:Toggle("Auto Craft Rare Scroll", _G.Settings.Craft["Auto Craft Rare Scroll"], "Craft Rare Scroll", function(value)
		_G.Settings.Craft["Auto Craft Rare Scroll"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Craft["Auto Craft Rare Scroll"] then
				pcall(function()
					repeat
						wait(1);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "RareScroll");
					until not _G.Settings.Craft["Auto Craft Rare Scroll"];
				end);
			end;
		end;
	end);
	CraftTab:Toggle("Auto Craft Legendary Scroll", _G.Settings.Craft["Auto Craft Legendary Scroll"], "Craft Legendary Scroll", function(value)
		_G.Settings.Craft["Auto Craft Legendary Scroll"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Craft["Auto Craft Legendary Scroll"] then
				pcall(function()
					repeat
						wait(1);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LegendaryScroll");
					until not _G.Settings.Craft["Auto Craft Legendary Scroll"];
				end);
			end;
		end;
	end);
	CraftTab:Toggle("Auto Craft Mythical Scroll", _G.Settings.Craft["Auto Craft Mythical Scroll"], "Craft Mythical Scroll", function(value)
		_G.Settings.Craft["Auto Craft Mythical Scroll"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Craft["Auto Craft Mythical Scroll"] then
				pcall(function()
					repeat
						wait(1);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "MythicalScroll");
					until not _G.Settings.Craft["Auto Craft Mythical Scroll"];
				end);
			end;
		end;
	end);
	CraftTab:Seperator("Beast Hunter Crafts");
	CraftTab:Button("Craft Leviathan Crown", function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanCrown");
	end);
	CraftTab:Button("Craft Leviathan Shield", function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanShield");
	end);
	CraftTab:Button("Craft Beast Hunter", function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "BeastHunter");
	end);
	CraftTab:Seperator("Shark Hunter Crafts");
	CraftTab:Button("Craft Tooth Necklace", function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "ToothNecklace");
	end);
	CraftTab:Button("Craft Terror Jaw", function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "TerrorJaw");
	end);
	CraftTab:Button("Craft Monster Magnet", function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "MonsterMagnet");
	end);
end;
ItemsTab:Seperator("Fighting Style");
ItemsTab:Toggle("Auto Superhuman", _G.Settings.Items["Auto Super Human"], false, function(value)
	_G.Settings.Items["Auto Super Human"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	pcall(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Super Human"] then
				if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") and (game:GetService("Players")).LocalPlayer.Data.Beli.Value >= 150000 then
					UnEquipWeapon("Combat");
					wait(0.1);
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyBlackLeg");
				end;
				if game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") or game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") then
					_G.Settings.Main["Selected Weapon"] = "Superhuman";
				end;
				if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") or game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") or game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") or game.Players.LocalPlayer.Character:FindFirstChild("Electro") or game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") or game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") then
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and (game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg")).Level.Value <= 299 then
						_G.Settings.Main["Selected Weapon"] = "Black Leg";
					end;
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and (game.Players.LocalPlayer.Backpack:FindFirstChild("Electro")).Level.Value <= 299 then
						_G.Settings.Main["Selected Weapon"] = "Electro";
					end;
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and (game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate")).Level.Value <= 299 then
						_G.Settings.Main["Selected Weapon"] = "Fishman Karate";
					end;
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and (game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw")).Level.Value <= 299 then
						_G.Settings.Main["Selected Weapon"] = "Dragon Claw";
					end;
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and (game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg")).Level.Value >= 300 and (game:GetService("Players")).LocalPlayer.Data.Beli.Value >= 300000 then
						UnEquipWeapon("Black Leg");
						wait(0.1);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectro");
					end;
					if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and (game.Players.LocalPlayer.Character:FindFirstChild("Black Leg")).Level.Value >= 300 and (game:GetService("Players")).LocalPlayer.Data.Beli.Value >= 300000 then
						UnEquipWeapon("Black Leg");
						wait(0.1);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectro");
					end;
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and (game.Players.LocalPlayer.Backpack:FindFirstChild("Electro")).Level.Value >= 300 and (game:GetService("Players")).LocalPlayer.Data.Beli.Value >= 750000 then
						UnEquipWeapon("Electro");
						wait(0.1);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyFishmanKarate");
					end;
					if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and (game.Players.LocalPlayer.Character:FindFirstChild("Electro")).Level.Value >= 300 and (game:GetService("Players")).LocalPlayer.Data.Beli.Value >= 750000 then
						UnEquipWeapon("Electro");
						wait(0.1);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyFishmanKarate");
					end;
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and (game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate")).Level.Value >= 300 and (game:GetService("Players")).Localplayer.Data.Fragments.Value >= 1500 then
						UnEquipWeapon("Fishman Karate");
						wait(0.1);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1");
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2");
					end;
					if game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and (game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate")).Level.Value >= 300 and (game:GetService("Players")).Localplayer.Data.Fragments.Value >= 1500 then
						UnEquipWeapon("Fishman Karate");
						wait(0.1);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1");
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2");
					end;
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and (game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw")).Level.Value >= 300 and (game:GetService("Players")).LocalPlayer.Data.Beli.Value >= 3000000 then
						UnEquipWeapon("Dragon Claw");
						wait(0.1);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySuperhuman");
					end;
					if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and (game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw")).Level.Value >= 300 and (game:GetService("Players")).LocalPlayer.Data.Beli.Value >= 3000000 then
						UnEquipWeapon("Dragon Claw");
						wait(0.1);
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySuperhuman");
					end;
				end;
			end;
		end;
	end);
end);
ItemsTab:Toggle("Auto DeathStep", _G.Settings.Items["Auto Death Step"], false, function(value)
	_G.Settings.Items["Auto Death Step"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.Items["Auto Death Step"] then
			if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Black Leg") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Black Leg") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Death Step") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Death Step") then
				if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Black Leg") and ((game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Black Leg")).Level.Value >= 450 then
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyDeathStep");
					_G.Settings.Main["Selected Weapon"] = "Death Step";
				end;
				if (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Black Leg") and ((game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Black Leg")).Level.Value >= 450 then
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyDeathStep");
					_G.Settings.Main["Selected Weapon"] = "Death Step";
				end;
				if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Black Leg") and ((game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Black Leg")).Level.Value <= 449 then
					_G.Settings.Main["Selected Weapon"] = "Black Leg";
				end;
			else
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyBlackLeg");
			end;
		end;
	end;
end);
ItemsTab:Toggle("Auto Sharkman Karate", _G.Settings.Items["Auto Fishman Karate"], false, function(value)
	_G.Settings.Items["Auto Fishman Karate"] = value;
	StopTween(_G.Settings.Items["Auto Fishman Karate"]);
	(getgenv()).SaveSetting();
end);
spawn(function()
	pcall(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Fishman Karate"] then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyFishmanKarate");
				if string.find((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySharkmanKarate"), "keys") then
					if (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Water Key") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Water Key") then
						topos(CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365));
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySharkmanKarate");
					elseif (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Fishman Karate") and ((game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Fishman Karate")).Level.Value >= 400 then
					else
						Ms = "Tide Keeper";
						if (game:GetService("Workspace")).Enemies:FindFirstChild(Ms) then
							for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
								if v.Name == Ms then
									OldCFrameShark = v.HumanoidRootPart.CFrame;
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.Head.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										v.HumanoidRootPart.CFrame = OldCFrameShark;
										topos(v.HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
										Attack();
									until not v.Parent or v.Humanoid.Health <= 0 or _G.Settings.Items["Auto Fishman Karate"] == false or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Water Key") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Water Key");
								end;
							end;
						else
							topos(CFrame.new(-3570.18652, 123.328949, -11555.9072, 0.465199202, -0.000000013857326, 0.885206044, 0.0000000040332897, 1, 0.0000000135347511, -0.885206044, -0.00000000272606271, 0.465199202));
							wait(3);
						end;
					end;
				else
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySharkmanKarate");
				end;
			end;
		end;
	end);
end);
ItemsTab:Toggle("Auto Electric Claw", _G.Settings.Items["Auto Electric Claw"], false, function(value)
	_G.Settings.Items["Auto Electric Claw"] = value;
	StopTween(_G.Settings.Items["Auto Electric Claw"]);
	(getgenv()).SaveSetting();
end);
spawn(function()
	pcall(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Electric Claw"] then
				if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electro") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Electro") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electric Claw") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Electric Claw") then
					if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electro") and ((game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electro")).Level.Value >= 400 then
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectricClaw");
						_G.Settings.Main["Selected Weapon"] = "Electric Claw";
					end;
					if (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Electro") and ((game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Electro")).Level.Value >= 400 then
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectricClaw");
						_G.Settings.Main["Selected Weapon"] = "Electric Claw";
					end;
					if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electro") and ((game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electro")).Level.Value <= 399 then
						_G.Settings.Main["Selected Weapon"] = "Electro";
					end;
				else
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectro");
				end;
			end;
			if _G.Settings.Items["Auto Electric Claw"] then
				if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electro") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Electro") then
					if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electro") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Electro") and ((game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electro")).Level.Value >= 400 or ((game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Electro")).Level.Value >= 400 then
						if _G.Settings.Main["Auto Farm"] == false then
							repeat
								(game:GetService("RunService")).Heartbeat:wait();
								topos(CFrame.new(-10371.4717, 330.764496, -10131.4199));
							until not _G.Settings.Items["Auto Electric Claw"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - (CFrame.new((-10371.4717), 330.764496, (-10131.4199))).Position).Magnitude <= 10;
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start");
							wait(2);
							repeat
								task.wait();
								topos(CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438));
							until not _G.Settings.Items["Auto Electric Claw"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - (CFrame.new((-12550.532226563), 336.22631835938, (-7510.4233398438))).Position).Magnitude <= 10;
							wait(1);
							repeat
								task.wait();
								topos(CFrame.new(-10371.4717, 330.764496, -10131.4199));
							until not _G.Settings.Items["Auto Electric Claw"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - (CFrame.new((-10371.4717), 330.764496, (-10131.4199))).Position).Magnitude <= 10;
							wait(1);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectricClaw");
						elseif _G.Settings.Main["Auto Farm"] == true then
							_G.Settings.Main["Auto Farm"] = false;
							wait(1);
							repeat
								task.wait();
								topos(CFrame.new(-10371.4717, 330.764496, -10131.4199));
							until not _G.Settings.Items["Auto Electric Claw"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - (CFrame.new((-10371.4717), 330.764496, (-10131.4199))).Position).Magnitude <= 10;
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start");
							wait(2);
							repeat
								task.wait();
								topos(CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438));
							until not _G.Settings.Items["Auto Electric Claw"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - (CFrame.new((-12550.532226563), 336.22631835938, (-7510.4233398438))).Position).Magnitude <= 10;
							wait(1);
							repeat
								task.wait();
								topos(CFrame.new(-10371.4717, 330.764496, -10131.4199));
							until not _G.Settings.Items["Auto Electric Claw"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - (CFrame.new((-10371.4717), 330.764496, (-10131.4199))).Position).Magnitude <= 10;
							wait(1);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectricClaw");
							_G.Settings.Main["Selected Weapon"] = "Electric Claw";
							wait(0.1);
							_G.Settings.Main["Auto Farm"] = true;
						end;
					end;
				end;
			end;
		end;
	end);
end);
ItemsTab:Toggle("Auto Dragon Talon", _G.Settings.Items["Auto Dragon Talon"], false, function(value)
	_G.Settings.Items["Auto Dragon Talon"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.Items["Auto Dragon Talon"] then
			if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Dragon Claw") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Dragon Talon") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Dragon Talon") then
				if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and ((game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Dragon Claw")).Level.Value >= 400 then
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyDragonTalon");
					_G.Settings.Main["Selected Weapon"] = "Dragon Talon";
				end;
				if (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Dragon Claw") and ((game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Dragon Claw")).Level.Value >= 400 then
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyDragonTalon");
					_G.Settings.Main["Selected Weapon"] = "Dragon Talon";
				end;
				if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and ((game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Dragon Claw")).Level.Value <= 399 then
					_G.Settings.Main["Selected Weapon"] = "Dragon Claw";
				end;
			else
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2");
			end;
		end;
	end;
end);
ItemsTab:Toggle("Auto GodHuman", _G.Settings.Items["Auto God Human"], false, function(value)
	_G.Settings.Items["Auto God Human"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Items["Auto God Human"] then
			pcall(function()
				if (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Superhuman") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Superhuman") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Black Leg") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Black Leg") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Death Step") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Death Step") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Fishman Karate") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Sharkman Karate") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Sharkman Karate") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electro") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Electro") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electric Claw") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Electric Claw") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Dragon Claw") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Dragon Talon") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Dragon Talon") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Godhuman") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Godhuman") then
					if (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySuperhuman", true) == 1 then
						if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Superhuman") and ((game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Superhuman")).Level.Value >= 400 or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Superhuman") and ((game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Superhuman")).Level.Value >= 400 then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyDeathStep");
						end;
					else
						Update:Notify("Not Have Superhuman", 3);
					end;
					if (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyDeathStep", true) == 1 then
						if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Death Step") and ((game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Death Step")).Level.Value >= 400 or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Death Step") and ((game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Death Step")).Level.Value >= 400 then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySharkmanKarate");
						end;
					else
						Update:Notify("Not Have Death Step", 3);
					end;
					if (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySharkmanKarate", true) == 1 then
						if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Sharkman Karate") and ((game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Sharkman Karate")).Level.Value >= 400 or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Sharkman Karate") and ((game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Sharkman Karate")).Level.Value >= 400 then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectricClaw");
						end;
					else
						Update:Notify("Not Have Sharkman Karate", 3);
					end;
					if (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectricClaw", true) == 1 then
						if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electric Claw") and ((game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Electric Claw")).Level.Value >= 400 or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Electric Claw") and ((game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Electric Claw")).Level.Value >= 400 then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyDragonTalon");
						end;
					else
						Update:Notify("Not Have Electric Claw", 3);
					end;
					if (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
						if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Dragon Talon") and ((game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Dragon Talon")).Level.Value >= 400 or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Dragon Talon") and ((game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Dragon Talon")).Level.Value >= 400 then
							if string.find((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyGodhuman", true), "Bring") then
								Update:Notify("Not Have Enough Material", 3);
							else
								(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyGodhuman");
							end;
						end;
					else
						Update:Notify("Not Have Dragon Talon", 3);
					end;
				else
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySuperhuman");
				end;
			end);
		end;
	end;
end);
]========]},
{Order=10, Code=[========[ItemsTab:Seperator("Gun & Sword");
if World3 then
	ItemsTab:Toggle("Auto Buddy Sword", _G.Settings.Items["Auto Buddy Sword"], false, function(value)
		_G.Settings.Items["Auto Buddy Sword"] = value;
		StopTween(_G.Settings.Items["Auto Buddy Sword"]);
		(getgenv()).SaveSetting();
	end);
	local BigMomPos = CFrame.new(-731.2034301757812, 381.5658874511719, -11198.4951171875);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Buddy Sword"] and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Queen") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Cake Queen" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.HumanoidRootPart.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										topos(v.HumanoidRootPart.CFrame * Pos);
										Attack();
									until not _G.Settings.Items["Auto Buddy Sword"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-731.2034301757812, 381.5658874511719, -11198.4951171875));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Cake Queen") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Cake Queen")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
function CheckItemCount(itemName, itemCount)
	for i, v in next, game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory") do
		if v.Name == itemName and v.Count >= itemCount then
			return true;
		end;
	end;
	return false;
end;
function DetectChest()
	local dist = math.huge;
	local name;
	for k, v in pairs(game.Workspace:GetChildren()) do
		if string.match(v.Name, "Chest") then
			local magnitude = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude;
			if magnitude < dist then
				dist = magnitude;
				name = v;
			end;
		end;
	end;
	if not name then
		for i, v in next, (game:GetService("Workspace")).Map:GetDescendants() do
			if v:IsA("Part") and string.find(v.Name, "Chest") then
				local magnitude = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude;
				if magnitude < dist then
					dist = magnitude;
					name = v;
				end;
			end;
		end;
	end;
	return name;
end;
local MobBlacklist = {};
function DetectPartSpawnMob(name)
	local name1;
	if string.find(name, "Lv.") then
		name1 = name:gsub(" %pLv. %d+%p", "");
	end;
	for i, v in pairs((game:GetService("Workspace"))._WorldOrigin.EnemySpawns:GetChildren()) do
		local stringgsub;
		if string.find(v.Name, "Lv.") then
			stringgsub = v.Name:gsub(" %pLv. %d+%p", "");
		end;
		if v:IsA("Part") and (stringgsub and stringgsub == name or name == v.Name or name1 and v.Name == name1) then
			return v;
		end;
	end;
	for i, v in pairs(getnilinstances()) do
		local stringgsub;
		if string.find(v.Name, "Lv.") then
			stringgsub = v.Name:gsub(" %pLv. %d+%p", "");
		end;
		if v:IsA("Part") and (stringgsub and stringgsub == name or name == v.Name or name1 and v.Name == name1) then
			return v;
		end;
	end;
end;
function TeleportSpawnMob(Path, value)
	if typeof(Path) == "table" then
		if #MobBlacklist >= 4 then
			MobBlacklist = {};
			return;
		end;
		local GetPart;
		for i, v in next, Path do
			if not table.find(MobBlacklist, v) then
				GetPart = DetectPartSpawnMob(v);
				repeat
					task.wait();
					topos(GetPart.CFrame * CFrame.new(0, 60, 0));
				until (GetPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 100 or DetectMob(Path) or (not value);
			end;
		end;
	else
		GetPart = DetectPartSpawnMob(Path);
		topos(GetPart.CFrame * CFrame.new(0, 60, 0));
	end;
end;
function DetectMob(c)
	local dist = math.huge;
	local name;
	for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
		local stringgsub = v.Name:gsub(" %pLv. %d+%p", "");
		if (typeof(c) == "table" and (table.find(c, v.Name) or table.find(c, stringgsub)) or (v.Name == c or c == stringgsub)) and v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
			local magnitude = (v.HumanoidRootPart.Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).magnitude;
			if magnitude < dist then
				dist = magnitude;
				name = v;
			end;
		end;
	end;
	return name;
end;
if World3 then
	function DetectRequestSoulGuitar()
		local Mob = {};
		local PlaceId;
		local NameRemote;
		if not CheckItemCount("Ectoplasm", 250) then
			Mob = {
				"Ship Deckhand [Lv. 1250]",
				"Ship Steward [Lv. 1300]",
				"Ship Officer [Lv. 1325]",
				"Ship Engineer [Lv. 1275]"
			};
			PlaceId = 4442272183;
			NameRemote = "TravelDressrosa";
		elseif not CheckItemCount("Bones", 500) then
			Mob = {
				"Reborn Skeleton [Lv. 1975]",
				"Demonic Soul [Lv. 2025]",
				"Living Zombie [Lv. 2000]",
				"Posessed Mummy [Lv. 2050]"
			};
			PlaceId = 7449423635;
			NameRemote = "TravelZou";
		end;
		return Mob, PlaceId, NameRemote;
	end;
	local CommF = (game:GetService("ReplicatedStorage")).Remotes.CommF_;
	function GuitarPuzzleProgress()
		if not CommF:InvokeServer("GuitarPuzzleProgress", "Check") then
			if game.Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" and (game.Lighting.ClockTime > 16 or game.Lighting.ClockTime < 5) then
				if (game:GetService("Players")).LocalPlayer:DistanceFromCharacter(Vector3.new(-8654.314453125, 140.9499053955078, 6167.5283203125)) > 50 then
					topos(CFrame.new(-8654.314453125, 140.9499053955078, 6167.5283203125));
				end;
				CommF:InvokeServer("gravestoneEvent", 2);
				CommF:InvokeServer("gravestoneEvent", 2, true);
				task.wait(1);
			else
				Update:Notify("Hop Full Moon", 5);
				Hop();
			end;
		else
			if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Dialogue.Visible then
				game.VirtualUser:Button1Down(Vector2.new(0, 0));
				game.VirtualUser:Button1Down(Vector2.new(0, 0));
			end;
			if not (CommF:InvokeServer("GuitarPuzzleProgress", "Check")).Swamp then
				if ((CFrame.new((-10171.7607421875), 138.62667846679688, 6008.0654296875)).Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 100 then
					toTarget((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position, (CFrame.new(-10171.7607421875, 138.62667846679688, 6008.0654296875)).Position, CFrame.new(-10171.7607421875, 138.62667846679688 + 20, 6008.0654296875));
				elseif CountZombie() == 6 then
					for i, v in pairs(game.workspace.Enemies:GetChildren()) do
						if v.Name == "Living Zombie [Lv. 2000]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
							repeat
								task.wait();
								EquipWeapon(_G.Settings.Main["Selected Weapon"]);
								AutoHaki();
								v.HumanoidRootPart.CanCollide = false;
								v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
								PosMon = v.HumanoidRootPart.CFrame;
								MonFarm = v.Name;
								topos(v.HumanoidRootPart.CFrame * Pos);
								Attack();
							until v.Humanoid.Health <= 0 or (not v.Parent);
						end;
					end;
				end;
				return;
			elseif not (CommF:InvokeServer("GuitarPuzzleProgress", "Check")).Gravestones then
				if (game:GetService("Players")).LocalPlayer:DistanceFromCharacter(Vector3.new(-8761.4765625, 142.10487365722656, 6086.07861328125)) > 50 then
					topos(CFrame.new(-8761.4765625, 142.10487365722656, 6086.07861328125));
				else
					local ClickSigns = {
						game.workspace.Map["Haunted Castle"].Placard1.Right.ClickDetector,
						game.workspace.Map["Haunted Castle"].Placard2.Right.ClickDetector,
						game.workspace.Map["Haunted Castle"].Placard3.Left.ClickDetector,
						game.workspace.Map["Haunted Castle"].Placard4.Right.ClickDetector,
						game.workspace.Map["Haunted Castle"].Placard5.Left.ClickDetector,
						game.workspace.Map["Haunted Castle"].Placard6.Left.ClickDetector,
						game.workspace.Map["Haunted Castle"].Placard7.Left.ClickDetector
					};
					for i, v in pairs(ClickSigns) do
						fireclickdetector(v);
					end;
				end;
			elseif not (CommF:InvokeServer("GuitarPuzzleProgress", "Check")).Ghost then
				if (game:GetService("Players")).LocalPlayer:DistanceFromCharacter(Vector3.new(-9755.6591796875, 271.0661315917969, 6290.61474609375)) > 50 then
					topos(CFrame.new(-9755.6591796875, 271.0661315917969, 6290.61474609375));
				end;
				CommF:InvokeServer("GuitarPuzzleProgress", "Ghost");
				task.wait(3);
			elseif not (CommF:InvokeServer("GuitarPuzzleProgress", "Check")).Trophies then
				if (game:GetService("Players")).LocalPlayer:DistanceFromCharacter(Vector3.new(-9530.0126953125, 6.104853630065918, 6054.83349609375)) > 50 then
					topos(CFrame.new(-9530.0126953125, 6.104853630065918, 6054.83349609375));
				end;
				local Tablet = game.workspace.Map["Haunted Castle"].Tablet;
				for i, v in pairs(BlankTablets) do
					local x = Tablet[v];
					if x.Line.Position.X ~= 0 then
						repeat
							task.wait();
							fireclickdetector(x.ClickDetector);
						until x.Line.Position.X == 0;
					end;
				end;
				for i, v in pairs(Trophy) do
					local x = game.workspace.Map["Haunted Castle"].Trophies.Quest[v].Handle.CFrame;
					x = tostring(x);
					x = (x:split(", "))[4];
					local c = "180";
					if x == "1" or x == "-1" then
						c = "90";
					end;
					if not string.find(tostring(Tablet[i].Line.Rotation.Z), c) then
						repeat
							task.wait();
							fireclickdetector(Tablet[i].ClickDetector);
						until string.find(tostring(Tablet[i].Line.Rotation.Z), c);
						print(i, c);
					end;
				end;
			elseif not (CommF:InvokeServer("GuitarPuzzleProgress", "Check")).Pipes then
				for i, v in pairs(Pipes) do
					local x = game.workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model[i];
					if x.BrickColor.Name ~= v then
						repeat
							task.wait();
							fireclickdetector(x.ClickDetector);
						until x.BrickColor.Name == v;
					end;
				end;
			end;
		end;
	end;
	function AutoSoulGuitar()
		if (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("soulGuitarBuy", true) == "[You already own this item.]" then
			Update:Notify("You already own this item", 5);
			task.wait(5);
			return;
		end;
		if game.Players.LocalPlayer.Data.Fragments.Value < 5000 then
			task.wait(2);
			Update:Notify("Need 5000 Fragments", 5);
			return;
		end;
		if not CheckItemCount("Ectoplasm", 250) then
			task.wait(2);
			Update:Notify("Need 250 Ectoplasm", 5);
			return;
		end;
		if CheckItemCount("Dark Fragment", 1) and CheckItemCount("Ectoplasm", 250) and CheckItemCount("Bones", 500) then
			(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("soulGuitarBuy", true);
			(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("soulGuitarBuy");
			if World3 then
				GuitarPuzzleProgress();
			else
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelZou");
			end;
			return;
		end;
		if not CheckItemCount("Dark Fragment", 1) then
			if World2 then
				if CheckNameBoss("Darkbeard [Lv. 1000] [Raid Boss]") then
					local v = CheckNameBoss("Darkbeard [Lv. 1000] [Raid Boss]");
					repeat
						task.wait();
						AutoHaki();
						EquipWeapon(_G.Settings.Main["Selected Weapon"]);
						v.HumanoidRootPart.CanCollide = false;
						v.Humanoid.WalkSpeed = 0;
						v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
						topos(v.HumanoidRootPart.CFrame * Pos);
						Attack();
					until v.Humanoid.Health <= 0 or (not v.Parent);
				elseif game.Players.LocalPlayer.Character:FindFirstChild("Fist of Darkness") or game.Players.LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") then
					if ((game:GetService("Workspace")).Map.DarkbeardArena.Summoner.Detection.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
						EquipWeapon("Fist of Darkness");
						firetouchinterest(game.Players.LocalPlayer.Character["Fist of Darkness"].Handle, (game:GetService("Workspace")).Map.DarkbeardArena.Summoner.Detection, 0);
						firetouchinterest(game.Players.LocalPlayer.Character["Fist of Darkness"].Handle, (game:GetService("Workspace")).Map.DarkbeardArena.Summoner.Detection, 1);
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, (game:GetService("Workspace")).Map.DarkbeardArena.Summoner.Detection, 0);
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, (game:GetService("Workspace")).Map.DarkbeardArena.Summoner.Detection, 1);
					else
						topos((game:GetService("Workspace")).Map.DarkbeardArena.Summoner.Detection.CFrame);
					end;
				else
					local v = DetectChest();
					repeat
						task.wait();
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude <= 2 then
							firetouchinterest(v, game.Players.LocalPlayer.Character.HumanoidRootPart, 0);
							firetouchinterest(v, game.Players.LocalPlayer.Character.HumanoidRootPart, 1);
						end;
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude <= 5 then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "W", false, game);
							task.wait();
							(game:service("VirtualInputManager")):SendKeyEvent(false, "W", false, game);
						end;
						InstantTp(v.CFrame * CFrame.new(0, 1, 0));
					until not v or (not v.Parent) or (not _G.Settings.Items["Auto Soul Guitar"]);
				end;
			else
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelDressrosa");
			end;
		else
			local Mob, PlaceId, NameRemote = DetectRequestSoulGuitar();
			if game.PlaceId == PlaceId then
				if not DetectMob(Mob) then
					TeleportSpawnMob(Mob, _G.Settings.Items["Auto Soul Guitar"]);
				else
					local v = DetectMob(Mob);
					repeat
						task.wait();
						EquipWeapon(_G.Settings.Main["Selected Weapon"]);
						AutoHaki();
						v.HumanoidRootPart.CanCollide = false;
						v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
						PosMon = v.HumanoidRootPart.CFrame;
						MonFarm = v.Name;
						topos(v.HumanoidRootPart.CFrame * Pos);
						Attack();
					until not v or (not v.Parent) or v.Humanoid.Health == 0 or (not _G.Settings.Items["Auto Soul Guitar"]);
				end;
			else
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(NameRemote);
			end;
		end;
	end;
	ItemsTab:Toggle("Auto Soul Guitar", _G.Settings.Items["Auto Soul Guitar"], false, function(value)
		_G.Settings.Items["Auto Soul Guitar"] = value;
		StopTween(_G.Settings.Items["Auto Soul Guitar"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.Items["Auto Soul Guitar"] then
					AutoSoulGuitar();
				end;
			end);
		end;
	end);
end;
if World2 then
	ItemsTab:Toggle("Auto Rengoku", _G.Settings.Items["Auto Rengoku"], false, function(value)
		_G.Settings.Items["Auto Rengoku"] = value;
		StopTween(_G.Settings.Items["Auto Rengoku"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Items["Auto Rengoku"] and World2 then
					if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Hidden Key") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Hidden Key") then
						EquipWeapon("Hidden Key");
						topos(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875));
					elseif (game:GetService("Workspace")).Enemies:FindFirstChild("Snow Lurker") or (game:GetService("Workspace")).Enemies:FindFirstChild("Arctic Warrior") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if (v.Name == "Snow Lurker" or v.Name == "Arctic Warrior") and v.Humanoid.Health > 0 then
								repeat
									(game:GetService("RunService")).Heartbeat:wait();
									EquipWeapon(_G.Settings.Main["Selected Weapon"]);
									AutoHaki();
									v.HumanoidRootPart.CanCollide = false;
									v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
									PosMon = v.HumanoidRootPart.CFrame;
									MonFarm = v.Name;
									topos(v.HumanoidRootPart.CFrame * Pos);
									Attack();
								until (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Hidden Key") or _G.Settings.Items["Auto Rengoku"] == false or (not v.Parent) or v.Humanoid.Health <= 0;
							end;
						end;
					else
						topos(CFrame.new(5439.716796875, 84.420944213867, -6715.1635742188));
					end;
				end;
			end;
		end);
	end);
end;
if World3 then
	ItemsTab:Toggle("Auto Hallow Scythe", _G.Settings.Items["Auto Hallow Scythe"], "Auto Kill Soul Reaper", function(value)
		_G.Settings.Items["Auto Hallow Scythe"] = value;
		StopTween(_G.Settings.Items["Auto Hallow Scythe"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Hallow Scythe"] then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Soul Reaper") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if string.find(v.Name, "Soul Reaper") then
								repeat
									(game:GetService("RunService")).Heartbeat:wait();
									EquipWeapon(_G.Settings.Main["Selected Weapon"]);
									AutoHaki();
									v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
									topos(v.HumanoidRootPart.CFrame * Pos);
									Attack();
									v.HumanoidRootPart.Transparency = 1;
								until v.Humanoid.Health <= 0 or _G.Settings.Items["Auto Hallow Scythe"] == false;
							end;
						end;
					elseif (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Hallow Essence") then
						repeat
							topos(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125));
							wait();
						until ((CFrame.new((-8932.322265625), 146.83154296875, 6062.55078125)).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 8;
						EquipWeapon("Hallow Essence");
					elseif (game:GetService("ReplicatedStorage")):FindFirstChild("Soul Reaper") then
						topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Soul Reaper")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
					end;
				end);
			end;
		end;
	end);
end;
if World1 then
	ItemsTab:Toggle("Auto Warden Sword", _G.Settings.Items["Auto Warden Sword"], "Auto Get Warden Sword", function(value)
		_G.Settings.Items["Auto Warden Sword"] = value;
		StopTween(_G.Settings.Items["Auto Warden Sword"]);
		(getgenv()).SaveSetting();
	end);
	local NamfonPos = CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976562);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Warden Sword"] and World1 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Chief Warden") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Chief Warden" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.HumanoidRootPart.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										topos(v.HumanoidRootPart.CFrame * Pos);
										Attack();
									until not _G.Settings.Items["Auto Warden Sword"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976562));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Chief Warden") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Chief Warden")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World3 then
	ItemsTab:Toggle("Auto Cursed Dual Katana", _G.Settings.Items["Auto Cursed Dual Katana"], "Must be have Yama and Tushita", function(value)
		_G.Settings.Items["Auto Cursed Dual Katana"] = value;
		StopTween(_G.Settings.Items["Auto Cursed Dual Katana"]);
		(getgenv()).SaveSetting();
	end);
	ItemsTab:Toggle("Auto Get Yama", _G.Settings.Items["Auto Yama"], "Auto Get Yama Fully", function(value)
		_G.Settings.Items["Auto Yama"] = value;
		(getgenv()).SaveSetting();
	end);
	ItemsTab:Toggle("Auto Get Yama Hop", _G.Settings.Items["Auto Yama"], "Hop If Elite Hunter Not Spawn", function(value)
		_G.Settings.Items["Auto Yama Hop"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Yama Hop"] then
				pcall(function()
					if (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("EliteHunter", "Progress") < 30 then
						if _G.Settings.Items["Auto Yama"] then
							if not (game:GetService("Workspace")).Enemies:FindFirstChild("Diablo") or (not (game:GetService("Workspace")).Enemies:FindFirstChild("Deandre")) or (not (game:GetService("Workspace")).Enemies:FindFirstChild("Urban")) then
								Hop();
							end;
						end;
					end;
				end);
			end;
		end;
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Yama"] then
				if (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("EliteHunter", "Progress") >= 30 then
					repeat
						wait(0.1);
						fireclickdetector((game:GetService("Workspace")).Map.Waterfall.SealedKatana.Handle.ClickDetector);
					until (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Yama") or (not _G.Settings.Items["Auto Yama"]);
				elseif string.find(QuestTitle, "Diablo") or string.find(QuestTitle, "Deandre") or string.find(QuestTitle, "Urban") then
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Diablo") or (game:GetService("Workspace")).Enemies:FindFirstChild("Deandre") or (game:GetService("Workspace")).Enemies:FindFirstChild("Urban") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.HumanoidRootPart.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										topos(v.HumanoidRootPart.CFrame * Pos);
										Attack();
									until _G.Settings.Farm["Auto Elite Hunter"] == false or v.Humanoid.Health <= 0 or (not v.Parent);
								end;
							end;
						end;
					end;
				else
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("EliteHunter");
				end;
			end;
		end;
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.Items["Auto Cursed Dual Katana"] then
					if game.Players.LocalPlayer.Character:FindFirstChild("Tushita") or game.Players.LocalPlayer.Backpack:FindFirstChild("Tushita") or game.Players.LocalPlayer.Character:FindFirstChild("Yama") or game.Players.LocalPlayer.Backpack:FindFirstChild("Yama") then
						if game.Players.LocalPlayer.Character:FindFirstChild("Tushita") or game.Players.LocalPlayer.Backpack:FindFirstChild("Tushita") then
							if game.Players.LocalPlayer.Backpack:FindFirstChild("Tushita") then
								EquipWeapon("Tushita");
							end;
						elseif game.Players.LocalPlayer.Character:FindFirstChild("Yama") or game.Players.LocalPlayer.Backpack:FindFirstChild("Yama") then
							if game.Players.LocalPlayer.Backpack:FindFirstChild("Yama") then
								EquipWeapon("Yama");
							end;
						end;
					else
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("LoadItem", "Tushita");
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.Items["Auto Cursed Dual Katana"] then
					if GetMaterial("Alucard Fragment") == 0 then
						Auto_Quest_Yama_1 = true;
						Auto_Quest_Yama_2 = false;
						Auto_Quest_Yama_3 = false;
						Auto_Quest_Tushita_1 = false;
						Auto_Quest_Tushita_2 = false;
						Auto_Quest_Tushita_3 = false;
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil");
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil");
					elseif GetMaterial("Alucard Fragment") == 1 then
						Auto_Quest_Yama_1 = false;
						Auto_Quest_Yama_2 = true;
						Auto_Quest_Yama_3 = false;
						Auto_Quest_Tushita_1 = false;
						Auto_Quest_Tushita_2 = false;
						Auto_Quest_Tushita_3 = false;
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil");
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil");
					elseif GetMaterial("Alucard Fragment") == 2 then
						Auto_Quest_Yama_1 = false;
						Auto_Quest_Yama_2 = false;
						Auto_Quest_Yama_3 = true;
						Auto_Quest_Tushita_1 = false;
						Auto_Quest_Tushita_2 = false;
						Auto_Quest_Tushita_3 = false;
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil");
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil");
					elseif GetMaterial("Alucard Fragment") == 3 then
						Auto_Quest_Yama_1 = false;
						Auto_Quest_Yama_2 = false;
						Auto_Quest_Yama_3 = false;
						Auto_Quest_Tushita_1 = true;
						Auto_Quest_Tushita_2 = false;
						Auto_Quest_Tushita_3 = false;
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good");
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good");
					elseif GetMaterial("Alucard Fragment") == 4 then
						Auto_Quest_Yama_1 = false;
						Auto_Quest_Yama_2 = false;
						Auto_Quest_Yama_3 = false;
						Auto_Quest_Tushita_1 = false;
						Auto_Quest_Tushita_2 = true;
						Auto_Quest_Tushita_3 = false;
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good");
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good");
					elseif GetMaterial("Alucard Fragment") == 5 then
						Auto_Quest_Yama_1 = false;
						Auto_Quest_Yama_2 = false;
						Auto_Quest_Yama_3 = false;
						Auto_Quest_Tushita_1 = false;
						Auto_Quest_Tushita_2 = false;
						Auto_Quest_Tushita_3 = true;
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good");
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good");
					elseif GetMaterial("Alucard Fragment") == 6 then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]") or (game:GetService("Workspace")).ReplicatedStorage:FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]") then
							Auto_Quest_Yama_1 = false;
							Auto_Quest_Yama_2 = false;
							Auto_Quest_Yama_3 = false;
							Auto_Quest_Tushita_1 = false;
							Auto_Quest_Tushita_2 = false;
							Auto_Quest_Tushita_3 = false;
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]") or (game:GetService("Workspace")).Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200]") then
								for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
									if v.Name == "Cursed Skeleton Boss" or v.Name == "Cursed Skeleton" then
										if v.Humanoid.Health > 0 then
											EquipWeapon(Sword);
											topos(v.HumanoidRootPart.CFrame * pos);
											v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid.JumpPower = 0;
											v.Humanoid.WalkSpeed = 0;
											v.HumanoidRootPart.CanCollide = false;
											PosMon = v.HumanoidRootPart.CFrame;
											MonFarm = v.Name;
											Attack();
										end;
									end;
								end;
							end;
						elseif ((CFrame.new((-12361.7060546875), 603.3547973632812, (-6550.5341796875))).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good");
							wait(1);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil");
							wait(1);
							topos(CFrame.new(-12361.7060546875, 603.3547973632812, -6550.5341796875));
							wait(1.5);
							(game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
							wait(1.5);
							topos(CFrame.new(-12253.5419921875, 598.8999633789062, -6546.8388671875));
						else
							topos(CFrame.new(-12361.7060546875, 603.3547973632812, -6550.5341796875));
						end;
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		while wait(0.2) do
			if Auto_Quest_Yama_1 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Mythological Pirate") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Mythological Pirate" then
								repeat
									wait();
									topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 0, (-2)));
								until _G.Settings.Items["Auto Cursed Dual Katana"] == false or Auto_Quest_Yama_1 == false;
								(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil");
							end;
						end;
					else
						topos(CFrame.new(-13451.46484375, 543.712890625, -6961.0029296875));
					end;
				end);
			end;
		end;
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if Auto_Quest_Yama_2 then
					for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
						if v:FindFirstChild("HazeESP") then
							v.HazeESP.Size = UDim2.new(50, 50, 50, 50);
							v.HazeESP.MaxDistance = "inf";
						end;
					end;
					for i, v in pairs((game:GetService("ReplicatedStorage")):GetChildren()) do
						if v:FindFirstChild("HazeESP") then
							v.HazeESP.Size = UDim2.new(50, 50, 50, 50);
							v.HazeESP.MaxDistance = "inf";
						end;
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
					if Auto_Quest_Yama_2 and v:FindFirstChild("HazeESP") and (v.HumanoidRootPart.Position - PosMonsEsp.Position).magnitude <= 300 then
						v.HumanoidRootPart.CFrame = PosMonsEsp;
						v.HumanoidRootPart.CanCollide = false;
						v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
						if not v.HumanoidRootPart:FindFirstChild("BodyVelocity") then
							local vc = Instance.new("BodyVelocity", v.HumanoidRootPart);
							vc.MaxForce = Vector3.new(1, 1, 1) * math.huge;
							vc.Velocity = Vector3.new(0, 0, 0);
						end;
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		while wait(0.2) do
			if Auto_Quest_Yama_2 then
				pcall(function()
					for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
						if v:FindFirstChild("HazeESP") then
							repeat
								(game:GetService("RunService")).Heartbeat:wait();
								if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
									topos(v.HumanoidRootPart.CFrame * Pos);
								else
									EquipWeapon(Sword);
									topos(v.HumanoidRootPart.CFrame * Pos);
									v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
									v.HumanoidRootPart.Transparency = 1;
									v.Humanoid.JumpPower = 0;
									v.Humanoid.WalkSpeed = 0;
									v.HumanoidRootPart.CanCollide = false;
									PosMon = v.HumanoidRootPart.CFrame;
									MonFarm = v.Name;
									Attack();
									if v.Humanoid.Health <= 0 and v.Humanoid:FindFirstChild("Animator") then
										v.Humanoid.Animator:Destroy();
									end;
								end;
							until _G.Settings.Items["Auto Cursed Dual Katana"] == false or Auto_Quest_Yama_2 == false or (not v.Parent) or v.Humanoid.Health <= 0 or (not v:FindFirstChild("HazeESP"));
						else
							for x, y in pairs((game:GetService("ReplicatedStorage")):GetChildren()) do
								if y:FindFirstChild("HazeESP") then
									if (y.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
										topos(y.HumanoidRootPart.CFrameMon * Pos);
									else
										topos(y.HumanoidRootPart.CFrame * Pos);
									end;
								end;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
	spawn(function()
		while wait(0.2) do
			if Auto_Quest_Yama_3 then
				pcall(function()
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Hallow Essence") then
						topos((game:GetService("Workspace")).Map["Haunted Castle"].Summoner.Detection.CFrame);
					elseif (game:GetService("Workspace")).Map:FindFirstChild("HellDimension") then
						repeat
							wait();
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200]") or (game:GetService("Workspace")).Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200] [Boss]") or (game:GetService("Workspace")).Enemies:FindFirstChild("Hell's Messenger [Lv. 2200] [Boss]") then
								for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
									if v.Name == "Cursed Skeleton" or v.Name == "Cursed Skeleton" or v.Name == "Hell's Messenger" then
										if v.Humanoid.Health > 0 then
											repeat
												(game:GetService("RunService")).Heartbeat:wait();
												EquipWeapon(Sword);
												topos(v.HumanoidRootPart.CFrame * Pos);
												v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
												v.HumanoidRootPart.Transparency = 1;
												v.Humanoid.JumpPower = 0;
												v.Humanoid.WalkSpeed = 0;
												v.HumanoidRootPart.CanCollide = false;
												PosMon = v.HumanoidRootPart.CFrame;
												MonFarm = v.Name;
												Attack();
											until v.Humanoid.Health <= 0 or (not v.Parent) or Auto_Quest_Yama_3 == false;
										end;
									end;
								end;
							else
								wait(5);
								topos((game:GetService("Workspace")).Map.HellDimension.Torch1.CFrame);
								wait(1.5);
								(game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
								(game:GetService("VirtualInputManager")):SendKeyEvent(false, "E", false, game);
								wait(1.5);
								topos((game:GetService("Workspace")).Map.HellDimension.Torch2.CFrame);
								wait(1.5);
								(game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
								(game:GetService("VirtualInputManager")):SendKeyEvent(false, "E", false, game);
								wait(1.5);
								topos((game:GetService("Workspace")).Map.HellDimension.Torch3.CFrame);
								wait(1.5);
								(game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
								(game:GetService("VirtualInputManager")):SendKeyEvent(false, "E", false, game);
								wait(1.5);
								topos((game:GetService("Workspace")).Map.HellDimension.Exit.CFrame);
							end;
						until _G.Settings.Items["Auto Cursed Dual Katana"] == false or Auto_Quest_Yama_3 == false or GetMaterial("Alucard Fragment") == 3;
					elseif (game:GetService("Workspace")).Enemies:FindFirstChild("Soul Reaper") or game.ReplicatedStorage:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Soul Reaper") then
							for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
								if v.Name == "Soul Reaper" then
									if v.Humanoid.Health > 0 then
										repeat
											wait();
											topos(v.HumanoidRootPart.CFrame * Pos);
										until _G.Settings.Items["Auto Cursed Dual Katana"] == false or Auto_Quest_Yama_3 == false or (game:GetService("Workspace")).Map:FindFirstChild("HellDimension");
									end;
								end;
							end;
						else
							topos(CFrame.new(-9570.033203125, 315.9346923828125, 6726.89306640625));
						end;
					else
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1);
					end;
				end);
			end;
		end;
	end);
	spawn(function()
		while wait(0.2) do
			if Auto_Quest_Tushita_1 then
				topos(CFrame.new(-9546.990234375, 21.139892578125, 4686.1142578125));
				wait(5);
				topos(CFrame.new(-6120.0576171875, 16.455780029296875, -2250.697265625));
				wait(5);
				topos(CFrame.new(-9533.2392578125, 7.254445552825928, -8372.69921875));
			end;
		end;
	end);
	spawn(function()
		while wait(0.2) do
			if Auto_Quest_Tushita_2 then
				pcall(function()
					if ((CFrame.new((-5539.3115234375), 313.800537109375, (-2972.372314453125))).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if Auto_Quest_Tushita_2 and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										EquipWeapon(Sword);
										topos(v.HumanoidRootPart.CFrame * Pos);
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid.JumpPower = 0;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.CanCollide = false;
										PosMon = v.HumanoidRootPart.CFrame;
										MonFarm = v.Name;
										Attack();
									until v.Humanoid.Health <= 0 or (not v.Parent) or Auto_Quest_Tushita_2 == false;
								end;
							end;
						end;
					else
						topos(CFrame.new(-5545.1240234375, 313.800537109375, -2976.616455078125));
					end;
				end);
			end;
		end;
	end);
	spawn(function()
		while wait(0.2) do
			if Auto_Quest_Tushita_3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Queen") or game.ReplicatedStorage:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Queen") then
							for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
								if v.Name == "Cake Queen" then
									if v.Humanoid.Health > 0 then
										repeat
											(game:GetService("RunService")).Heartbeat:wait();
											EquipWeapon(Sword);
											topos(v.HumanoidRootPart.CFrame * Pos);
											v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid.JumpPower = 0;
											v.Humanoid.WalkSpeed = 0;
											v.HumanoidRootPart.CanCollide = false;
											PosMon = v.HumanoidRootPart.CFrame;
											MonFarm = v.Name;
											Attack();
										until _G.Settings.Items["Auto Cursed Dual Katana"] == false or Auto_Quest_Tushita_3 == false or (game:GetService("Workspace")).Map:FindFirstChild("HeavenlyDimension");
									end;
								end;
							end;
						else
							topos(CFrame.new(-709.3132934570312, 381.6005859375, -11011.396484375));
						end;
					elseif (game:GetService("Workspace")).Map:FindFirstChild("HeavenlyDimension") then
						repeat
							wait();
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200]") or (game:GetService("Workspace")).Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200] [Boss]") or (game:GetService("Workspace")).Enemies:FindFirstChild("Heaven's Guardian [Lv. 2200] [Boss]") then
								for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
									if v.Name == "Cursed Skeleton" or v.Name == "Cursed Skeleton" or v.Name == "Heaven's Guardian" then
										if v.Humanoid.Health > 0 then
											repeat
												(game:GetService("RunService")).Heartbeat:wait();
												EquipWeapon(Sword);
												topos(v.HumanoidRootPart.CFrame * Pos);
												v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
												v.HumanoidRootPart.Transparency = 1;
												v.Humanoid.JumpPower = 0;
												v.Humanoid.WalkSpeed = 0;
												v.HumanoidRootPart.CanCollide = false;
												PosMon = v.HumanoidRootPart.CFrame;
												MonFarm = v.Name;
												Attack();
											until v.Humanoid.Health <= 0 or (not v.Parent) or Auto_Quest_Tushita_3 == false;
										end;
									end;
								end;
							else
								wait(5);
								topos((game:GetService("Workspace")).Map.HeavenlyDimension.Torch1.CFrame);
								wait(1.5);
								(game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
								wait(1.5);
								topos((game:GetService("Workspace")).Map.HeavenlyDimension.Torch2.CFrame);
								wait(1.5);
								(game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
								wait(1.5);
								topos((game:GetService("Workspace")).Map.HeavenlyDimension.Torch3.CFrame);
								wait(1.5);
								(game:GetService("VirtualInputManager")):SendKeyEvent(true, "E", false, game);
								wait(1.5);
								topos((game:GetService("Workspace")).Map.HeavenlyDimension.Exit.CFrame);
							end;
						until not _G.Settings.Items["Auto Cursed Dual Katana"] or (not Auto_Quest_Tushita_3) or GetMaterial("Alucard Fragment") == 6;
					end;
				end);
			end;
		end;
	end);
	function CheckTorch()
		local a;
		if not (game:GetService("Workspace")).Map.Turtle.QuestTorches.Torch1.Particles.Main.Enabled then
			a = "1";
		elseif not (game:GetService("Workspace")).Map.Turtle.QuestTorches.Torch2.Particles.Main.Enabled then
			a = "2";
		elseif not (game:GetService("Workspace")).Map.Turtle.QuestTorches.Torch3.Particles.Main.Enabled then
			a = "3";
		elseif not (game:GetService("Workspace")).Map.Turtle.QuestTorches.Torch4.Particles.Main.Enabled then
			a = "4";
		elseif not (game:GetService("Workspace")).Map.Turtle.QuestTorches.Torch5.Particles.Main.Enabled then
			a = "5";
		end;
		for i, v in next, (game:GetService("Workspace")).Map.Turtle.QuestTorches:GetChildren() do
			if v:IsA("MeshPart") and string.find(v.Name, a) and (not v.Particles.Main.Enabled) then
				return v;
			end;
		end;
	end;
	ItemsTab:Toggle("Auto Get Tushita", _G.Settings.Items["Auto Tushita"], "Need Spawn Longma and Rip Indra", function(value)
		_G.Settings.Items["Auto Tushita"] = value;
		StopTween(_G.Settings.Items["Auto Tushita"]);
		(getgenv()).SaveSetting();
	end);
	function CheckNameBoss(a)
		for i, v in next, game.ReplicatedStorage:GetChildren() do
			if v:IsA("Model") and (typeof(a) == "table" and table.find(a, v.Name) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
				return v;
			end;
		end;
		for i, v in next, game.Workspace.Enemies:GetChildren() do
			if v:IsA("Model") and (typeof(a) == "table" and table.find(a, v.Name) or v.Name == a) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
				return v;
			end;
		end;
	end;
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Tushita"] and World3 then
				pcall(function()
					if not (game:GetService("Workspace")).Map.Turtle:FindFirstChild("TushitaGate") then
						if CheckNameBoss("Longma [Lv. 2000] [Boss]") then
							local v = CheckNameBoss("Longma [Lv. 2000] [Boss]");
							repeat
								task.wait();
								AutoHaki();
								EquipWeapon(_G.Settings.Main["Selected Weapon"]);
								v.HumanoidRootPart.CanCollide = false;
								v.Humanoid.WalkSpeed = 0;
								v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
								topos(v.HumanoidRootPart.CFrame * Pos);
								Attack();
							until not v or (not v.Parent) or v.Humanoid.Health == 0;
						end;
					elseif CheckNameBoss("rip_indra True Form [Lv. 5000] [Raid Boss]") then
						if not game.Players.LocalPlayer.Character:FindFirstChild("Holy Torch") and (not game.Players.LocalPlayer.Backpack:FindFirstChild("Holy Torch")) then
							topos((game:GetService("Workspace")).Map.Waterfall.SecretRoom.Room.Door.Door.Hitbox.CFrame);
						else
							EquipWeapon("Holy Torch");
							if CheckTorch() then
								topos((CheckTorch()).CFrame);
							end;
						end;
					else
						Update:Notify("Rip Indra Not Spawn", 2);
						task.wait(3);
					end;
				end);
			end;
		end;
	end);
	ItemsTab:Toggle("Auto Canvander", _G.Settings.Items["Auto Canvander"], false, function(value)
		_G.Settings.Items["Auto Canvander"] = value;
		StopTween(_G.Settings.Items["Auto Canvander"]);
		(getgenv()).SaveSetting();
	end);
	local CavandisPos = CFrame.new(5311.07421875, 426.0243835449219, 165.12762451171875);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Canvander"] and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Beautiful Pirate") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Beautiful Pirate" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										task.wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.HumanoidRootPart.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										topos(v.HumanoidRootPart.CFrame * Pos);
										Attack();
									until not _G.Settings.Items["Auto Canvander"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						topos(CavandisPos);
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Beautiful Pirate") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Beautiful Pirate")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World3 then
]========]},
{Order=12, Code=[========[	ItemsTab:Toggle("Auto Dragon Trident", _G.Settings.Items["Auto Dragon Trident"], false, function(value)
		_G.Settings.Items["Auto Dragon Trident"] = value;
		StopTween(_G.Settings.Items["Auto Dragon Trident"]);
		(getgenv()).SaveSetting();
	end);
	local TridentPos = CFrame.new(-3914.830322265625, 123.29389190673828, -11516.8642578125);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Dragon Trident"] and World2 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Tide Keeper") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Tide Keeper" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.HumanoidRootPart.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										topos(v.HumanoidRootPart.CFrame * Pos);
										Attack();
									until not _G.Settings.Items["Auto Dragon Trident"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-3914.830322265625, 123.29389190673828, -11516.8642578125));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Tide Keeper") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Tide Keeper")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World1 then
	local NamfonPos = CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976562);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Warden Sword"] and World1 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Chief Warden") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Chief Warden" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.HumanoidRootPart.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										topos(v.HumanoidRootPart.CFrame * Pos);
										Attack();
									until not _G.Settings.Items["Auto Warden Sword"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976562));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Chief Warden") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Chief Warden")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
	local GayMakPos = CFrame.new(-5023.38330078125, 28.65203285217285, 4332.3818359375);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Greybeard"] and World1 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Greybeard") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Greybeard" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.HumanoidRootPart.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										topos(v.HumanoidRootPart.CFrame * Pos);
										Attack();
									until not _G.Settings.Items["Auto Greybeard"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						topos(GayMakPos);
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-5023.38330078125, 28.65203285217285, 4332.3818359375));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Greybeard") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Greybeard")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
	ItemsTab:Toggle("Auto Pole", _G.Settings.Items["Auto Pole"], false, function(value)
		_G.Settings.Items["Auto Pole"] = value;
		StopTween(_G.Settings.Items["Auto Pole"]);
		(getgenv()).SaveSetting();
	end);
	ItemsTab:Toggle("Auto Shark saw", _G.Settings.Items["Auto Shark Saw"], false, function(value)
		_G.Settings.Items["Auto Shark Saw"] = value;
		StopTween(_G.Settings.Items["Auto Shark Saw"]);
		(getgenv()).SaveSetting();
	end);
	ItemsTab:Toggle("Auto Greybeard", _G.Settings.Items["Auto Greybeard"], false, function(value)
		_G.Settings.Items["Auto Greybeard"] = value;
		StopTween(_G.Settings.Items["Auto Greybeard"]);
		(getgenv()).SaveSetting();
	end);
	local PolePos = CFrame.new(-7748.0185546875, 5606.80615234375, -2305.898681640625);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Pole"] and World1 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Thunder God") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Thunder God" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.HumanoidRootPart.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										topos(v.HumanoidRootPart.CFrame * Pos);
										Attack();
									until not _G.Settings.Items["Auto Pole"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-7748.0185546875, 5606.80615234375, -2305.898681640625));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Thunder God") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Thunder God")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
	local SharkPos = CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Shark Saw"] and World1 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("The Saw") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "The Saw" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.HumanoidRootPart.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										topos(v.HumanoidRootPart.CFrame * Pos);
										Attack();
									until not _G.Settings.Items["Auto Shark Saw"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						topos(SharkPos);
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("The Saw") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("The Saw")).HumanoidRootPart.CFrame * CFrame.new(2, 40, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World2 then
	ItemsTab:Toggle("Auto Swan Glasses", _G.Settings.Items["Auto Swan Glasses"], "Auto Kill Don Swan", function(value)
		_G.Settings.Items["Auto Swan Glasses"] = value;
		StopTween(_G.Settings.Items["Auto Swan Glasses"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Items["Auto Swan Glasses"] then
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Don Swan") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Don Swan" and v.Humanoid.Health > 0 and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
								repeat
									(game:GetService("RunService")).Heartbeat:wait();
									AutoHaki();
									EquipWeapon(_G.Settings.Main["Selected Weapon"]);
									v.HumanoidRootPart.CanCollide = false;
									v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
									topos(v.HumanoidRootPart.CFrame * Pos);
									Attack();
								until _G.Settings.Items["Auto Swan Glasses"] == false or v.Humanoid.Health <= 0;
							end;
						end;
					else
						repeat
							task.wait();
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2284.912109375, 15.537666320801, 905.48291015625));
						until ((CFrame.new(2284.912109375, 15.537666320801, 905.48291015625)).Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 or _G.Settings.Items["Auto Swan Glasses"] == false;
					end;
				end;
			end;
		end);
	end);
end;
if World3 then
	ItemsTab:Seperator("Other");
	ItemsTab:Toggle("Auto Arena Trainer", _G.Settings.Items["Auto Arena Trainer"], false, function(value)
		_G.Settings.Items["Auto Arena Trainer"] = value;
		StopTween(_G.Settings.Items["Auto Arena Trainer"]);
		(getgenv()).SaveSetting();
	end);
	local GGPos = CFrame.new(3757.732421875, 91.99540710449219, 253.65066528320312);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Items["Auto Arena Trainer"] and World3 then
				pcall(function()
					if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == true then
						if string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Training Dummy") or string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Training Dummy") or string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Training Dummy") then
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Training Dummy") or (game:GetService("Workspace")).Enemies:FindFirstChild("Training Dummy") or (game:GetService("Workspace")).Enemies:FindFirstChild("Training Dummy") then
								for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
									if v.Name == "Training Dummy" or v.Name == "Training Dummy" or v.Name == "Training Dummy" then
										if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat
												(game:GetService("RunService")).Heartbeat:wait();
												AutoHaki();
												EquipWeapon(_G.Settings.Main["Selected Weapon"]);
												v.HumanoidRootPart.CanCollide = false;
												v.Humanoid.WalkSpeed = 0;
												v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
												topos(v.HumanoidRootPart.CFrame * Pos);
												Attack();
											until _G.Settings.Items["Auto Arena Trainer"] == false or v.Humanoid.Health <= 0 or (not v.Parent);
										end;
									end;
								end;
							else
								topos(GGPos);
								topos(CFrame.new(3757.732421875, 91.99540710449219, 253.65066528320312));
								if (game:GetService("ReplicatedStorage")):FindFirstChild("Training Dummy") then
									topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Training Dummy")).HumanoidRootPart.CFrame * MethodFarm);
								elseif (game:GetService("ReplicatedStorage")):FindFirstChild("Training Dummy") then
									topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Training Dummy")).HumanoidRootPart.CFrame * MethodFarm);
								elseif (game:GetService("ReplicatedStorage")):FindFirstChild("Training Dummy") then
									topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Training Dummy")).HumanoidRootPart.CFrame * MethodFarm);
								end;
							end;
						end;
					elseif _G.Settings.Items["Auto Arena Trainer"] and (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ArenaTrainer") == "I don't have anything for you right now. Come back later." then
						Hop();
					else
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ArenaTrainer");
					end;
				end);
			end;
		end;
	end);
	ItemsTab:Toggle("Auto Dark Dagger", _G.Settings.Items["Auto Dark Dagger"], false, function(value)
		_G.Settings.Items["Auto Dark Dagger"] = value;
		StopTween(_G.Settings.Items["Auto Dark Dagger"]);
		(getgenv()).SaveSetting();
	end);
	local AdminPos = CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Items["Auto Dark Dagger"] then
					if (game:GetService("Workspace")).Enemies:FindFirstChild("rip_indra True Form") or (game:GetService("Workspace")).Enemies:FindFirstChild("rip_indra") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == ("rip_indra True Form" or v.Name == "rip_indra") and v.Humanoid.Health > 0 and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
								repeat
									(game:GetService("RunService")).Heartbeat:wait();
									AutoHaki();
									EquipWeapon(_G.Settings.Main["Selected Weapon"]);
									v.HumanoidRootPart.CanCollide = false;
									v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
									topos(v.HumanoidRootPart.CFrame * Pos);
									Attack();
								until _G.Settings.Items["Auto Dark Dagger"] == false or v.Humanoid.Health <= 0;
							end;
						end;
					else
						topos(AdminPos);
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781));
					end;
				end;
			end;
		end);
	end);
	ItemsTab:Toggle("Auto Press Haki Button", _G.Settings.Items["Auto Press Haki Button"], "Need Legendary Haki Color", function(value)
		_G.Settings.Items["Auto Press Haki Button"] = value;
		StopTween(_G.Settings.Items["Auto Press Haki Button"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.3) do
			pcall(function()
				if _G.Settings.Items["Auto Press Haki Button"] then
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("activateColor", "Winter Sky");
					wait(0.5);
					repeat
						topos(CFrame.new(-5420.16602, 1084.9657, -2666.8208));
						wait();
					until _G.StopTween == true or _G.Settings.Items["Auto Press Haki Button"] == false or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-5420.16602), 1084.9657, (-2666.8208))).Magnitude <= 10;
					wait(0.5);
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("activateColor", "Pure Red");
					wait(0.5);
					repeat
						topos(CFrame.new(-5414.41357, 309.865753, -2212.45776));
						wait();
					until _G.StopTween == true or _G.Settings.Items["Auto Press Haki Button"] == false or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-5414.41357), 309.865753, (-2212.45776))).Magnitude <= 10;
					wait(0.5);
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("activateColor", "Snow White");
					wait(0.5);
					repeat
						topos(CFrame.new(-4971.47559, 331.565765, -3720.02954));
						wait();
					until _G.StopTween == true or _G.Settings.Items["Auto Press Haki Button"] == false or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-4971.47559), 331.565765, (-3720.02954))).Magnitude <= 10;
					wait(0.5);
					(game:GetService("VirtualUser")):Button1Down(Vector2.new(1280, 600));
					wait(3);
					(game:GetService("VirtualUser")):Button1Down(Vector2.new(1280, 600));
				end;
			end);
		end;
	end);
	ItemsTab:Toggle("Auto Rainbow Haki", _G.Settings.Items["Auto Rainbow Haki"], false, function(value)
		_G.Settings.Items["Auto Rainbow Haki"] = value;
		StopTween(_G.Settings.Items["Auto Rainbow Haki"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Items["Auto Rainbow Haki"] then
					if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false then
						topos(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875));
						if (Vector3.new((-11892.0703125), 930.57672119141, (-8760.1591796875)) - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
							wait(1.5);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("HornedMan", "Bet");
						end;
					elseif (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == true and string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Stone") then
							for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
								if v.Name == "Stone" then
									OldCFrameRainbow = v.HumanoidRootPart.CFrame;
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										topos(v.HumanoidRootPart.CFrame * Pos);
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.CFrame = OldCFrameRainbow;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										Attack();
									until _G.Settings.Items["Auto Rainbow Haki"] == false or v.Humanoid.Health <= 0 or (not v.Parent) or (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false;
								end;
							end;
						else
							topos(CFrame.new(-1086.11621, 38.8425903, 6768.71436, 0.0231462717, -0.592676699, 0.805107772, 0.0000203251839, 0.805323839, 0.592835128, -0.999732077, -0.0137055516, 0.0186523199));
						end;
					elseif (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == true and string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Island Empress") then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Island Empress") then
							for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
								if v.Name == "Island Empress" then
									OldCFrameRainbow = v.HumanoidRootPart.CFrame;
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										topos(v.HumanoidRootPart.CFrame * Pos);
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.CFrame = OldCFrameRainbow;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										Attack();
									until _G.Settings.Items["Auto Rainbow Haki"] == false or v.Humanoid.Health <= 0 or (not v.Parent) or (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false;
								end;
							end;
						else
							topos(CFrame.new(5713.98877, 601.922974, 202.751251, -0.101080291, -0, -0.994878292, -0, 1, -0, 0.994878292, 0, -0.101080291));
						end;
					elseif string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Kilo Admiral") then
							for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
								if v.Name == "Kilo Admiral" then
									OldCFrameRainbow = v.HumanoidRootPart.CFrame;
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										topos(v.HumanoidRootPart.CFrame * Pos);
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										v.HumanoidRootPart.CFrame = OldCFrameRainbow;
										Attack();
									until _G.Settings.Items["Auto Rainbow Haki"] == false or v.Humanoid.Health <= 0 or (not v.Parent) or (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false;
								end;
							end;
						else
							topos(CFrame.new(2877.61743, 423.558685, -7207.31006, -0.989591599, -0, -0.143904909, -0, 1.00000012, -0, 0.143904924, 0, -0.989591479));
						end;
					elseif string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Captain Elephant") then
							for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
								if v.Name == "Captain Elephant" then
									OldCFrameRainbow = v.HumanoidRootPart.CFrame;
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										topos(v.HumanoidRootPart.CFrame * Pos);
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										v.HumanoidRootPart.CFrame = OldCFrameRainbow;
										Attack();
									until _G.Settings.Items["Auto Rainbow Haki"] == false or v.Humanoid.Health <= 0 or (not v.Parent) or (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false;
								end;
							end;
						else
							topos(CFrame.new(-13485.0283, 331.709259, -8012.4873, 0.714521289, 0.0000000798849911, 0.69961375, -0.000000102065748, 1, -0.00000000994383065, -0.69961375, -0.0000000643015241, 0.714521289));
						end;
					elseif string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Beautiful Pirate") then
							for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
								if v.Name == "Beautiful Pirate" then
									OldCFrameRainbow = v.HumanoidRootPart.CFrame;
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										topos(v.HumanoidRootPart.CFrame * Pos);
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										v.HumanoidRootPart.CFrame = OldCFrameRainbow;
										Attack();
									until _G.Settings.Items["Auto Rainbow Haki"] == false or v.Humanoid.Health <= 0 or (not v.Parent) or (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false;
								end;
							end;
						else
							topos(CFrame.new(5312.3598632813, 20.141201019287, -10.158538818359));
						end;
					else
						topos(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875));
						if (Vector3.new((-11892.0703125), 930.57672119141, (-8760.1591796875)) - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
							wait(1.5);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("HornedMan", "Bet");
						end;
					end;
				end;
			end;
		end);
	end);
	ItemsTab:Toggle("Auto Holy Torch", _G.Settings.Items["Auto Holy Torch"], false, function(value)
		_G.Settings.Items["Auto Holy Torch"] = value;
		StopTween(_G.Settings.Items["Auto Holy Torch"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.5) do
			pcall(function()
				if _G.Settings.Items["Auto Holy Torch"] then
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Holy Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Holy Torch") then
						repeat
							wait(0.2);
							EquipWeapon("Holy Torch");
							topos(CFrame.new(-10752.4434, 415.261749, -9367.43848, 1, 0, 0, 0, 1, 0, 0, 0, 1));
						until (Vector3.new((-10752.4434), 415.261749, (-9367.43848)) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5;
						wait(2);
						repeat
							wait(0.2);
							EquipWeapon("Holy Torch");
							topos(CFrame.new(-11671.6289, 333.78125, -9474.31934, 0.300932229, 0, -0.953645527, 0, 1, 0, 0.953645527, 0, 0.300932229));
						until (Vector3.new((-11671.6289), 333.78125, (-9474.31934)) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5;
						wait(2);
						repeat
							wait(0.2);
							EquipWeapon("Holy Torch");
							topos(CFrame.new(-12133.1406, 521.507446, -10654.292, 0.80428642, 0, -0.594241858, 0, 1, 0, 0.594241858, 0, 0.80428642));
						until (Vector3.new((-12133.1406), 521.507446, (-10654.292)) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5;
						wait(2);
						repeat
							wait(0.2);
							EquipWeapon("Holy Torch");
							topos(CFrame.new(-13336.127, 484.521179, -6985.31689, 0.853732228, 0, -0.520712316, 0, 1, 0, 0.520712316, 0, 0.853732228));
						until (Vector3.new((-13336.127), 484.521179, (-6985.31689)) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5;
						wait(2);
						EquipWeapon("Holy Torch");
						repeat
							wait(0.2);
							topos(CFrame.new(-13487.623, 336.436188, -7924.53857, -0.982848108, 0, 0.184417039, 0, 1, 0, -0.184417039, 0, -0.982848108));
						until (Vector3.new((-13487.623), 336.436188, (-7924.53857)) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5;
						wait(2);
					end;
				end;
			end);
		end;
	end);
end;
if World2 then
	ItemsTab:Toggle("Auto Bartlio Quest", _G.Settings.Items["Auto Bartilo Quest"], false, function(value)
		_G.Settings.Items["Auto Bartilo Quest"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Items["Auto Bartilo Quest"] then
					if (game:GetService("Players")).LocalPlayer.Data.Level.Value >= 800 and (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
						if string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == true then
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Swan Pirate") then
								Ms = "Swan Pirate";
								for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
									if v.Name == Ms then
										pcall(function()
											repeat
												(game:GetService("RunService")).Heartbeat:wait();
												EquipWeapon(_G.Settings.Main["Selected Weapon"]);
												AutoHaki();
												v.HumanoidRootPart.CanCollide = false;
												v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
												topos(v.HumanoidRootPart.CFrame * Pos);
												PosMon = v.HumanoidRootPart.CFrame;
												MonFarm = v.Name;
												Attack();
											until not v.Parent or v.Humanoid.Health <= 0 or _G.Settings.Items["Auto Bartilo Quest"] == false or (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false;
										end);
									end;
								end;
							else
								repeat
									topos(CFrame.new(932.624451, 156.106079, 1180.27466, -0.973085582, 0.0000000455137119, -0.230443969, 0.0000000267024713, 1, 0.0000000847491108, 0.230443969, 0.0000000763147128, -0.973085582));
									wait();
								until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(932.624451, 156.106079, 1180.27466, (-0.973085582), 0.0000000455137119, (-0.230443969), 0.0000000267024713, 1, 0.0000000847491108, 0.230443969, 0.0000000763147128, (-0.973085582))).Magnitude <= 10;
							end;
						else
							repeat
								topos(CFrame.new(-456.28952, 73.0200958, 299.895966));
								wait();
							until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-456.28952), 73.0200958, 299.895966)).Magnitude <= 10;
							wait(1.1);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest", 1);
						end;
					elseif (game:GetService("Players")).LocalPlayer.Data.Level.Value >= 800 and (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Jeremy") then
							Ms = "Jeremy";
							for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
								if v.Name == Ms then
									OldCFrameBartlio = v.HumanoidRootPart.CFrame;
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										AutoHaki();
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										v.HumanoidRootPart.CFrame = OldCFrameBartlio;
										topos(v.HumanoidRootPart.CFrame * Pos);
										Attack();
									until not v.Parent or v.Humanoid.Health <= 0 or _G.Settings.Items["Auto Bartilo Quest"] == false;
								end;
							end;
						elseif (game:GetService("ReplicatedStorage")):FindFirstChild("Jeremy [Lv. 850] [Boss]") then
							repeat
								topos(CFrame.new(-456.28952, 73.0200958, 299.895966));
								wait();
							until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-456.28952), 73.0200958, 299.895966)).Magnitude <= 10;
							wait(1.1);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo");
							wait(1);
							repeat
								topos(CFrame.new(2099.88159, 448.931, 648.997375));
								wait();
							until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(2099.88159, 448.931, 648.997375)).Magnitude <= 10;
							wait(2);
						else
							repeat
								topos(CFrame.new(2099.88159, 448.931, 648.997375));
								wait();
							until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(2099.88159, 448.931, 648.997375)).Magnitude <= 10;
						end;
					elseif (game:GetService("Players")).LocalPlayer.Data.Level.Value >= 800 and (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
						repeat
							topos(CFrame.new(-1850.49329, 13.1789551, 1750.89685));
							wait();
						until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-1850.49329), 13.1789551, 1750.89685)).Magnitude <= 10;
						wait(1);
						repeat
							topos(CFrame.new(-1858.87305, 19.3777466, 1712.01807));
							wait();
						until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-1858.87305), 19.3777466, 1712.01807)).Magnitude <= 10;
						wait(1);
						repeat
							topos(CFrame.new(-1803.94324, 16.5789185, 1750.89685));
							wait();
						until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-1803.94324), 16.5789185, 1750.89685)).Magnitude <= 10;
						wait(1);
						repeat
							topos(CFrame.new(-1858.55835, 16.8604317, 1724.79541));
							wait();
						until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-1858.55835), 16.8604317, 1724.79541)).Magnitude <= 10;
						wait(1);
						repeat
							topos(CFrame.new(-1869.54224, 15.987854, 1681.00659));
							wait();
						until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-1869.54224), 15.987854, 1681.00659)).Magnitude <= 10;
						wait(1);
						repeat
							topos(CFrame.new(-1800.0979, 16.4978027, 1684.52368));
							wait();
						until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-1800.0979), 16.4978027, 1684.52368)).Magnitude <= 10;
						wait(1);
						repeat
							topos(CFrame.new(-1819.26343, 14.795166, 1717.90625));
							wait();
						until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-1819.26343), 14.795166, 1717.90625)).Magnitude <= 10;
						wait(1);
						repeat
							topos(CFrame.new(-1813.51843, 14.8604736, 1724.79541));
							wait();
						until not _G.Settings.Items["Auto Bartilo Quest"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-1813.51843), 14.8604736, 1724.79541)).Magnitude <= 10;
					end;
				end;
			end;
		end);
	end);
end;
spawn(function()
	while task.wait() do
		if _G.Settings.Setting["Bring Mob"] then
			pcall(function()
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if not string.find(v.Name, "Boss") and v.Name == MonFarm and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= BringMobDistance then
						v.HumanoidRootPart.CFrame = PosMon;
						v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
					end;
				end;
			end);
		end;
	end;
end);
spawn(function()
	(game:GetService("RunService")).RenderStepped:Connect(function()
		wait();
		if setscriptable then
			setscriptable(game.Players.LocalPlayer, "SimulationRadius", true);
		end;
		if sethiddenproperty then
			sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge);
		end;
	end);
end);
]========]}
}}
