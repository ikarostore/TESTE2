return {Name="upgrade Race", Chunks={
{Order=14, Code=[========[	RaceV4Tab:Seperator("Race V2");
	RaceV4Tab:Toggle("Auto Evo Race [ V2 ]", _G.Settings.Race["Auto Race V2"], false, function(value)
		_G.Settings.Race["Auto Race V2"] = value;
		StopTween(_G.Settings.Race["Auto Race V2"]);
		(getgenv()).SaveSetting();
	end);
	RaceV4Tab:Toggle("Auto Evo Race [ V3 ]", _G.Settings.Race["Auto Race V3"], "false", function(value)
		_G.Settings.Race["Auto Race V3"] = value;
		StopTween(_G.Settings.Race["Auto Race V3"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait() do
			pcall(function()
				if _G.AutoSeabeasts then
					if (game:GetService("Workspace")):FindFirstChild("SeaBeasts") then
						for i, v in pairs((game:GetService("Workspace")).SeaBeasts:GetChildren()) do
							if CheckSeaBeast() then
								repeat
									wait();
									local CFrameSeaBeast = v.HumanoidRootPart.CFrame * CFrame.new(0, 200, 0);
									if (CFrameSeaBeast.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).Magnitude <= 200 then
										_G.SeaSkill = true;
									else
										_G.SeaSkill = false;
									end;
									Skillaimbot = true;
									AimBotSkillPosition = v.HumanoidRootPart.CFrame.Position;
									topos(CFrameSeaBeast * CFrame.new(0, 200, 0));
								until not _G.AutoSeabeasts or CheckSeaBeast() == false or (not v:FindFirstChild("Humanoid")) or (not v:FindFirstChild("HumanoidRootPart")) or v.Humanoid.Health < 0 or (not v.Parent);
								Skillaimbot = false;
								_G.SeaSkill = false;
							else
								Skillaimbot = false;
								_G.SeaSkill = false;
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		while wait() do
			pcall(function()
				if _G.AutoSeabeasts then
					if not CheckBoat() then
						local BuyBoatCFrame = CFrame.new(-1936.93213, 6.6355958, -2568.47974, -0.922701657, -0.00000000988315652, 0.385514766, -0.000000016636152, 1, -0.0000000141811682, -0.385514766, -0.0000000194984704, -0.922701657);
						BuyBoat = topos(BuyBoatCFrame);
						if (BuyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							if BuyBoat then
								BuyBoat:Cancel();
							end;
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyBoat", "MarineBrigade");
							wait(1);
							for i, v in pairs((game:GetService("Workspace")).Boats:GetChildren()) do
								if v.Name == "MarineBrigade" then
									if (v.VehicleSeat.CFrame.Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
										AddEsp("MyBoatEsp", v);
									end;
								end;
							end;
						end;
					elseif CheckBoat() then
						for i, v in pairs((game:GetService("Workspace")).Boats:GetChildren()) do
							if v.Name == "MarineBrigade" then
								if v:FindFirstChild("MyBoatEsp") then
									if (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == false then
										if CheckSeaBeast() then
											if TweenPlayer then
												TweenPlayer:Cancel();
											end;
										else
											local BoatPos = v.VehicleSeat.CFrame * CFrame.new(0, 1, 0);
											local Distance = (BoatPos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;
											TweenPlayer = (game:GetService("TweenService")):Create((game:GetService("Players")).LocalPlayer.Character:WaitForChild("HumanoidRootPart"), TweenInfo.new(Distance / TweenSpeed, Enum.EasingStyle.Linear), {
												CFrame = BoatPos
											});
											TweenPlayer:Play();
										end;
									else
										repeat
											wait();
											local TargetPos = CFrame.new(-4124.19531, 9.00001144, -996.203918, 0.929954946, 0.0642714053, 0.362012357, -0.0689479187, 0.997620285, 0.00000000286939827, -0.361150861, -0.0249600001, 0.932173312);
											local Distance = (TargetPos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;
											TweenBoat = (game:service("TweenService")):Create(v.VehicleSeat, TweenInfo.new(Distance / 250, Enum.EasingStyle.Linear), {
												CFrame = TargetPos
											});
											if (v.VehicleSeat.CFrame.Position - TargetPos.Position).Magnitude <= 25 then
												TweenBoat:Cancel();
											else
												TweenBoat:Play();
											end;
										until CheckSeaBeast() or (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == false;
										if TweenBoat then
											TweenBoat:Cancel();
										end;
										(game:GetService("VirtualInputManager")):SendKeyEvent(true, 32, false, game);
										wait(0.1);
										(game:GetService("VirtualInputManager")):SendKeyEvent(false, 32, false, game);
									end;
								end;
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		while wait() do
			pcall(function()
				if _G.AutoSeabeasts then
					if CheckSeaBeast() then
						if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
							(game:GetService("VirtualInputManager")):SendKeyEvent(true, 32, false, game);
							wait(0.1);
							(game:GetService("VirtualInputManager")):SendKeyEvent(false, 32, false, game);
						end;
					end;
				end;
			end);
		end;
	end);
	function CheckV3()
		if (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Mink" then
			if game.Players.LocalPlayer.Backpack:FindFirstChild("Agility") then
				return true;
			end;
		elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Fishman" then
			if game.Players.LocalPlayer.Backpack:FindFirstChild("Water Body") then
				return true;
			end;
		elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Skypiea" then
			if game.Players.LocalPlayer.Backpack:FindFirstChild("Heavenly Blood") then
				return true;
			end;
		end;
		return false;
	end;
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.AutoMeleeSkill then
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
				end;
			end);
		end;
	end);
	spawn(function()
		while wait() do
			pcall(function()
				if _G.Settings.Race["Auto Race V3"] then
					if (game:GetService("Players")).LocalPlayer.Data.Race:FindFirstChild("Evolved") then
						local myRace = tostring((game:GetService("Players")).LocalPlayer.Data.Race.Value);
						if (game:GetService("Players")).LocalPlayer.Data.Beli.Value >= 2000000 then
							_G.AutoKatakuri = false;
							if myRace == "Skypiea" then
								if (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "1") == 0 then
									local QuestCFrame = CFrame.new(-1990.71094, 125.519119, -70.5762024, -0.235444918, -0.0000000715676052, -0.971887708, 0.0000000305724122, 1, -0.0000000810440568, 0.971887708, -0.0000000487943623, -0.235444918);
									topos(QuestCFrame);
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - QuestCFrame.Position).Magnitude <= 5 then
										(((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "2");
									end;
								elseif (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "1") == 1 then
									for i, v in pairs((game:GetService("Players")):GetChildren()) do
										if tostring(v.Data.Race.Value) == "Skypiea" then
											local Player = v:FindFirstChild(v.Name);
											if Player then
												repeat
													wait();
													topos(Player.HumanoidRootPart.CFrame * CFrame.new(0, 0, (-2)));
													Attack();
													AutoHaki();
													_G.AutoMeleeSkill = true;
													EquipWeapon("Melee");
												until not Player or (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "1") == 2;
												_G.AutoMeleeSkill = false;
												UnEquipWeapon();
											end;
										end;
									end;
								elseif (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "1") == 2 then
									(((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "3");
								end;
							elseif myRace == "Fishman" then
								if (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "1") == 0 then
									local QuestCFrame = CFrame.new(-1990.71094, 125.519119, -70.5762024, -0.235444918, -0.0000000715676052, -0.971887708, 0.0000000305724122, 1, -0.0000000810440568, 0.971887708, -0.0000000487943623, -0.235444918);
									topos(QuestCFrame);
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - QuestCFrame.Position).Magnitude <= 5 then
										(((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "2");
									end;
								elseif (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "1") == 1 then
									_G.AutoSeabeasts = true;
								elseif (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "1") == 2 then
									_G.AutoSeabeasts = false;
									(((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "3");
								end;
							elseif myRace == "Mink" then
								if (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "1") == 0 then
									local QuestCFrame = CFrame.new(-1990.71094, 125.519119, -70.5762024, -0.235444918, -0.0000000715676052, -0.971887708, 0.0000000305724122, 1, -0.0000000810440568, 0.971887708, -0.0000000487943623, -0.235444918);
									topos(QuestCFrame);
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - QuestCFrame.Position).Magnitude <= 5 then
										(((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "2");
									end;
								elseif (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "1") == 1 then
									for i, v in pairs((game:GetService("Workspace")):GetChildren()) do
										if string.find(v.Name, "Chest") then
											if (game:GetService("Workspace")):FindFirstChild(v.Name) then
												repeat
													wait(0.5);
													game.Players.LocalPlayer.Character:PivotTo(v:GetPivot());
													firesignal(v.Touched, game.Players.LocalPlayer.Character.HumanoidRootPart);
													(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("SetTeam", "Pirates");
												until not v.Parent;
											end;
										end;
									end;
								elseif (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "1") == 2 then
									(((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("Wenlocktoad", "3");
								end;
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Race["Auto Race V2"] then
					if not (game:GetService("Players")).LocalPlayer.Data.Race:FindFirstChild("Evolved") then
						if (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
							topos(CFrame.new(-2779.83521, 72.9661407, -3574.02002, -0.730484903, 0.0000000639014104, -0.68292886, 0.0000000359963224, 1, 0.0000000550667032, 0.68292886, 0.0000000156424669, -0.730484903));
							if (Vector3.new((-2779.83521), 72.9661407, (-3574.02002)) - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
								wait(1.3);
								(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Alchemist", "2");
							end;
						elseif (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
							pcall(function()
								if not (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Flower 1") and (not (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Flower 1")) then
									topos((game:GetService("Workspace")).Flower1.CFrame);
								elseif not (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Flower 2") and (not (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Flower 2")) then
									topos((game:GetService("Workspace")).Flower2.CFrame);
								elseif not (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Flower 3") and (not (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Flower 3")) then
									if (game:GetService("Workspace")).Enemies:FindFirstChild("Zombie") then
										for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
											if v.Name == "Zombie" then
												repeat
													(game:GetService("RunService")).Heartbeat:wait();
													AutoHaki();
													EquipWeapon(_G.Settings.Main["Selected Weapon"]);
													topos(v.HumanoidRootPart.CFrame * Pos);
													v.HumanoidRootPart.CanCollide = false;
													v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
													Attack();
													PosMon = v.HumanoidRootPart.CFrame;
													MonFarm = v.Name;
												until (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Flower 3") or (not v.Parent) or v.Humanoid.Health <= 0 or _G.Settings.Race["Auto Race V2"] == false;
											end;
										end;
									else
										topos(CFrame.new(-5685.9233398438, 48.480125427246, -853.23724365234));
									end;
								end;
							end);
						elseif (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Alchemist", "3");
						end;
					end;
				end;
			end;
		end);
	end);
end;
if World3 then
	RaceV4Tab:Seperator("Race V4");
	local PlaceV4List = {
		"Top Of GreatTree",
		"Timple Of Time",
		"Lever Pull",
		"Acient One"
	};
	RaceV4Tab:Dropdown("Choose Place", PlaceV4List, _G.Settings.Race["Selected PlaceV4"], function(value)
		_G.Settings.Race["Selected PlaceV4"] = value;
		(getgenv()).SaveSetting();
	end);
	RaceV4Tab:Toggle("Teleport To Selected Place", _G.Settings.Race["Teleport To PlaceV4"], false, function(value)
		_G.Settings.Race["Teleport To PlaceV4"] = value;
		StopTween(_G.Settings.Race["Teleport To PlaceV4"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Race["Teleport To PlaceV4"] then
				pcall(function()
					if _G.Settings.Race["Selected PlaceV4"] == "Top Of GreatTree" then
						topos(CFrame.new(2947.556884765625, 2281.630615234375, -7213.54931640625));
					elseif _G.Settings.Race["Selected PlaceV4"] == "Timple Of Time" then
						(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875);
					elseif _G.Settings.Race["Selected PlaceV4"] == "Lever Pull" then
						local LeverPullPos = CFrame.new(28575.181640625, 14936.6279296875, 72.31636810302734);
						if (LeverPullPos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1000 then
							(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875);
						else
							topos(LeverPullPos);
						end;
					elseif _G.Settings.Race["Selected PlaceV4"] == "Acient One" then
						topos(CFrame.new(28981.552734375, 14888.4267578125, -120.245849609375));
					end;
				end);
			end;
		end;
	end);
	RaceV4Tab:Toggle("Auto Buy Gear", _G.Settings.Race["Auto Buy Gear"], false, function(value)
		_G.Settings.Race["Auto Buy Gear"] = value;
		StopTween(_G.Settings.Race["Auto Buy Gear"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Race["Auto Buy Gear"] then
					local args = {
						[1] = true
					};
					local args = {
						[1] = "UpgradeRace",
						[2] = "Buy"
					};
					(((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer(unpack(args));
				end;
			end;
		end);
	end);
	RaceV4Tab:Toggle("Tween To Highest Point Mirage Island", _G.Settings.Race["Tween To Highest Mirage"], "Tween To Top Mirage Island", function(value)
		_G.Settings.Race["Tween To Highest Mirage"] = value;
		StopTween(_G.Settings.Race["Tween To Highest Mirage"]);
		(getgenv()).SaveSetting();
	end);
	RaceV4Tab:Toggle("Find Blue Gear", _G.Settings.Race["Find Blue Gear"], "Tween To Blue Gear", function(value)
		_G.Settings.Race["Find Blue Gear"] = value;
		StopTween(_G.Settings.Race["Find Blue Gear"]);
		(getgenv()).SaveSetting();
	end);
	RaceV4Tab:Toggle("Auto Look Moon + Use Ability", _G.Settings.Race["Look Moon Ability"], "Camera Focus To Moon", function(value)
		_G.Settings.Race["Look Moon Ability"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.Race["Look Moon Ability"] then
					wait();
					local moonDir = game.Lighting:GetMoonDirection();
					local lookAtPos = game.Workspace.CurrentCamera.CFrame.p + moonDir * 100;
					game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.p, lookAtPos);
				end;
			end);
		end;
	end);
	RaceV4Tab:Toggle("Auto Train", _G.Settings.Race["Auto Train"], false, function(value)
		_G.Settings.Race["Auto Train"] = value;
		StardFarm = value;
		StopTween(_G.Settings.Race["Auto Train"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Race["Auto Train"] then
					if game.Players.LocalPlayer.Character.RaceTransformed.Value == true then
						StardFarm = false;
						topos(CFrame.new(216.211181640625, 126.9352035522461, -12599.0732421875));
					end;
				end;
			end;
		end);
	end);
	spawn(function()
		while wait(0.2) do
			if StardFarm and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Cocoa Warrior") or (game:GetService("Workspace")).Enemies:FindFirstChild("Chocolate Bar Battler") or (game:GetService("Workspace")).Enemies:FindFirstChild("Sweet Thief") or (game:GetService("Workspace")).Enemies:FindFirstChild("Candy Rebel") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Cocoa Warrior" or v.Name == "Chocolate Bar Battler" or v.Name == "Sweet Thief" or v.Name == "Candy Rebel" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.HumanoidRootPart.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.Head.CanCollide = false;
										PosMon = v.HumanoidRootPart.CFrame;
										MonFarm = v.Name;
										topos(v.HumanoidRootPart.CFrame * Pos);
										Attack();
									until not StardFarm or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						topos(CFrame.new(216.211181640625, 126.9352035522461, -12599.0732421875));
					end;
				end);
			end;
		end;
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Race["Auto Train"] then
					if game.Players.LocalPlayer.Character.RaceTransformed.Value == false then
						StardFarm = true;
					end;
				end;
			end;
		end);
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.Race["Auto Train"] then
					(game:GetService("VirtualInputManager")):SendKeyEvent(true, "Y", false, game);
					wait(0.1);
					(game:GetService("VirtualInputManager")):SendKeyEvent(false, "Y", false, game);
				end;
			end);
		end;
	end);
	RaceV4Tab:Toggle("Disabled Inf Stairs", false, false, function(value)
		game.Players.LocalPlayer.Character.InfiniteStairs.Disabled = value;
	end);
	RaceV4Tab:Button("Teleport To Race Door", function()
		(Game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875);
		wait(0.1);
		(Game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875);
		wait(0.1);
		(Game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875);
		wait(0.1);
		(Game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875);
		wait(0.5);
		if (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Human" then
			topos(CFrame.new(29221.822265625, 14890.9755859375, -205.99114990234375));
		elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Skypiea" then
			topos(CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375));
		elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Fishman" then
			topos(CFrame.new(28231.17578125, 14890.9755859375, -211.64173889160156));
		elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Cyborg" then
			topos(CFrame.new(28502.681640625, 14895.9755859375, -423.7279357910156));
		elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Ghoul" then
			topos(CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156));
		elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Mink" then
			topos(CFrame.new(29012.341796875, 14890.9755859375, -380.1492614746094));
		end;
		wait(2);
		StopTween(false);
	end);
	RaceV4Tab:Seperator("Auto Complete Trials");
	RaceV4Tab:Button("Buy Ancient One Quest", function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("UpgradeRace", "Buy");
	end);
	RaceV4Tab:Toggle("Auto Kill Player After Trial", _G.Settings.Race["Auto Kill Player After Trial"], false, function(value)
		_G.Settings.Race["Auto Kill Player After Trial"] = value;
		StopTween(_G.Settings.Race["Auto Kill Player After Trial"]);
		(getgenv()).SaveSetting();
	end);
	RaceV4Tab:Toggle("Auto Trial RaceV4", _G.Settings.Race["Auto Trial"], false, function(value)
		_G.Settings.Race["Auto Trial"] = value;
		StopTween(_G.Settings.Race["Auto Trial"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Race["Auto Trial"] then
					if (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Human" then
						for i, v in pairs(game.Workspace.Enemies:GetDescendants()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								pcall(function()
									repeat
										wait(0.1);
										v.Humanoid.Health = 0;
										v.HumanoidRootPart.CanCollide = false;
									until not _G.Settings.Race["Auto Trial"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end);
							end;
						end;
					elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Skypiea" then
						for i, v in pairs((game:GetService("Workspace")).Map.SkyTrial.Model:GetDescendants()) do
							if v.Name == "snowisland_Cylinder.081" then
								topos(v.CFrame * CFrame.new(0, 0, 0));
							end;
						end;
					elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Fishman" then
						for i, v in pairs((game:GetService("Workspace")).SeaBeasts.SeaBeast1:GetDescendants()) do
							if v.Name == "HumanoidRootPart" then
								repeat
									wait();
									topos(v.CFrame * CFrame.new(0, 200, 0));
									for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
										if v:IsA("Tool") then
											if v.ToolTip == "Melee" then
												game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
											end;
										end;
									end;
									(game:GetService("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
									(game:GetService("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
									wait(0.2);
									(game:GetService("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
									(game:GetService("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
									wait(0.2);
									(game:GetService("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
									(game:GetService("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
									wait(0.2);
									for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
										if v:IsA("Tool") then
											if v.ToolTip == "Blox Fruit" then
												game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
											end;
										end;
									end;
									(game:GetService("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
									(game:GetService("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
									wait(0.2);
									(game:GetService("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
									(game:GetService("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
									wait(0.2);
									(game:GetService("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
									(game:GetService("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
									wait(0.2);
									(game:GetService("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
									(game:GetService("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
									wait(0.2);
									for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
										if v:IsA("Tool") then
											if v.ToolTip == "Sword" then
												game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
											end;
										end;
									end;
									(game:GetService("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
									(game:GetService("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
									wait(0.2);
									(game:GetService("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
									(game:GetService("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
									wait(0.2);
									for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
										if v:IsA("Tool") then
											if v.ToolTip == "Gun" then
												game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
											end;
										end;
									end;
									(game:GetService("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
									(game:GetService("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
									wait(0.2);
									(game:GetService("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
									(game:GetService("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
									wait(0.2);
								until not _G.Settings.Race["Auto Trial"] or (not v.Parent) or v.Humanoid.Health <= 0 or (not v:FindFirstChild("HumanoidRootPart"));
							end;
						end;
					elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Cyborg" then
						topos(CFrame.new(28654, 14898.7832, -30, 1, 0, 0, 0, 1, 0, 0, 0, 1));
					elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Ghoul" then
						for i, v in pairs(game.Workspace.Enemies:GetDescendants()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								pcall(function()
									repeat
										wait(0.1);
										v.Humanoid.Health = 0;
										v.HumanoidRootPart.CanCollide = false;
									until not _G.Settings.Race["Auto Trial"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end);
							end;
						end;
					elseif (game:GetService("Players")).LocalPlayer.Data.Race.Value == "Mink" then
						for i, v in pairs((game:GetService("Workspace")):GetDescendants()) do
							if v.Name == "StartPoint" then
								topos(v.CFrame * CFrame.new(0, 10, 0));
							end;
						end;
					end;
				end;
			end;
		end);
	end);
end;
spawn(function()
	while wait(0.2) do
		if _G.Settings.Race["Auto Kill Player After Trial"] then
			if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Timer.Visible == true then
				for i, v in pairs((game:GetService("Players")):GetPlayers()) do
					if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
						if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 200 then
							if v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
								repeat
									(game:GetService("RunService")).Heartbeat:Wait();
									EquipWeapon(_G.Settings.Main["Selected Weapon"]);
									AutoHaki();
									topos(v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 20));
									Attack();
								until not _G.Settings.Race["Auto Kill Player After Trial"] or (not v.Character) or v.Character.Humanoid.Health <= 0;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end);
]========]}
}}
