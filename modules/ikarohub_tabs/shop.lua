return {Name="Shop", Chunks={
{Order=18, Code=[========[	ShopTab:Seperator("Legendary Sword");
	ShopTab:Toggle("Auto Buy Legendary Sword", _G.Settings.Shop["Auto Buy Legendary Sword"], "Buy Legendary Sword When Spawn", function(value)
		_G.Settings.Shop["Auto Buy Legendary Sword"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Shop["Auto Buy Legendary Sword"] then
				pcall(function()
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1");
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2");
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3");
				end);
			end;
		end;
	end);
end;
if World2 or World3 then
	ShopTab:Seperator("Haki Color");
	local MOA_Status = ShopTab:Label("Master of Aura Status");
	spawn(function()
		while wait(0.2) do
			pcall(function()
				local response = (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("ColorsDealer", "1");
				if response then
					MOA_Status:Set("Master of Auras Spawn!");
				else
					MOA_Status:Set("Master of Auras Not Spawn!");
				end;
			end);
		end;
	end);
	ShopTab:Toggle("Auto Buy Haki Color", _G.Settings.Shop["Auto Buy Haki Color"], "Auto Buy Haki Color", function(value)
		_G.Settings.Shop["Auto Buy Haki Color"] = value;
		(getgenv()).SaveSetting();
	end);
	spawn(function()
		while wait(0.2) do
			if _G.Settings.Shop["Auto Buy Haki Color"] then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("ColorsDealer", "2");
			end;
		end;
	end);
end;
ShopTab:Seperator("Abilities");
ShopTab:Button("Buy Geppo [ $10,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Geppo");
end);
ShopTab:Button("Buy Buso Haki [ $25,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Buso");
end);
ShopTab:Button("Buy Soru [ $25,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Soru");
end);
ShopTab:Button("Buy Observation Haki [ $750,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("KenTalk", "Buy");
end);
ShopTab:Toggle("Auto Buy Abilities", false, "Auto Buy Haki", function(t)
	Abilities = t;
	while Abilities do
		wait(0.2);
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Geppo");
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Buso");
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyHaki", "Soru");
	end;
end);
ShopTab:Seperator("Boats");
BoatList = {
	"Pirate Sloop",
	"Enforcer",
	"Rocket Boost",
	"Dinghy",
	"Pirate Basic",
	"Pirate Brigade"
};
spawn(function()
	while wait() do
		pcall(function()
			if SelectBoat == "Pirate Sloop" then
				_G.SelectBoat = "PirateSloop";
			elseif SelectBoat == "Enforcer" then
				_G.SelectBoat = "Enforcer";
			elseif SelectBoat == "RocketBoost" then
				_G.SelectBoat = "RocketBoost";
			elseif SelectBoat == "PirateBasic" then
				_G.SelectBoat = "PirateBasic";
			elseif SelectBoat == "Pirate Brigade" then
				_G.SelectBoat = "PirateBrigade";
			end;
		end);
	end;
end);
ShopTab:Dropdown("Select Boats", BoatList, false, function(value)
	SelectBoat = value;
end);
ShopTab:Button("Buy Boat", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectBoat);
end);
ShopTab:Seperator("Fighting Style");
ShopTab:Button("Buy Black Leg [ $150,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyBlackLeg");
end);
ShopTab:Button("Buy Electro [ $550,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectro");
end);
ShopTab:Button("Buy Water Kung Fu [ $750,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyFishmanKarate");
end);
ShopTab:Button("Buy Dragon Claw [ Æ’1,500 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1");
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2");
end);
ShopTab:Button("Buy Superhuman [ $3,000,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySuperhuman");
end);
ShopTab:Button("Buy Death Step [ Æ’5,000 $5,000,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyDeathStep");
end);
ShopTab:Button("Buy Sharkman Karate [ Æ’5,000 $2,500,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySharkmanKarate", true);
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySharkmanKarate");
end);
ShopTab:Button("Buy Electric Claw [ Æ’5,000 $3,000,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectricClaw");
end);
ShopTab:Button("Buy Dragon Talon [ Æ’5,000 $3,000,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyDragonTalon");
end);
ShopTab:Button("Buy God Human [ Æ’5,000 $5,000,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyGodhuman");
end);
ShopTab:Button("Buy Sanguine Art [ Æ’5,000 $5,000,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySanguineArt", true);
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySanguineArt");
end);
ShopTab:Seperator("Sword");
ShopTab:Button("Cutlass [ $1,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Cutlass");
end);
ShopTab:Button("Katana [ $1,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Katana");
end);
ShopTab:Button("Iron Mace [ $25,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace");
end);
ShopTab:Button("Dual Katana [ $12,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana");
end);
ShopTab:Button("Triple Katana [ $60,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana");
end);
ShopTab:Button("Pipe [ $100,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Pipe");
end);
ShopTab:Button("Dual-Headed Blade [ $400,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade");
end);
ShopTab:Button("Bisento [ $1,200,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Bisento");
end);
ShopTab:Button("Soul Cane [ $750,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane");
end);
ShopTab:Button("Pole v.2 [ Æ’5,000 ]", function()
	game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ThunderGodTalk");
end);
ShopTab:Seperator("Gun");
ShopTab:Button("Slingshot [ $5,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Slingshot");
end);
ShopTab:Button("Musket [ $8,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Musket");
end);
ShopTab:Button("Flintlock [ $10,500 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Flintlock");
end);
ShopTab:Button("Refined Slingshot [ $30,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock");
end);
ShopTab:Button("Refined Flintlock [ $65,000 ]", function()
	local args = {
		[1] = "BuyItem",
		[2] = "Refined Flintlock"
	};
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
end);
ShopTab:Button("Cannon [ $100,000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyItem", "Cannon");
end);
ShopTab:Button("Kabucha [ Æ’1,500]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "1");
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2");
end);
ShopTab:Button("Bizarre Rifle [ 250 Ectoplasm ]", function()
	local A_1 = "Ectoplasm";
	local A_2 = "Buy";
	local A_3 = 1;
	local Event = (game:GetService("ReplicatedStorage")).Remotes.CommF_;
	Event:InvokeServer(A_1, A_2, A_3);
end);
ShopTab:Seperator("Stats");
ShopTab:Button("Reset Stats [ Use Æ’2,500 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1");
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2");
end);
ShopTab:Button("Random Race [ Use Æ’3000 ]", function()
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "1");
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2");
end);
ShopTab:Seperator("Accessories");
ShopTab:Button("Black Cape [ $50,000 ]", function()
	local args = {
		[1] = "BuyItem",
		[2] = "Black Cape"
	};
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
end);
ShopTab:Button("Swordsman Hat [ $150,000 ]", function()
	local args = {
		[1] = "BuyItem",
		[2] = "Swordsman Hat"
	};
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
end);
ShopTab:Button("Tomoe Ring [ $500,000 ]", function()
	local args = {
		[1] = "BuyItem",
		[2] = "Tomoe Ring"
	};
	(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer(unpack(args));
end);
]========]}
}}
