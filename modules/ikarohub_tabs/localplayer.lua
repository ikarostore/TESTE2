return {Name="Localplayer", Chunks={
{Order=17, Code=[========[TeleportTab:Seperator("World");
TeleportTab:Button("Teleport To First Sea", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelMain");
end);
TeleportTab:Button("Teleport To Second Sea", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelDressrosa");
end);
TeleportTab:Button("Teleport To Third Sea", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelZou");
end);
TeleportTab:Seperator("Island");
if World1 then
	TeleportTab:Dropdown("Choose Island", {
		"WindMill",
		"Marine",
		"Middle Town",
		"Jungle",
		"Pirate Village",
		"Desert",
		"Snow Island",
		"MarineFord",
		"Colosseum",
		"Sky Island 1",
		"Sky Island 2",
		"Sky Island 3",
		"Prison",
		"Magma Village",
		"Under Water Island",
		"Fountain City",
		"Shank Room",
		"Mob Island"
	}, false, function(value)
		_G.SelectIsland = value;
	end);
end;
if World2 then
	TeleportTab:Dropdown("Choose Island", {
		"The Cafe",
		"Frist Spot",
		"Dark Area",
		"Flamingo Mansion",
		"Flamingo Room",
		"Green Zone",
		"Factory",
		"Colossuim",
		"Zombie Island",
		"Two Snow Mountain",
		"Punk Hazard",
		"Cursed Ship",
		"Ice Castle",
		"Forgotten Island",
		"Ussop Island",
		"Mini Sky Island"
	}, false, function(value)
		_G.SelectIsland = value;
	end);
end;
if World3 then
	TeleportTab:Dropdown("Choose Island", {
		"Mansion",
		"Port Town",
		"Great Tree",
		"Castle On The Sea",
		"MiniSky",
		"Hydra Island",
		"Floating Turtle",
		"Haunted Castle",
		"Ice Cream Island",
		"Peanut Island",
		"Cake Island",
		"Cocoa Island",
		"Candy Island",
		"Tiki Outpost",
		"Dragon Dojo"
	}, false, function(value)
		_G.SelectIsland = value;
	end);
end;
TeleportTab:Toggle("Teleport", false, "Tween To Island", function(value)
	_G.TeleportIsland = value;
	if _G.TeleportIsland == true then
		repeat
			wait();
			if _G.SelectIsland == "WindMill" then
				topos(CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594));
			elseif _G.SelectIsland == "Marine" then
				topos(CFrame.new(-2566.4296875, 6.8556680679321, 2045.2561035156));
			elseif _G.SelectIsland == "Middle Town" then
				topos(CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094));
			elseif _G.SelectIsland == "Jungle" then
				topos(CFrame.new(-1612.7957763672, 36.852081298828, 149.12843322754));
			elseif _G.SelectIsland == "Pirate Village" then
				topos(CFrame.new(-1181.3093261719, 4.7514905929565, 3803.5456542969));
			elseif _G.SelectIsland == "Desert" then
				topos(CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688));
			elseif _G.SelectIsland == "Snow Island" then
				topos(CFrame.new(1347.8067626953, 104.66806030273, -1319.7370605469));
			elseif _G.SelectIsland == "MarineFord" then
				topos(CFrame.new(-4914.8212890625, 50.963626861572, 4281.0278320313));
			elseif _G.SelectIsland == "Colosseum" then
				topos(CFrame.new(-1427.6203613281, 7.2881078720093, -2792.7722167969));
			elseif _G.SelectIsland == "Sky Island 1" then
				topos(CFrame.new(-4869.1025390625, 733.46051025391, -2667.0180664063));
			elseif _G.SelectIsland == "Sky Island 2" then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.82275, 872.54248, -1667.55688));
			elseif _G.SelectIsland == "Sky Island 3" then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047));
			elseif _G.SelectIsland == "Prison" then
				topos(CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656));
			elseif _G.SelectIsland == "Magma Village" then
				topos(CFrame.new(-5247.7163085938, 12.883934020996, 8504.96875));
			elseif _G.SelectIsland == "Under Water Island" then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875));
			elseif _G.SelectIsland == "Fountain City" then
				topos(CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813));
			elseif _G.SelectIsland == "Shank Room" then
				topos(CFrame.new(-1442.16553, 29.8788261, -28.3547478));
			elseif _G.SelectIsland == "Mob Island" then
				topos(CFrame.new(-2850.20068, 7.39224768, 5354.99268));
			elseif _G.SelectIsland == "The Cafe" then
				topos(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828));
			elseif _G.SelectIsland == "Frist Spot" then
				topos(CFrame.new(-11.311455726624, 29.276733398438, 2771.5224609375));
			elseif _G.SelectIsland == "Dark Area" then
				topos(CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375));
			elseif _G.SelectIsland == "Flamingo Mansion" then
				topos(CFrame.new(-483.73370361328, 332.0383605957, 595.32708740234));
			elseif _G.SelectIsland == "Flamingo Room" then
				topos(CFrame.new(2284.4140625, 15.152037620544, 875.72534179688));
			elseif _G.SelectIsland == "Green Zone" then
				topos(CFrame.new(-2448.5300292969, 73.016105651855, -3210.6306152344));
			elseif _G.SelectIsland == "Factory" then
				topos(CFrame.new(424.12698364258, 211.16171264648, -427.54049682617));
			elseif _G.SelectIsland == "Colossuim" then
				topos(CFrame.new(-1503.6224365234, 219.7956237793, 1369.3101806641));
			elseif _G.SelectIsland == "Zombie Island" then
				topos(CFrame.new(-5622.033203125, 492.19604492188, -781.78552246094));
			elseif _G.SelectIsland == "Two Snow Mountain" then
				topos(CFrame.new(753.14288330078, 408.23559570313, -5274.6147460938));
			elseif _G.SelectIsland == "Punk Hazard" then
				topos(CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125));
			elseif _G.SelectIsland == "Cursed Ship" then
				topos(CFrame.new(923.40197753906, 125.05712890625, 32885.875));
			elseif _G.SelectIsland == "Ice Castle" then
				topos(CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188));
			elseif _G.SelectIsland == "Forgotten Island" then
				topos(CFrame.new(-3032.7641601563, 317.89672851563, -10075.373046875));
			elseif _G.SelectIsland == "Ussop Island" then
				topos(CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781));
			elseif _G.SelectIsland == "Mini Sky Island" then
				topos(CFrame.new(-288.74060058594, 49326.31640625, -35248.59375));
			elseif _G.SelectIsland == "Great Tree" then
				topos(CFrame.new(2681.2736816406, 1682.8092041016, -7190.9853515625));
			elseif _G.SelectIsland == "Castle On The Sea" then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5083.26025390625, 314.6056823730469, -3175.673095703125));
			elseif _G.SelectIsland == "MiniSky" then
				topos(CFrame.new(-260.65557861328, 49325.8046875, -35253.5703125));
			elseif _G.SelectIsland == "Port Town" then
				topos(CFrame.new(-290.7376708984375, 6.729952812194824, 5343.5537109375));
			elseif _G.SelectIsland == "Hydra Island" then
				topos(CFrame.new(5291.24951, 1005.4433, 393.762421, 0.994222522, 0.00000000945717726, -0.10733854, -0.00000000708227299, 1, 0.0000000225065655, 0.10733854, -0.0000000216163336, 0.994222522));
			elseif _G.SelectIsland == "Floating Turtle" then
				topos(CFrame.new(-13274.528320313, 531.82073974609, -7579.22265625));
			elseif _G.SelectIsland == "Mansion" then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375));
			elseif _G.SelectIsland == "Haunted Castle" then
				topos(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562));
			elseif _G.SelectIsland == "Ice Cream Island" then
				topos(CFrame.new(-902.56817626953, 79.93204498291, -10988.84765625));
			elseif _G.SelectIsland == "Peanut Island" then
				topos(CFrame.new(-2062.7475585938, 50.473892211914, -10232.568359375));
			elseif _G.SelectIsland == "Cake Island" then
				topos(CFrame.new(-1884.7747802734375, 19.327526092529297, -11666.8974609375));
			elseif _G.SelectIsland == "Cocoa Island" then
				topos(CFrame.new(87.94276428222656, 73.55451202392578, -12319.46484375));
			elseif _G.SelectIsland == "Candy Island" then
				topos(CFrame.new(-1014.4241943359375, 149.11068725585938, -14555.962890625));
			elseif _G.SelectIsland == "Tiki Outpost" then
				topos(CFrame.new(-16218.6826, 9.08636189, 445.618408, -0.0610186495, 0.00000000110512588, -0.99813664, -0.0000000183458475, 1, 0.00000000222871765, 0.99813664, 0.0000000184476558, -0.0610186495));
			elseif _G.SelectIsland == "Dragon Dojo" then
				topos(CFrame.new(5743.31934, 1206.90991, 936.011047, 0.475779682, -0.00000000366404773, -0.879564524, 0.0000000254969592, 1, 0.00000000962622693, 0.879564524, -0.000000027006184, 0.475779682));
			end;
		until not _G.TeleportIsland;
	end;
	StopTween(_G.TeleportIsland);
