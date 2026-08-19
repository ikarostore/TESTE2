return {Name="PVP", Chunks={
{Order=15, Code=[========[PvpTab:Seperator("Combat");
local plyserv = PvpTab:Label("Players");
spawn(function()
	while wait(0.2) do
		pcall(function()
			for i, v in pairs((game:GetService("Players")):GetPlayers()) do
				if i == 12 then
					plyserv:Set("Players :" .. " " .. i .. " " .. "/" .. " " .. "12" .. " " .. "(Max)");
				elseif i == 1 then
					plyserv:Set("Player :" .. " " .. i .. " " .. "/" .. " " .. "12");
				else
					plyserv:Set("Players :" .. " " .. i .. " " .. "/" .. " " .. "12");
				end;
			end;
		end);
	end;
end);
Playerslist = {};
for i, v in pairs((game:GetService("Players")):GetChildren()) do
	table.insert(Playerslist, v.Name);
end;
local SelectedPly = PvpTab:Dropdown("Choose Player", Playerslist, false, function(value)
	_G.SelectedPlayer = value;
end);
PvpTab:Button("Refresh Player", function()
	Playerslist = {};
	SelectedPly:Clear();
	for i, v in pairs((game:GetService("Players")):GetChildren()) do
		SelectedPly:Add(v.Name);
	end;
end);
PvpTab:Toggle("Spectate Player", false, "Change Camera Player", function(value)
	SpectatePlys = value;
	local plr1 = (game:GetService("Players")).LocalPlayer.Character.Humanoid;
	local plr2 = (game:GetService("Players")):FindFirstChild(_G.SelectedPlayer);
	repeat
		wait(0.1);
		(game:GetService("Workspace")).Camera.CameraSubject = ((game:GetService("Players")):FindFirstChild(_G.SelectedPlayer)).Character.Humanoid;
	until SpectatePlys == false;
	(game:GetService("Workspace")).Camera.CameraSubject = (game:GetService("Players")).LocalPlayer.Character.Humanoid;
end);
PvpTab:Toggle("Teleport To Player", false, "Tween To Players", function(value)
	_G.TeleportToPlayer = value;
	pcall(function()
		if _G.TeleportToPlayer then
			repeat
				topos((game:GetService("Players"))[_G.SelectedPlayer].Character.HumanoidRootPart.CFrame);
				wait();
			until _G.TeleportToPlayer == false;
		end;
		StopTween(_G.TeleportToPlayer);
	end);
end);
PvpTab:Toggle("Auto Farm Player", false, "Auto Kill Players", function(value)
	_G.AutoKillSelectedPlayer = value;
	StopTween(_G.AutoKillSelectedPlayer);
end);
spawn(function()
	while wait(0.2) do
		if _G.AutoKillSelectedPlayer then
			pcall(function()
				if _G.SelectedPlayer ~= nil then
					if game.Players:FindFirstChild(_G.SelectedPlayer) then
						if (game.Players:FindFirstChild(_G.SelectedPlayer)).Character.Humanoid.Health > 0 then
							repeat
								(game:GetService("RunService")).Heartbeat:wait();
								EquipWeapon(_G.Settings.Main["Selected Weapon"]);
								Attack();
								AutoHaki();
								(game.Players:FindFirstChild(_G.SelectedPlayer)).Character.HumanoidRootPart.CanCollide = false;
								topos((game.Players:FindFirstChild(_G.SelectedPlayer)).Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0));
								spawn(function()
									pcall(function()
										if _G.Settings.Main["Selected Weapon"] == SelectWeaponGun then
											local args = {
												[1] = (game.Players:FindFirstChild(_G.SelectedPlayer)).Character.HumanoidRootPart.Position,
												[2] = (game.Players:FindFirstChild(_G.SelectedPlayer)).Character.HumanoidRootPart
											};
											(game:GetService("Players")).LocalPlayer.Character[SelectWeaponGun].RemoteFunctionShoot:InvokeServer(unpack(args));
										else
											(game:GetService("VirtualUser")):CaptureController();
											(game:GetService("VirtualUser")):Button1Down(Vector2.new(1280, 672));
										end;
									end);
								end);
							until (game.Players:FindFirstChild(_G.SelectedPlayer)).Character.Humanoid.Health <= 0 or (not game.Players:FindFirstChild(_G.SelectedPlayer)) or (not _G.AutoKillSelectedPlayer);
						end;
					end;
				end;
			end);
		end;
	end;
end);
if World3 then
	PvpTab:Seperator("Quest Player");
	PvpTab:Button("Get Quest Elite Players", function()
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("PlayerHunter");
	end);
	PvpTab:Toggle("Auto Kill Player Quest", _G.Settings.Combat["Auto Kill Player Quest"], "Auto Player Quest", function(value)
		_G.Settings.Combat["Auto Kill Player Quest"] = value;
		StopTween(_G.Settings.Combat["Auto Kill Player Quest"]);
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		(game:GetService("RunService")).Heartbeat:connect(function()
			pcall(function()
				if _G.Settings.Combat["Auto Kill Player Quest"] then
					if (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("Humanoid") then
						(game:GetService("Players")).LocalPlayer.Character.Humanoid:ChangeState(11);
					end;
				end;
			end);
		end);
	end);
	spawn(function()
		pcall(function()
			while wait(0.2) do
				if _G.Settings.Combat["Auto Kill Player Quest"] then
					if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true then
						(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("EnablePvp");
					end;
				end;
			end;
		end);
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Combat["Auto Kill Player Quest"] then
				if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Visible == false then
					wait(0.5);
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("PlayerHunter");
				else
					for i, v in pairs((game:GetService("Workspace")).Characters:GetChildren()) do
						if string.find((game:GetService("Players")).LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, v.Name) then
							repeat
								(game:GetService("RunService")).Heartbeat:wait();
								AutoHaki();
								EquipWeapon(_G.Settings.Main["Selected Weapon"]);
								topos(v.HumanoidRootPart.CFrame * CFrame.new(1, 30, 30));
								v.HumanoidRootPart.Size = Vector3.new(1, 1, 1);
								Attack();
							until _G.Settings.Combat["Auto Kill Player Quest"] == false or v.Humanoid.Health <= 0;
							(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("AbandonQuest");
						end;
					end;
				end;
			end;
		end;
	end);
end;
PvpTab:Seperator("Aimbot");
spawn(function()
	while wait() do
		pcall(function()
			local MaxDistance = math.huge;
			for i, v in pairs((game:GetService("Players")):GetPlayers()) do
				if v.Name ~= (game:GetService("Players")).LocalPlayer.Name then
					local Distance = v:DistanceFromCharacter((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position);
					if Distance < MaxDistance then
						MaxDistance = Distance;
						PlayerSelectAimbot = v.Name;
					end;
				end;
			end;
		end);
	end;
end);
PvpTab:Toggle("Aimbot Gun", _G.Settings.Combat["Aimbot Gun"], "Aimbot Skill Gun", function(value)
	_G.Settings.Combat["Aimbot Gun"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while task.wait() do
		if _G.Settings.Combat["Aimbot Gun"] and (game:GetService("Players")).LocalPlayer.Character:FindFirstChild(SelectWeaponGun) then
			pcall(function()
				(game:GetService("Players")).LocalPlayer.Character[SelectWeaponGun].Cooldown.Value = 0;
				local args = {
					[1] = ((game:GetService("Players")):FindFirstChild(PlayerSelectAimbot)).Character.HumanoidRootPart.Position,
					[2] = ((game:GetService("Players")):FindFirstChild(PlayerSelectAimbot)).Character.HumanoidRootPart
				};
				(game:GetService("Players")).LocalPlayer.Character[SelectWeaponGun].RemoteFunctionShoot:InvokeServer(unpack(args));
				(game:GetService("VirtualUser")):CaptureController();
				(game:GetService("VirtualUser")):Button1Down(Vector2.new(1280, 672));
			end);
		end;
	end;
end);
PvpTab:Toggle("Aimbot Skill Nearest", _G.Settings.Combat["Aimbot Skill Nearest"], "Aim Bot Skill Nearest", function(value)
	_G.Settings.Combat["Aimbot Skill Nearest"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.1) do
		pcall(function()
			local MaxDistance = math.huge;
			for i, v in pairs((game:GetService("Players")):GetPlayers()) do
				if v.Name ~= game.Players.LocalPlayer.Name then
					local Distance = v:DistanceFromCharacter(game.Players.LocalPlayer.Character.HumanoidRootPart.Position);
					if Distance < MaxDistance then
						MaxDistance = Distance;
						TargetPlayerAim = v.Name;
					end;
				end;
			end;
		end);
	end;
end);
spawn(function()
	pcall(function()
		(game:GetService("RunService")).RenderStepped:connect(function()
			if _G.Settings.Combat["Aimbot Skill Nearest"] and TargetPlayerAim ~= nil and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character[(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")).Name]:FindFirstChild("MousePos") then
				local args = {
					[1] = ((game:GetService("Players")):FindFirstChild(TargetPlayerAim)).Character.HumanoidRootPart.Position
				};
				(game:GetService("Players")).LocalPlayer.Character[(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")).Name].RemoteEvent:FireServer(unpack(args));
			end;
		end);
	end);
end);
PvpTab:Toggle("Aimbot Skill", _G.Settings.Combat["Aimbot Skill"], "Aimbot All Skill", function(value)
	_G.Settings.Combat["Aimbot Skill"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	pcall(function()
		while task.wait() do
			if _G.Settings.Combat["Aimbot Skill"] and PlayerSelectAimbot ~= nil and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and game.Players.LocalPlayer.Character[(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")).Name]:FindFirstChild("MousePos") then
				local args = {
					[1] = ((game:GetService("Players")):FindFirstChild(PlayerSelectAimbot)).Character.HumanoidRootPart.Position
				};
				((game:GetService("Players")).LocalPlayer.Character:FindFirstChild((game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")).Name)).RemoteEvent:FireServer(unpack(args));
			end;
		end;
	end);
end);
PvpTab:Toggle("Enable PvP", _G.Settings.Combat["Enable PvP"], "Enable PvP", function(value)
	_G.Settings.Combat["Enable PvP"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	pcall(function()
		while wait(0.1) do
			if _G.Settings.Combat["Enable PvP"] then
				if (game:GetService("Players")).LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true then
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("EnablePvp");
				end;
			end;
		end;
	end);
end);
PvpTab:Toggle("Safe Mode", false, "Auto Teleport To Up", function(value)
	_G.Safe_Mode = value;
	StopTween(_G.Safe_Mode);
end);
spawn(function()
	pcall(function()
		while wait(0.2) do
			if _G.Safe_Mode then
				local PlayerPosition = (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame;
				if (game:GetService("Players")).LocalPlayer.Character.Humanoid.Health <= 2000 then
					repeat
						wait();
						topos(PlayerPosition * CFrame.new(0, 400, 0));
					until (game:GetService("Players")).LocalPlayer.Character.Humanoid.Health >= 5000 or (not _g.Safe_Mode);
				end;
			end;
		end;
	end);
end);
PvpTab:Button("Respawn", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("SetTeam", "Pirates");
end);
if World2 or World3 then
]========]}
}}
