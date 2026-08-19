return {Name="setting", Chunks={
{Order=20, Code=[========[MiscTab:Seperator("Misc");
MiscTab:Button("Open Devil Shop", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("GetFruits");
	(game:GetService("Players")).LocalPlayer.PlayerGui.Main.FruitShop.Visible = true;
end);
MiscTab:Button("Open Haki Color", function()
	game.Players.LocalPlayer.PlayerGui.Main.Colors.Visible = true;
end);
MiscTab:Button("Open Title Name", function()
	local args = {
		[1] = "getTitles"
	};
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
	game.Players.LocalPlayer.PlayerGui.Main.Titles.Visible = true;
end);
MiscTab:Button("Open Inventory", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("getInventoryWeapons");
	wait(1);
	(game:GetService("Players")).LocalPlayer.PlayerGui.Main.Inventory.Visible = true;
end);
MiscTab:Button("Open Inventory Fruit", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("getInventoryFruits");
	(game:GetService("Players")).LocalPlayer.PlayerGui.Main.FruitInventory.Visible = true;
end);
MiscTab:Seperator("Teams");
MiscTab:Button("Join Pirates Team", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("SetTeam", "Pirates");
end);
MiscTab:Button("Join Marines Team", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("SetTeam", "Marines");
end);
MiscTab:Seperator("Highlight");
MiscTab:Toggle("Hide Chat", _G.Settings.Misc["Hide Chat"], "Invisible Chat", function(value)
	_G.Settings.Misc["Hide Chat"] = value;
	if _G.Settings.Misc["Hide Chat"] then
		local StarterGui = game:GetService("StarterGui");
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false);
	else
		local StarterGui = game:GetService("StarterGui");
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
	end;
end);
MiscTab:Toggle("Hide Leaderboard", _G.Settings.Misc["Hide Leaderboard"], "Invisible Leaderboard", function(value)
	_G.Settings.Misc["Hide Leaderboard"] = value;
	if _G.Settings.Misc["Hide Leaderboard"] then
		local StarterGui = game:GetService("StarterGui");
		(game:GetService("StarterGui")):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
	else
		local StarterGui = game:GetService("StarterGui");
		(game:GetService("StarterGui")):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
	end;
end);
MiscTab:Toggle("Highlight Mode", false, "Hide All Player Gui", function(value)
	_G.Settings.Misc["Highlight Mode"] = value;
end);
MiscTab:Seperator("Codes");
local x2Code = {
	"KITTGAMING",
	"ENYU_IS_PRO",
	"FUDD10",
	"BIGNEWS",
	"THEGREATACE",
	"SUB2GAMERROBOT_EXP1",
	"STRAWHATMAIME",
	"SUB2OFFICIALNOOBIE",
	"SUB2NOOBMASTER123",
	"SUB2DAIGROCK",
	"AXIORE",
	"TANTAIGAMIMG",
	"STRAWHATMAINE",
	"JCWK",
	"FUDD10_V2",
	"SUB2FER999",
	"MAGICBIS",
	"TY_FOR_WATCHING",
	"STARCODEHEO"
};
MiscTab:Button("Redeem All Codes", function()
	function RedeemCode(value)
		(game:GetService("ReplicatedStorage")).Remotes.Redeem:InvokeServer(value);
	end;
	for i, v in pairs(x2Code) do
		RedeemCode(v);
	end;
end);
MiscTab:Dropdown("Select Codes", {
	"NOOB_REFUND",
	"SUB2GAMERROBOT_RESET1",
	"Sub2UncleKizaru"
}, false, function(value)
	_G.CodeSelect = value;
end);
MiscTab:Button("Redeem Code", function()
	(game:GetService("ReplicatedStorage")).Remotes.Redeem:InvokeServer(_G.CodeSelect);
end);
MiscTab:Seperator("Graphic");
MiscTab:Button("FPS Boost", function()
	local decalsyeeted = true;
	local g = game;
	local w = g.Workspace;
	local l = g.Lighting;
	local t = w.Terrain;
	(settings()).Rendering.QualityLevel = "Level01";
	for i, v in pairs(g:GetDescendants()) do
		if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic";
			v.Reflectance = 0;
		elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
			v.Transparency = 1;
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0);
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1;
			v.BlastRadius = 1;
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
			v.Enabled = false;
		end;
	end;
end);
MiscTab:Button("Remove Fog", function()
	(game:GetService("Lighting")).LightingLayers:Destroy();
	(game:GetService("Lighting")).Sky:Destroy();
	game.Lighting.FogEnd = 9000000000;
end);
MiscTab:Button("Remove Lava", function()
	for i, v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "Lava" then
			v:Destroy();
		end;
	end;
	for i, v in pairs(game.ReplicatedStorage:GetDescendants()) do
		if v.Name == "Lava" then
			v:Destroy();
		end;
	end;
end);
]========]}
}}