end);
TeleportTab:Seperator("Npc");
if World1 then
	TeleportTab:Dropdown("Choose NPC", {
		"Random Devil Fruit",
		"Blox Fruits Dealer",
		"Remove Devil Fruit",
		"Ability Teacher",
		"Dark Step",
		"Electro",
		"Fishman Karate"
	}, false, function(value)
		_G.SelectNPC = value;
	end);
end;
if World2 then
	TeleportTab:Dropdown("Choose NPC", {
		"Dargon Berath",
		"Mtsterious Man",
		"Mysterious Scientist",
		"Awakening Expert",
		"Nerd",
		"Bar Manager",
		"Blox Fruits Dealer",
		"Trevor",
		"Enhancement Editor",
		"Pirate Recruiter",
		"Marines Recruiter",
		"Chemist",
		"Cyborg",
		"Ghoul Mark",
		"Guashiem",
		"El Admin",
		"El Rodolfo",
		"Arowe"
	}, false, function(value)
		_G.SelectNPC = value;
	end);
end;
if World3 then
	TeleportTab:Dropdown("Choose NPC", {
		"Blox Fruits Dealer",
		"Remove Devil Fruit",
		"Horned Man",
		"Hungey Man",
		"Previous Hero",
		"Butler",
		"Lunoven",
		"Trevor",
		"Elite Hunter",
		"Player Hunter",
		"Uzoth"
	}, false, function(value)
		_G.SelectNPC = value;
	end);
