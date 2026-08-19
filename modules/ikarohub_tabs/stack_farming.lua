return {Name="Stack farming", Chunks={
{Order=7, Code=[========[	SeaStackTab:Seperator("Frozen Dimension");
	Frozencheck = SeaStackTab:Label("Frozen Dimension");
	SeaStackTab:Toggle("Teleport To Frozen Dimension", _G.Settings.SeaStack["Teleport To Frozen Dimension"], "Tween Player To Frozen Dimension", function(value)
		_G.Settings.SeaStack["Teleport To Frozen Dimension"] = value;
		StopTween(_G.Settings.SeaStack["Teleport To Frozen Dimension"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.SeaStack["Teleport To Frozen Dimension"] then
				pcall(function()
					repeat
						wait();
						topos(CFrame.new((game:GetService("Workspace")).Map.FrozenDimension.Center.Position.X, 500, (game:GetService("Workspace")).Map.FrozenDimension.Center.Position.Z));
					until not _G.Settings.SeaStack["Teleport To Frozen Dimension"];
				end);
			end;
		end;
	end);
	SeaStackTab:Toggle("Sail To Frozen Dimension", _G.Settings.SeaStack["Sail To Frozen Dimension"], "Tween Boat To Frozen Dimension", function(value)
		_G.Settings.SeaStack["Sail To Frozen Dimension"] = value;
		StopTween(_G.Settings.SeaStack["Sail To Frozen Dimension"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.SeaStack["Sail To Frozen Dimension"] then
					if (game:GetService("Workspace")).Map:FindFirstChild("FrozenDimension") then
						if not (game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"]) then
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
								wait(1);
							end;
						elseif (game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"]) then
							repeat
								wait();
								if (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == false then
									local stoppos = topos(((game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"])).VehicleSeat.CFrame * CFrame.new(0, 1, 0));
								elseif (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == true then
									local stopboat = TweenBoat(CFrame.new((game:GetService("Workspace")).Map.FrozenDimension.Center.Position.X, 0, (game:GetService("Workspace")).Map.FrozenDimension.Center.Position.Z));
								end;
							until not _G.Settings.SeaStack["Sail To Frozen Dimension"];
							stopboat:Stop();
						end;
					end;
				end;
			end);
		end;
	end);
	SeaStackTab:Toggle("Summon Frozen Dimension", _G.Settings.SeaStack["Summon Frozen Dimension"], "Spawn Frozen Dimension", function(value)
		_G.Settings.SeaStack["Summon Frozen Dimension"] = value;
		StopTween(_G.Settings.SeaStack["Summon Frozen Dimension"]);
		(getgenv()).SaveSetting();
		if TweenBoatFrozen then
			TweenBoatFrozen:Stop();
		end;
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.SeaStack["Summon Frozen Dimension"] then
					if not (game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"]) then
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
							wait(1);
						end;
					elseif (game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"]) then
						repeat
							wait();
							if (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == false then
								if TweenBoatFrozen then
									TweenBoatFrozen:Stop();
								end;
								local stoppos = topos(((game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"])).VehicleSeat.CFrame * CFrame.new(0, 1, 0));
							elseif (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == true then
								TweenBoatFrozen = TweenBoat(CFrame.new(-148073.359, 8.99999523, 7721.05078, -0.0825930536, -0.00000154416148, 0.996583343, -0.000018696026, 1, -0.000000000000391858095, -0.996583343, -0.0000186321486, -0.0825930536));
							end;
						until not _G.Settings.SeaStack["Summon Frozen Dimension"] or game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension");
						if TweenBoatFrozen then
							TweenBoatFrozen:Stop();
						end;
					end;
				end;
			end);
		end;
	end);
	local BribeStatus = SeaStackTab:Label("Leviathan Status");
	SeaStackTab:Button("Bribe Leviathan ( Buy Info Leviathan )", function()
		local Status = (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("InfoLeviathan", "2");
		BribeStatus:Set("Leviathan Status: " .. Status);
	end);
	function GetHighestPoint()
		for i, v in pairs((game:GetService("Workspace")).Map.MysticIsland:GetDescendants()) do
			if v:IsA("MeshPart") then
				if v.MeshId == "rbxassetid://6745037796" then
					return v;
				end;
			end;
		end;
	end;
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Race["Tween To Highest Mirage"] then
					if (game:GetService("Workspace")).Map:FindFirstChild("MysticIsland") then
						topos((GetHighestPoint()).CFrame * CFrame.new(0, 211.88, 0));
					end;
				end;
			end;
		end);
	end);
	SeaStackTab:Seperator("Kitsune Island");
	Kitsunecheck = SeaStackTab:Label("Kitsune Island");
	SeaStackTab:Toggle("Summon Kitsune Island", _G.Settings.SeaStack["Summon Kitsune Island"], "Spawn Kitsune Island", function(value)
		_G.Settings.SeaStack["Summon Kitsune Island"] = value;
		StopTween(_G.Settings.SeaStack["Summon Kitsune Island"]);
		(getgenv()).SaveSetting();
		if TweenBoatKitsune then
			TweenBoatKitsune:Stop();
		end;
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.SeaStack["Summon Kitsune Island"] then
					if not (game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"]) then
						local BuyBoatCFrame = CFrame.new(-16927.451171875, 9.0863618850708, 433.8642883300781);
						if (BuyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
							BTP(BuyBoatCFrame);
						else
							BuyBoatKitsune = topos(BuyBoatCFrame);
						end;
						if ((CFrame.new((-16927.451171875), 9.0863618850708, 433.8642883300781)).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							if BuyBoatKitsune then
								BuyBoatKitsune:Stop();
							end;
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyBoat", _G.Settings.SeaEvent["Selected Boat"]);
							wait(1);
						end;
					elseif (game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"]) then
						repeat
							wait();
							if (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == false then
								if TweenBoatKitsune then
									TweenBoatKitsune:Stop();
								end;
								local stoppos = topos(((game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"])).VehicleSeat.CFrame * CFrame.new(0, 1, 0));
							elseif (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == true then
								TweenBoatKitsune = TweenBoat(CFrame.new(-44541.7617, 30.0003204, -1244.8584, -0.0844199061, -0.00553312758, 0.9964149, -0.0654025897, 0.997858942, 0.000000000202319411, -0.99428153, -0.0651681125, -0.0846010372));
							end;
						until not _G.Settings.SeaStack["Summon Kitsune Island"] or game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island");
						if TweenBoatKitsune then
							TweenBoatKitsune:Stop();
						end;
					end;
				end;
			end);
		end;
	end);
	SeaStackTab:Toggle("Teleport To Kitsune Island", _G.Settings.SeaStack["Teleport To Kitsune Island"], "Tween To Kitsune Island", function(value)
		_G.Settings.SeaStack["Teleport To Kitsune Island"] = value;
		StopTween(_G.Settings.SeaStack["Teleport To Kitsune Island"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.SeaStack["Teleport To Kitsune Island"] then
				if (game:GetService("Workspace")).Map:FindFirstChild("KitsuneIsland") then
					topos(game.Workspace.Map.KitsuneIsland.ShrineActive.NeonShrinePart.CFrame * CFrame.new(0, 0, 10));
				end;
			end;
		end;
	end);
	SeaStackTab:Toggle("Auto Collect Azure Ember", _G.Settings.SeaStack["Auto Collect Azure Ember"], "Tween To Azure Ember", function(value)
		_G.Settings.SeaStack["Auto Collect Azure Ember"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.SeaStack["Auto Collect Azure Ember"] then
				pcall(function()
					if (game:GetService("Workspace")):FindFirstChild("AttachedAzureEmber") then
						topos((((game:GetService("Workspace")):WaitForChild("EmberTemplate")):FindFirstChild("Part")).CFrame);
					end;
				end);
			end;
		end;
	end);
	SeaStackTab:Slider("Set Azure Ember", 10, 25, _G.Settings.SeaStack["Set Azure Ember"], function(value)
		_G.Settings.SeaStack["Set Azure Ember"] = value;
		(getgenv()).SaveSetting();
	end);
	SeaStackTab:Toggle("Auto Trade Azure Ember", _G.Settings.SeaStack["Auto Trade Azure Ember"], "Trade Azure Ember", function(value)
		_G.Settings.SeaStack["Auto Trade Azure Ember"] = value;
		(getgenv()).SaveSetting();
	end);
	function GetCountMaterials(MaterialName)
		local Inventory = (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("getInventory");
		for i, v in pairs(Inventory) do
			if v.Name == MaterialName then
				return v.Count;
			end;
		end;
	end;
	spawn(function()
		while wait(0.2) do
			if _G.Settings.SeaStack["Auto Trade Azure Ember"] then
				pcall(function()
					local AzureAvilable = GetCountMaterials("Azure Ember");
					if AzureAvilable >= _G.Settings.SeaStack["Set Azure Ember"] then
						((game:GetService("ReplicatedStorage")).Modules.Net:FindFirstChild("RF/KitsuneStatuePray")):InvokeServer();
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("KitsuneStatuePray");
					end;
				end);
			end;
		end;
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.SeaStack["Teleport To Advanced Fruit Dealer"] then
					if (game:GetService("Workspace")).NPCs:FindFirstChild("Advanced Fruit Dealer") then
						topos(CFrame.new((game:GetService("Workspace")).NPCs["Advanced Fruit Dealer"].HumanoidRootPart.Position));
					end;
				end;
			end;
		end);
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Race["Find Blue Gear"] then
					if (game:GetService("Workspace")).Map:FindFirstChild("MysticIsland") then
						for i, v in pairs((game:GetService("Workspace")).Map.MysticIsland:GetChildren()) do
							if v:IsA("MeshPart") then
								if v.Material == Enum.Material.Neon then
									topos(v.CFrame);
								end;
							end;
						end;
					end;
				end;
			end;
		end);
	end);
end;
if World2 or World3 then
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
					Mirragecheck:Set("ðŸï¸ Mirage Island Spawning");
					_G.MirageSpawn = true;
				else
					Mirragecheck:Set("ðŸï¸ Mirage Island Not Spawn");
					_G.MirageSpawn = false;
				end;
			end;
		end);
	end);
	SeaStackTab:Seperator("Mirage Island");
	Mirragecheck = SeaStackTab:Label("Mirage Island");
	SeaStackTab:Toggle("Teleport To Mirage Island", _G.Settings.SeaStack["Teleport To Mirage Island"], "Tween To Mirage Island", function(value)
		_G.Settings.SeaStack["Teleport To Mirage Island"] = value;
		StopTween(_G.Settings.SeaStack["Teleport To Mirage Island"]);
		(getgenv()).SaveSetting();
	end);
	SeaStackTab:Toggle("Teleport Advanced Fruit Dealer", _G.Settings.SeaStack["Teleport To Advanced Fruit Dealer"], "Tween To Advanced Fruit Dealer", function(value)
		_G.Settings.SeaStack["Teleport To Advanced Fruit Dealer"] = value;
		StopTween(_G.Settings.SeaStack["Teleport To Advanced Fruit Dealer"]);
		(getgenv()).SaveSetting();
	end);
	if World2 then
		SeaStackTab:Seperator("Sea Beasts");
		SeaStackTab:Toggle("Auto Attack Seabeasts", _G.Settings.SeaStack["Auto Attack Seabeasts"], "Need spawn seabeasts", function(value)
			_G.Settings.SeaStack["Auto Attack Seabeasts"] = value;
			StopTween(_G.Settings.SeaStack["Auto Attack Seabeasts"]);
			(getgenv()).SaveSetting();
		end);
		spawn(function()
			pcall(function()
				while wait() do
					if _G.Settings.SeaStack["Auto Attack Seabeasts"] then
						if (game:GetService("Workspace")):FindFirstChild("SeaBeasts") then
							for i, v in pairs((game:GetService("Workspace")).SeaBeasts:GetChildren()) do
								if CheckSeaBeast() then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										CFrameSeaBeast = v.HumanoidRootPart.CFrame * CFrame.new(0, 200, 0);
										if (CFrameSeaBeast.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).Magnitude <= 400 then
											_G.SeaSkill = true;
										else
											_G.SeaSkill = false;
										end;
										AutoHaki();
										Skillaimbot = true;
										AimBotSkillPosition = v.HumanoidRootPart.CFrame.Position;
										if SBAttacking then
											topos(CFrameSeaBeast * CFrame.new(math.random(100, 300), 100, math.random(100, 300)));
										else
											topos(CFrameSeaBeast * CFrame.new(0, 100, 0));
										end;
									until not _G.Settings.SeaEvent["Auto Farm Seabeasts"] or CheckSeaBeast() == false or (not v:FindFirstChild("Humanoid")) or (not v:FindFirstChild("HumanoidRootPart")) or v.Humanoid.Health < 0 or (not v.Parent);
									Skillaimbot = false;
									_G.SeaSkill = false;
								else
									Skillaimbot = false;
									_G.SeaSkill = false;
								end;
							end;
						end;
					end;
				end;
			end);
		end);
	end;
	spawn(function()
		pcall(function()
			while wait() do
				if _G.Settings.SeaStack["Teleport To Mirage Island"] then
					if (game:GetService("Workspace")).Map:FindFirstChild("MysticIsland") then
						topos(CFrame.new((game:GetService("Workspace")).Map.MysticIsland.Center.Position.X, 500, (game:GetService("Workspace")).Map.MysticIsland.Center.Position.Z));
					end;
				end;
			end;
		end);
	end);
end;
if World3 then
]========]}
}}
