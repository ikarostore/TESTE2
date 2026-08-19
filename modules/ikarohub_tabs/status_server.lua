return {Name="Status And Server", Chunks={
{Order=23, Code=[========[ServTab:Seperator("Server");
task.spawn(function()
	while task.wait() do
		pcall(function()
			if (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
				FM:Set("ðŸŒ• Full Moon 100%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
				FM:Set("ðŸŒ– Full Moon 75%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
				FM:Set("ðŸŒ— Full Moon 50%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
				FM:Set("ðŸŒ˜ Full Moon 25%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
				FM:Set("ðŸŒ˜ Full Moon 15%");
			else
				FM:Set("ðŸŒ‘ Full Moon 0%");
			end;
		end);
	end;
end);
spawn(function()
	pcall(function()
		while wait(0.2) do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
				KitsuneStatus:Set("â›©ï¸ Kitsune Island is Spawning");
			else
				KitsuneStatus:Set("â›©ï¸ Kitsune Island Not Spawn");
			end;
		end;
	end);
end);
spawn(function()
	pcall(function()
		while wait(0.2) do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
				FrozenStatus:Set("â„ï¸ Frozen Dimension Spawning");
			else
				FrozenStatus:Set("â„ï¸ Frozen Dimension Not Spawn");
			end;
		end;
	end);
end);
spawn(function()
	pcall(function()
		while wait(0.2) do
			if World2 or World3 then
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
					MirageStatus:Set("ðŸï¸ Mirage Island is Spawning");
				else
					MirageStatus:Set("ðŸï¸ Mirage Island Not Spawn");
				end;
			end;
		end;
	end);
end);
spawn(function()
	pcall(function()
		while wait(0.2) do
			for i, v in pairs(game.Workspace:GetChildren()) do
				if string.find(v.Name, "Fruit") then
					FindFruit:Set("ðŸ Find " .. v.Name);
				else
					FindFruit:Set("ðŸ Nothing");
				end;
			end;
		end;
	end);
end);
spawn(function()
	while wait(0.2) do
		pcall(function()
			local response = (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("ColorsDealer", "1");
			if response then
				HakiDealer:Set("ðŸŸ¢ Master Of Auras Spawning");
			else
				HakiDealer:Set("ðŸ”´ Master Of Auras Not Spawn");
			end;
		end);
	end;
end);
ServTab:Button("Rejoin Server", function()
	(game:GetService("TeleportService")):Teleport(game.PlaceId, (game:GetService("Players")).LocalPlayer);
end);
ServTab:Button("Server Hop", function()
	while wait(0.2) do
		local module = (loadstring(game:HttpGet("https://roblox.farrghii.com/Hop.lua")))();
		module:Teleport(game.PlaceId, "Singapore");
	end;
end);
ServTab:Button("Hop Lower Player", function()
	local module = (loadstring(game:HttpGet("https://raw.githubusercontent.com/raw-scriptpastebin/FE/main/Server_Hop_Settings")))();
	module:Teleport(game.PlaceId);
end);
spawn(function()
	while wait(0.2) do
		pcall(function()
			JobAiDee:Set("Server Job ID : " .. game.JobId);
		end);
	end;
end);
ServTab:Line();
JobAiDee = ServTab:Label("Server Job ID : ");
ServTab:Button("Copy Server Job ID", function()
	setclipboard(tostring(game.JobId));
end);
ServTab:Textbox("Enter Server Job ID", true, function(value)
	local parseResult = string.gsub(value, "`", "");
	_G.JobId = parseResult;
end);
ServTab:Button("Join Sever", function()
	(game:GetService("TeleportService")):TeleportToPlaceInstance(game.placeId, _G.JobId, game.Players.LocalPlayer);
end);
ServTab:Seperator("Status");
FM = ServTab:Label("Moon");
if World2 or World3 then
	if World3 then
		KitsuneStatus = ServTab:Label("Kitsune");
		FrozenStatus = ServTab:Label("Frozen");
	end;
	MirageStatus = ServTab:Label("Mirage");
	HakiDealer = ServTab:Label("Haki Dealer");
end;
FindFruit = ServTab:Label("Devil Fruit");
ServTab:Seperator("Advance Fruit Stock");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Remotes = ReplicatedStorage.Remotes;
local Event = Remotes.CommF_;
local resultAdvance = Event:InvokeServer("GetFruits", true);
local resultNormal = Event:InvokeServer("GetFruits");
local advanceFruitsOnSale = {};
local normalFruitsOnSale = {};
local function addCommas(number)
	local formatted = tostring(number);
	while true do
		formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2");
		if k == 0 then
			break;
		end;
	end;
	return formatted;
end;
for _, v in pairs(resultAdvance) do
	if v.OnSale == true then
		local advancePriceWithCommas = addCommas(v.Price);
		local AdvanceFruitInfo = v.Name .. " - $" .. advancePriceWithCommas;
		table.insert(advanceFruitsOnSale, AdvanceFruitInfo);
		ServTab:Label(tostring(AdvanceFruitInfo));
	end;
end;
ServTab:Seperator("Normal Fruit Stock");
for _, v in pairs(resultNormal) do
	if v.OnSale == true then
		local normalPriceWithCommas = addCommas(v.Price);
		local NormalFruitInfo = v.Name .. " - $" .. normalPriceWithCommas;
		table.insert(normalFruitsOnSale, NormalFruitInfo);
		ServTab:Label(tostring(NormalFruitInfo));
	end;
end;
print("Script Loaded!");
]========]}
}}
