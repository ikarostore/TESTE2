return {Name="Farming Other", Chunks={
{Order=2, Code=[========[	FarmTab:Seperator("Elite Hunter");
	local Elite_Hunter_Status = FarmTab:Label("Status");
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if (game:GetService("ReplicatedStorage")):FindFirstChild("Diablo") or (game:GetService("ReplicatedStorage")):FindFirstChild("Deandre") or (game:GetService("ReplicatedStorage")):FindFirstChild("Urban") or (game:GetService("Workspace")).Enemies:FindFirstChild("Diablo") or (game:GetService("Workspace")).Enemies:FindFirstChild("Deandre") or (game:GetService("Workspace")).Enemies:FindFirstChild("Urban") then
					Elite_Hunter_Status:Set("Status : Elite Spawn!");
				else
					Elite_Hunter_Status:Set("Status : Elite Not Spawn");
				end;
			end);
		end;
	end);
	FarmTab:Toggle("Auto Elite Hunter", _G.Settings.Farm["Auto Elite Hunter"], "Auto Kill Elite Hunter When Spawn", function(value)
		_G.Settings.Farm["Auto Elite Hunter"] = value;
		StopTween(_G.Settings.Farm["Auto Elite Hunter"]);
		(getgenv()).SaveSetting();
	end);
	FarmTab:Toggle("Auto Elite Hunter Hop", _G.Settings.Farm["Auto Elite Hunter Hop"], "Auto Hop If Elite Hunter Not Spawn", function(value)
		_G.Settings.Farm["Auto Elite Hunter Hop"] = value;
		StopTween(_G.Settings.Farm["Auto Elite Hunter Hop"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Elite Hunter Hop"] then
				pcall(function()
					if _G.Settings.Farm["Auto Elite Hunter"] then
						if not (game:GetService("Workspace")).Enemies:FindFirstChild("Diablo") or (not (game:GetService("Workspace")).Enemies:FindFirstChild("Deandre")) or (not (game:GetService("Workspace")).Enemies:FindFirstChild("Urban")) then
							Hop();
						end;
					end;
				end);
			end;
		end;
	end);
	FarmTab:Button("Check Progress", function()
		Update:Notify("Elite Hunter Progress : " .. (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("EliteHunter", "Progress"), 3);
	end);
	local Elite = CFrame.new(-5418.892578125, 313.74130249023, -2826.2260742188);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Elite Hunter"] and World3 then
				pcall(function()
					local QuestTitle = (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text;
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Diablo") or (game:GetService("Workspace")).Enemies:FindFirstChild("Deandre") or (game:GetService("Workspace")).Enemies:FindFirstChild("Urban") then
						if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false then
							topos(Elite);
							if (Vector3.new((-5418.892578125), 313.74130249023, (-2826.2260742188)) - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
								(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("EliteHunter");
							end;
						elseif (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == true then
							if string.find(QuestTitle, "Diablo") or string.find(QuestTitle, "Deandre") or string.find(QuestTitle, "Urban") then
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
							end;
						end;
					end;
				end);
			end;
		end;
	end);
	FarmTab:Seperator("Bone Farm");
	local ListB = {
		"Quest",
		"No Quest"
	};
	FarmTab:Dropdown("Choose Mode", ListB, _G.Settings.Farm["Selected Bone Farm Mode"], function(value)
		_G.Settings.Farm["Selected Bone Farm Mode"] = value;
	end);
	local BonesOwnedStatus = FarmTab:Label("Bones Owned");
	spawn(function()
		while wait(1) do
			pcall(function()
				local Bones = GetCountMaterials("Bones");
				BonesOwnedStatus:Set("Bones Owned: " .. tostring(Bones));
			end);
		end;
	end);
	local BoneFarm = FarmTab:Toggle("Auto Farm Bone", _G.Settings.Farm["Auto Farm Bone"], "Auto Kill Bone Mob", function(value)
		_G.Settings.Farm["Auto Farm Bone"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Bone"]);
		(getgenv()).SaveSetting();
	end);
	local BonePos = CFrame.new(-9506.234375, 172.130615234375, 6117.0771484375);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Selected Bone Farm Mode"] == "No Quest" and _G.Settings.Farm["Auto Farm Bone"] and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Reborn Skeleton") or (game:GetService("Workspace")).Enemies:FindFirstChild("Living Zombie") or (game:GetService("Workspace")).Enemies:FindFirstChild("Demonic Soul") or (game:GetService("Workspace")).Enemies:FindFirstChild("Posessed Mummy") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
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
									until not _G.Settings.Farm["Auto Farm Bone"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-9506.234375, 172.130615234375, 6117.0771484375));
					end;
				end);
			end;
		end;
	end);
	local BoneQuestPos = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Selected Bone Farm Mode"] == "Quest" and _G.Settings.Farm["Auto Farm Bone"] and World3 then
				pcall(function()
					local QuestTitle = (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text;
					if not string.find(QuestTitle, "Demonic Soul") then
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("AbandonQuest");
					end;
					if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false then
						topos(BoneQuestPos);
						if (BoneQuestPos.Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("StartQuest", "HauntedQuest2", 1);
						end;
					elseif (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == true then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Reborn Skeleton") or (game:GetService("Workspace")).Enemies:FindFirstChild("Living Zombie") or (game:GetService("Workspace")).Enemies:FindFirstChild("Demonic Soul") or (game:GetService("Workspace")).Enemies:FindFirstChild("Posessed Mummy") then
							for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
								if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
										if string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Demonic Soul") then
											repeat
												(game:GetService("RunService")).Heartbeat:wait();
												EquipWeapon(_G.Settings.Main["Selected Weapon"]);
												AutoHaki();
												PosMon = v.HumanoidRootPart.CFrame;
												MonFarm = v.Name;
												topos(v.HumanoidRootPart.CFrame * Pos);
												v.HumanoidRootPart.CanCollide = false;
												v.Humanoid.WalkSpeed = 0;
												v.Head.CanCollide = false;
												Attack();
											until not _G.Settings.Farm["Auto Farm Bone"] or v.Humanoid.Health <= 0 or (not v.Parent) or (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false;
										end;
									end;
								end;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
	FarmTab:Toggle("Auto Random Surprise", _G.Settings.Farm["Auto Random Surprise"], "Auto Trade Bone", function(value)
		_G.Settings.Farm["Auto Random Surprise"] = value;
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Farm["Auto Random Surprise"] then
					wait(2);
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1);
				end;
			end;
		end);
	end);
	FarmTab:Seperator("Pirate Raid");
	FarmTab:Toggle("Auto Pirate Raid", _G.Settings.Farm["Auto Pirate Raid"], "Auto Kill Pirate Raid Enemies", function(value)
		_G.Settings.Farm["Auto Pirate Raid"] = value;
		StopTween(_G.Settings.Farm["Auto Pirate Raid"]);
		(getgenv()).SaveSetting();
	end);
	function getPirateRaidEnemies()
		local PirateRaidPos = CFrame.new(-5515.08301, 343.112762, -3013.25171, 0.0679906458, 0.0000000121971047, -0.997685969, -0.0000000640159001, 1, 0.00000000786281706, 0.997685969, 0.000000063333168, 0.0679906458);
		for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
			if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
				local enemyPos = v.HumanoidRootPart.Position;
				if (PirateRaidPos.Position - enemyPos).Magnitude <= 2000 then
					if v then
						return v;
					else
						return false;
					end;
				end;
			end;
		end;
	end;
	spawn(function()
		while wait() do
			if _G.Settings.Farm["Auto Pirate Raid"] then
				pcall(function()
					for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
						if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
							if v.Name then
								if getPirateRaidEnemies() then
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (v:FindFirstChild("HumanoidRootPart")).Position).Magnitude <= 2000 then
										repeat
											(game:GetService("RunService")).Heartbeat:wait();
											Attack();
											AutoHaki();
											EquipWeapon(_G.Settings.Main["Selected Weapon"]);
											topos(v.HumanoidRootPart.CFrame * Pos);
											v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid.JumpPower = 0;
											v.Humanoid.WalkSpeed = 0;
											v.HumanoidRootPart.CanCollide = false;
											PosMon = v.HumanoidRootPart.CFrame;
											MonFarm = v.Name;
										until not _G.Settings.Main["Auto Pirate Raid"] or (not v.Parent) or v.Humanoid.Health <= 0 or (not game.Workspace.Enemies:FindFirstChild(v.Name));
									end;
								else
									topos(CFrame.new(-5515.08301, 343.112762, -3013.25171, 0.0679906458, 0.0000000121971047, -0.997685969, -0.0000000640159001, 1, 0.00000000786281706, 0.997685969, 0.000000063333168, 0.0679906458));
								end;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
end;
FarmTab:Seperator("Observation");
local ObservationRange = FarmTab:Label("");
spawn(function()
	while wait(0.2) do
		pcall(function()
			ObservationRange:Set("Observation Range : " .. math.floor((game:GetService("Players")).LocalPlayer.VisionRadius.Value));
		end);
	end;
end);
FarmTab:Toggle("Auto Farm Observation", _G.Settings.Farm["Auto Farm Observation"], false, function(value)
	_G.Settings.Farm["Auto Farm Observation"] = value;
	StopTween(_G.Settings.Farm["Auto Farm Observation"]);
	(getgenv()).SaveSetting();
end);
if World3 then
	FarmTab:Toggle("Auto V2 Observation", _G.Settings.Farm["Auto Observation V2"], false, function(value)
		_G.Settings.Farm["Auto Observation V2"] = value;
		StopTween(_G.Settings.Farm["Auto Observation V2"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.Farm["Auto Observation V2"] then
					if (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 3 then
						_G.Settings.Farm["Auto Musketeer Hat"] = false;
						if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Banana") and (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Apple") and (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Pineapple") then
							repeat
								topos(CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625));
								wait();
							until not _G.Settings.Farm["Auto Observation V2"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-12444.78515625), 332.40396118164, (-7673.1806640625))).Magnitude <= 10;
							wait(0.5);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
						elseif (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Fruit Bowl") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Fruit Bowl") then
							repeat
								topos(CFrame.new(-10920.125, 624.20275878906, -10266.995117188));
								wait();
							until not _G.Settings.Farm["Auto Observation V2"] or ((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new((-10920.125), 624.20275878906, (-10266.995117188))).Magnitude <= 10;
							wait(0.5);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("KenTalk2", "Start");
							wait(1);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("KenTalk2", "Buy");
						else
							for i, v in pairs((game:GetService("Workspace")):GetDescendants()) do
								if v.Name == "Apple" or v.Name == "Banana" or v.Name == "Pineapple" then
									v.Handle.CFrame = (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10);
									wait();
									firetouchinterest((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart, v.Handle, 0);
									wait();
								end;
							end;
						end;
					else
						_G.Settings.Farm["Auto Musketeer Hat"] = true;
					end;
				end;
			end);
		end;
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Farm["Auto Musketeer Hat"] then
					if (game:GetService("Players")).LocalPlayer.Data.Level.Value >= 1800 and ((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CitizenQuestProgress")).KilledBandits == false then
						if string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == true then
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Forest Pirate") then
								for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
									if v.Name == "Forest Pirate" then
										repeat
											(game:GetService("RunService")).Heartbeat:wait();
											EquipWeapon(_G.Settings.Main["Selected Weapon"]);
											AutoHaki();
											v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
											topos(v.HumanoidRootPart.CFrame * Pos);
											v.HumanoidRootPart.CanCollide = false;
											Attack();
											PosMon = v.HumanoidRootPart.CFrame;
											MonFarm = v.Name;
										until _G.Settings.Farm["Auto Musketeer Hat"] == false or (not v.Parent) or v.Humanoid.Health <= 0 or (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false;
									end;
								end;
							else
								topos(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375));
							end;
						else
							topos(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125));
							if (Vector3.new((-12443.8671875), 332.40396118164, (-7675.4892578125)) - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
								wait(1.5);
								(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1);
							end;
						end;
					elseif (game:GetService("Players")).LocalPlayer.Data.Level.Value >= 1800 and ((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CitizenQuestProgress")).KilledBoss == false then
						if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible and string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == true then
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Captain Elephant") then
								for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
									if v.Name == "Captain Elephant" then
										OldCFrameElephant = v.HumanoidRootPart.CFrame;
										repeat
											(game:GetService("RunService")).Heartbeat:wait();
											EquipWeapon(_G.Settings.Main["Selected Weapon"]);
											AutoHaki();
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
											topos(v.HumanoidRootPart.CFrame * Pos);
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.CFrame = OldCFrameElephant;
											Attack();
										until _G.Settings.Farm["Auto Musketeer Hat"] == false or v.Humanoid.Health <= 0 or (not v.Parent) or (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false;
									end;
								end;
							else
								topos(CFrame.new(-13374.889648438, 421.27752685547, -8225.208984375));
							end;
						else
							topos(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125));
							if ((CFrame.new((-12443.8671875), 332.40396118164, (-7675.4892578125))).Position - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
								wait(0.5);
								(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
							end;
						end;
					elseif (game:GetService("Players")).LocalPlayer.Data.Level.Value >= 1800 and (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
						topos(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125));
					end;
				end;
			end;
		end);
	end);
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.Settings.Farm["Auto Farm Observation"] then
					repeat
						task.wait();
						if not (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
							(game:GetService("VirtualUser")):CaptureController();
							(game:GetService("VirtualUser")):SetKeyDown("0x65");
							wait(2);
							(game:GetService("VirtualUser")):SetKeyUp("0x65");
						end;
					until (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") or (not _G.Settings.Farm["Auto Farm Observation"]);
				end;
			end);
		end;
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Farm["Auto Farm Observation"] then
					if (game:GetService("Players")).LocalPlayer.VisionRadius.Value >= 5000 then
						Update:Notify("You Have Max Points", 3);
						wait(2);
					elseif World2 then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Lava Pirate [Lv. 1200]") then
							if (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
								repeat
									task.wait();
									(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = ((game:GetService("Workspace")).Enemies:FindFirstChild("Lava Pirate")).HumanoidRootPart.CFrame * CFrame.new(3, 0, 0);
								until _G.Settings.Farm["Auto Farm Observation"] == false or (not (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel"));
							else
								repeat
									task.wait();
									(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = ((game:GetService("Workspace")).Enemies:FindFirstChild("Lava Pirate")).HumanoidRootPart.CFrame * CFrame.new(0, 50, 0);
									if not (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and _G.Settings.Farm["Auto Farm Observation"] == true then
										(game:GetService("TeleportService")):Teleport(game.PlaceId, (game:GetService("Players")).LocalPlayer);
									end;
								until _G.Settings.Farm["Auto Farm Observation"] == false or (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel");
							end;
						else
							topos(CFrame.new(-5478.39209, 15.9775667, -5246.9126));
						end;
					elseif World1 then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Galley Captain") then
							if (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
								repeat
									task.wait();
									(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = ((game:GetService("Workspace")).Enemies:FindFirstChild("Galley Captain")).HumanoidRootPart.CFrame * CFrame.new(3, 0, 0);
								until _G.Settings.Farm["Auto Farm Observation"] == false or (not (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel"));
							else
								repeat
									task.wait();
									(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = ((game:GetService("Workspace")).Enemies:FindFirstChild("Galley Captain")).HumanoidRootPart.CFrame * CFrame.new(0, 50, 0);
									wait(1);
									if not (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and _G.Settings.Farm["Auto Farm Observation"] == true then
										(game:GetService("TeleportService")):Teleport(game.PlaceId, (game:GetService("Players")).LocalPlayer);
									end;
								until _G.Settings.Farm["Auto Farm Observation"] == false or (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel");
							end;
						else
							topos(CFrame.new(5533.29785, 88.1079102, 4852.3916));
						end;
					elseif World3 then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Giant Islander") then
							if (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
								repeat
									task.wait();
									(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = ((game:GetService("Workspace")).Enemies:FindFirstChild("Giant Islander")).HumanoidRootPart.CFrame * CFrame.new(3, 0, 0);
								until _G.Settings.Farm["Auto Farm Observation"] == false or (not (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel"));
							else
								repeat
									task.wait();
									(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = ((game:GetService("Workspace")).Enemies:FindFirstChild("Giant Islander")).HumanoidRootPart.CFrame * CFrame.new(0, 50, 0);
									wait(1);
									if not (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and _G.Settings.Farm["Auto Farm Observation"] == true then
										(game:GetService("TeleportService")):Teleport(game.PlaceId, (game:GetService("Players")).LocalPlayer);
									end;
								until _G.Settings.Farm["Auto Farm Observation"] == false or (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel");
							end;
						else
							topos(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789));
						end;
					end;
				end;
			end;
		end);
	end);
end;
if World1 then
	FarmTab:Toggle("Auto Get Saber", _G.Settings.Farm["Auto Saber"], "Auto Get Saber", function(value)
		_G.Settings.Farm["Auto Saber"] = value;
		StopTween(_G.Settings.Farm["Auto Saber"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while task.wait(0.2) do
			if _G.Settings.Farm["Auto Saber"] and game.Players.LocalPlayer.Data.Level.Value >= 200 then
				pcall(function()
					if (game:GetService("Workspace")).Map.Jungle.Final.Part.Transparency == 0 then
						if (game:GetService("Workspace")).Map.Jungle.QuestPlates.Door.Transparency == 0 then
							if ((CFrame.new((-1612.55884), 36.9774132, 148.719543, 0.37091279, 0.0000000030717151, (-0.928667724), 0.0000000397099491, 1, 0.0000000191679348, 0.928667724, (-0.0000000439869794), 0.37091279)).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
								topos((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame);
								wait(1);
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (game:GetService("Workspace")).Map.Jungle.QuestPlates.Plate1.Button.CFrame;
								wait(1);
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (game:GetService("Workspace")).Map.Jungle.QuestPlates.Plate2.Button.CFrame;
								wait(1);
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (game:GetService("Workspace")).Map.Jungle.QuestPlates.Plate3.Button.CFrame;
								wait(1);
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (game:GetService("Workspace")).Map.Jungle.QuestPlates.Plate4.Button.CFrame;
								wait(1);
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (game:GetService("Workspace")).Map.Jungle.QuestPlates.Plate5.Button.CFrame;
								wait(1);
							else
								topos(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 0.0000000030717151, -0.928667724, 0.0000000397099491, 1, 0.0000000191679348, 0.928667724, -0.0000000439869794, 0.37091279));
							end;
						elseif (game:GetService("Workspace")).Map.Desert.Burn.Part.Transparency == 0 then
							if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
								EquipWeapon("Torch");
								topos(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -0.00000000128799094, 0.761243105, -0.000000000570652914, 1, 0.00000000120584542, -0.761243105, 0.000000000347544882, -0.648466587));
							else
								topos(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 0.0000342372805, -0.258850515, 0.965917408));
							end;
						elseif (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan") ~= 0 then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ProQuestProgress", "GetCup");
							wait(0.5);
							EquipWeapon("Cup");
							wait(0.5);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ProQuestProgress", "FillCup", (game:GetService("Players")).LocalPlayer.Character.Cup);
							wait(0);
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan");
						elseif (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == nil then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon");
						elseif (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 0 then
							if (game:GetService("Workspace")).Enemies:FindFirstChild("Mob Leader") or (game:GetService("ReplicatedStorage")):FindFirstChild("Mob Leader") then
								topos(CFrame.new(-2967.59521, -4.91089821, 5328.70703, 0.342208564, -0.0227849055, 0.939347804, 0.0251603816, 0.999569714, 0.0150796166, -0.939287126, 0.0184739735, 0.342634559));
								for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
									if v.Name == "Mob Leader" then
										if (game:GetService("Workspace")).Enemies:FindFirstChild("Mob Leader [Lv. 120] [Boss]") then
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
												until v.Humanoid.Health <= 0 or (not _G.Settings.Farm["Auto Saber"]);
											end;
										end;
										if (game:GetService("ReplicatedStorage")):FindFirstChild("Mob Leader") then
											topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Mob Leader")).HumanoidRootPart.CFrame * Pos);
										end;
									end;
								end;
							end;
						elseif (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon");
							wait(0.5);
							EquipWeapon("Relic");
							wait(0.5);
							topos(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 0.00000000566906877, 0.481375456, 0.0000000253851997, 1, -0.0000000579995607, -0.481375456, 0.0000000630572643, 0.876514494));
						end;
					elseif (game:GetService("Workspace")).Enemies:FindFirstChild("Saber Expert") or (game:GetService("ReplicatedStorage")):FindFirstChild("Saber Expert") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								if v.Name == "Saber Expert" then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										topos(v.HumanoidRootPart.CFrame * Pos);
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid.JumpPower = 0;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.CanCollide = false;
										PosMon = v.HumanoidRootPart.CFrame;
										MonFarm = v.Name;
										Attack();
									until v.Humanoid.Health <= 0 or (not _G.Settings.Farm["Auto Saber"]);
									if v.Humanoid.Health <= 0 then
										(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic");
									end;
								end;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
end;
FarmTab:Seperator("Chest Farm");
FarmTab:Toggle("Auto Farm Chest [ Tween ]", _G.Settings.Farm["Auto Farm Chest Tween"], "Auto Claim Chest Tween", function(value)
	_G.Settings.Farm["Auto Farm Chest Tween"] = value;
	StopTween(_G.Settings.Farm["Auto Farm Chest Tween"]);
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		pcall(function()
			if _G.Settings.Farm["Auto Farm Chest Tween"] then
				for i, v in pairs((game:GetService("Workspace")).ChestModels:GetChildren()) do
					if v.Name:find("Chest") then
						repeat
							wait();
							topos(v.RootPart.CFrame);
						until _G.Settings.Farm["Auto Farm Chest Tween"] == false or (not v.Parent);
						topos((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame);
					end;
				end;
			end;
		end);
	end;
end);
FarmTab:Toggle("Auto Farm Chest [ Instant ]", _G.Settings.Farm["Auto Farm Chest Instant"], "Auto Claim Chest Teleport", function(value)
	_G.Settings.Farm["Auto Farm Chest Instant"] = value;
	(getgenv()).SaveSetting();
end);
FarmTab:Toggle("Auto Chest Hop", _G.Settings.Farm["Auto Chest Hop"], "Auto Hop if chest is not avillable", function(value)
	_G.Settings.Farm["Auto Chest Hop"] = value;
	(getgenv()).SaveSetting();
end);
FarmTab:Toggle("Auto Stop Items", _G.Settings.Farm["Auto Stop Items"], "Stop When Get God's Chalice or FoD", function(value)
	_G.Settings.Farm["Auto Stop Items"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait() do
		pcall(function()
			if _G.Settings.Farm["Auto Stop Items"] then
				if (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("God's Chalice") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("God's Chalice") or (game:GetService("Players")).LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") or (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Fist of Darkness") then
					_G.Settings.Farm["Auto Farm Chest Instant"] = false;
					_G.Settings.Farm["Auto Farm Chest Tween"] = false;
					topos((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame);
				end;
			end;
		end);
	end;
end);
if World2 or World3 then
	FarmTab:Toggle("Auto Farm Chest Mirage island", _G.Settings.Farm["Auto Farm Chest Mirage"], "Auto Claim Chest Mirage", function(value)
		_G.Settings.Farm["Auto Farm Chest Mirage"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Chest Mirage"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Chest Mirage"] then
				for i, v in pairs((game:GetService("Workspace")).Map.MysticIsland.Chests:GetChildren()) do
					if string.find(v.Name, "Chest") then
						if (game:GetService("Workspace")):FindFirstChild(v.Name) then
							repeat
								(game:GetService("RunService")).Heartbeat:wait();
								if (game:GetService("Workspace")):FindFirstChild(v.Name) then
									topos(v.CFrame);
								end;
							until _G.Settings.Farm["Auto Farm Chest Mirage"] == false or (not v.Parent);
							topos((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame);
							break;
						end;
					end;
				end;
			end;
		end;
	end);
end;
spawn(function()
	while wait(0.2) do
		pcall(function()
			if _G.Settings.Farm["Auto Farm Chest Instant"] then
				for i, v in pairs((game:GetService("Workspace")).ChestModels:GetChildren()) do
					if v.Name:find("Chest") then
						repeat
							wait();
							if v.Name == "DiamondChest" then
								InstantTp(v.RootPart.CFrame);
								InstantTp(((game:GetService("Workspace")).ChestModels:FindFirstChild("DiamondChest")).RootPart.CFrame);
							elseif v.Name == "GoldChest" then
								InstantTp(v.RootPart.CFrame);
								InstantTp(((game:GetService("Workspace")).ChestModels:FindFirstChild("GoldChest")).RootPart.CFrame);
							elseif v.Name == "SilverChest" then
								InstantTp(v.RootPart.CFrame);
								InstantTp(((game:GetService("Workspace")).ChestModels:FindFirstChild("SilverChest")).RootPart.CFrame);
							end;
						until not _G.Settings.Farm["Auto Farm Chest Instant"] or (not v.Parent);
					end;
				end;
			end;
		end);
	end;
end);
spawn(function()
	while task.wait(0.2) do
		if _G.Settings.Farm["Auto Farm Chest Instant"] then
			(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("SetTeam", "Pirates");
		end;
	end;
end);
if World3 then
	FarmTab:Seperator("Cake Farm");
	local CakePrinceStatus = FarmTab:Label("Cake Prince Status");
	spawn(function()
		while task.wait(5) do
			pcall(function()
				if string.len((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
					CakePrinceStatus:Set("Cake Prince Status: " .. string.sub((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 41) .. " Remaining");
				elseif string.len((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
					CakePrinceStatus:Set("Cake Prince Status: " .. string.sub((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 40) .. " Remaining");
				elseif string.len((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
					CakePrinceStatus:Set("Cake Prince Status: " .. string.sub((game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 39) .. " Remaining");
				else
					CakePrinceStatus:Set("Cake Prince Status: Spawned!");
				end;
			end);
		end;
	end);
	FarmTab:Toggle("Auto Katakuri", _G.Settings.Farm["Auto Farm Katakuri"], "Auto Farm + Kill Cake Prince", function(value)
		_G.Settings.Farm["Auto Farm Katakuri"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Katakuri"]);
		(getgenv()).SaveSetting();
	end);
	local CakePos = CFrame.new(-2091.911865234375, 70.00884246826172, -12142.8359375);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Katakuri"] then
				pcall(function()
					if game.ReplicatedStorage:FindFirstChild("Cake Prince") or (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Prince") then
						if (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Prince") then
							for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
								if v.Name == "Cake Prince" then
									if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat
											(game:GetService("RunService")).Heartbeat:wait();
											AutoHaki();
											EquipWeapon(_G.Settings.Main["Selected Weapon"]);
											v.HumanoidRootPart.CanCollide = false;
											v.Humanoid.WalkSpeed = 0;
											v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
											topos(v.HumanoidRootPart.CFrame * Pos);
											RemoveAnimation(v);
											Attack();
										until not _G.Settings.Farm["Auto Farm Katakuri"] or (not v.Parent) or v.Humanoid.Health <= 0;
									end;
								end;
							end;
						elseif (game:GetService("Workspace")).Map.CakeLoaf.BigMirror.Other.Transparency == 0 and ((CFrame.new((-1990.672607421875), 4532.99951171875, (-14973.6748046875))).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000 then
							topos(CFrame.new(-2151.82153, 149.315704, -12404.9053));
						end;
					elseif (game:GetService("Workspace")).Enemies:FindFirstChild("Cookie Crafter") or (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Guard") or (game:GetService("Workspace")).Enemies:FindFirstChild("Baking Staff") or (game:GetService("Workspace")).Enemies:FindFirstChild("Head Baker") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker" then
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
									until not _G.Settings.Farm["Auto Farm Katakuri"] or (not v.Parent) or v.Humanoid.Health <= 0 or (game:GetService("Workspace")).Map.CakeLoaf.BigMirror.Other.Transparency == 0 or (game:GetService("ReplicatedStorage")):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]");
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-2091.911865234375, 70.00884246826172, -12142.8359375));
					end;
				end);
			end;
		end;
	end);
	FarmTab:Toggle("Auto Spawn Cake Prince", _G.Settings.Farm["Auto Spawn Cake Prince"], false, function(value)
		_G.Settings.Farm["Auto Spawn Cake Prince"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Spawn Cake Prince"] then
				wait(2);
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("CakePrinceSpawner", true);
			end;
		end;
	end);
	FarmTab:Toggle("Auto Kill Cake Prince Only", _G.Settings.Farm["Auto Kill Cake Prince"], false, function(value)
		_G.Settings.Farm["Auto Kill Cake Prince"] = value;
		StopTween(_G.Settings.Farm["Auto Kill Cake Prince"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Kill Cake Prince"] and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Cake Prince") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Cake Prince" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.HumanoidRootPart.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										topos(v.HumanoidRootPart.CFrame * Pos);
										RemoveAnimation(v);
										Attack();
										if v.Humanoid:FindFirstChild("Animator") then
											v.Humanoid.Animator:Destroy();
										end;
									until not _G.Settings.Farm["Auto Kill Cake Prince"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
					end;
				end);
			end;
		end;
	end);
	FarmTab:Toggle("Auto Kill Dough King Only", _G.Settings.Farm["Auto Kill Dough King"], false, function(value)
		_G.Settings.Farm["Auto Kill Dough King"] = value;
		StopTween(_G.Settings.Farm["Auto Kill Dough King"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Kill Dough King"] and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Dough King") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Dough King" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat
										(game:GetService("RunService")).Heartbeat:wait();
										AutoHaki();
										EquipWeapon(_G.Settings.Main["Selected Weapon"]);
										v.HumanoidRootPart.CanCollide = false;
										v.Humanoid.WalkSpeed = 0;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										topos(v.HumanoidRootPart.CFrame * Pos);
										RemoveAnimation(v);
										Attack();
										if v.Humanoid:FindFirstChild("Animator") then
											v.Humanoid.Animator:Destroy();
										end;
									until not _G.Settings.Farm["Auto Kill Dough King"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					end;
				end);
			end;
		end;
	end);
end;
]========]},
{Order=9, Code=[========[FarmTab:Seperator("Materials");
if World2 then
	FarmTab:Toggle("Auto Farm Radioactive", _G.Settings.Farm["Auto Farm Radioactive"], false, function(value)
		_G.Settings.Farm["Auto Farm Radioactive"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Radioactive"]);
		(getgenv()).SaveSetting();
	end);
	local MaterialsPos1 = CFrame.new(-507.7895202636719, 72.99479675292969, -126.45632934570312);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Radioactive"] and World2 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Factory Staff") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Factory Staff" then
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
									until not _G.Settings.Farm["Auto Farm Radioactive"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-507.7895202636719, 72.99479675292969, -126.45632934570312));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Factory Staff") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Factory Staff")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World2 then
	FarmTab:Toggle("Auto Farm Mystic Droplet", _G.Settings.Farm["Auto Farm Mystic Droplet"], false, function(value)
		_G.Settings.Farm["Auto Farm Mystic Droplet"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Mystic Droplet"]);
		(getgenv()).SaveSetting();
	end);
	local MaterialsPos2 = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Mystic Droplet"] and World2 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Water Fighter") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Water Fighter" then
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
									until not _G.Settings.Farm["Auto Farm Mystic Droplet"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Water Fighter") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Water Fighter")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World1 or World2 then
	FarmTab:Toggle("Auto Farm Magma Ore", _G.Settings.Farm["Auto Farm Magma Ore"], "Auto Farm Magma Ore", function(value)
		_G.Settings.Farm["Auto Farm Magma Ore"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Magma Ore"]);
		(getgenv()).SaveSetting();
	end);
	local MaterialsPos3 = CFrame.new(-5850.2802734375, 77.28675079345703, 8848.6748046875);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Magma Ore"] and World1 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Military Spy") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Military Spy" then
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
									until not _G.Settings.Farm["Auto Farm Magma Ore"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-5850.2802734375, 77.28675079345703, 8848.6748046875));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Military Spy") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Military Spy")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
	local MaterialsPos4 = CFrame.new(-5234.60595703125, 51.953372955322266, -4732.27880859375);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Magma Ore"] and World2 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Lava Pirate") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Lava Pirate" then
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
									until not _G.Settings.Farm["Auto Farm Magma Ore"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-5234.60595703125, 51.953372955322266, -4732.27880859375));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Lava Pirate") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Lava Pirate")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World1 then
	FarmTab:Toggle("Auto Farm Angel Wings", _G.Settings.Farm["Auto Farm Angel Wings"], false, function(value)
		_G.Settings.Farm["Auto Farm Angel Wings"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Angel Wings"]);
		(getgenv()).SaveSetting();
	end);
	local MaterialsPos5 = CFrame.new(-7827.15625, 5606.912109375, -1705.5833740234375);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Angel Wings"] and World1 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Royal Soldier") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Royal Soldier" then
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
									until not _G.Settings.Farm["Auto Farm Angel Wings"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-7827.15625, 5606.912109375, -1705.5833740234375));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Royal Soldier") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Royal Soldier")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World1 or World2 or World3 then
	FarmTab:Toggle("Auto Farm Leather", _G.Settings.Farm["Auto Farm Leather"], false, function(value)
		_G.Settings.Farm["Auto Farm Leather"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Leather"]);
		(getgenv()).SaveSetting();
	end);
	local MaterialsPos6 = CFrame.new(-1211.8792724609375, 4.787090301513672, 3916.83056640625);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Leather"] and World1 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Pirate") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Pirate" then
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
									until not _G.Settings.Farm["Auto Farm Leather"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-1211.8792724609375, 4.787090301513672, 3916.83056640625));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Pirate") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Pirate")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
	local MaterialsPos7 = CFrame.new(-2010.5059814453125, 73.00115966796875, -3326.620849609375);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Leather"] and World2 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Marine Captain") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Marine Captain" then
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
									until not _G.Settings.Farm["Auto Farm Leather"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-2010.5059814453125, 73.00115966796875, -3326.620849609375));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Marine Captain") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Marine Captain")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
	local MaterialsPos8 = CFrame.new(-11975.78515625, 331.7734069824219, -10620.0302734375);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Leather"] and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Jungle Pirate") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Jungle Pirate" then
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
									until not _G.Settings.Farm["Auto Farm Leather"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-11975.78515625, 331.7734069824219, -10620.0302734375));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Jungle Pirate") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Jungle Pirate")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World2 then
	FarmTab:Toggle("Auto Farm Ectoplasm", _G.Settings.Farm["Auto Farm Ectoplasm"], false, function(value)
		_G.Settings.Farm["Auto Farm Ectoplasm"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Ectoplasm"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Farm["Auto Farm Ectoplasm"] then
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Ship Deckhand") or (game:GetService("Workspace")).Enemies:FindFirstChild("Ship Engineer") or (game:GetService("Workspace")).Enemies:FindFirstChild("Ship Steward") or (game:GetService("Workspace")).Enemies:FindFirstChild("Ship Officer") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Ship Deckhand" or v.Name == "Ship Engineer" or v.Name == "Ship Steward" or v.Name == "Ship Officer" then
								repeat
									(game:GetService("RunService")).Heartbeat:wait();
									EquipWeapon(_G.Settings.Main["Selected Weapon"]);
									AutoHaki();
									if string.find(v.Name, "Ship") then
										v.HumanoidRootPart.CanCollide = false;
										v.Head.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
										topos(v.HumanoidRootPart.CFrame * Pos);
										Attack();
										PosMon = v.HumanoidRootPart.CFrame;
										MonFarm = v.Name;
									else
										topos(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625));
									end;
								until _G.Settings.Farm["Auto Farm Ectoplasm"] == false or (not v.Parent) or v.Humanoid.Health <= 0;
							end;
						end;
					else
						local Distance = (Vector3.new(911.35827636719, 125.95812988281, 33159.5390625) - (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;
						if Distance > 18000 then
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
						end;
						topos(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625));
					end;
				end;
			end;
		end);
	end);
end;
if World1 or World2 or World3 then
	FarmTab:Toggle("Auto Farm Scrap Metal", _G.Settings.Farm["Auto Farm Scrap Metal"], false, function(value)
		_G.Settings.Farm["Auto Farm Scrap Metal"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Scrap Metal"]);
		(getgenv()).SaveSetting();
	end);
	local MaterialsPos9 = CFrame.new(-1132.4202880859375, 14.844913482666016, 4293.30517578125);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Scrap Metal"] and World1 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Brute") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Brute" then
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
									until not _G.Settings.Farm["Auto Farm Scrap Metal"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-1132.4202880859375, 14.844913482666016, 4293.30517578125));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Brute") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Brute")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
	local MaterialsPos10 = CFrame.new(-972.307373046875, 73.04473876953125, 1419.2901611328125);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Scrap Metal"] and World2 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Mercenary") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Mercenary" then
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
									until not _G.Settings.Farm["Auto Farm Scrap Metal"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-972.307373046875, 73.04473876953125, 1419.2901611328125));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Mercenary") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Mercenary")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
	local MaterialsPos11 = CFrame.new(-289.6311950683594, 43.8282470703125, 5583.66357421875);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Scrap Metal"] and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Pirate Millionaire") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Pirate Millionaire" then
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
									until not _G.Settings.Farm["Auto Farm Scrap Metal"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-289.6311950683594, 43.8282470703125, 5583.66357421875));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Pirate Millionaire") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Pirate Millionaire")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World3 then
	FarmTab:Toggle("Auto Farm Conjured Cocoa", _G.Settings.Farm["Auto Farm Conjured Cocoa"], false, function(value)
		_G.Settings.Farm["Auto Farm Conjured Cocoa"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Conjured Cocoa"]);
		(getgenv()).SaveSetting();
	end);
	local MaterialsPos12 = CFrame.new(744.7930908203125, 24.76934242248535, -12637.7255859375);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Conjured Cocoa"] and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Chocolate Bar Battler") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Chocolate Bar Battler" then
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
									until not _G.Settings.Farm["Auto Farm Conjured Cocoa"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(744.7930908203125, 24.76934242248535, -12637.7255859375));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Chocolate Bar Battler") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Chocolate Bar Battler")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World3 then
	FarmTab:Toggle("Auto Farm Dragon Scale", _G.Settings.Farm["Auto Farm Dragon Scale"], false, function(value)
		_G.Settings.Farm["Auto Farm Dragon Scale"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Dragon Scale"]);
		(getgenv()).SaveSetting();
	end);
	local MaterialsPos13 = CFrame.new(5824.06982421875, 51.38640213012695, -1106.694580078125);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Dragon Scale"] and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Dragon Crew Warrior") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Dragon Crew Warrior" then
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
									until not _G.Settings.Farm["Auto Farm Dragon Scale"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(5824.06982421875, 51.38640213012695, -1106.694580078125));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Dragon Crew Warrior") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Dragon Crew Warrior")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World3 then
	FarmTab:Toggle("Auto Farm Gunpowder", _G.Settings.Farm["Auto Farm Gunpowder"], false, function(value)
		_G.Settings.Farm["Auto Farm Gunpowder"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Gunpowder"]);
		(getgenv()).SaveSetting();
	end);
	local MaterialsPos14 = CFrame.new(-379.6134338378906, 73.84449768066406, 5928.5263671875);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Gunpowder"] and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Pistol Billionaire") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Pistol Billionaire" then
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
									until not _G.Settings.Farm["Auto Farm Gunpowder"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-379.6134338378906, 73.84449768066406, 5928.5263671875));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Pistol Billionaire") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Pistol Billionaire")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World3 then
	FarmTab:Toggle("Auto Farm Fish Tail", _G.Settings.Farm["Auto Farm Fish Tail"], false, function(value)
		_G.Settings.Farm["Auto Farm Fish Tail"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Fish Tail"]);
		(getgenv()).SaveSetting();
	end);
	local MaterialsPos15 = CFrame.new(-10961.0126953125, 331.7977600097656, -8914.29296875);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Fish Tail"] and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Fishman Captain") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Fishman Captain" then
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
									until not Fish or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-10961.0126953125, 331.7977600097656, -8914.29296875));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Fishman Captain") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Fishman Captain")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
if World3 then
	FarmTab:Toggle("Auto Farm Mini Tusk", _G.Settings.Farm["Auto Farm Mini Tusk"], false, function(value)
		_G.Settings.Farm["Auto Farm Mini Tusk"] = value;
		StopTween(_G.Settings.Farm["Auto Farm Mini Tusk"]);
		(getgenv()).SaveSetting();
	end);
	local MaterialsPos16 = CFrame.new(-13516.0458984375, 469.8182373046875, -6899.16064453125);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Farm["Auto Farm Mini Tusk"] and World3 then
				pcall(function()
					if (game:GetService("Workspace")).Enemies:FindFirstChild("Mythological Pirate") then
						for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
							if v.Name == "Mythological Pirate" then
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
									until not _G.Settings.Farm["Auto Farm Mini Tusk"] or (not v.Parent) or v.Humanoid.Health <= 0;
								end;
							end;
						end;
					else
						UnEquipWeapon(_G.Settings.Main["Selected Weapon"]);
						topos(CFrame.new(-13516.0458984375, 469.8182373046875, -6899.16064453125));
						if (game:GetService("ReplicatedStorage")):FindFirstChild("Mythological Pirate") then
							topos(((game:GetService("ReplicatedStorage")):FindFirstChild("Mythological Pirate")).HumanoidRootPart.CFrame * CFrame.new(2, 20, 2));
						end;
					end;
				end);
			end;
		end;
	end);
end;
function NormalAttack()
	AttackModule:BladeHits();
end;
spawn(function()
	(game:GetService("RunService")).RenderStepped:Connect(function()
		pcall(function()
			if UseSkill or UseGunSkill or _G.SeaSkill then
				for i, v in pairs((game:GetService("Players")).LocalPlayer.PlayerGui.Notifications:GetChildren()) do
					for _, Notif in pairs(v:GetChildren()) do
						if string.find(Notif.Text, "Skill locked!") then
							v:Destroy();
						end;
					end;
				end;
			end;
		end);
	end);
end);
function EquipWeaponSword()
	pcall(function()
		for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v.ToolTip == "Sword" and v:IsA("Tool") then
				local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name);
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid);
			end;
		end;
	end);
end;
]========]}
}}
