return {Name="Hold and select Skill", Chunks={
{Order=4, Code=[========[HoldTab:Seperator("Mastery");
HoldTab:Slider("Skill Z", 0, 5, _G.Settings.Hold["Hold Mastery Skill Z"], function(value)
	_G.Settings.Hold["Hold Mastery Skill Z"] = value;
	(getgenv()).SaveSetting();
end);
HoldTab:Slider("Skill X", 0, 5, _G.Settings.Hold["Hold Mastery Skill X"], function(value)
	_G.Settings.Hold["Hold Mastery Skill X"] = value;
	(getgenv()).SaveSetting();
end);
HoldTab:Slider("Skill C", 0, 5, _G.Settings.Hold["Hold Mastery Skill C"], function(value)
	_G.Settings.Hold["Hold Mastery Skill C"] = value;
	(getgenv()).SaveSetting();
end);
HoldTab:Slider("Skill V", 0, 5, _G.Settings.Hold["Hold Mastery Skill V"], function(value)
	_G.Settings.Hold["Hold Mastery Skill V"] = value;
	(getgenv()).SaveSetting();
end);
HoldTab:Slider("Skill F", 0, 5, _G.Settings.Hold["Hold Mastery Skill F"], function(value)
	_G.Settings.Hold["Hold Mastery Skill F"] = value;
	(getgenv()).SaveSetting();
end);
if World3 then
	HoldTab:Seperator("Sea Event");
	HoldTab:Slider("Skill Z", 0, 5, _G.Settings.Hold["Hold Sea Skill Z"], function(value)
		_G.Settings.Hold["Hold Sea Skill Z"] = value;
		(getgenv()).SaveSetting();
	end);
	HoldTab:Slider("Skill X", 0, 5, _G.Settings.Hold["Hold Sea Skill Z"], function(value)
		_G.Settings.Hold["Hold Sea Skill Z"] = value;
		(getgenv()).SaveSetting();
	end);
	HoldTab:Slider("Skill C", 0, 5, _G.Settings.Hold["Hold Sea Skill C"], function(value)
		_G.Settings.Hold["Hold Sea Skill C"] = value;
		(getgenv()).SaveSetting();
	end);
	HoldTab:Slider("Skill V", 0, 5, _G.Settings.Hold["Hold Sea Skill V"], function(value)
		_G.Settings.Hold["Hold Sea Skill V"] = value;
		(getgenv()).SaveSetting();
	end);
	HoldTab:Slider("Skill F", 0, 5, _G.Settings.Hold["Hold Sea Skill F"], function(value)
		_G.Settings.Hold["Hold Sea Skill F"] = value;
		(getgenv()).SaveSetting();
	end);
end;
if World1 or World2 then
]========]}
}}