end;
TeleportTab:Toggle("Teleport", _G.TeleportNPC, "Tween To Npc", function(value)
	_G.TeleportNPC = value;
	if _G.TeleportNPC == true then
		repeat
			wait();
			if _G.SelectNPC == "Dargon Berath" then
				topos(CFrame.new(703.372986, 186.985519, 654.522034, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Mtsterious Man" then
				topos(CFrame.new(-2574.43335, 1627.92371, -3739.35767, 0.378697902, -0.00000000906400288, 0.92552036, -0.00000000895582009, 1, 0.0000000134578926, -0.92552036, -0.0000000133852689, 0.378697902));
			elseif _G.SelectNPC == "Mysterious Scientist" then
				topos(CFrame.new(-6437.87793, 250.645355, -4498.92773, 0.502376854, -0.0000000101223634, -0.864648759, 0.0000000234106086, 1, 0.00000000189508653, 0.864648759, -0.0000000211940012, 0.502376854));
			elseif _G.SelectNPC == "Awakening Expert" then
				topos(CFrame.new(-408.098846, 16.0459061, 247.432846, 0.028394036, 0.000000000617599138, 0.999596894, -0.00000000557905944, 1, -0.000000000459372484, -0.999596894, -0.00000000556376767, 0.028394036));
			elseif _G.SelectNPC == "Nerd" then
				topos(CFrame.new(-401.783722, 73.0859299, 262.306702, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Bar Manager" then
				topos(CFrame.new(-385.84726, 73.0458984, 316.088806, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Blox Fruits Dealer" then
				topos(CFrame.new(-450.725464, 73.0458984, 355.636902, -0.780352175, -0.000000027266168, 0.625340283, 0.00000000978516468, 1, 0.0000000558128797, -0.625340283, 0.0000000496727601, -0.780352175));
			elseif _G.SelectNPC == "Trevor" then
				topos(CFrame.new(-341.498322, 331.886444, 643.024963, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Plokster" then
				topos(CFrame.new(-1885.16016, 88.3838196, -1912.28723, -0.513468027, 0, 0.858108759, 0, 1, 0, -0.858108759, 0, -0.513468027));
			elseif _G.SelectNPC == "Enhancement Editor" then
				topos(CFrame.new(-346.820221, 72.9856339, 1194.36218, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Pirate Recruiter" then
				topos(CFrame.new(-428.072998, 72.9495239, 1445.32422, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Marines Recruiter" then
				topos(CFrame.new(-1349.77295, 72.9853363, -1045.12964, 0.866493046, 0, -0.499189168, 0, 1, 0, 0.499189168, 0, 0.866493046));
			elseif _G.SelectNPC == "Chemist" then
				topos(CFrame.new(-2777.45288, 72.9919434, -3572.25732, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Ghoul Mark" then
				topos(CFrame.new(635.172546, 125.976357, 33219.832, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Cyborg" then
				topos(CFrame.new(629.146851, 312.307373, -531.624146, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Guashiem" then
				topos(CFrame.new(937.953003, 181.083359, 33277.9297, 1, -0.0000000860126406, 0.0000000000000000381773896, 0.0000000860126406, 1, -0.000000000000000189969598, -0.000000000000000038177373, 0.000000000000000189969598, 1));
			elseif _G.SelectNPC == "El Admin" then
				topos(CFrame.new(1322.80835, 126.345039, 33135.8789, 0.988783717, -0.0000000869797603, -0.149354503, 0.0000000862223786, 1, -0.0000000115461916, 0.149354503, -0.00000000146101409, 0.988783717));
			elseif _G.SelectNPC == "El Rodolfo" then
				topos(CFrame.new(941.228699, 40.4686775, 32778.9922, -0.818029106, -0.0000000119524382, 0.575176775, -0.0000000128741648, 1, 0.00000000247053866, -0.575176775, -0.00000000538394795, -0.818029106));
			elseif _G.SelectNPC == "Arowe" then
				topos(CFrame.new(-1994.51038, 125.519142, -72.2622986, -0.16715166, -0.0000000655417338, -0.985931218, -0.0000000713315558, 1, -0.0000000543836585, 0.985931218, 0.0000000612376851, -0.16715166));
			elseif _G.SelectNPC == "Random Devil Fruit" then
				topos(CFrame.new(-1436.19727, 61.8777695, 4.75247526, -0.557794094, 0.0000000274216543, 0.829979479, 0.0000000583273234, 1, 0.00000000616037932, -0.829979479, 0.0000000518467118, -0.557794094));
			elseif _G.SelectNPC == "Blox Fruits Dealer" then
				topos(CFrame.new(-923.255066, 7.67800522, 1608.61011, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Remove Devil Fruit" then
				topos(CFrame.new(5664.80469, 64.677681, 867.85907, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Ability Teacher" then
				topos(CFrame.new(-1057.67822, 9.65220833, 1799.49146, -0.865874112, -0.0000000926330159, 0.500262439, -0.0000000733759435, 1, 0.00000005816689, -0.500262439, 0.0000000136579752, -0.865874112));
			elseif _G.SelectNPC == "Dark Step" then
				topos(CFrame.new(-987.873047, 13.7778397, 3989.4978, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Electro" then
				topos(CFrame.new(-5389.49561, 13.283, -2149.80151, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Fishman Karate" then
				topos(CFrame.new(61581.8047, 18.8965912, 987.832703, 1, 0, 0, 0, 1, 0, 0, 0, 1));
			elseif _G.SelectNPC == "Random Devil Fruit" then
				topos(CFrame.new(-12491, 337, -7449));
			elseif _G.SelectNPC == "Blox Fruits Dealer" then
				topos(CFrame.new(-12511, 337, -7448));
			elseif _G.SelectNPC == "Remove Devil Fruit" then
				topos(CFrame.new(-5571, 1089, -2661));
			elseif _G.SelectNPC == "Horned Man" then
				topos(CFrame.new(-11890, 931, -8760));
			elseif _G.SelectNPC == "Hungey Man" then
				topos(CFrame.new(-10919, 624, -10268));
			elseif _G.SelectNPC == "Previous Hero" then
				topos(CFrame.new(-10368, 332, -10128));
			elseif _G.SelectNPC == "Butler" then
				topos(CFrame.new(-5125, 316, -3130));
			elseif _G.SelectNPC == "Lunoven" then
				topos(CFrame.new(-5117, 316, -3093));
			elseif _G.SelectNPC == "Elite Hunter" then
				topos(CFrame.new(-5420, 314, -2828));
			elseif _G.SelectNPC == "Player Hunter" then
				topos(CFrame.new(-5559, 314, -2840));
			elseif _G.SelectNPC == "Uzoth" then
				topos(CFrame.new(-9785, 852, 6667));
			end;
		until not _G.TeleportNPC;
	end;
	StopTween(_G.TeleportNPC);
end);
if World2 then
]========]},
{Order=22, Code=[========[LocalPlayerTab:Seperator("Local Player");
LocalPlayerTab:Toggle("Dodge No Cooldown", _G.Settings.LocalPlayer["Dodge No Cooldown"], false, function(value)
	_G.Settings.LocalPlayer["Dodge No Cooldown"] = value;
	(getgenv()).SaveSetting();
end);
LocalPlayerTab:Toggle("Infinite Energy", _G.Settings.LocalPlayer["Infinite Energy"], false, function(value)
	_G.Settings.LocalPlayer["Infinite Energy"] = value;
	(getgenv()).SaveSetting();
end);
LocalPlayerTab:Toggle("Auto Active Race V3", _G.Settings.LocalPlayer["Active Race V3"], "Auto Active Ability", function(value)
	_G.Settings.LocalPlayer["Active Race V3"] = value;
	(getgenv()).SaveSetting();
end);
LocalPlayerTab:Toggle("Auto Active Race V4", _G.Settings.LocalPlayer["Active Race V4"], "Auto Active Awakening", function(value)
	_G.Settings.LocalPlayer["Active Race V4"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.LocalPlayer["Active Race V4"] then
			if tonumber(((game:GetService("Players")).LocalPlayer.Character:WaitForChild("RaceEnergy")).Value) == 1 then
				if (game:GetService("Players")).LocalPlayer.Character.RaceTransformed.Value == false then
					(game:GetService("VirtualInputManager")):SendKeyEvent(true, "Y", false, game);
					wait(0.1);
					(game:GetService("VirtualInputManager")):SendKeyEvent(false, "Y", false, game);
				end;
			end;
		end;
	end;
end);
spawn(function()
	pcall(function()
		while wait(1) do
			if _G.Settings.LocalPlayer["Active Race V3"] then
				(game:GetService("ReplicatedStorage")).Remotes.CommE:FireServer("ActivateAbility");
			end;
		end;
	end);
end);
spawn(function()
	pcall(function()
		while wait(0.2) do
			if _G.Settings.Race["Look Moon Ability"] then
				(game:GetService("ReplicatedStorage")).Remotes.CommE:FireServer("ActivateAbility");
			end;
		end;
	end);
end);
LocalPlayerTab:Toggle("Infinite Ability", _G.Settings.LocalPlayer["Infinite Ability"], false, function(value)
	_G.Settings.LocalPlayer["Infinite Ability"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		if _G.Settings.LocalPlayer["Infinite Ability"] then
			InfAb();
		end;
	end;
end);
LocalPlayerTab:Toggle("Infinite Geppo", _G.Settings.LocalPlayer["Infinite Geppo"], false, function(value)
	_G.Settings.LocalPlayer["Infinite Geppo"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		pcall(function()
			if _G.Settings.LocalPlayer["Infinite Geppo"] then
				for i, v in next, getgc() do
					if (game:GetService("Players")).LocalPlayer.Character.Geppo then
						if typeof(v) == "function" and (getfenv(v)).script == (game:GetService("Players")).LocalPlayer.Character.Geppo then
							for i2, v2 in next, getupvalues(v) do
								if tostring(i2) == "9" then
									repeat
										wait(0.1);
										setupvalue(v, i2, 0);
									until not _G.Settings.LocalPlayer["Infinite Geppo"] or (game:GetService("Players")).LocalPlayer.Character.Humanoid.Health <= 0;
								end;
							end;
						end;
					end;
				end;
			end;
		end);
	end;
end);
LocalPlayerTab:Toggle("Infinite Soru", _G.Settings.LocalPlayer["Infinite Soru"], false, function(value)
	_G.Settings.LocalPlayer["Infinite Soru"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while wait(0.2) do
		pcall(function()
			if _G.Settings.LocalPlayer["Infinite Soru"] and (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("HumanoidRootPart") ~= nil then
				for i, v in next, getgc() do
					if (game:GetService("Players")).LocalPlayer.Character.Soru then
						if typeof(v) == "function" and (getfenv(v)).script == (game:GetService("Players")).LocalPlayer.Character.Soru then
							for i2, v2 in next, getupvalues(v) do
								if typeof(v2) == "table" then
									repeat
										wait(0.1);
										v2.LastUse = 0;
									until not _G.Settings.LocalPlayer["Infinite Soru"] or (game:GetService("Players")).LocalPlayer.Character.Humanoid.Health <= 0;
								end;
							end;
						end;
					end;
				end;
			end;
		end);
	end;
end);
LocalPlayerTab:Toggle("Walk on Water", _G.Settings.LocalPlayer["Walk On Water"], false, function(value)
	_G.Settings.LocalPlayer["Walk On Water"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.WalkWater then
				(game:GetService("Workspace")).Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000);
			else
				(game:GetService("Workspace")).Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000);
			end;
		end);
	end;
end);
LocalPlayerTab:Toggle("NoClip", _G.Settings.LocalPlayer["No Clip"], false, function(value)
	_G.Settings.LocalPlayer["No Clip"] = value;
	(getgenv()).SaveSetting();
end);
spawn(function()
	pcall(function()
		while wait(0.2) do
			if _G.Settings.LocalPlayer["No Clip"] then
				for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v:IsA("BasePart") or v:IsA("Part") then
						v.CanCollide = false;
					end;
				end;
			end;
		end;
	end);
end);
]========]}
}}
