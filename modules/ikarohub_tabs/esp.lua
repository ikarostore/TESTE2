return {Name="esp", Chunks={
{Order=21, Code=[========[EspTab:Seperator("ESP");
EspTab:Toggle("ESP Player", _G.Settings.Esp["ESP Player"], "Highlight Player", function(value)
	_G.Settings.Esp["ESP Player"] = value;
	(getgenv()).SaveSetting();
end);
EspTab:Toggle("ESP Chest", _G.Settings.Esp["ESP Chest"], "Highlight Chest", function(value)
	_G.Settings.Esp["ESP Chest"] = value;
	(getgenv()).SaveSetting();
end);
EspTab:Toggle("ESP Fruit", _G.Settings.Esp["ESP DevilFruit"], "Highlight Fruit", function(value)
	_G.Settings.Esp["ESP DevilFruit"] = value;
	(getgenv()).SaveSetting();
end);
if World3 then
	EspTab:Toggle("ESP Real Fruit", _G.Settings.Esp["ESP RealFruit"], "Highlight Real Fruit", function(value)
		_G.Settings.Esp["ESP RealFruit"] = value;
		(getgenv()).SaveSetting();
	end);
end;
if World2 then
	EspTab:Toggle("ESP Flower", _G.Settings.Esp["ESP Flower"], "Highlight Flower", function(value)
		_G.Settings.Esp["ESP Flower"] = value;
		(getgenv()).SaveSetting();
	end);
end;
EspTab:Toggle("ESP Island", _G.Settings.Esp["ESP Island"], "Highlight Island", function(value)
	_G.Settings.Esp["ESP Island"] = value;
	(getgenv()).SaveSetting();
end);
EspTab:Toggle("ESP Npc", _G.Settings.Esp["ESP Npc"], "Highlight Npc", function(value)
	_G.Settings.Esp["ESP Npc"] = value;
	(getgenv()).SaveSetting();
end);
if World2 or World3 then
	EspTab:Toggle("Esp Sea Beast", _G.Settings.Esp["ESP Sea Beast"], "Highlight SeaBest", function(value)
		_G.Settings.Esp["ESP Sea Beast"] = value;
		(getgenv()).SaveSetting();
	end);
end;
EspTab:Toggle("Esp Monster", _G.Settings.Esp["ESP Monster"], "Highlight Mob", function(value)
	_G.Settings.Esp["ESP Monster"] = value;
	(getgenv()).SaveSetting();
end);
if World2 or World3 then
	EspTab:Toggle("Esp Mirage Island", _G.Settings.Esp["ESP Mirage"], "Highlight Mirage Island", function(value)
		_G.Settings.Esp["ESP Mirage"] = value;
		(getgenv()).SaveSetting();
	end);
end;
if World3 then
	EspTab:Toggle("Esp Kitsune Island", _G.Settings.Esp["ESP Kitsune"], "Highlight Kitsune Island", function(value)
		_G.Settings.Esp["ESP Kitsune"] = value;
		(getgenv()).SaveSetting();
	end);
	EspTab:Toggle("Esp Frozen Dimension", _G.Settings.Esp["ESP Frozen"], "Highlight Frozen Dimension", function(value)
		_G.Settings.Esp["ESP Frozen"] = value;
		(getgenv()).SaveSetting();
	end);
	EspTab:Toggle("Esp Prehistoric Island", _G.Settings.Esp["ESP Prehistoric"], "Highlight Prehistoric Island", function(value)
		_G.Settings.Esp["ESP Prehistoric"] = value;
		(getgenv()).SaveSetting();
	end);
	EspTab:Toggle("Esp Advanced Fruit Dealer", _G.Settings.Esp["ESP Advanced Fruit Dealer"], "Highlight Advanced Fruit Dealer", function(value)
		_G.Settings.Esp["ESP Advanced Fruit Dealer"] = value;
		(getgenv()).SaveSetting();
	end);
	EspTab:Toggle("Esp Gear", _G.Settings.Esp["ESP Gear"], "Highlight Gear", function(value)
		_G.Settings.Esp["ESP Gear"] = value;
		(getgenv()).SaveSetting();
	end);
end;
]========]}
}}
