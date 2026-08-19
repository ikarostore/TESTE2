return {Name="volcano event", Chunks={
{Order=6, Code=[========[	PrehistoricTab:Seperator("Prehistoric Island");
	Prehistoriccheck = PrehistoricTab:Label("Prehistoric Island");
	PrehistoricTab:Toggle("Summon Prehistoric Island", _G.Settings.SeaStack["Summon Prehistoric Island"], "Need Volcano Magnet", function(value)
		_G.Settings.SeaStack["Summon Prehistoric Island"] = value;
		StopTween(_G.Settings.SeaStack["Summon Prehistoric Island"]);
		(getgenv()).SaveSetting();
		if TweenBoatPrehistoric then
			TweenBoatPrehistoric:Stop();
		end;
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.SeaStack["Summon Prehistoric Island"] then
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
								if TweenBoatPrehistoric then
									TweenBoatPrehistoric:Stop();
								end;
								local stoppos = topos(((game:GetService("Workspace")).Boats:FindFirstChild(_G.Settings.SeaEvent["Selected Boat"])).VehicleSeat.CFrame * CFrame.new(0, 1, 0));
							elseif (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Sit == true then
								TweenBoatPrehistoric = TweenBoat(CFrame.new(-148073.359, 8.99999523, 7721.05078, -0.0825930536, -0.00000154416148, 0.996583343, -0.000018696026, 1, -0.000000000000391858095, -0.996583343, -0.0000186321486, -0.0825930536));
							end;
						until not _G.Settings.SeaStack["Summon Prehistoric Island"] or game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island");
						if TweenBoatPrehistoric then
							TweenBoatPrehistoric:Stop();
						end;
					end;
				end;
			end);
		end;
	end);
	PrehistoricTab:Toggle("Tween To Prehistoric Island", _G.Settings.SeaStack["Tween To Prehistoric Island"], "Need Spawn Prehistoric Island", function(value)
		_G.Settings.SeaStack["Tween To Prehistoric Island"] = value;
		StopTween(_G.Settings.SeaStack["Tween To Prehistoric Island"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait() do
			if _G.Settings.SeaStack["Tween To Prehistoric Island"] then
				pcall(function()
					if (game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
						topos(((game:GetService("Workspace"))._WorldOrigin.Locations:FindFirstChild("Prehistoric Island")).CFrame);
					end;
				end);
			end;
		end;
	end);
	PrehistoricTab:Toggle("Auto Kill Lava Golem", _G.Settings.SeaStack["Auto Kill Lava Golem"], "Need Spawn Prehistoric Island", function(value)
		_G.Settings.SeaStack["Auto Kill Lava Golem"] = value;
		StopTween(_G.Settings.SeaStack["Auto Kill Lava Golem"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.DragonDojo["Auto Kill Lava Golem"] then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Lava Golem") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Lava Golem" then
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
									until not _G.Settings.DragonDojo["Auto Kill Lava Golem"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
	PrehistoricTab:Seperator("Volcano Defense");
	PrehistoricTab:Toggle("Auto Defend Volcano", _G.Settings.SeaStack["Auto Defend Volcano"], "Attack the active volcano rock automatically", function(value)
		_G.Settings.SeaStack["Auto Defend Volcano"] = value;
		StopTween(value);
		(getgenv()).SaveSetting();
	end);
	PrehistoricTab:Toggle("Remove Prehistoric Lava", _G.Settings.SeaStack["Remove Prehistoric Lava"], "Disable lava locally while the option is active", function(value)
		_G.Settings.SeaStack["Remove Prehistoric Lava"] = value;
		(getgenv()).SaveSetting();
	end);

	local function GetPrehistoricIsland()
		local Map = (game:GetService("Workspace")):FindFirstChild("Map");
		return Map and Map:FindFirstChild("PrehistoricIsland");
	end;

	local function GetActiveVolcanoRock()
		local Island = GetPrehistoricIsland();
		local Core = Island and Island:FindFirstChild("Core");
		local Rocks = Core and Core:FindFirstChild("VolcanoRocks");
		if not Rocks then
			return nil;
		end;
		for _, Object in pairs(Rocks:GetDescendants()) do
			if Object:IsA("MeshPart") and string.lower(Object.Name) == "volcanorock" then
				local Color = Object.Color;
				if Color == Color3.fromRGB(185, 53, 56) or Color == Color3.fromRGB(185, 53, 57) then
					return Object;
				end;
			end;
		end;
		return nil;
	end;

	spawn(function()
		while wait(0.1) do
			pcall(function()
				if _G.Settings.SeaStack["Remove Prehistoric Lava"] then
					local Island = GetPrehistoricIsland();
					if Island then
						for _, Object in pairs(Island:GetDescendants()) do
							if Object:IsA("BasePart") and string.find(string.lower(Object.Name), "lava") then
								Object.CanCollide = false;
								Object.CanTouch = false;
								Object.Transparency = 1;
							end;
						end;
					end;
				end;
				if _G.Settings.SeaStack["Auto Defend Volcano"] then
					local Rock = GetActiveVolcanoRock();
					if Rock then
						AutoHaki();
						EquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(Rock.CFrame * CFrame.new(0, 8, 12));
						Attack();
					end;
				end;
			end);
		end;
	end);

	PrehistoricTab:Seperator("Prehistoric Collectibles");
	PrehistoricTab:Toggle("Auto Collect Dino Bone", _G.Settings.SeaStack["Auto Collect Dino Bone"], "Collect Dinosaur Bones around the island", function(value)
		_G.Settings.SeaStack["Auto Collect Dino Bone"] = value;
		StopTween(value);
		(getgenv()).SaveSetting();
	end);
	PrehistoricTab:Toggle("Auto Collect Dragon Egg", _G.Settings.SeaStack["Auto Collect Dragon Egg"], "Collect spawned Dragon Eggs", function(value)
		_G.Settings.SeaStack["Auto Collect Dragon Egg"] = value;
		StopTween(value);
		(getgenv()).SaveSetting();
	end);

	spawn(function()
		while wait(0.2) do
			pcall(function()
				local Island = GetPrehistoricIsland();
				if not Island then
					return;
				end;
				if _G.Settings.SeaStack["Auto Collect Dino Bone"] then
					for _, Object in pairs(Island:GetDescendants()) do
						if Object:IsA("BasePart") and Object.Name == "DinoBone" then
							topos(Object.CFrame);
							break;
						end;
					end;
				elseif _G.Settings.SeaStack["Auto Collect Dragon Egg"] then
					local Eggs = Island:FindFirstChild("SpawnedDragonEggs", true);
					local Egg = Eggs and Eggs:FindFirstChildWhichIsA("BasePart", true);
					if Egg then
						topos(Egg.CFrame);
					end;
				end;
			end);
		end;
	end);

	PrehistoricTab:Seperator("Prehistoric Crafting");
	PrehistoricTab:Button("Craft Volcanic Magnet", function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Volcanic Magnet");
	end);
	PrehistoricTab:Button("Craft Dino Hood", function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "DinoHood");
	end);
	PrehistoricTab:Button("Craft T-Rex Skull", function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CraftItem", "Craft", "T-RexSkull");
	end);

]========]}
}}
