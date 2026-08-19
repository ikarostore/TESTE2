return {Name="Sea event", Chunks={
{Order=11, Code=[========[	SeaTab:Seperator("Sea Event");
	local ListSeaBoat = {
		"Guardian",
		"Beast Hunter",
		"PirateGrandBrigade",
		"MarineGrandBrigade",
		"PirateBrigade",
		"MarineBrigade",
		"PirateSloop",
		"MarineSloop"
	};
	local ListSeaZone = {
		"Zone 1",
		"Zone 2",
		"Zone 3",
		"Zone 4",
		"Zone 5",
		"Zone 6",
		"Infinite"
	};
	SeaTab:Dropdown("Choose Boat", ListSeaBoat, _G.Settings.SeaEvent["Selected Boat"], function(value)
		_G.Settings.SeaEvent["Selected Boat"] = value;
		(getgenv()).SaveSetting();
	end);
	SeaTab:Dropdown("Choose Zone", ListSeaZone, _G.Settings.SeaEvent["Selected Zone"], function(value)
		_G.Settings.SeaEvent["Selected Zone"] = value;
		(getgenv()).SaveSetting();
	end);
	SeaTab:Slider("Boat Tween Speed", 100, 350, _G.Settings.SeaEvent["Boat Tween Speed"], function(value)
		_G.Settings.SeaEvent["Boat Tween Speed"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.SeaEvent["Selected Zone"] == "Zone 1" then
					CFrameSelectedZone = CFrame.new(-21998.375, 30.0006084, -682.309143, 0.120013528, 0.00690158736, 0.99274826, -0.0574118942, 0.998350561, -0.000000000236509201, -0.991110802, -0.0569955558, 0.120211802);
				elseif _G.Settings.SeaEvent["Selected Zone"] == "Zone 2" then
					CFrameSelectedZone = CFrame.new(-26779.5215, 30.0005474, -822.858032, 0.307457417, 0.019647358, 0.951358974, -0.0637726262, 0.997964442, -0.000000000415334017, -0.949422479, -0.0606706589, 0.308084518);
				elseif _G.Settings.SeaEvent["Selected Zone"] == "Zone 3" then
					CFrameSelectedZone = CFrame.new(-31171.957, 30.0001011, -2256.93774, 0.37637493, 0.0150483791, 0.926345229, -0.0399504974, 0.999201655, 0.0000000000270896673, -0.925605655, -0.0370079502, 0.376675636);
				elseif _G.Settings.SeaEvent["Selected Zone"] == "Zone 4" then
					CFrameSelectedZone = CFrame.new(-34054.6875, 30.2187767, -2560.12012, 0.0935864747, -0.00122954219, 0.995610416, 0.0624034069, 0.998040259, -0.00463332096, -0.993653536, 0.062563099, 0.0934797972);
				elseif _G.Settings.SeaEvent["Selected Zone"] == "Zone 5" then
					CFrameSelectedZone = CFrame.new(-38887.5547, 30.0004578, -2162.99023, -0.188895494, -0.00704088295, 0.981971979, -0.0372481011, 0.999306023, -0.00000000139882339, -0.981290519, -0.0365765914, -0.189026669);
				elseif _G.Settings.SeaEvent["Selected Zone"] == "Zone 6" then
					CFrameSelectedZone = CFrame.new(-44541.7617, 30.0003204, -1244.8584, -0.0844199061, -0.00553312758, 0.9964149, -0.0654025897, 0.997858942, 0.000000000202319411, -0.99428153, -0.0651681125, -0.0846010372);
				elseif _G.Settings.SeaEvent["Selected Zone"] == "Infinite" then
					CFrameSelectedZone = CFrame.new(-148073.359, 8.99999523, 7721.05078, -0.0825930536, -0.00000154416148, 0.996583343, -0.000018696026, 1, -0.000000000000391858095, -0.996583343, -0.0000186321486, -0.0825930536);
				end;
			end;
		end);
	end);
	SeaTab:Toggle("Auto Sail Boat", _G.Settings.SeaEvent["Sail Boat"], "Sail Boat", function(value)
		_G.Settings.SeaEvent["Sail Boat"] = value;
		(getgenv()).SaveSetting();
		StopTween(_G.Settings.SeaEvent["Sail Boat"]);
		if not _G.Settings.SeaEvent["Sail Boat"] then
			_G.SeaSkill = false;
			Skillaimbot = false;
		end;
		if StopTweenBoat then
			StopTweenBoat:Stop();
		end;
	end);
	function CheckBoat()
		for i, v in pairs((game:GetService("Workspace")).Boats:GetChildren()) do
			if v.Name == _G.Settings.SeaEvent["Selected Boat"] then
				for _, child in pairs(v:GetChildren()) do
					if child.Name == "MyBoatEsp" then
						return v;
					end;
				end;
			end;
		end;
		return false;
	end;
	function CheckEnemiesBoat()
		if (game:GetService("Workspace")).Enemies:FindFirstChild("FishBoat") or (game:GetService("Workspace")).Enemies:FindFirstChild("PirateBrigade") or (game:GetService("Workspace")).Enemies:FindFirstChild("PirateGrandBrigade") then
			return true;
		end;
		return false;
	end;
	function CheckShark()
		for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
			if v.Name == "Shark" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
				if (game:GetService("Workspace")).Enemies:FindFirstChild("Shark") then
					if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 200 then
						return true;
					end;
				end;
			end;
		end;
		return false;
	end;
	function CheckPiranha()
		for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
			if v.Name == "Piranha" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
				if (game:GetService("Workspace")).Enemies:FindFirstChild("Piranha") then
					if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 200 then
						return true;
					end;
				end;
			end;
		end;
		return false;
	end;
	function AddEsp(Name, Parent)
		local BillboardGui = Instance.new("BillboardGui");
		local TextLabel = Instance.new("TextLabel");
		BillboardGui.Parent = Parent;
		BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
		BillboardGui.Active = true;
		BillboardGui.Name = Name;
		BillboardGui.AlwaysOnTop = true;
		BillboardGui.LightInfluence = 1;
		BillboardGui.Size = UDim2.new(0, 200, 0, 50);
		BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0);
		TextLabel.Parent = BillboardGui;
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		TextLabel.BackgroundTransparency = 1;
		TextLabel.Size = UDim2.new(1, 0, 1, 0);
		TextLabel.Font = Enum.Font.GothamBold;
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
		TextLabel.TextSize = 15;
		TextLabel.Text = "My Boat";
	end;
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.SeaEvent["Sail Boat"] then
					if not CheckBoat() then
						local BuyBoatCFrame = CFrame.new(-16927.451171875, 9.0863618850708, 433.8642883300781);
						if (BuyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
							BTP(BuyBoatCFrame);
						else
							BuyBoat = topos(BuyBoatCFrame);
						end;
						if ((CFrame.new((-16927.451171875), 9.0863618850708, 433.8642883300781)).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							if BuyBoat then
								BuyBoat:Stop();
							end;
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyBoat", _G.Settings.SeaEvent["Selected Boat"]);
							for i, v in pairs((game:GetService("Workspace")).Boats:GetChildren()) do
								if v.Name == _G.Settings.SeaEvent["Selected Boat"] then
									if (v.VehicleSeat.CFrame.Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
										AddEsp("MyBoatEsp", v);
									end;
								end;
							end;
							wait(1);
						end;
					elseif CheckBoat() then
						for i, v in pairs((game:GetService("Workspace")).Boats:GetChildren()) do
							if v.Name == _G.Settings.SeaEvent["Selected Boat"] then
								if v:FindFirstChild("MyBoatEsp") then
									if (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == false then
										if CheckShark() and _G.Settings.SeaEvent["Auto Farm Shark"] or (game:GetService("Workspace")).Enemies:FindFirstChild("Terrorshark") and _G.Settings.SeaEvent["Auto Farm Terrorshark"] or CheckPiranha() and _G.Settings.SeaEvent["Auto Farm Piranha"] or (game:GetService("Workspace")).Enemies:FindFirstChild("Fish Crew Member") and _G.Settings.SeaEvent["Auto Farm Fish Crew Member"] or (game:GetService("Workspace")).Enemies:FindFirstChild("FishBoat") and _G.Settings.SeaEvent["Auto Farm Ghost Ship"] or (game:GetService("Workspace")).Enemies:FindFirstChild("PirateBrigade") and _G.Settings.SeaEvent["Auto Farm Pirate Brigade"] or (game:GetService("Workspace")).Enemies:FindFirstChild("PirateGrandBrigade") and _G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"] or CheckSeaBeast() and _G.Settings.SeaEvent["Auto Farm Seabeasts"] then
											if stoppos then
												stoppos:Stop();
											end;
										else
											stoppos = topos(v.VehicleSeat.CFrame * CFrame.new(0, 1, 0));
										end;
									else
										repeat
											wait();
											StopTweenBoat = TweenBoat(CFrameSelectedZone);
										until CheckShark() and _G.Settings.SeaEvent["Auto Farm Shark"] or (game:GetService("Workspace")).Enemies:FindFirstChild("Terrorshark") and _G.Settings.SeaEvent["Auto Farm Terrorshark"] or CheckPiranha() and _G.Settings.SeaEvent["Auto Farm Piranha"] or (game:GetService("Workspace")).Enemies:FindFirstChild("Fish Crew Member") and _G.Settings.SeaEvent["Auto Farm Fish Crew Member"] or (game:GetService("Workspace")).Enemies:FindFirstChild("FishBoat") and _G.Settings.SeaEvent["Auto Farm Ghost Ship"] or (game:GetService("Workspace")).Enemies:FindFirstChild("PirateBrigade") and _G.Settings.SeaEvent["Auto Farm Pirate Brigade"] or (game:GetService("Workspace")).Enemies:FindFirstChild("PirateGrandBrigade") and _G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"] or CheckSeaBeast() and _G.Settings.SeaEvent["Auto Farm Seabeasts"] or (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == false or _G.Settings.SeaEvent["Sail Boat"] == false;
										if StopTweenBoat then
											StopTweenBoat:Stop();
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
		pcall(function()
			while wait(0.2) do
				if _G.Settings.SeaEvent["Sail Boat"] then
					if CheckShark() and _G.Settings.SeaEvent["Auto Farm Shark"] or (game:GetService("Workspace")).Enemies:FindFirstChild("Terrorshark") and _G.Settings.SeaEvent["Auto Farm Terrorshark"] or CheckPiranha() and _G.Settings.SeaEvent["Auto Farm Piranha"] or (game:GetService("Workspace")).Enemies:FindFirstChild("Fish Crew Member") and _G.Settings.SeaEvent["Auto Farm Fish Crew Member"] or (game:GetService("Workspace")).Enemies:FindFirstChild("FishBoat") and _G.Settings.SeaEvent["Auto Farm Ghost Ship"] or (game:GetService("Workspace")).Enemies:FindFirstChild("PirateBrigade") and _G.Settings.SeaEvent["Auto Farm Pirate Brigade"] or (game:GetService("Workspace")).Enemies:FindFirstChild("PirateGrandBrigade") and _G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"] or CheckSeaBeast() and _G.Settings.SeaEvent["Auto Farm Seabeasts"] then
						if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
							(game:GetService("VirtualInputManager")):SendKeyEvent(true, 32, false, game);
							wait(0.1);
							(game:GetService("VirtualInputManager")):SendKeyEvent(false, 32, false, game);
						end;
					end;
				end;
			end;
		end);
	end);
	function DodgeSeabeasts()
		local seaBeastsFolder = (game:GetService("Workspace")).SeaBeasts;
		for _, seaBeast in pairs(seaBeastsFolder:GetChildren()) do
			if seaBeast:FindFirstChild("Humanoid") and seaBeast:FindFirstChild("Anims") then
				local humanoid = seaBeast.Humanoid;
				local animator = humanoid:FindFirstChildOfClass("Animator") or humanoid;
				for _, anim in pairs(seaBeast.Anims:GetChildren()) do
					if anim:IsA("Animation") then
						if anim.AnimationId == "rbxassetid://8708221792" or anim.AnimationId == "rbxassetid://8708222556" or anim.AnimationId == "rbxassetid://8708223619" or anim.AnimationId == "rbxassetid://8708225668" then
							for _, animationTrack in pairs(animator:GetPlayingAnimationTracks()) do
								if animationTrack.Animation.AnimationId == anim.AnimationId then
									if animationTrack.IsPlaying then
										return true;
									else
										return false;
									end;
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
	spawn(function()
		while wait(0.2) do
			if _G.Settings.SeaEvent["Sail Boat"] then
				pcall(function()
					if _G.Settings.SeaEvent["Sail Boat"] and (game:GetService("Workspace")).Enemies:FindFirstChild("Fish Crew Member") and _G.Settings.SeaEvent["Auto Farm Fish Crew Member"] then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Fish Crew Member") then
								if v.Name == "Fish Crew Member" then
									if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat
											(game:GetService("RunService")).Heartbeat:wait();
											AutoHaki();
											EquipWeapon(_G.Settings.Main["Selected Weapon"]);
											topos(v.HumanoidRootPart.CFrame * Pos);
											Attack();
											_G.SeaSkill = false;
										until not _G.Settings.SeaEvent["Auto Farm Fish Crew Member"] or (not v.Parent) or v.Humanoid.Health <= 0;
									end;
								end;
							end;
						end;
					elseif _G.Settings.SeaEvent["Sail Boat"] and (game:GetService("Workspace")).Enemies:FindFirstChild("FishBoat") and _G.Settings.SeaEvent["Auto Farm Ghost Ship"] then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if (game:GetService("Workspace")).Enemies:FindFirstChild("FishBoat") then
								repeat
									(game:GetService("RunService")).Heartbeat:wait();
									local BoatCFrame = v.Engine.CFrame;
									if (BoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
										_G.SeaSkill = true;
									else
										_G.SeaSkill = false;
									end;
									topos(BoatCFrame);
									AutoHaki();
									Skillaimbot = true;
									AimSkill = v.Engine.CFrame * CFrame.new(0, (-15), 0);
									AimBotSkillPosition = AimSkill.Position;
								until not v.Parent or v.Health < 0 or (not (game:GetService("Workspace")).Enemies:FindFirstChild("FishBoat")) or (not v:FindFirstChild("Engine")) or (not _G.Settings.SeaEvent["Auto Farm Ghost Ship"]);
								Skillaimbot = false;
								_G.SeaSkill = false;
							end;
						end;
					elseif _G.Settings.SeaEvent["Sail Boat"] and (game:GetService("Workspace")).Enemies:FindFirstChild("PirateGrandBrigade") and _G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"] then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if (game:GetService("Workspace")).Enemies:FindFirstChild("PirateGrandBrigade") then
								repeat
									(game:GetService("RunService")).Heartbeat:wait();
									local BoatCFrame = v.Engine.CFrame;
									AutoHaki();
									if (BoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
										_G.SeaSkill = true;
									else
										_G.SeaSkill = false;
									end;
									topos(BoatCFrame);
									Skillaimbot = true;
									AimSkill = v.Engine.CFrame * CFrame.new(0, (-15), 0);
									AimBotSkillPosition = AimSkill.Position;
								until not v.Parent or v.Health.Value < 0 or (not (game:GetService("Workspace")).Enemies:FindFirstChild("PirateGrandBrigade")) or (not v:FindFirstChild("Engine")) or (not _G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"]);
								Skillaimbot = false;
								_G.SeaSkill = false;
							end;
						end;
					elseif _G.Settings.SeaEvent["Sail Boat"] and (game:GetService("Workspace")).Enemies:FindFirstChild("PirateBrigade") and _G.Settings.SeaEvent["Auto Farm Pirate Brigade"] then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if (game:GetService("Workspace")).Enemies:FindFirstChild("PirateBrigade") then
								repeat
									(game:GetService("RunService")).Heartbeat:wait();
									local BoatCFrame = v.Engine.CFrame;
									if (BoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
										_G.SeaSkill = true;
									else
										_G.SeaSkill = false;
									end;
									topos(BoatCFrame);
									Skillaimbot = true;
									AutoHaki();
									AimSkill = v.Engine.CFrame * CFrame.new(0, (-15), 0);
									AimBotSkillPosition = AimSkill.Position;
								until not v.Parent or v.Health.Value < 0 or (not (game:GetService("Workspace")).Enemies:FindFirstChild("PirateBrigade")) or (not v:FindFirstChild("Engine")) or (not _G.Settings.SeaEvent["Auto Farm Pirate Brigade"]);
								Skillaimbot = false;
								_G.SeaSkill = false;
							end;
						end;
					elseif _G.Settings.SeaEvent["Sail Boat"] and CheckSeaBeast() and _G.Settings.SeaEvent["Auto Farm Seabeasts"] then
						if (game:GetService("Workspace")):FindFirstChild("SeaBeasts") then
							for i, v in pairs((game:GetService("Workspace")).SeaBeasts:GetChildren()) do
								if CheckSeaBeast() then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										CFrameSeaBeast = v.HumanoidRootPart.CFrame * CFrame.new(0, 400, 0);
										if (CFrameSeaBeast.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).Magnitude <= 400 then
											_G.SeaSkill = true;
										else
											_G.SeaSkill = false;
										end;
										AutoHaki();
										Skillaimbot = true;
										AimBotSkillPosition = v.HumanoidRootPart.CFrame.Position;
										if DodgeSeabeasts() then
											topos(v.HumanoidRootPart.CFrame * CFrame.new(math.random((-200), 300), 400, math.random((-200), 300)));
										else
											topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 400, 0));
										end;
									until not _G.Settings.SeaEvent["Auto Farm Seabeasts"] or CheckSeaBeast() == false or (not v:FindFirstChild("Humanoid")) or (not v:FindFirstChild("HumanoidRootPart")) or v.Humanoid.Health <= 0 or (not v.Parent);
									Skillaimbot = false;
									_G.SeaSkill = false;
								else
									Skillaimbot = false;
									_G.SeaSkill = false;
								end;
							end;
						end;
					elseif _G.Settings.SeaEvent["Sail Boat"] and (game:GetService("Workspace")).Enemies:FindFirstChild("Terrorshark") and _G.Settings.SeaEvent["Auto Farm Terrorshark"] then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Terrorshark") then
								if v.Name == "Terrorshark" then
									if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat
											(game:GetService("RunService")).Heartbeat:wait();
											AutoHaki();
											EquipWeapon(_G.Settings.Main["Selected Weapon"]);
											Attack();
											_G.SeaSkill = false;
											topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 60, 0));
										until not _G.Settings.SeaEvent["Auto Farm Terrorshark"] or (not v.Parent) or v.Humanoid.Health <= 0;
									end;
								end;
							end;
						end;
					elseif _G.Settings.SeaEvent["Sail Boat"] and CheckPiranha() and _G.Settings.SeaEvent["Auto Farm Piranha"] then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Piranha") then
								if v.Name == "Piranha" then
									if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat
											(game:GetService("RunService")).Heartbeat:wait();
											AutoHaki();
											EquipWeapon(_G.Settings.Main["Selected Weapon"]);
											topos(v.HumanoidRootPart.CFrame * Pos);
											Attack();
											_G.SeaSkill = false;
										until not _G.Settings.SeaEvent["Auto Farm Piranha"] or (not v.Parent) or v.Humanoid.Health <= 0;
									end;
								end;
							end;
						end;
					elseif _G.Settings.SeaEvent["Sail Boat"] and CheckShark() and _G.Settings.SeaEvent["Auto Farm Shark"] then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Shark") then
								if v.Name == "Shark" then
									if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat
											(game:GetService("RunService")).Heartbeat:wait();
											AutoHaki();
											EquipWeapon(_G.Settings.Main["Selected Weapon"]);
											topos(v.HumanoidRootPart.CFrame * Pos);
											Attack();
											_G.SeaSkill = false;
										until not _G.Settings.SeaEvent["Auto Farm Shark"] or (not v.Parent) or v.Humanoid.Health <= 0;
									end;
								end;
							end;
						end;
					else
						Skillaimbot = false;
						_G.SeaSkill = false;
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
					end;
				end);
			end;
		end;
	end);
	SeaTab:Label("Enemies");
	SeaTab:Toggle("Auto Farm Shark", _G.Settings.SeaEvent["Auto Farm Shark"], "Auto Kill Shark", function(value)
		_G.Settings.SeaEvent["Auto Farm Shark"] = value;
		StopTween(_G.Settings.SeaEvent["Auto Farm Shark"]);
		(getgenv()).SaveSetting();
	end);
	SeaTab:Toggle("Auto Farm Piranha", _G.Settings.SeaEvent["Auto Farm Piranha"], "Auto Kill Piranha", function(value)
		_G.Settings.SeaEvent["Auto Farm Piranha"] = value;
		StopTween(_G.Settings.SeaEvent["Auto Farm Piranha"]);
		(getgenv()).SaveSetting();
	end);
	SeaTab:Toggle("Auto Farm Fish Crew Member", _G.Settings.SeaEvent["Auto Farm Fish Crew Member"], "Auto Kill Fish Crew Member", function(value)
		_G.Settings.SeaEvent["Auto Farm Fish Crew Member"] = value;
		StopTween(_G.Settings.SeaEvent["Auto Farm Fish Crew Member"]);
		(getgenv()).SaveSetting();
	end);
	SeaTab:Label("Boat");
	SeaTab:Toggle("Auto Kill Ghost Ship", _G.Settings.SeaEvent["Auto Farm Ghost Ship"], "Auto Kill Use Skill", function(value)
		_G.Settings.SeaEvent["Auto Farm Ghost Ship"] = value;
		if not _G.Settings.SeaEvent["Auto Farm Ghost Ship"] then
			_G.SeaSkill = false;
			Skillaimbot = false;
		end;
		StopTween(_G.Settings.SeaEvent["Auto Farm Ghost Ship"]);
		(getgenv()).SaveSetting();
	end);
	SeaTab:Toggle("Auto Kill Pirate Brigade", _G.Settings.SeaEvent["Auto Farm Pirate Brigade"], "Auto Kill Enemies Use Skill", function(value)
		_G.Settings.SeaEvent["Auto Farm Pirate Brigade"] = value;
		StopTween(_G.Settings.SeaEvent["Auto Farm Pirate Brigade"]);
		(getgenv()).SaveSetting();
	end);
	SeaTab:Toggle("Auto Kill Pirate Grand Brigade", _G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"], "Auto Kill Enemies Use Skill", function(value)
		_G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"] = value;
		StopTween(_G.Settings.SeaEvent["Auto Farm Pirate Grand Brigade"]);
		(getgenv()).SaveSetting();
	end);
	SeaTab:Label("Boss");
	SeaTab:Toggle("Auto Kill Terrorshark", _G.Settings.SeaEvent["Auto Farm Terrorshark"], false, function(value)
		_G.Settings.SeaEvent["Auto Farm Terrorshark"] = value;
		StopTween(_G.Settings.SeaEvent["Auto Farm Terrorshark"]);
		(getgenv()).SaveSetting();
	end);
	SeaTab:Toggle("Auto Kill Seabest", _G.Settings.SeaEvent["Auto Farm Seabeasts"], false, function(value)
		_G.Settings.SeaEvent["Auto Farm Seabeasts"] = value;
		if not _G.Settings.SeaEvent["Auto Farm Seabeasts"] then
			_G.SeaSkill = false;
			Skillaimbot = false;
		end;
		StopTween(_G.Settings.SeaEvent["Auto Farm Seabeasts"]);
		(getgenv()).SaveSetting();
	end);
	SeaTab:Seperator("Ability");
	SeaTab:Toggle("Lightning", _G.Settings.SeaEvent.Lightning, "For lightning in the night", function(value)
		_G.Settings.SeaEvent.Lightning = value;
	end);
	local RunService = game:GetService("RunService");
	RunService.Heartbeat:Connect(function()
		local Lighting = game:GetService("Lighting");
		if _G.Settings.SeaEvent.Lightning then
			Lighting.ClockTime = 12;
		end;
	end);
	SeaTab:Toggle("Speed Boat", _G.Settings.SeaEvent["Increase Boat Speed"], false, function(value)
		_G.Settings.SeaEvent["Increase Boat Speed"] = value;
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				local vehicleSeats = {};
				for i, v in pairs(game.Workspace.Boats:GetDescendants()) do
					if v:IsA("VehicleSeat") then
						table.insert(vehicleSeats, v);
					end;
				end;
				if _G.Settings.SeaEvent["Increase Boat Speed"] then
					for _, v in pairs(vehicleSeats) do
						v.MaxSpeed = 350;
					end;
				else
					for _, v in pairs(vehicleSeats) do
						v.MaxSpeed = 150;
					end;
				end;
			end);
		end;
	end);
	SeaTab:Toggle("No Clip Rock", _G.Settings.SeaEvent["No Clip Rock"], "NoClip", function(value)
		_G.Settings.SeaEvent["No Clip Rock"] = value;
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				for i, boat in pairs((game:GetService("Workspace")).Boats:GetChildren()) do
					for _, v in pairs((game:GetService("Workspace")).Boats[boat.Name]:GetDescendants()) do
						if v:IsA("BasePart") then
							if _G.Settings.SeaEvent["No Clip Rock"] or _G.Settings.SeaEvent["Sail Boat"] then
								v.CanCollide = false;
							else
								v.CanCollide = true;
							end;
						end;
					end;
				end;
			end);
		end;
	end);
	SettingSeaTab:Seperator("Settings Sea Event");
	SettingSeaTab:Toggle("Use Skill Devil Fruit", _G.Settings.SettingSea["Skill Devil Fruit"], "Use Fruit Skill", function(value)
		_G.Settings.SettingSea["Skill Devil Fruit"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Toggle("Use Skill Melee", _G.Settings.SettingSea["Skill Melee"], "Use Melee Skill", function(value)
		_G.Settings.SettingSea["Skill Melee"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Toggle("Use Skill Sword", _G.Settings.SettingSea["Skill Sword"], "Use Sword Skill", function(value)
		_G.Settings.SettingSea["Skill Sword"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Toggle("Use Skill Gun", _G.Settings.SettingSea["Skill Gun"], "Use Gun Skill", function(value)
		_G.Settings.SettingSea["Skill Gun"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Label("[ Skill Fruit ]");
	SettingSeaTab:Toggle("Skill Z", _G.Settings.SettingSea["Sea Fruit Skill Z"], "Auto Skill Z", function(value)
		_G.Settings.SettingSea["Sea Fruit Skill Z"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Toggle("Skill X", _G.Settings.SettingSea["Sea Fruit Skill X"], "Auto Skill X", function(value)
		_G.Settings.SettingSea["Sea Fruit Skill X"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Toggle("Skill C", _G.Settings.SettingSea["Sea Fruit Skill C"], "Auto Skill C", function(value)
		_G.Settings.SettingSea["Sea Fruit Skill C"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Toggle("Skill V", _G.Settings.SettingSea["Sea Fruit Skill V"], "Auto Skill V", function(value)
		_G.Settings.SettingSea["Sea Fruit Skill V"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Toggle("Skill F", _G.Settings.SettingSea["Sea Fruit Skill F"], "Auto Skill F", function(value)
		_G.Settings.SettingSea["Sea Fruit Skill F"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Label("[ Skill Melee ]");
	SettingSeaTab:Toggle("Skill Z", _G.Settings.SettingSea["Sea Melee Skill Z"], "Auto Skill Z", function(value)
		_G.Settings.SettingSea["Sea Melee Skill Z"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Toggle("Skill X", _G.Settings.SettingSea["Sea Fruit Skill X"], "Auto Skill X", function(value)
		_G.Settings.SettingSea["Sea Fruit Skill X"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Toggle("Skill C", _G.Settings.SettingSea["Sea Fruit Skill C"], "Auto Skill C", function(value)
		_G.Settings.SettingSea["Sea Fruit Skill C"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Toggle("Skill V", _G.Settings.SettingSea["Sea Fruit Skill V"], "Auto Skill V", function(value)
		_G.Settings.SettingSea["Sea Fruit Skill V"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Label("[ Skill Sword ]");
	SettingSeaTab:Toggle("Skill Z", _G.Settings.SettingSea["Sea Sword Skill Z"], "Auto Skill Z", function(value)
		_G.Settings.SettingSea["Sea Sword Skill Z"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Toggle("Skill X", _G.Settings.SettingSea["Sea Sword Skill X"], "Auto Skill X", function(value)
		_G.Settings.SettingSea["Sea Sword Skill X"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Label("[ Skill Gun ]");
	SettingSeaTab:Toggle("Skill Z", _G.Settings.SettingSea["Sea Gun Skill Z"], "Auto Skill Z", function(value)
		_G.Settings.SettingSea["Sea Gun Skill Z"] = value;
		(getgenv()).SaveSetting();
	end);
	SettingSeaTab:Toggle("Skill X", _G.Settings.SettingSea["Sea Gun Skill X"], "Auto Skill X", function(value)
		_G.Settings.SettingSea["Sea Gun Skill X"] = value;
		(getgenv()).SaveSetting();
	end);
end;
DoneSkillGun = false;
DoneSkillSword = false;
DoneSkillFruit = false;
DoneSkillMelee = false;
spawn(function()
	while wait() do
		pcall(function()
			if _G.SeaSkill then
				if _G.Settings.SettingSea["Skill Devil Fruit"] and DoneSkillFruit == false then
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							if v.ToolTip == "Blox Fruit" then
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
							end;
						end;
					end;
					if _G.Settings.SettingSea["Sea Fruit Skill Z"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
						wait(_G.Settings.Hold["Hold Sea Skill Z"]);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
					end;
					if _G.Settings.SettingSea["Sea Fruit Skill X"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
						wait(_G.Settings.Hold["Hold Sea Skill X"]);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
					end;
					if _G.Settings.SettingSea["Sea Fruit Skill C"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
						wait(_G.Settings.Hold["Hold Sea Skill C"]);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
					end;
					if _G.Settings.SettingSea["Sea Fruit Skill V"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
						wait(_G.Settings.Hold["Hold Sea Skill V"]);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
					end;
					if _G.Settings.SettingSea["Sea Fruit Skill F"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "F", false, game);
						wait(_G.Settings.Hold["Hold Sea Skill F"]);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "F", false, game);
					end;
					DoneSkillFruit = true;
				end;
				if _G.Settings.SettingSea["Skill Melee"] and DoneSkillMelee == false then
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							if v.ToolTip == "Melee" then
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
							end;
						end;
					end;
					if _G.Settings.SettingSea["Sea Melee Skill Z"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
						wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
					end;
					if _G.Settings.SettingSea["Sea Fruit Skill X"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
						wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
					end;
					if _G.Settings.SettingSea["Sea Fruit Skill C"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
						wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
					end;
					if _G.Settings.SettingSea["Sea Fruit Skill V"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
						wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
					end;
					DoneSkillMelee = true;
				end;
				if _G.Settings.SettingSea["Skill Sword"] and DoneSkillSword == false then
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							if v.ToolTip == "Sword" then
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
							end;
						end;
					end;
					if _G.Settings.SettingSea["Sea Sword Skill Z"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
						wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
					end;
					if _G.Settings.SettingSea["Sea Sword Skill X"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
						wait(0);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
					end;
					DoneSkillSword = true;
				end;
				if _G.Settings.SettingSea["Skill Gun"] and DoneSkillGun == false then
					for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							if v.ToolTip == "Gun" then
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(v);
							end;
						end;
					end;
					if _G.Settings.SettingSea["Sea Gun Skill Z"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
						wait(0.1);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
					end;
					if _G.Settings.SettingSea["Sea Gun Skill X"] then
						(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
						wait(0.1);
						(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
					end;
					DoneSkillGun = true;
				end;
				DoneSkillGun = false;
				DoneSkillSword = false;
				DoneSkillFruit = false;
				DoneSkillMelee = false;
			end;
		end);
	end;
end);
function CheckSeaBeast()
	if (game:GetService("Workspace")):FindFirstChild("SeaBeasts") then
		for i, v in pairs((game:GetService("Workspace")).SeaBeasts:GetChildren()) do
			if v:FindFirstChild("Humanoid") or v:FindFirstChild("HumanoidRootPart") or v.Humanoid.Health < 0 then
				return true;
			end;
		end;
	end;
	return false;
end;
function EquipAllWeapon()
	pcall(function()
		for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") and (not (v.Name == "Summon Sea Beast" or v.Name == "Water Body" or v.Name == "Awakening")) then
				local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name);
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid);
				wait(1);
			end;
		end;
	end);
end;
local gg = getrawmetatable(game);
local old = gg.__namecall;
setreadonly(gg, false);
gg.__namecall = newcclosure(function(...)
	local method = getnamecallmethod();
	local args = {
		...
	};
	if tostring(method) == "FireServer" then
		if tostring(args[1]) == "RemoteEvent" then
			if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
				if Skillaimbot then
					args[2] = AimBotSkillPosition;
					return old(unpack(args));
				end;
			end;
		end;
	end;
	return old(...);
end);
spawn(function()
	while wait(0.2) do
		pcall(function()
			if UseSkill then
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
					if v.Name == MonFarm and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health <= v.Humanoid.MaxHealth * _G.Settings.Setting["Mastery Health"] / 100 then
						if _G.Settings.Setting["Fruit Mastery Skill Z"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
							wait(_G.Settings.Hold["Hold Mastery Skill Z"]);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
						end;
						if _G.Settings.Setting["Fruit Mastery Skill X"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
							wait(_G.Settings.Hold["Hold Mastery Skill X"]);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
						end;
						if _G.Settings.Setting["Fruit Mastery Skill C"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "C", false, game);
							wait(_G.Settings.Hold["Hold Mastery Skill C"]);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "C", false, game);
						end;
						if _G.Settings.Setting["Fruit Mastery Skill V"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "V", false, game);
							wait(_G.Settings.Hold["Hold Mastery Skill V"]);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "V", false, game);
						end;
						if _G.Settings.Setting["Fruit Mastery Skill F"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "F", false, game);
							wait(_G.Settings.Hold["Hold Mastery Skill F"]);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "F", false, game);
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
			if UseGunSkill then
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
					if v.Name == MonFarm and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health <= v.Humanoid.MaxHealth * _G.Settings.Setting["Mastery Health"] / 100 then
						if _G.Settings.Setting["Gun Mastery Skill Z"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "Z", false, game);
							wait(0.5);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "Z", false, game);
						end;
						if _G.Settings.Setting["Gun Mastery Skill X"] then
							(game:service("VirtualInputManager")):SendKeyEvent(true, "X", false, game);
							wait(0.5);
							(game:service("VirtualInputManager")):SendKeyEvent(false, "X", false, game);
						end;
					end;
				end;
			end;
		end);
	end;
end);
if World2 then
]========]}
}}
