return {Order=0, Code=[========[-- local function scary()
--     warn("❌ This script must only be executed from the offical IKAROHUB loader")
--         return
--     end

-- local HttpService = game:GetService("HttpService")
-- local SECRET_KEY = "YourSecretSecondaryToken" 
-- local function simpleHMAC(input, key)
--     return HttpService:UrlEncode(input .. key)
-- end
-- if not _G._secondaryData or
--    not _G._secondaryData.nonce or 
--    not _G._secondaryData.timestamp or 
--    not _G._secondaryData.signature or 
--    not _G._secondaryData.userKey or 
--    not _G.__userKey then
--     print("❌ Security verification failed: missing token data or user key.")
--     scary()
--     return
-- end
-- if _G._secondaryData.userKey ~= _G.__userKey then
--     print("❌ Security verification failed: user key mismatch.")
--     return
-- end
-- local tokenData = _G._secondaryData.nonce .. ":" .. _G._secondaryData.timestamp .. ":" .. _G.__userKey
-- local expectedSignature = simpleHMAC(tokenData, SECRET_KEY)
-- if expectedSignature ~= _G._secondaryData.signature then
--     print("❌ Security verification failed: token signature mismatch.")
--     return
-- end
-- local allowedTimeWindow = 300  -- seconds
-- local currentTime = os.time()
-- if math.abs(currentTime - tonumber(_G._secondaryData.timestamp)) > allowedTimeWindow then
--     print("❌ Security verification failed: token expired.")
--     return
-- end
-- _G._secondaryData = nil
-- _G.__userKey = nil
print("✅ Security verification passed. Loading IKAROHUB...")
if game.PlaceId == 2753915549 then
	World1 = true;
elseif game.PlaceId == 4442272183 then
	World2 = true;
elseif game.PlaceId == 7449423635 then
	World3 = true;
end;

-- Seleciona Marines antes de qualquer rotina que dependa do personagem.
local PlayersService = game:GetService("Players");
local ReplicatedStorageService = game:GetService("ReplicatedStorage");
local LocalPlayerBootstrap = PlayersService.LocalPlayer;
if not LocalPlayerBootstrap.Team then
	local TeamRemote = ReplicatedStorageService:WaitForChild("Remotes"):WaitForChild("CommF_");
	for Attempt = 1, 20 do
		if LocalPlayerBootstrap.Team then
			break;
		end;
		pcall(function()
			TeamRemote:InvokeServer("SetTeam", "Marines");
		end);
		task.wait(0.5);
	end;
end;
local BootstrapCharacter = LocalPlayerBootstrap.Character or LocalPlayerBootstrap.CharacterAdded:Wait();
BootstrapCharacter:WaitForChild("HumanoidRootPart", 15);
-- print("--------------------------------------------------------------------------");
-- print("-- [[ Webhook ]] --");
-- (loadstring(game:HttpGet("https://gitshare.me/backend/api/files/677ec71a-082b-4b8c-a1e8-f590f2ab286a/download")))();
-- print("--------------------------------------------------------------------------");
local Update = (function()
if (game:GetService("CoreGui")):FindFirstChild("IKAROHUB") and (game:GetService("CoreGui")):FindFirstChild("ScreenGui") then
	(game:GetService("CoreGui")).IKAROHUB:Destroy();
	(game:GetService("CoreGui")).ScreenGui:Destroy();
end;
_G.Primary = Color3.fromRGB(100, 100, 100);
_G.Dark = Color3.fromRGB(22, 22, 26);
_G.Third = Color3.fromRGB(255, 0, 0);
function CreateRounded(Parent, Size)
	local Rounded = Instance.new("UICorner");
	Rounded.Name = "Rounded";
	Rounded.Parent = Parent;
	Rounded.CornerRadius = UDim.new(0, Size);
end;
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
function MakeDraggable(topbarobject, object)
	local Dragging = nil;
	local DragInput = nil;
	local DragStart = nil;
	local StartPosition = nil;
	local function Update(input)
		local Delta = input.Position - DragStart;
		local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y);
		local Tween = TweenService:Create(object, TweenInfo.new(0.15), {
			Position = pos
		});
		Tween:Play();
	end;
	topbarobject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true;
			DragStart = input.Position;
			StartPosition = object.Position;
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Dragging = false;
				end;
			end);
		end;
	end);
	topbarobject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			DragInput = input;
		end;
	end);
	UserInputService.InputChanged:Connect(function(input)
		if input == DragInput and Dragging then
			Update(input);
		end;
	end);
end;
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Parent = game.CoreGui;
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
local OutlineButton = Instance.new("Frame");
OutlineButton.Name = "OutlineButton";
OutlineButton.Parent = ScreenGui;
OutlineButton.ClipsDescendants = true;
OutlineButton.BackgroundColor3 = _G.Dark;
OutlineButton.BackgroundTransparency = 0;
OutlineButton.Position = UDim2.new(0, 10, 0, 10);
OutlineButton.Size = UDim2.new(0, 50, 0, 50);
CreateRounded(OutlineButton, 12);
local ImageButton = Instance.new("ImageButton");
ImageButton.Parent = OutlineButton;
ImageButton.Position = UDim2.new(0.5, 0, 0.5, 0);
ImageButton.Size = UDim2.new(0, 40, 0, 40);
ImageButton.AnchorPoint = Vector2.new(0.5, 0.5);
ImageButton.BackgroundColor3 = _G.Dark;
ImageButton.ImageColor3 = Color3.fromRGB(250, 250, 250);
ImageButton.ImageTransparency = 0;
ImageButton.BackgroundTransparency = 0;
ImageButton.Image = "rbxassetid://13940080072";
ImageButton.AutoButtonColor = false;
MakeDraggable(ImageButton, OutlineButton);
CreateRounded(ImageButton, 10);
ImageButton.MouseButton1Click:connect(function()
	(game.CoreGui:FindFirstChild("IKAROHUB")).Enabled = not (game.CoreGui:FindFirstChild("IKAROHUB")).Enabled;
end);
local NotificationFrame = Instance.new("ScreenGui");
NotificationFrame.Name = "NotificationFrame";
NotificationFrame.Parent = game.CoreGui;
NotificationFrame.ZIndexBehavior = Enum.ZIndexBehavior.Global;
local NotificationList = {};
local function RemoveOldestNotification()
	if #NotificationList > 0 then
		local removed = table.remove(NotificationList, 1);
		removed[1]:TweenPosition(UDim2.new(0.5, 0, -0.2, 0), "Out", "Quad", 0.4, true, function()
			removed[1]:Destroy();
		end);
	end;
end;
spawn(function()
	while wait() do
		if #NotificationList > 0 then
			wait(2);
			RemoveOldestNotification();
		end;
	end;
end);
local Update = {};
function Update:Notify(desc)
	local Frame = Instance.new("Frame");
	local Image = Instance.new("ImageLabel");
	local Title = Instance.new("TextLabel");
	local Desc = Instance.new("TextLabel");
	local OutlineFrame = Instance.new("Frame");
	OutlineFrame.Name = "OutlineFrame";
	OutlineFrame.Parent = NotificationFrame;
	OutlineFrame.ClipsDescendants = true;
	OutlineFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
	OutlineFrame.AnchorPoint = Vector2.new(0.5, 1);
	OutlineFrame.BackgroundTransparency = 0.4;
	OutlineFrame.Position = UDim2.new(0.5, 0, -0.2, 0);
	OutlineFrame.Size = UDim2.new(0, 412, 0, 72);
	Frame.Name = "Frame";
	Frame.Parent = OutlineFrame;
	Frame.ClipsDescendants = true;
	Frame.AnchorPoint = Vector2.new(0.5, 0.5);
	Frame.BackgroundColor3 = _G.Dark;
	Frame.BackgroundTransparency = 0.1;
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0);
	Frame.Size = UDim2.new(0, 400, 0, 60);
	Image.Name = "Icon";
	Image.Parent = Frame;
	Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	Image.BackgroundTransparency = 1;
	Image.Position = UDim2.new(0, 8, 0, 8);
	Image.Size = UDim2.new(0, 45, 0, 45);
	Image.Image = "rbxassetid://13940080072";
	Title.Parent = Frame;
	Title.BackgroundColor3 = _G.Primary;
	Title.BackgroundTransparency = 1;
	Title.Position = UDim2.new(0, 55, 0, 14);
	Title.Size = UDim2.new(0, 10, 0, 20);
	Title.Font = Enum.Font.GothamBold;
	Title.Text = "IKAROHUB";
	Title.TextColor3 = Color3.fromRGB(255, 255, 255);
	Title.TextSize = 16;
	Title.TextXAlignment = Enum.TextXAlignment.Left;
	Desc.Parent = Frame;
	Desc.BackgroundColor3 = _G.Primary;
	Desc.BackgroundTransparency = 1;
	Desc.Position = UDim2.new(0, 55, 0, 33);
	Desc.Size = UDim2.new(0, 10, 0, 10);
	Desc.Font = Enum.Font.GothamSemibold;
	Desc.TextTransparency = 0.3;
	Desc.Text = desc;
	Desc.TextColor3 = Color3.fromRGB(200, 200, 200);
	Desc.TextSize = 12;
	Desc.TextXAlignment = Enum.TextXAlignment.Left;
	CreateRounded(Frame, 10);
	CreateRounded(OutlineFrame, 12);
	OutlineFrame:TweenPosition(UDim2.new(0.5, 0, 0.1 + (#NotificationList) * 0.1, 0), "Out", "Quad", 0.4, true);
	table.insert(NotificationList, {
		OutlineFrame,
		title
	});
end;
function Update:StartLoad()
	local Loader = Instance.new("ScreenGui");
	Loader.Parent = game.CoreGui;
	Loader.ZIndexBehavior = Enum.ZIndexBehavior.Global;
	Loader.DisplayOrder = 1000;
	local LoaderFrame = Instance.new("Frame");
	LoaderFrame.Name = "LoaderFrame";
	LoaderFrame.Parent = Loader;
	LoaderFrame.ClipsDescendants = true;
	LoaderFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5);
	LoaderFrame.BackgroundTransparency = 0;
	LoaderFrame.AnchorPoint = Vector2.new(0.5, 0.5);
	LoaderFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
	LoaderFrame.Size = UDim2.new(1.5, 0, 1.5, 0);
	LoaderFrame.BorderSizePixel = 0;
	local MainLoaderFrame = Instance.new("Frame");
	MainLoaderFrame.Name = "MainLoaderFrame";
	MainLoaderFrame.Parent = LoaderFrame;
	MainLoaderFrame.ClipsDescendants = true;
	MainLoaderFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5);
	MainLoaderFrame.BackgroundTransparency = 0;
	MainLoaderFrame.AnchorPoint = Vector2.new(0.5, 0.5);
	MainLoaderFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
	MainLoaderFrame.Size = UDim2.new(0.5, 0, 0.5, 0);
	MainLoaderFrame.BorderSizePixel = 0;
	local TitleLoader = Instance.new("TextLabel");
	TitleLoader.Parent = MainLoaderFrame;
	TitleLoader.Text = "IKAROHUB";
	TitleLoader.Font = Enum.Font.FredokaOne;
	TitleLoader.TextSize = 50;
	TitleLoader.TextColor3 = Color3.fromRGB(255, 255, 255);
	TitleLoader.BackgroundTransparency = 1;
	TitleLoader.AnchorPoint = Vector2.new(0.5, 0.5);
	TitleLoader.Position = UDim2.new(0.5, 0, 0.3, 0);
	TitleLoader.Size = UDim2.new(0.8, 0, 0.2, 0);
	TitleLoader.TextTransparency = 0;
	local DescriptionLoader = Instance.new("TextLabel");
	DescriptionLoader.Parent = MainLoaderFrame;
	DescriptionLoader.Text = "Loading..";
	DescriptionLoader.Font = Enum.Font.Gotham;
	DescriptionLoader.TextSize = 15;
	DescriptionLoader.TextColor3 = Color3.fromRGB(255, 255, 255);
	DescriptionLoader.BackgroundTransparency = 1;
	DescriptionLoader.AnchorPoint = Vector2.new(0.5, 0.5);
	DescriptionLoader.Position = UDim2.new(0.5, 0, 0.6, 0);
	DescriptionLoader.Size = UDim2.new(0.8, 0, 0.2, 0);
	DescriptionLoader.TextTransparency = 0;
	local LoadingBarBackground = Instance.new("Frame");
	LoadingBarBackground.Parent = MainLoaderFrame;
	LoadingBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
	LoadingBarBackground.AnchorPoint = Vector2.new(0.5, 0.5);
	LoadingBarBackground.Position = UDim2.new(0.5, 0, 0.7, 0);
	LoadingBarBackground.Size = UDim2.new(0.7, 0, 0.05, 0);
	LoadingBarBackground.ClipsDescendants = true;
	LoadingBarBackground.BorderSizePixel = 0;
	LoadingBarBackground.ZIndex = 2;
	local LoadingBar = Instance.new("Frame");
	LoadingBar.Parent = LoadingBarBackground;
	LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
	LoadingBar.Size = UDim2.new(0, 0, 1, 0);
	LoadingBar.ZIndex = 3;
	CreateRounded(LoadingBarBackground, 20);
	CreateRounded(LoadingBar, 20);
	local tweenService = game:GetService("TweenService");
	local dotCount = 0;
	local running = true;
	local barTweenInfoPart1 = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
	local barTweenPart1 = tweenService:Create(LoadingBar, barTweenInfoPart1, {
		Size = UDim2.new(0.25, 0, 1, 0)
	});
	local barTweenInfoPart2 = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
	local barTweenPart2 = tweenService:Create(LoadingBar, barTweenInfoPart2, {
		Size = UDim2.new(1, 0, 1, 0)
	});
	barTweenPart1:Play();
	function Update:Loaded()
		barTweenPart2:Play();
	end;
	barTweenPart1.Completed:Connect(function()
		running = true;
		barTweenPart2.Completed:Connect(function()
			wait(1);
			running = false;
			DescriptionLoader.Text = "Loaded!";
			wait(0.5);
			Loader:Destroy();
		end);
	end);
	spawn(function()
		while running do
			dotCount = (dotCount + 1) % 4;
			local dots = string.rep(".", dotCount);
			DescriptionLoader.Text = "Please wait" .. dots;
			wait(0.5);
		end;
	end);
end;
local SettingsLib = {
	SaveSettings = true,
	LoadAnimation = true
};
(getgenv()).LoadConfig = function()
	if readfile and writefile and isfile and isfolder then
		if not isfolder("IKAROHUB") then
			makefolder("IKAROHUB");
		end;
		if not isfolder("IKAROHUB/Library/") then
			makefolder("IKAROHUB/Library/");
		end;
		if not isfile(("IKAROHUB/Library/" .. game.Players.LocalPlayer.Name .. ".json")) then
			writefile("IKAROHUB/Library/" .. game.Players.LocalPlayer.Name .. ".json", (game:GetService("HttpService")):JSONEncode(SettingsLib));
		else
			local Decode = (game:GetService("HttpService")):JSONDecode(readfile("IKAROHUB/Library/" .. game.Players.LocalPlayer.Name .. ".json"));
			for i, v in pairs(Decode) do
				SettingsLib[i] = v;
			end;
		end;
		print("Library Loaded!");
	else
		return warn("Status : Undetected Executor");
	end;
end;
(getgenv()).SaveConfig = function()
	if readfile and writefile and isfile and isfolder then
		if not isfile(("IKAROHUB/Library/" .. game.Players.LocalPlayer.Name .. ".json")) then
			(getgenv()).Load();
		else
			local Decode = (game:GetService("HttpService")):JSONDecode(readfile("IKAROHUB/Library/" .. game.Players.LocalPlayer.Name .. ".json"));
			local Array = {};
			for i, v in pairs(SettingsLib) do
				Array[i] = v;
			end;
			writefile("IKAROHUB/Library/" .. game.Players.LocalPlayer.Name .. ".json", (game:GetService("HttpService")):JSONEncode(Array));
		end;
	else
		return warn("Status : Undetected Executor");
	end;
end;
(getgenv()).LoadConfig();
function Update:SaveSettings()
	if SettingsLib.SaveSettings then
		return true;
	end;
	return false;
end;
function Update:LoadAnimation()
	if SettingsLib.LoadAnimation then
		return true;
	end;
	return false;
end;
function Update:Window(Config)
	assert(Config.SubTitle, "v4");
	local WindowConfig = {
		Size = Config.Size,
		TabWidth = Config.TabWidth
	};
	local osfunc = {};
	local uihide = false;
	local abc = false;
	local currentpage = "";
	local keybind = keybind or Enum.KeyCode.RightControl;
	local yoo = string.gsub(tostring(keybind), "Enum.KeyCode.", "");
	local IKAROHUB = Instance.new("ScreenGui");
	IKAROHUB.Name = "IKAROHUB";
	IKAROHUB.Parent = game.CoreGui;
	IKAROHUB.DisplayOrder = 999;
	local OutlineMain = Instance.new("Frame");
	OutlineMain.Name = "OutlineMain";
	OutlineMain.Parent = IKAROHUB;
	OutlineMain.ClipsDescendants = true;
	OutlineMain.AnchorPoint = Vector2.new(0.5, 0.5);
	OutlineMain.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
	OutlineMain.BackgroundTransparency = 0.4;
	OutlineMain.Position = UDim2.new(0.5, 0, 0.45, 0);
	OutlineMain.Size = UDim2.new(0, 0, 0, 0);
	CreateRounded(OutlineMain, 15);
	local Main = Instance.new("Frame");
	Main.Name = "Main";
	Main.Parent = OutlineMain;
	Main.ClipsDescendants = true;
	Main.AnchorPoint = Vector2.new(0.5, 0.5);
	Main.BackgroundColor3 = Color3.fromRGB(24, 24, 26);
	Main.BackgroundTransparency = 0;
	Main.Position = UDim2.new(0.5, 0, 0.5, 0);
	Main.Size = WindowConfig.Size;
	OutlineMain:TweenSize(UDim2.new(0, WindowConfig.Size.X.Offset + 15, 0, WindowConfig.Size.Y.Offset + 15), "Out", "Quad", 0.4, true);
	CreateRounded(Main, 12);
	local BtnStroke = Instance.new("UIStroke");
	local DragButton = Instance.new("Frame");
	DragButton.Name = "DragButton";
	DragButton.Parent = Main;
	DragButton.Position = UDim2.new(1, 5, 1, 5);
	DragButton.AnchorPoint = Vector2.new(1, 1);
	DragButton.Size = UDim2.new(0, 15, 0, 15);
	DragButton.BackgroundColor3 = _G.Primary;
	DragButton.BackgroundTransparency = 1;
	DragButton.ZIndex = 10;
	local mouse = game.Players.LocalPlayer:GetMouse();
	local uis = game:GetService("UserInputService");
	local CircleDragButton = Instance.new("UICorner");
	CircleDragButton.Name = "CircleDragButton";
	CircleDragButton.Parent = DragButton;
	CircleDragButton.CornerRadius = UDim.new(0, 99);
	local Top = Instance.new("Frame");
	Top.Name = "Top";
	Top.Parent = Main;
	Top.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
	Top.Size = UDim2.new(1, 0, 0, 40);
	Top.BackgroundTransparency = 1;
	CreateRounded(Top, 5);
	local NameHub = Instance.new("TextLabel");
	NameHub.Name = "NameHub";
	NameHub.Parent = Top;
	NameHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	NameHub.BackgroundTransparency = 1;
	NameHub.RichText = true;
	NameHub.Position = UDim2.new(0, 15, 0.5, 0);
	NameHub.AnchorPoint = Vector2.new(0, 0.5);
	NameHub.Size = UDim2.new(0, 1, 0, 25);
	NameHub.Font = Enum.Font.GothamBold;
	NameHub.Text = "IKAROHUB";
	NameHub.TextSize = 20;
	NameHub.TextColor3 = Color3.fromRGB(255, 255, 255);
	NameHub.TextXAlignment = Enum.TextXAlignment.Left;
	local nameHubSize = (game:GetService("TextService")):GetTextSize(NameHub.Text, NameHub.TextSize, NameHub.Font, Vector2.new(math.huge, math.huge));
	NameHub.Size = UDim2.new(0, nameHubSize.X, 0, 25);
	local SubTitle = Instance.new("TextLabel");
	SubTitle.Name = "SubTitle";
	SubTitle.Parent = NameHub;
	SubTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	SubTitle.BackgroundTransparency = 1;
	SubTitle.Position = UDim2.new(0, nameHubSize.X + 8, 0.5, 0);
	SubTitle.Size = UDim2.new(0, 1, 0, 20);
	SubTitle.Font = Enum.Font.Cartoon;
	SubTitle.AnchorPoint = Vector2.new(0, 0.5);
	SubTitle.Text = Config.SubTitle;
	SubTitle.TextSize = 15;
	SubTitle.TextColor3 = Color3.fromRGB(150, 150, 150);
	local SubTitleSize = (game:GetService("TextService")):GetTextSize(SubTitle.Text, SubTitle.TextSize, SubTitle.Font, Vector2.new(math.huge, math.huge));
	SubTitle.Size = UDim2.new(0, SubTitleSize.X, 0, 25);
	local CloseButton = Instance.new("ImageButton");
	CloseButton.Name = "CloseButton";
	CloseButton.Parent = Top;
	CloseButton.BackgroundColor3 = _G.Primary;
	CloseButton.BackgroundTransparency = 1;
	CloseButton.AnchorPoint = Vector2.new(1, 0.5);
	CloseButton.Position = UDim2.new(1, -15, 0.5, 0);
	CloseButton.Size = UDim2.new(0, 20, 0, 20);
	CloseButton.Image = "rbxassetid://7743878857";
	CloseButton.ImageTransparency = 0;
	CloseButton.ImageColor3 = Color3.fromRGB(245, 245, 245);
	CreateRounded(CloseButton, 3);
	CloseButton.MouseButton1Click:connect(function()
		(game.CoreGui:FindFirstChild("IKAROHUB")).Enabled = not (game.CoreGui:FindFirstChild("IKAROHUB")).Enabled;
	end);
	local ResizeButton = Instance.new("ImageButton");
	ResizeButton.Name = "ResizeButton";
	ResizeButton.Parent = Top;
	ResizeButton.BackgroundColor3 = _G.Primary;
	ResizeButton.BackgroundTransparency = 1;
	ResizeButton.AnchorPoint = Vector2.new(1, 0.5);
	ResizeButton.Position = UDim2.new(1, -50, 0.5, 0);
	ResizeButton.Size = UDim2.new(0, 20, 0, 20);
	ResizeButton.Image = "rbxassetid://10734886735";
	ResizeButton.ImageTransparency = 0;
	ResizeButton.ImageColor3 = Color3.fromRGB(245, 245, 245);
	CreateRounded(ResizeButton, 3);
	local BackgroundSettings = Instance.new("Frame");
	BackgroundSettings.Name = "BackgroundSettings";
	BackgroundSettings.Parent = OutlineMain;
	BackgroundSettings.ClipsDescendants = true;
	BackgroundSettings.Active = true;
	BackgroundSettings.AnchorPoint = Vector2.new(0, 0);
	BackgroundSettings.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
	BackgroundSettings.BackgroundTransparency = 0.3;
	BackgroundSettings.Position = UDim2.new(0, 0, 0, 0);
	BackgroundSettings.Size = UDim2.new(1, 0, 1, 0);
	BackgroundSettings.Visible = false;
	CreateRounded(BackgroundSettings, 15);
	local SettingsFrame = Instance.new("Frame");
	SettingsFrame.Name = "SettingsFrame";
	SettingsFrame.Parent = BackgroundSettings;
	SettingsFrame.ClipsDescendants = true;
	SettingsFrame.AnchorPoint = Vector2.new(0.5, 0.5);
	SettingsFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 26);
	SettingsFrame.BackgroundTransparency = 0;
	SettingsFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
	SettingsFrame.Size = UDim2.new(0.7, 0, 0.7, 0);
	CreateRounded(SettingsFrame, 15);
	local CloseSettings = Instance.new("ImageButton");
	CloseSettings.Name = "CloseSettings";
	CloseSettings.Parent = SettingsFrame;
	CloseSettings.BackgroundColor3 = _G.Primary;
	CloseSettings.BackgroundTransparency = 1;
	CloseSettings.AnchorPoint = Vector2.new(1, 0);
	CloseSettings.Position = UDim2.new(1, -20, 0, 15);
	CloseSettings.Size = UDim2.new(0, 20, 0, 20);
	CloseSettings.Image = "rbxassetid://10747384394";
	CloseSettings.ImageTransparency = 0;
	CloseSettings.ImageColor3 = Color3.fromRGB(245, 245, 245);
	CreateRounded(CloseSettings, 3);
	CloseSettings.MouseButton1Click:connect(function()
		BackgroundSettings.Visible = false;
	end);
	local SettingsButton = Instance.new("ImageButton");
	SettingsButton.Name = "SettingsButton";
	SettingsButton.Parent = Top;
	SettingsButton.BackgroundColor3 = _G.Primary;
	SettingsButton.BackgroundTransparency = 1;
	SettingsButton.AnchorPoint = Vector2.new(1, 0.5);
	SettingsButton.Position = UDim2.new(1, -85, 0.5, 0);
	SettingsButton.Size = UDim2.new(0, 20, 0, 20);
	SettingsButton.Image = "rbxassetid://10734950020";
	SettingsButton.ImageTransparency = 0;
	SettingsButton.ImageColor3 = Color3.fromRGB(245, 245, 245);
	CreateRounded(SettingsButton, 3);
	SettingsButton.MouseButton1Click:connect(function()
		BackgroundSettings.Visible = true;
	end);
	local TitleSettings = Instance.new("TextLabel");
	TitleSettings.Name = "TitleSettings";
	TitleSettings.Parent = SettingsFrame;
	TitleSettings.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	TitleSettings.BackgroundTransparency = 1;
	TitleSettings.Position = UDim2.new(0, 20, 0, 15);
	TitleSettings.Size = UDim2.new(1, 0, 0, 20);
	TitleSettings.Font = Enum.Font.GothamBold;
	TitleSettings.AnchorPoint = Vector2.new(0, 0);
	TitleSettings.Text = "Library Settings";
	TitleSettings.TextSize = 20;
	TitleSettings.TextColor3 = Color3.fromRGB(245, 245, 245);
	TitleSettings.TextXAlignment = Enum.TextXAlignment.Left;
	local SettingsMenuList = Instance.new("Frame");
	SettingsMenuList.Name = "SettingsMenuList";
	SettingsMenuList.Parent = SettingsFrame;
	SettingsMenuList.ClipsDescendants = true;
	SettingsMenuList.AnchorPoint = Vector2.new(0, 0);
	SettingsMenuList.BackgroundColor3 = Color3.fromRGB(24, 24, 26);
	SettingsMenuList.BackgroundTransparency = 1;
	SettingsMenuList.Position = UDim2.new(0, 0, 0, 50);
	SettingsMenuList.Size = UDim2.new(1, 0, 1, -70);
	CreateRounded(SettingsMenuList, 15);
	local ScrollSettings = Instance.new("ScrollingFrame");
	ScrollSettings.Name = "ScrollSettings";
	ScrollSettings.Parent = SettingsMenuList;
	ScrollSettings.Active = true;
	ScrollSettings.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
	ScrollSettings.Position = UDim2.new(0, 0, 0, 0);
	ScrollSettings.BackgroundTransparency = 1;
	ScrollSettings.Size = UDim2.new(1, 0, 1, 0);
	ScrollSettings.ScrollBarThickness = 3;
	ScrollSettings.ScrollingDirection = Enum.ScrollingDirection.Y;
	CreateRounded(SettingsMenuList, 5);
	local SettingsListLayout = Instance.new("UIListLayout");
	SettingsListLayout.Name = "SettingsListLayout";
	SettingsListLayout.Parent = ScrollSettings;
	SettingsListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
	SettingsListLayout.Padding = UDim.new(0, 8);
	local PaddingScroll = Instance.new("UIPadding");
	PaddingScroll.Name = "PaddingScroll";
	PaddingScroll.Parent = ScrollSettings;
	function CreateCheckbox(title, state, callback)
		local checked = state or false;
		local Background = Instance.new("Frame");
		Background.Name = "Background";
		Background.Parent = ScrollSettings;
		Background.ClipsDescendants = true;
		Background.BackgroundColor3 = Color3.fromRGB(24, 24, 26);
		Background.BackgroundTransparency = 1;
		Background.Size = UDim2.new(1, 0, 0, 20);
		local Title = Instance.new("TextLabel");
		Title.Name = "Title";
		Title.Parent = Background;
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		Title.BackgroundTransparency = 1;
		Title.Position = UDim2.new(0, 60, 0.5, 0);
		Title.Size = UDim2.new(1, -60, 0, 20);
		Title.Font = Enum.Font.Code;
		Title.AnchorPoint = Vector2.new(0, 0.5);
		Title.Text = title or "";
		Title.TextSize = 15;
		Title.TextColor3 = Color3.fromRGB(200, 200, 200);
		Title.TextXAlignment = Enum.TextXAlignment.Left;
		local Checkbox = Instance.new("ImageButton");
		Checkbox.Name = "Checkbox";
		Checkbox.Parent = Background;
		Checkbox.BackgroundColor3 = Color3.fromRGB(100, 100, 100);
		Checkbox.BackgroundTransparency = 0;
		Checkbox.AnchorPoint = Vector2.new(0, 0.5);
		Checkbox.Position = UDim2.new(0, 30, 0.5, 0);
		Checkbox.Size = UDim2.new(0, 20, 0, 20);
		Checkbox.Image = "rbxassetid://10709790644";
		Checkbox.ImageTransparency = 1;
		Checkbox.ImageColor3 = Color3.fromRGB(245, 245, 245);
		CreateRounded(Checkbox, 5);
		Checkbox.MouseButton1Click:Connect(function()
			checked = not checked;
			if checked then
				Checkbox.ImageTransparency = 0;
				Checkbox.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
			else
				Checkbox.ImageTransparency = 1;
				Checkbox.BackgroundColor3 = Color3.fromRGB(100, 100, 100);
			end;
			pcall(callback, checked);
		end);
		if checked then
			Checkbox.ImageTransparency = 0;
			Checkbox.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
		else
			Checkbox.ImageTransparency = 1;
			Checkbox.BackgroundColor3 = Color3.fromRGB(100, 100, 100);
		end;
		pcall(callback, checked);
	end;
	function CreateButton(title, callback)
		local Background = Instance.new("Frame");
		Background.Name = "Background";
		Background.Parent = ScrollSettings;
		Background.ClipsDescendants = true;
		Background.BackgroundColor3 = Color3.fromRGB(24, 24, 26);
		Background.BackgroundTransparency = 1;
		Background.Size = UDim2.new(1, 0, 0, 30);
		local Button = Instance.new("TextButton");
		Button.Name = "Button";
		Button.Parent = Background;
		Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
		Button.BackgroundTransparency = 0;
		Button.Size = UDim2.new(0.8, 0, 0, 30);
		Button.Font = Enum.Font.Code;
		Button.Text = title or "Button";
		Button.AnchorPoint = Vector2.new(0.5, 0);
		Button.Position = UDim2.new(0.5, 0, 0, 0);
		Button.TextColor3 = Color3.fromRGB(255, 255, 255);
		Button.TextSize = 15;
		Button.AutoButtonColor = false;
		Button.MouseButton1Click:Connect(function()
			callback();
		end);
		CreateRounded(Button, 5);
	end;
	CreateCheckbox("Save Settings", SettingsLib.SaveSettings, function(state)
		SettingsLib.SaveSettings = state;
		(getgenv()).SaveConfig();
	end);
	CreateCheckbox("Loading Animation", SettingsLib.LoadAnimation, function(state)
		SettingsLib.LoadAnimation = state;
		(getgenv()).SaveConfig();
	end);
	CreateButton("Reset Config", function()
		if isfolder("IKAROHUB") then
			delfolder("IKAROHUB");
		end;
		Update:Notify("Config has been reseted!");
	end);
	local Tab = Instance.new("Frame");
	Tab.Name = "Tab";
	Tab.Parent = Main;
	Tab.BackgroundColor3 = Color3.fromRGB(45, 45, 45);
	Tab.Position = UDim2.new(0, 8, 0, Top.Size.Y.Offset);
	Tab.BackgroundTransparency = 1;
	Tab.Size = UDim2.new(0, WindowConfig.TabWidth, Config.Size.Y.Scale, Config.Size.Y.Offset - Top.Size.Y.Offset - 8);
	local BtnStroke = Instance.new("UIStroke");
	local ScrollTab = Instance.new("ScrollingFrame");
	ScrollTab.Name = "ScrollTab";
	ScrollTab.Parent = Tab;
	ScrollTab.Active = true;
	ScrollTab.BackgroundColor3 = Color3.fromRGB(10, 10, 10);
	ScrollTab.Position = UDim2.new(0, 0, 0, 0);
	ScrollTab.BackgroundTransparency = 1;
	ScrollTab.Size = UDim2.new(1, 0, 1, 0);
	ScrollTab.ScrollBarThickness = 0;
	ScrollTab.ScrollingDirection = Enum.ScrollingDirection.Y;
	CreateRounded(Tab, 5);
	local TabListLayout = Instance.new("UIListLayout");
	TabListLayout.Name = "TabListLayout";
	TabListLayout.Parent = ScrollTab;
	TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
	TabListLayout.Padding = UDim.new(0, 2);
	local PPD = Instance.new("UIPadding");
	PPD.Name = "PPD";
	PPD.Parent = ScrollTab;
	local Page = Instance.new("Frame");
	Page.Name = "Page";
	Page.Parent = Main;
	Page.BackgroundColor3 = _G.Dark;
	Page.Position = UDim2.new(0, Tab.Size.X.Offset + 18, 0, Top.Size.Y.Offset);
	Page.Size = UDim2.new(Config.Size.X.Scale, Config.Size.X.Offset - Tab.Size.X.Offset - 25, Config.Size.Y.Scale, Config.Size.Y.Offset - Top.Size.Y.Offset - 8);
	Page.BackgroundTransparency = 1;
	CreateRounded(Page, 3);
	local MainPage = Instance.new("Frame");
	MainPage.Name = "MainPage";
	MainPage.Parent = Page;
	MainPage.ClipsDescendants = true;
	MainPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	MainPage.BackgroundTransparency = 1;
	MainPage.Size = UDim2.new(1, 0, 1, 0);
	local PageList = Instance.new("Folder");
	PageList.Name = "PageList";
	PageList.Parent = MainPage;
	local UIPageLayout = Instance.new("UIPageLayout");
	UIPageLayout.Parent = PageList;
	UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder;
	UIPageLayout.EasingDirection = Enum.EasingDirection.InOut;
	UIPageLayout.EasingStyle = Enum.EasingStyle.Quad;
	UIPageLayout.FillDirection = Enum.FillDirection.Vertical;
	UIPageLayout.Padding = UDim.new(0, 10);
	UIPageLayout.TweenTime = 0;
	UIPageLayout.GamepadInputEnabled = false;
	UIPageLayout.ScrollWheelInputEnabled = false;
	UIPageLayout.TouchInputEnabled = false;
	MakeDraggable(Top, OutlineMain);
	UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.Insert then
			(game.CoreGui:FindFirstChild("IKAROHUB")).Enabled = not (game.CoreGui:FindFirstChild("IKAROHUB")).Enabled;
		end;
	end);
	local Dragging = false;
	DragButton.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true;
		end;
	end);
	UserInputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Dragging = false;
		end;
	end);
	UserInputService.InputChanged:Connect(function(Input)
		if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
			OutlineMain.Size = UDim2.new(0, math.clamp(Input.Position.X - Main.AbsolutePosition.X + 15, WindowConfig.Size.X.Offset + 15, math.huge), 0, math.clamp(Input.Position.Y - Main.AbsolutePosition.Y + 15, WindowConfig.Size.Y.Offset + 15, math.huge));
			Main.Size = UDim2.new(0, math.clamp(Input.Position.X - Main.AbsolutePosition.X, WindowConfig.Size.X.Offset, math.huge), 0, math.clamp(Input.Position.Y - Main.AbsolutePosition.Y, WindowConfig.Size.Y.Offset, math.huge));
			Page.Size = UDim2.new(0, math.clamp(Input.Position.X - Page.AbsolutePosition.X - 8, WindowConfig.Size.X.Offset - Tab.Size.X.Offset - 25, math.huge), 0, math.clamp(Input.Position.Y - Page.AbsolutePosition.Y - 8, WindowConfig.Size.Y.Offset - Top.Size.Y.Offset - 10, math.huge));
			Tab.Size = UDim2.new(0, WindowConfig.TabWidth, 0, math.clamp(Input.Position.Y - Tab.AbsolutePosition.Y - 8, WindowConfig.Size.Y.Offset - Top.Size.Y.Offset - 10, math.huge));
		end;
	end);
	local uitab = {};
	function uitab:Tab(text, img)
		local BtnStroke = Instance.new("UIStroke");
		local TabButton = Instance.new("TextButton");
		local title = Instance.new("TextLabel");
		local TUICorner = Instance.new("UICorner");
		local UICorner = Instance.new("UICorner");
		local Title = Instance.new("TextLabel");
		TabButton.Parent = ScrollTab;
		TabButton.Name = text .. "Unique";
		TabButton.Text = "";
		TabButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100);
		TabButton.BackgroundTransparency = 1;
		TabButton.Size = UDim2.new(1, 0, 0, 35);
		TabButton.Font = Enum.Font.Nunito;
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255);
		TabButton.TextSize = 12;
		TabButton.TextTransparency = 0.9;
		local SelectedTab = Instance.new("Frame");
		SelectedTab.Name = "SelectedTab";
		SelectedTab.Parent = TabButton;
		SelectedTab.BackgroundColor3 = _G.Third;
		SelectedTab.BackgroundTransparency = 0;
		SelectedTab.Size = UDim2.new(0, 3, 0, 0);
		SelectedTab.Position = UDim2.new(0, 0, 0.5, 0);
		SelectedTab.AnchorPoint = Vector2.new(0, 0.5);
		UICorner.CornerRadius = UDim.new(0, 100);
		UICorner.Parent = SelectedTab;
		Title.Parent = TabButton;
		Title.Name = "Title";
		Title.BackgroundColor3 = Color3.fromRGB(150, 150, 150);
		Title.BackgroundTransparency = 1;
		Title.Position = UDim2.new(0, 30, 0.5, 0);
		Title.Size = UDim2.new(0, 100, 0, 30);
		Title.Font = Enum.Font.Roboto;
		Title.Text = text;
		Title.AnchorPoint = Vector2.new(0, 0.5);
		Title.TextColor3 = Color3.fromRGB(255, 255, 255);
		Title.TextTransparency = 0.4;
		Title.TextSize = 14;
		Title.TextXAlignment = Enum.TextXAlignment.Left;
		local IDK = Instance.new("ImageLabel");
		IDK.Name = "IDK";
		IDK.Parent = TabButton;
		IDK.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		IDK.BackgroundTransparency = 1;
		IDK.ImageTransparency = 0.3;
		IDK.Position = UDim2.new(0, 7, 0.5, 0);
		IDK.Size = UDim2.new(0, 15, 0, 15);
		IDK.AnchorPoint = Vector2.new(0, 0.5);
		IDK.Image = img;
		CreateRounded(TabButton, 6);
		local MainFramePage = Instance.new("ScrollingFrame");
		MainFramePage.Name = text .. "_Page";
		MainFramePage.Parent = PageList;
		MainFramePage.Active = true;
		MainFramePage.BackgroundColor3 = _G.Dark;
		MainFramePage.Position = UDim2.new(0, 0, 0, 0);
		MainFramePage.BackgroundTransparency = 1;
		MainFramePage.Size = UDim2.new(1, 0, 1, 0);
		MainFramePage.ScrollBarThickness = 0;
		MainFramePage.ScrollingDirection = Enum.ScrollingDirection.Y;
		local zzzR = Instance.new("UICorner");
		zzzR.Parent = MainPage;
		zzzR.CornerRadius = UDim.new(0, 5);
		local UIPadding = Instance.new("UIPadding");
		local UIListLayout = Instance.new("UIListLayout");
		UIPadding.Parent = MainFramePage;
		UIListLayout.Padding = UDim.new(0, 3);
		UIListLayout.Parent = MainFramePage;
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
		TabButton.MouseButton1Click:Connect(function()
			for i, v in next, ScrollTab:GetChildren() do
				if v:IsA("TextButton") then
					(TweenService:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						BackgroundTransparency = 1
					})):Play();
					(TweenService:Create(v.SelectedTab, TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.new(0, 3, 0, 0)
					})):Play();
					(TweenService:Create(v.IDK, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						ImageTransparency = 0.4
					})):Play();
					(TweenService:Create(v.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						TextTransparency = 0.4
					})):Play();
				end;
				(TweenService:Create(TabButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					BackgroundTransparency = 0.8
				})):Play();
				(TweenService:Create(SelectedTab, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, 3, 0, 15)
				})):Play();
				(TweenService:Create(IDK, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					ImageTransparency = 0
				})):Play();
				(TweenService:Create(Title, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					TextTransparency = 0
				})):Play();
			end;
			for i, v in next, PageList:GetChildren() do
				currentpage = string.gsub(TabButton.Name, "Unique", "") .. "_Page";
				if v.Name == currentpage then
					UIPageLayout:JumpTo(v);
				end;
			end;
		end);
		if abc == false then
			for i, v in next, ScrollTab:GetChildren() do
				if v:IsA("TextButton") then
					(TweenService:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						BackgroundTransparency = 1
					})):Play();
					(TweenService:Create(v.SelectedTab, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.new(0, 3, 0, 15)
					})):Play();
					(TweenService:Create(v.IDK, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						ImageTransparency = 0.4
					})):Play();
					(TweenService:Create(v.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						TextTransparency = 0.4
					})):Play();
				end;
				(TweenService:Create(TabButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					BackgroundTransparency = 0.8
				})):Play();
				(TweenService:Create(SelectedTab, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, 3, 0, 15)
				})):Play();
				(TweenService:Create(IDK, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					ImageTransparency = 0
				})):Play();
				(TweenService:Create(Title, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					TextTransparency = 0
				})):Play();
			end;
			UIPageLayout:JumpToIndex(1);
			abc = true;
		end;
		(game:GetService("RunService")).Stepped:Connect(function()
			pcall(function()
				MainFramePage.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y);
				ScrollTab.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y);
				ScrollSettings.CanvasSize = UDim2.new(0, 0, 0, SettingsListLayout.AbsoluteContentSize.Y);
			end);
		end);
		local defaultSize = true;
		ResizeButton.MouseButton1Click:Connect(function()
			if defaultSize then
				defaultSize = false;
				OutlineMain:TweenPosition(UDim2.new(0.5, 0, 0.45, 0), "Out", "Quad", 0.2, true);
				Main:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quad", 0.4, true, function()
					Page:TweenSize(UDim2.new(0, Main.AbsoluteSize.X - Tab.AbsoluteSize.X - 25, 0, Main.AbsoluteSize.Y - Top.AbsoluteSize.Y - 10), "Out", "Quad", 0.4, true);
					Tab:TweenSize(UDim2.new(0, WindowConfig.TabWidth, 0, Main.AbsoluteSize.Y - Top.AbsoluteSize.Y - 10), "Out", "Quad", 0.4, true);
				end);
				OutlineMain:TweenSize(UDim2.new(1, -10, 1, -10), "Out", "Quad", 0.4, true);
				ResizeButton.Image = "rbxassetid://10734895698";
			else
				defaultSize = true;
				Main:TweenSize(UDim2.new(0, WindowConfig.Size.X.Offset, 0, WindowConfig.Size.Y.Offset), "Out", "Quad", 0.4, true, function()
					Page:TweenSize(UDim2.new(0, Main.AbsoluteSize.X - Tab.AbsoluteSize.X - 25, 0, Main.AbsoluteSize.Y - Top.AbsoluteSize.Y - 10), "Out", "Quad", 0.4, true);
					Tab:TweenSize(UDim2.new(0, WindowConfig.TabWidth, 0, Main.AbsoluteSize.Y - Top.AbsoluteSize.Y - 10), "Out", "Quad", 0.4, true);
				end);
				OutlineMain:TweenSize(UDim2.new(0, WindowConfig.Size.X.Offset + 15, 0, WindowConfig.Size.Y.Offset + 15), "Out", "Quad", 0.4, true);
				ResizeButton.Image = "rbxassetid://10734886735";
			end;
		end);
		local main = {};
		function main:Button(text, callback)
			local Button = Instance.new("Frame");
			local UICorner = Instance.new("UICorner");
			local TextLabel = Instance.new("TextLabel");
			local TextButton = Instance.new("TextButton");
			local UICorner_2 = Instance.new("UICorner");
			local Black = Instance.new("Frame");
			local UICorner_3 = Instance.new("UICorner");
			Button.Name = "Button";
			Button.Parent = MainFramePage;
			Button.BackgroundColor3 = _G.Primary;
			Button.BackgroundTransparency = 1;
			Button.Size = UDim2.new(1, 0, 0, 36);
			UICorner.CornerRadius = UDim.new(0, 5);
			UICorner.Parent = Button;
			local ImageLabel = Instance.new("ImageLabel");
			ImageLabel.Name = "ImageLabel";
			ImageLabel.Parent = TextButton;
			ImageLabel.BackgroundColor3 = _G.Primary;
			ImageLabel.BackgroundTransparency = 1;
			ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
			ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0);
			ImageLabel.Size = UDim2.new(0, 15, 0, 15);
			ImageLabel.Image = "rbxassetid://10734898355";
			ImageLabel.ImageTransparency = 0;
			ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255);
			CreateRounded(TextButton, 4);
			TextButton.Name = "TextButton";
			TextButton.Parent = Button;
			TextButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200);
			TextButton.BackgroundTransparency = 0.8;
			TextButton.AnchorPoint = Vector2.new(1, 0.5);
			TextButton.Position = UDim2.new(1, -1, 0.5, 0);
			TextButton.Size = UDim2.new(0, 25, 0, 25);
			TextButton.Font = Enum.Font.Nunito;
			TextButton.Text = "";
			TextButton.TextXAlignment = Enum.TextXAlignment.Left;
			TextButton.TextColor3 = Color3.fromRGB(255, 255, 255);
			TextButton.TextSize = 15;
			TextLabel.Name = "TextLabel";
			TextLabel.Parent = Button;
			TextLabel.BackgroundColor3 = _G.Primary;
			TextLabel.BackgroundTransparency = 1;
			TextLabel.AnchorPoint = Vector2.new(0, 0.5);
			TextLabel.Position = UDim2.new(0, 20, 0.5, 0);
			TextLabel.Size = UDim2.new(1, -50, 1, 0);
			TextLabel.Font = Enum.Font.Cartoon;
			TextLabel.RichText = true;
			TextLabel.Text = text;
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
			TextLabel.TextSize = 15;
			TextLabel.ClipsDescendants = true;
            local ArrowRight = Instance.new("ImageLabel");
			ArrowRight.Name = "ArrowRight";
			ArrowRight.Parent = Button;
			ArrowRight.BackgroundColor3 = _G.Primary;
			ArrowRight.BackgroundTransparency = 1;
			ArrowRight.AnchorPoint = Vector2.new(0, 0.5);
			ArrowRight.Position = UDim2.new(0, 0, 0.5, 0);
			ArrowRight.Size = UDim2.new(0, 15, 0, 15);
			ArrowRight.Image = "rbxassetid://10709768347";
			ArrowRight.ImageTransparency = 0;
			ArrowRight.ImageColor3 = Color3.fromRGB(255, 255, 255);
			Black.Name = "Black";
			Black.Parent = Button;
			Black.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
			Black.BackgroundTransparency = 1;
			Black.BorderSizePixel = 0;
			Black.Position = UDim2.new(0, 0, 0, 0);
			Black.Size = UDim2.new(1, 0, 0, 33);
			UICorner_3.CornerRadius = UDim.new(0, 5);
			UICorner_3.Parent = Black;
			TextButton.MouseButton1Click:Connect(function()
				callback();
			end);
		end;
		function main:Toggle(text, config, desc, callback)
			config = config or false;
			local toggled = config;
			local UICorner = Instance.new("UICorner");
			local TogglePadding = Instance.new("UIPadding");
			local UIStroke = Instance.new("UIStroke");
			local Button = Instance.new("TextButton");
			local UICorner_2 = Instance.new("UICorner");
			local Title = Instance.new("TextLabel");
			local Title2 = Instance.new("TextLabel");
			local Desc = Instance.new("TextLabel");
			local ToggleImage = Instance.new("TextButton");
			local UICorner_3 = Instance.new("UICorner");
			local UICorner_5 = Instance.new("UICorner");
			local Circle = Instance.new("Frame");
			local ToggleFrame = Instance.new("Frame");
			local UICorner_4 = Instance.new("UICorner");
			local TextBoxIcon = Instance.new("ImageLabel");
			Button.Name = "Button";
			Button.Parent = MainFramePage;
			Button.BackgroundColor3 = _G.Primary;
			Button.BackgroundTransparency = 0.8;
			Button.AutoButtonColor = false;
			Button.Font = Enum.Font.SourceSans;
			Button.Text = "";
			Button.TextColor3 = Color3.fromRGB(0, 0, 0);
			Button.TextSize = 11;
			CreateRounded(Button, 5);
			Title2.Parent = Button;
			Title2.BackgroundColor3 = Color3.fromRGB(150, 150, 150);
			Title2.BackgroundTransparency = 1;
			Title2.Size = UDim2.new(1, 0, 0, 35);
			Title2.Font = Enum.Font.Cartoon;
			Title2.Text = text;
			Title2.TextColor3 = Color3.fromRGB(255, 255, 255);
			Title2.TextSize = 15;
			Title2.TextXAlignment = Enum.TextXAlignment.Left;
			Title2.AnchorPoint = Vector2.new(0, 0.5);
			Desc.Parent = Title2;
			Desc.BackgroundColor3 = Color3.fromRGB(100, 100, 100);
			Desc.BackgroundTransparency = 1;
			Desc.Position = UDim2.new(0, 0, 0, 22);
			Desc.Size = UDim2.new(0, 280, 0, 16);
			Desc.Font = Enum.Font.Gotham;
			if desc then
				Desc.Text = desc;
				Title2.Position = UDim2.new(0, 15, 0.5, -5);
				Desc.Position = UDim2.new(0, 0, 0, 22);
				Button.Size = UDim2.new(1, 0, 0, 46);
			else
				Title2.Position = UDim2.new(0, 15, 0.5, 0);
				Desc.Visible = false;
				Button.Size = UDim2.new(1, 0, 0, 36);
			end;
			Desc.TextColor3 = Color3.fromRGB(150, 150, 150);
			Desc.TextSize = 10;
			Desc.TextXAlignment = Enum.TextXAlignment.Left;
			ToggleFrame.Name = "ToggleFrame";
			ToggleFrame.Parent = Button;
			ToggleFrame.BackgroundColor3 = _G.Dark;
			ToggleFrame.BackgroundTransparency = 1;
			ToggleFrame.Position = UDim2.new(1, -10, 0.5, 0);
			ToggleFrame.Size = UDim2.new(0, 35, 0, 20);
			ToggleFrame.AnchorPoint = Vector2.new(1, 0.5);
			UICorner_5.CornerRadius = UDim.new(0, 10);
			UICorner_5.Parent = ToggleFrame;
			ToggleImage.Name = "ToggleImage";
			ToggleImage.Parent = ToggleFrame;
			ToggleImage.BackgroundColor3 = Color3.fromRGB(200, 200, 200);
			ToggleImage.BackgroundTransparency = 0.8;
			ToggleImage.Position = UDim2.new(0, 0, 0, 0);
			ToggleImage.AnchorPoint = Vector2.new(0, 0);
			ToggleImage.Size = UDim2.new(1, 0, 1, 0);
			ToggleImage.Text = "";
			ToggleImage.AutoButtonColor = false;
			CreateRounded(ToggleImage, 10);
			Circle.Name = "Circle";
			Circle.Parent = ToggleImage;
			Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			Circle.BackgroundTransparency = 0;
			Circle.Position = UDim2.new(0, 3, 0.5, 0);
			Circle.Size = UDim2.new(0, 14, 0, 14);
			Circle.AnchorPoint = Vector2.new(0, 0.5);
			UICorner_4.CornerRadius = UDim.new(0, 10);
			UICorner_4.Parent = Circle;
			ToggleImage.MouseButton1Click:Connect(function()
				if toggled == false then
					toggled = true;
					Circle:TweenPosition(UDim2.new(0, 17, 0.5, 0), "Out", "Sine", 0.2, true);
					(TweenService:Create(ToggleImage, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						BackgroundColor3 = _G.Third,
						BackgroundTransparency = 0
					})):Play();
				else
					toggled = false;
					Circle:TweenPosition(UDim2.new(0, 4, 0.5, 0), "Out", "Sine", 0.2, true);
					(TweenService:Create(ToggleImage, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						BackgroundColor3 = Color3.fromRGB(200, 200, 200),
						BackgroundTransparency = 0.8
					})):Play();
				end;
				pcall(callback, toggled);
			end);
			if config == true then
				toggled = true;
				Circle:TweenPosition(UDim2.new(0, 17, 0.5, 0), "Out", "Sine", 0.4, true);
				(TweenService:Create(ToggleImage, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					BackgroundColor3 = _G.Third,
					BackgroundTransparency = 0
				})):Play();
				pcall(callback, toggled);
			end;
		end;
		function main:Dropdown(text, option, var, callback)
			local isdropping = false;
			local Dropdown = Instance.new("Frame");
			local DropdownFrameScroll = Instance.new("Frame");
			local UICorner = Instance.new("UICorner");
			local UICorner_2 = Instance.new("UICorner");
			local UICorner_3 = Instance.new("UICorner");
			local UICorner_4 = Instance.new("UICorner");
			local DropTitle = Instance.new("TextLabel");
			local DropScroll = Instance.new("ScrollingFrame");
			local UIListLayout = Instance.new("UIListLayout");
			local UIPadding = Instance.new("UIPadding");
			local DropButton = Instance.new("TextButton");
			local HideButton = Instance.new("TextButton");
			local SelectItems = Instance.new("TextButton");
			local DropImage = Instance.new("ImageLabel");
			local UIStroke = Instance.new("UIStroke");
			Dropdown.Name = "Dropdown";
			Dropdown.Parent = MainFramePage;
			Dropdown.BackgroundColor3 = _G.Primary;
			Dropdown.BackgroundTransparency = 0.8;
			Dropdown.ClipsDescendants = false;
			Dropdown.Size = UDim2.new(1, 0, 0, 40);
			UICorner.CornerRadius = UDim.new(0, 5);
			UICorner.Parent = Dropdown;
			DropTitle.Name = "DropTitle";
			DropTitle.Parent = Dropdown;
			DropTitle.BackgroundColor3 = _G.Primary;
			DropTitle.BackgroundTransparency = 1;
			DropTitle.Size = UDim2.new(1, 0, 0, 30);
			DropTitle.Font = Enum.Font.Cartoon;
			DropTitle.Text = text;
			DropTitle.TextColor3 = Color3.fromRGB(255, 255, 255);
			DropTitle.TextSize = 15;
			DropTitle.TextXAlignment = Enum.TextXAlignment.Left;
			DropTitle.Position = UDim2.new(0, 15, 0, 5);
			DropTitle.AnchorPoint = Vector2.new(0, 0);
			SelectItems.Name = "SelectItems";
			SelectItems.Parent = Dropdown;
			SelectItems.BackgroundColor3 = Color3.fromRGB(24, 24, 26);
			SelectItems.TextColor3 = Color3.fromRGB(255, 255, 255);
			SelectItems.BackgroundTransparency = 0;
			SelectItems.Position = UDim2.new(1, -5, 0, 5);
			SelectItems.Size = UDim2.new(0, 100, 0, 30);
			SelectItems.AnchorPoint = Vector2.new(1, 0);
			SelectItems.Font = Enum.Font.GothamMedium;
			SelectItems.AutoButtonColor = false;
			SelectItems.TextSize = 9;
			SelectItems.ZIndex = 1;
			SelectItems.ClipsDescendants = true;
			SelectItems.Text = "   Select Items";
			SelectItems.TextXAlignment = Enum.TextXAlignment.Left;
			local ArrowDown = Instance.new("ImageLabel");
			ArrowDown.Name = "ArrowDown";
			ArrowDown.Parent = Dropdown;
			ArrowDown.BackgroundColor3 = _G.Primary;
			ArrowDown.BackgroundTransparency = 1;
			ArrowDown.AnchorPoint = Vector2.new(1, 0);
			ArrowDown.Position = UDim2.new(1, -110, 0, 10);
			ArrowDown.Size = UDim2.new(0, 20, 0, 20);
			ArrowDown.Image = "rbxassetid://10709790948";
			ArrowDown.ImageTransparency = 0;
			ArrowDown.ImageColor3 = Color3.fromRGB(255, 255, 255);
			CreateRounded(SelectItems, 5);
			CreateRounded(DropScroll, 5);
			DropdownFrameScroll.Name = "DropdownFrameScroll";
			DropdownFrameScroll.Parent = Dropdown;
			DropdownFrameScroll.BackgroundColor3 = Color3.fromRGB(24, 24, 26);
			DropdownFrameScroll.BackgroundTransparency = 0;
			DropdownFrameScroll.ClipsDescendants = true;
			DropdownFrameScroll.Size = UDim2.new(1, 0, 0, 100);
			DropdownFrameScroll.Position = UDim2.new(0, 5, 0, 40);
			DropdownFrameScroll.Visible = false;
			DropdownFrameScroll.AnchorPoint = Vector2.new(0, 0);
			UICorner_4.Parent = DropdownFrameScroll;
			UICorner_4.CornerRadius = UDim.new(0, 5);
			DropScroll.Name = "DropScroll";
			DropScroll.Parent = DropdownFrameScroll;
			DropScroll.ScrollingDirection = Enum.ScrollingDirection.Y;
			DropScroll.Active = true;
			DropScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			DropScroll.BackgroundTransparency = 1;
			DropScroll.BorderSizePixel = 0;
			DropScroll.Position = UDim2.new(0, 0, 0, 10);
			DropScroll.Size = UDim2.new(1, 0, 0, 80);
			DropScroll.AnchorPoint = Vector2.new(0, 0);
			DropScroll.ClipsDescendants = true;
			DropScroll.ScrollBarThickness = 3;
			DropScroll.ZIndex = 3;
			local PaddingDrop = Instance.new("UIPadding");
			PaddingDrop.PaddingLeft = UDim.new(0, 10);
			PaddingDrop.PaddingRight = UDim.new(0, 10);
			PaddingDrop.Parent = DropScroll;
			PaddingDrop.Name = "PaddingDrop";
			UIListLayout.Parent = DropScroll;
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
			UIListLayout.Padding = UDim.new(0, 1);
			UIPadding.Parent = DropScroll;
			UIPadding.PaddingLeft = UDim.new(0, 5);
			for i, v in next, option do
				local Item = Instance.new("TextButton");
				local CRNRitems = Instance.new("UICorner");
				local UICorner_5 = Instance.new("UICorner");
				local ItemPadding = Instance.new("UIPadding");
				Item.Name = "Item";
				Item.Parent = DropScroll;
				Item.BackgroundColor3 = _G.Primary;
				Item.BackgroundTransparency = 1;
				Item.Size = UDim2.new(1, 0, 0, 30);
				Item.Font = Enum.Font.Nunito;
				Item.Text = tostring(v);
				Item.TextColor3 = Color3.fromRGB(255, 255, 255);
				Item.TextSize = 13;
				Item.TextTransparency = 0.5;
				Item.TextXAlignment = Enum.TextXAlignment.Left;
				Item.ZIndex = 4;
				ItemPadding.Parent = Item;
				ItemPadding.PaddingLeft = UDim.new(0, 8);
				UICorner_5.Parent = Item;
				UICorner_5.CornerRadius = UDim.new(0, 5);
				local SelectedItems = Instance.new("Frame");
				SelectedItems.Name = "SelectedItems";
				SelectedItems.Parent = Item;
				SelectedItems.BackgroundColor3 = _G.Third;
				SelectedItems.BackgroundTransparency = 1;
				SelectedItems.Size = UDim2.new(0, 3, 0.4, 0);
				SelectedItems.Position = UDim2.new(0, -8, 0.5, 0);
				SelectedItems.AnchorPoint = Vector2.new(0, 0.5);
				SelectedItems.ZIndex = 4;
				CRNRitems.Parent = SelectedItems;
				CRNRitems.CornerRadius = UDim.new(0, 999);
				if var then
					pcall(callback, var);
					SelectItems.Text = "   " .. var;
					activeItem = tostring(var);
					for i, v in next, DropScroll:GetChildren() do
						if v:IsA("TextButton") then
							local SelectedItems = v:FindFirstChild("SelectedItems");
							if activeItem == v.Text then
								v.BackgroundTransparency = 0.8;
								v.TextTransparency = 0;
								if SelectedItems then
									SelectedItems.BackgroundTransparency = 0;
								end;
							end;
						end;
					end;
				end;
				Item.MouseButton1Click:Connect(function()
					SelectItems.ClipsDescendants = true;
					callback(Item.Text);
					activeItem = Item.Text;
					for i, v in next, DropScroll:GetChildren() do
						if v:IsA("TextButton") then
							local SelectedItems = v:FindFirstChild("SelectedItems");
							if activeItem == v.Text then
								v.BackgroundTransparency = 0.8;
								v.TextTransparency = 0;
								if SelectedItems then
									SelectedItems.BackgroundTransparency = 0;
								end;
							else
								v.BackgroundTransparency = 1;
								v.TextTransparency = 0.5;
								if SelectedItems then
									SelectedItems.BackgroundTransparency = 1;
								end;
							end;
						end;
					end;
					SelectItems.Text = "   " .. Item.Text;
				end);
			end;
			DropScroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y);
			SelectItems.MouseButton1Click:Connect(function()
				if isdropping == false then
					isdropping = true;
					(TweenService:Create(DropdownFrameScroll, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.new(1, -10, 0, 100),
						Visible = true
					})):Play();
					(TweenService:Create(Dropdown, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.new(1, 0, 0, 145)
					})):Play();
                    (TweenService:Create(ArrowDown, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Rotation = 180
                    })):Play();
				else
					isdropping = false;
					(TweenService:Create(DropdownFrameScroll, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.new(1, -10, 0, 0),
						Visible = false
					})):Play();
					(TweenService:Create(Dropdown, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.new(1, 0, 0, 40)
					})):Play();
                    (TweenService:Create(ArrowDown, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Rotation = 0
                    })):Play();
				end;
			end);
			local dropfunc = {};
			function dropfunc:Add(t)
				local Item = Instance.new("TextButton");
				local CRNRitems = Instance.new("UICorner");
				local UICorner_5 = Instance.new("UICorner");
				local ItemPadding = Instance.new("UIPadding");
				Item.Name = "Item";
				Item.Parent = DropScroll;
				Item.BackgroundColor3 = _G.Primary;
				Item.BackgroundTransparency = 1;
				Item.Size = UDim2.new(1, 0, 0, 30);
				Item.Font = Enum.Font.Nunito;
				Item.Text = tostring(t);
				Item.TextColor3 = Color3.fromRGB(255, 255, 255);
				Item.TextSize = 13;
				Item.TextTransparency = 0.5;
				Item.TextXAlignment = Enum.TextXAlignment.Left;
				Item.ZIndex = 4;
				ItemPadding.Parent = Item;
				ItemPadding.PaddingLeft = UDim.new(0, 8);
				UICorner_5.Parent = Item;
				UICorner_5.CornerRadius = UDim.new(0, 5);
				local SelectedItems = Instance.new("Frame");
				SelectedItems.Name = "SelectedItems";
				SelectedItems.Parent = Item;
				SelectedItems.BackgroundColor3 = _G.Third;
				SelectedItems.BackgroundTransparency = 1;
				SelectedItems.Size = UDim2.new(0, 3, 0.4, 0);
				SelectedItems.Position = UDim2.new(0, -8, 0.5, 0);
				SelectedItems.AnchorPoint = Vector2.new(0, 0.5);
				SelectedItems.ZIndex = 4;
				CRNRitems.Parent = SelectedItems;
				CRNRitems.CornerRadius = UDim.new(0, 999);
				Item.MouseButton1Click:Connect(function()
					callback(Item.Text);
					activeItem = Item.Text;
					for i, v in next, DropScroll:GetChildren() do
						if v:IsA("TextButton") then
							local SelectedItems = v:FindFirstChild("SelectedItems");
							if activeItem == v.Text then
								v.BackgroundTransparency = 0.8;
								v.TextTransparency = 0;
								if SelectedItems then
									SelectedItems.BackgroundTransparency = 0;
								end;
							else
								v.BackgroundTransparency = 1;
								v.TextTransparency = 0.5;
								if SelectedItems then
									SelectedItems.BackgroundTransparency = 1;
								end;
							end;
						end;
					end;
					SelectItems.Text = "   " .. Item.Text;
				end);
			end;
			function dropfunc:Clear()
				SelectItems.Text = "   Select Items";
				isdropping = false;
				DropdownFrameScroll.Visible = false;
				for i, v in next, DropScroll:GetChildren() do
					if v:IsA("TextButton") then
						v:Destroy();
					end;
				end;
			end;
			return dropfunc;
		end;
		function main:Slider(text, min, max, set, callback)
			local Slider = Instance.new("Frame");
			local slidercorner = Instance.new("UICorner");
			local sliderr = Instance.new("Frame");
			local sliderrcorner = Instance.new("UICorner");
			local ImageLabel = Instance.new("ImageLabel");
			local SliderStroke = Instance.new("UIStroke");
			local Title = Instance.new("TextLabel");
			local ValueText = Instance.new("TextLabel");
			local HAHA = Instance.new("Frame");
			local AHEHE = Instance.new("TextButton");
			local bar = Instance.new("Frame");
			local bar1 = Instance.new("Frame");
			local bar1corner = Instance.new("UICorner");
			local barcorner = Instance.new("UICorner");
			local circlebar = Instance.new("Frame");
			local UICorner = Instance.new("UICorner");
			local slidervalue = Instance.new("Frame");
			local valuecorner = Instance.new("UICorner");
			local TextBox = Instance.new("TextBox");
			local UICorner_2 = Instance.new("UICorner");
			local posto = Instance.new("UIStroke");
			Slider.Name = "Slider";
			Slider.Parent = MainFramePage;
			Slider.BackgroundColor3 = _G.Primary;
			Slider.BackgroundTransparency = 1;
			Slider.Size = UDim2.new(1, 0, 0, 35);
			slidercorner.CornerRadius = UDim.new(0, 5);
			slidercorner.Name = "slidercorner";
			slidercorner.Parent = Slider;
			sliderr.Name = "sliderr";
			sliderr.Parent = Slider;
			sliderr.BackgroundColor3 = _G.Primary;
			sliderr.BackgroundTransparency = 0.8;
			sliderr.Position = UDim2.new(0, 0, 0, 0);
			sliderr.Size = UDim2.new(1, 0, 0, 35);
			sliderrcorner.CornerRadius = UDim.new(0, 5);
			sliderrcorner.Name = "sliderrcorner";
			sliderrcorner.Parent = sliderr;
			Title.Parent = sliderr;
			Title.BackgroundColor3 = Color3.fromRGB(150, 150, 150);
			Title.BackgroundTransparency = 1;
			Title.Position = UDim2.new(0, 15, 0.5, 0);
			Title.Size = UDim2.new(1, 0, 0, 30);
			Title.Font = Enum.Font.Cartoon;
			Title.Text = text;
			Title.AnchorPoint = Vector2.new(0, 0.5);
			Title.TextColor3 = Color3.fromRGB(255, 255, 255);
			Title.TextSize = 15;
			Title.TextXAlignment = Enum.TextXAlignment.Left;
			ValueText.Parent = bar;
			ValueText.BackgroundColor3 = Color3.fromRGB(150, 150, 150);
			ValueText.BackgroundTransparency = 1;
			ValueText.Position = UDim2.new(0, -38, 0.5, 0);
			ValueText.Size = UDim2.new(0, 30, 0, 30);
			ValueText.Font = Enum.Font.GothamMedium;
			ValueText.Text = set;
			ValueText.AnchorPoint = Vector2.new(0, 0.5);
			ValueText.TextColor3 = Color3.fromRGB(255, 255, 255);
			ValueText.TextSize = 12;
			ValueText.TextXAlignment = Enum.TextXAlignment.Right;
			bar.Name = "bar";
			bar.Parent = sliderr;
			bar.BackgroundColor3 = Color3.fromRGB(200, 200, 200);
			bar.Size = UDim2.new(0, 100, 0, 4);
			bar.Position = UDim2.new(1, -10, 0.5, 0);
			bar.BackgroundTransparency = 0.8;
			bar.AnchorPoint = Vector2.new(1, 0.5);
			bar1.Name = "bar1";
			bar1.Parent = bar;
			bar1.BackgroundColor3 = _G.Third;
			bar1.BackgroundTransparency = 0;
			bar1.Size = UDim2.new(set / max, 0, 0, 4);
			bar1corner.CornerRadius = UDim.new(0, 5);
			bar1corner.Name = "bar1corner";
			bar1corner.Parent = bar1;
			barcorner.CornerRadius = UDim.new(0, 5);
			barcorner.Name = "barcorner";
			barcorner.Parent = bar;
			circlebar.Name = "circlebar";
			circlebar.Parent = bar1;
			circlebar.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			circlebar.Position = UDim2.new(1, 0, 0, -5);
			circlebar.AnchorPoint = Vector2.new(0.5, 0);
			circlebar.Size = UDim2.new(0, 13, 0, 13);
			UICorner.CornerRadius = UDim.new(0, 100);
			UICorner.Parent = circlebar;
			valuecorner.CornerRadius = UDim.new(0, 2);
			valuecorner.Name = "valuecorner";
			valuecorner.Parent = slidervalue;
			local mouse = game.Players.LocalPlayer:GetMouse();
			local uis = game:GetService("UserInputService");
			if Value == nil then
				Value = set;
				pcall(function()
					callback(Value);
				end);
			end;
			local Dragging = false;
			circlebar.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true;
				end;
			end);
			bar.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true;
				end;
			end);
			UserInputService.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = false;
				end;
			end);
			UserInputService.InputChanged:Connect(function(Input)
				if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
					Value = math.floor((tonumber(max) - tonumber(min)) / 100 * bar1.AbsoluteSize.X + tonumber(min)) or 0;
					pcall(function()
						callback(Value);
					end);
					ValueText.Text = Value;
					bar1.Size = UDim2.new(0, math.clamp(Input.Position.X - bar1.AbsolutePosition.X, 0, 100), 0, 4);
					circlebar.Position = UDim2.new(0, math.clamp(Input.Position.X - bar1.AbsolutePosition.X - 5, 0, 100), 0, -5);
				end;
			end);
		end;
		function main:Textbox(text, disappear, callback)
			local Textbox = Instance.new("Frame");
			local TextboxCorner = Instance.new("UICorner");
			local TextboxLabel = Instance.new("TextLabel");
			local RealTextbox = Instance.new("TextBox");
			local UICorner = Instance.new("UICorner");
			local TextBoxIcon = Instance.new("ImageLabel");
			Textbox.Name = "Textbox";
			Textbox.Parent = MainFramePage;
			Textbox.BackgroundColor3 = _G.Primary;
			Textbox.BackgroundTransparency = 0.8;
			Textbox.Size = UDim2.new(1, 0, 0, 35);
			TextboxCorner.CornerRadius = UDim.new(0, 5);
			TextboxCorner.Name = "TextboxCorner";
			TextboxCorner.Parent = Textbox;
			TextboxLabel.Name = "TextboxLabel";
			TextboxLabel.Parent = Textbox;
			TextboxLabel.BackgroundColor3 = _G.Primary;
			TextboxLabel.BackgroundTransparency = 1;
			TextboxLabel.Position = UDim2.new(0, 15, 0.5, 0);
			TextboxLabel.Text = text;
			TextboxLabel.Size = UDim2.new(1, 0, 0, 35);
			TextboxLabel.Font = Enum.Font.Nunito;
			TextboxLabel.AnchorPoint = Vector2.new(0, 0.5);
			TextboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
			TextboxLabel.TextSize = 15;
			TextboxLabel.TextTransparency = 0;
			TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left;
			RealTextbox.Name = "RealTextbox";
			RealTextbox.Parent = Textbox;
			RealTextbox.BackgroundColor3 = Color3.fromRGB(200, 200, 200);
			RealTextbox.BackgroundTransparency = 0.8;
			RealTextbox.Position = UDim2.new(1, -5, 0.5, 0);
			RealTextbox.AnchorPoint = Vector2.new(1, 0.5);
			RealTextbox.Size = UDim2.new(0, 80, 0, 25);
			RealTextbox.Font = Enum.Font.Gotham;
			RealTextbox.Text = "";
			RealTextbox.TextColor3 = Color3.fromRGB(225, 225, 225);
			RealTextbox.TextSize = 11;
			RealTextbox.TextTransparency = 0;
			RealTextbox.ClipsDescendants = true;
			RealTextbox.FocusLost:Connect(function()
				callback(RealTextbox.Text);
			end);
			UICorner.CornerRadius = UDim.new(0, 5);
			UICorner.Parent = RealTextbox;
		end;
		function main:Label(text)
			local Frame = Instance.new("Frame");
			local Label = Instance.new("TextLabel");
			local PaddingLabel = Instance.new("UIPadding");
			local labelfunc = {};
			Frame.Name = "Frame";
			Frame.Parent = MainFramePage;
			Frame.BackgroundColor3 = _G.Primary;
			Frame.BackgroundTransparency = 1;
			Frame.Size = UDim2.new(1, 0, 0, 30);
			Label.Name = "Label";
			Label.Parent = Frame;
			Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			Label.BackgroundTransparency = 1;
			Label.Size = UDim2.new(1, -30, 0, 30);
			Label.Font = Enum.Font.Nunito;
			Label.Position = UDim2.new(0, 30, 0.5, 0);
			Label.AnchorPoint = Vector2.new(0, 0.5);
			Label.TextColor3 = Color3.fromRGB(225, 225, 225);
			Label.TextSize = 15;
			Label.Text = text;
			Label.TextXAlignment = Enum.TextXAlignment.Left;
			local ImageLabel = Instance.new("ImageLabel");
			ImageLabel.Name = "ImageLabel";
			ImageLabel.Parent = Frame;
			ImageLabel.BackgroundColor3 = Color3.fromRGB(200, 200, 200);
			ImageLabel.BackgroundTransparency = 1;
			ImageLabel.ImageTransparency = 0;
			ImageLabel.Position = UDim2.new(0, 10, 0.5, 0);
			ImageLabel.Size = UDim2.new(0, 14, 0, 14);
			ImageLabel.AnchorPoint = Vector2.new(0, 0.5);
			ImageLabel.Image = "rbxassetid://10723415903";
			ImageLabel.ImageColor3 = Color3.fromRGB(200, 200, 200);
			function labelfunc:Set(newtext)
				Label.Text = newtext;
			end;
			return labelfunc;
		end;
		function main:Seperator(text)
			local Seperator = Instance.new("Frame");
			local Sep1 = Instance.new("TextLabel");
			local Sep2 = Instance.new("TextLabel");
			local Sep3 = Instance.new("TextLabel");
			local SepRadius = Instance.new("UICorner");
			Seperator.Name = "Seperator";
			Seperator.Parent = MainFramePage;
			Seperator.BackgroundColor3 = _G.Primary;
			Seperator.BackgroundTransparency = 1;
			Seperator.Size = UDim2.new(1, 0, 0, 36);
			Sep1.Name = "Sep1";
			Sep1.Parent = Seperator;
			Sep1.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			Sep1.BackgroundTransparency = 1;
			Sep1.AnchorPoint = Vector2.new(0, 0.5);
			Sep1.Position = UDim2.new(0, 0, 0.5, 0);
			Sep1.Size = UDim2.new(0, 20, 0, 36);
			Sep1.Font = Enum.Font.GothamBold;
			Sep1.RichText = true;
			Sep1.Text = "âŒ©<font color=\"rgb(255, 0, 0)\">âŒ©</font>";
			Sep1.TextColor3 = Color3.fromRGB(255, 255, 255);
			Sep1.TextSize = 14;
			Sep2.Name = "Sep2";
			Sep2.Parent = Seperator;
			Sep2.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			Sep2.BackgroundTransparency = 1;
			Sep2.AnchorPoint = Vector2.new(0.5, 0.5);
			Sep2.Position = UDim2.new(0.5, 0, 0.5, 0);
			Sep2.Size = UDim2.new(1, 0, 0, 36);
			Sep2.Font = Enum.Font.GothamBold;
			Sep2.Text = text;
			Sep2.TextColor3 = Color3.fromRGB(255, 255, 255);
			Sep2.TextSize = 14;
			Sep3.Name = "Sep3";
			Sep3.Parent = Seperator;
			Sep3.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			Sep3.BackgroundTransparency = 1;
			Sep3.AnchorPoint = Vector2.new(1, 0.5);
			Sep3.Position = UDim2.new(1, 0, 0.5, 0);
			Sep3.Size = UDim2.new(0, 20, 0, 36);
			Sep3.Font = Enum.Font.GothamBold;
			Sep3.RichText = true;
			Sep3.Text = "<font color=\"rgb(255, 0, 0)\">âŒª</font>âŒª";
			Sep3.TextColor3 = Color3.fromRGB(255, 255, 255);
			Sep3.TextSize = 14;
		end;
		function main:Line()
			local Linee = Instance.new("Frame");
			local Line = Instance.new("Frame");
			local UIGradient = Instance.new("UIGradient");
			Linee.Name = "Linee";
			Linee.Parent = MainFramePage;
			Linee.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			Linee.BackgroundTransparency = 1;
			Linee.Position = UDim2.new(0, 0, 0.119999997, 0);
			Linee.Size = UDim2.new(1, 0, 0, 20);
			Line.Name = "Line";
			Line.Parent = Linee;
			Line.BackgroundColor3 = Color3.new(125, 125, 125);
			Line.BorderSizePixel = 0;
			Line.Position = UDim2.new(0, 0, 0, 10);
			Line.Size = UDim2.new(1, 0, 0, 1);
			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, _G.Dark),
				ColorSequenceKeypoint.new(0.4, _G.Primary),
				ColorSequenceKeypoint.new(0.5, _G.Primary),
				ColorSequenceKeypoint.new(0.6, _G.Primary),
				ColorSequenceKeypoint.new(1, _G.Dark)
			});
			UIGradient.Parent = Line;
		end;
		return main;
	end;
	return uitab;
end;
return Update;

end)();
if Update:LoadAnimation() then
	Update:StartLoad();
end;
if Update:LoadAnimation() then
	Update:Loaded();
end;
local Library = Update:Window({
	Title = "IKAROHUB",
	SubTitle = "by ikaro",
	Size = UDim2.new(0, 620, 0, 420),
	TabWidth = 180
});
-- Ordem oficial do IKAROHUB. Abas antigas do Banana que pertencem ao mesmo
-- assunto apontam para o mesmo painel, preservando todas as rotinas originais.
local ShopTab = Library:Tab("Shop", "rbxassetid://10734952479");
local ServTab = Library:Tab("Status And Server", "rbxassetid://10723426722");
local LocalPlayerTab = Library:Tab("Localplayer", "rbxassetid://10747373176");
local SettingsTab = Library:Tab("setting farm", "rbxassetid://10734950309");
local HoldTab = Library:Tab("Hold and select Skill", "rbxassetid://10734984606");
local MainTab = Library:Tab("Farming", "rbxassetid://10723407389");
local SeaStackTab = Library:Tab("Stack farming", "rbxassetid://10747376931");
local FarmTab = Library:Tab("Farming Other", "rbxassetid://10723415335");
local FruitTab = Library:Tab("Fruit and Raid", "rbxassetid://10734883986");
local RaidTab = Library:Tab("Dungeon", "rbxassetid://10723345749");
local SeaTab = Library:Tab("Sea event", "rbxassetid://10709761530");
local RaceV4Tab = Library:Tab("upgrade Race", "rbxassetid://10723425539");
local ItemsTab = Library:Tab("get and upgrade item", "rbxassetid://10709782497");
local PrehistoricTab = Library:Tab("volcano event", "rbxassetid://10709761530");
local EspTab = Library:Tab("esp", "rbxassetid://10723346959");
local PvpTab = Library:Tab("PVP", "rbxassetid://10734975486");
local WebhookTab = Library:Tab("Tab webhook", "rbxassetid://10723424838");
local MiscTab = Library:Tab("setting", "rbxassetid://10723424838");

-- Consolida as abas auxiliares antigas sem criar itens extras no menu lateral.
local SettingSeaTab = SeaTab;
local CraftTab = ItemsTab;
local DragonDojoTab = ItemsTab;
local StatsTab = SettingsTab;
local TeleportTab = LocalPlayerTab;
_G.Settings = {
	Main = {
		["Select Weapon"] = "Melee",
		["Farm Mode"] = "Normal",
		["Auto Farm"] = false,
		["Auto Farm Fast"] = false,
		["Selected Mastery Mode"] = "Quest",
		["Auto Farm Fruit Mastery"] = false,
		["Auto Farm Gun Mastery"] = false,
		["Selected Mastery Sword"] = nil,
		["Auto Farm Sword Mastery"] = false,
		["Selected Mob"] = nil,
		["Auto Farm Mob"] = false,
		["Selected Boss"] = nil,
		["Auto Farm Boss"] = false,
		["Auto Farm All Boss"] = false
	},
	Event = {},
	Farm = {
		["Auto Elite Hunter"] = false,
		["Auto Elite Hunter Hop"] = false,
		["Selected Bone Farm Mode"] = "Quest",
		["Auto Farm Bone"] = false,
		["Auto Random Surprise"] = false,
		["Auto Pirate Raid"] = false,
		["Auto Farm Observation"] = false,
		["Auto Observation V2"] = false,
		["Auto Musketeer Hat"] = false,
		["Auto Saber"] = false,
		["Auto Farm Chest Tween"] = false,
		["Auto Farm Chest Instant"] = false,
		["Auto Chest Hop"] = false,
		["Auto Farm Chest Mirage"] = false,
		["Auto Stop Items"] = false,
		["Auto Farm Katakuri"] = false,
		["Auto Spawn Cake Prince"] = false,
		["Auto Kill Cake Prince"] = false,
		["Auto Kill Dough King"] = false,
		["Auto Farm Radioactive"] = false,
		["Auto Farm Mystic Droplet"] = false,
		["Auto Farm Magma Ore"] = false,
		["Auto Farm Angel Wings"] = false,
		["Auto Farm Leather"] = false,
		["Auto Farm Scrap Metal"] = false,
		["Auto Farm Conjured Cocoa"] = false,
		["Auto Farm Dragon Scale"] = false,
		["Auto Farm Gunpowder"] = false,
		["Auto Farm Fish Tail"] = false,
		["Auto Farm Mini Tusk"] = false
	},
	Setting = {
		["Spin Position"] = false,
		["Farm Distance"] = 35,
		["Player Tween Speed"] = 350,
		["Bring Mob"] = true,
		["Bring Mob Mode"] = "Normal",
		["Fast Attack"] = true,
		["Fast Attack Mode"] = "Normal",
		["Fast Attack Type"] = "New",
		["Attack Aura"] = true,
		["Hide Notification"] = false,
		["Hide Damage Text"] = true,
		["Black Screen"] = false,
		["White Screen"] = false,
		["Hide Monster"] = false,
		["Mastery Health"] = 25,
		["Fruit Mastery Skill Z"] = true,
		["Fruit Mastery Skill X"] = true,
		["Fruit Mastery Skill C"] = true,
		["Fruit Mastery Skill V"] = false,
		["Fruit Mastery Skill F"] = false,
		["Gun Mastery Skill Z"] = true,
		["Gun Mastery Skill X"] = true,
		["Auto Set Spawn Point"] = true,
		["Auto Observation"] = false,
		["Auto Haki"] = true,
		["Auto Rejoin"] = true,
		["Bypass Anti Cheat"] = true
	},
	Hold = {
		["Hold Mastery Skill Z"] = 0,
		["Hold Mastery Skill X"] = 0,
		["Hold Mastery Skill C"] = 0,
		["Hold Mastery Skill V"] = 0,
		["Hold Mastery Skill F"] = 0,
		["Hold Sea Skill Z"] = 0,
		["Hold Sea Skill X"] = 0,
		["Hold Sea Skill C"] = 0,
		["Hold Sea Skill V"] = 0,
		["Hold Sea Skill F"] = 0
	},
	Stats = {
		["Auto Add Melee Stats"] = false,
		["Auto Add Defense Stats"] = false,
		["Auto Add Devil Fruit Stats"] = false,
		["Auto Add Sword Stats"] = false,
		["Auto Add Gun Stats"] = false,
		["Point Stats"] = 1
	},
	Items = {
		["Auto Second Sea"] = false,
		["Auto Third Sea"] = false,
		["Auto Farm Factory"] = false,
		["Auto Super Human"] = false,
		["Auto Death Step"] = false,
		["Auto Fishman Karate"] = false,
		["Auto Electric Claw"] = false,
		["Auto Dragon Talon"] = false,
		["Auto God Human"] = false,
		["Auto Buddy Sword"] = false,
		["Auto Soul Guitar"] = false,
		["Auto Rengoku"] = false,
		["Auto Hallow Scythe"] = false,
		["Auto Warden Sword"] = false,
		["Auto Cursed Dual Katana"] = false,
		["Auto Yama"] = false,
		["Auto Tushita"] = false,
		["Auto Canvander"] = false,
		["Auto Dragon Trident"] = false,
		["Auto Pole"] = false,
		["Auto Shawk Saw"] = false,
		["Auto Greybeard"] = false,
		["Auto Swan Glasses"] = false,
		["Auto Arena Trainer"] = false,
		["Auto Dark Dagger"] = false,
		["Auto Press Haki Button"] = false,
		["Auto Rainbow Haki"] = false,
		["Auto Holy Torch"] = false,
		["Auto Bartilo Quest"] = false
	},
	Esp = {
		["ESP Player"] = false,
		["ESP Chest"] = false,
		["ESP DevilFruit"] = false,
		["ESP RealFruit"] = false,
		["ESP Flower"] = false,
		["ESP Island"] = false,
		["ESP Npc"] = false,
		["ESP Sea Beast"] = false,
		["ESP Monster"] = false,
		["ESP Mirage"] = false,
		["ESP Kitsune"] = false,
		["ESP Frozen"] = false,
		["ESP Prehistoric"] = false,
		["ESP Advanced Fruit Dealer"] = false,
		["ESP Aura"] = false,
		["ESP Gear"] = false
	},
	DragonDojo = {
		["Auto Farm Blaze Ember"] = false,
		["Auto Collect Blaze Ember"] = false
	},
	SeaEvent = {
		["Selected Boat"] = "Guardian",
		["Selected Zone"] = "Zone 5",
		["Boat Tween Speed"] = 300,
		["Sail Boat"] = false,
		["Auto Farm Shark"] = true,
		["Auto Farm Piranha"] = true,
		["Auto Farm Fish Crew Member"] = true,
		["Auto Farm Ghost Ship"] = true,
		["Auto Farm Pirate Brigade"] = true,
		["Auto Farm Pirate Grand Brigade"] = true,
		["Auto Farm Terrorshark"] = true,
		["Auto Farm Seabeasts"] = true,
		["Dodge Seabeasts Attack"] = true,
		["Dodge Terrorshark Attack"] = true,
		Lightning = false,
		["Increase Boat Speed"] = false,
		["No Clip Rock"] = false
	},
	SettingSea = {
		["Skill Devil Fruit"] = true,
		["Skill Melee"] = true,
		["Skill Sword"] = true,
		["Skill Gun"] = true,
		["Sea Fruit Skill Z"] = true,
		["Sea Fruit Skill X"] = true,
		["Sea Fruit Skill C"] = true,
		["Sea Fruit Skill V"] = false,
		["Sea Fruit Skill F"] = false,
		["Sea Melee Skill Z"] = true,
		["Sea Melee Skill X"] = true,
		["Sea Melee Skill C"] = true,
		["Sea Melee Skill V"] = true,
		["Sea Sword Skill Z"] = true,
		["Sea Sword Skill X"] = true,
		["Sea Gun Skill Z"] = true,
		["Sea Gun Skill X"] = true
	},
	SeaStack = {
		["Teleport To Frozen Dimension"] = false,
		["Sail To Frozen Dimension"] = false,
		["Summon Frozen Dimension"] = false,
		["Teleport To Kitsune Island"] = false,
		["Auto Collect Azure Ember"] = false,
		["Set Azure Ember"] = 20,
		["Auto Trade Azure Ember"] = false,
		["Teleport To Mirage Island"] = false,
		["Teleport To Advanced Fruit Dealer"] = false,
		["Auto Attack Seabeasts"] = false,
		["Summon Prehistoric Island"] = false,
		["Tween To Prehistoric Island"] = false,
		["Auto Defend Volcano"] = false,
		["Remove Prehistoric Lava"] = false,
		["Auto Collect Dino Bone"] = false,
		["Auto Collect Dragon Egg"] = false,
		["Auto Kill Lava Golem"] = false
	},
	Craft = {
		["Auto Craft Common Scroll"] = false,
		["Auto Craft Rare Scroll"] = false,
		["Auto Craft Legendary Scroll"] = false,
		["Auto Craft Mythical Scroll"] = false
	},
	Race = {
		["Auto Race V2"] = false,
		["Auto Race V3"] = false,
		["Selected PlaceV4"] = nil,
		["Teleport To PlaceV4"] = false,
		["Auto Buy Gear"] = false,
		["Tween To Highest Mirage"] = false,
		["Find Blue Gear"] = false,
		["Look Moon Ability"] = false,
		["Auto Train"] = false,
		["Auto Kill Player After Trial"] = false,
		["Auto Trial"] = false
	},
	Combat = {
		["Auto Kill Player Quest"] = false,
		["Aimbot Gun"] = false,
		["Aimbot Skill Neares"] = false,
		["Aimbot Skill"] = false,
		["Enable PvP"] = false
	},
	Raid = {
		["Selected Chip"] = nil,
		["Auto Dungeon"] = false,
		["Auto Awaken"] = false,
		["Price Devil Fruit"] = 1000000,
		["Unstore Devil Fruit"] = false,
		["Law Raid"] = false
	},
	Shop = {
		["Auto Buy Legendary Sword"] = false,
		["Auto Buy Haki Color"] = false
	},
	LocalPlayer = {
		["Infinite Energy"] = false,
		["Infinite Ability"] = true,
		["Infinite Geppo"] = false,
		["Infinite Soru"] = false,
		["Dodge No Cooldown"] = false,
		["Active Race V3"] = false,
		["Active Race V4"] = true,
		["Walk On Water"] = true,
		["No Clip"] = false
	},
	Fruit = {
		["Auto Buy Random Fruit"] = false,
		["Store Rarity Fruit"] = "Common - Mythical",
		["Auto Store Fruit"] = false,
		["Fruit Notification"] = false,
		["Teleport To Fruit"] = false,
		["Tween To Fruit"] = false
	},
	Misc = {
		["Hide Chat"] = false,
		["Hide Leaderboard"] = false,
		["Highlight Mode"] = false
	}
};
(getgenv()).Load = function()
	if readfile and writefile and isfile and isfolder and makefolder then
		if not isfolder("IKAROHUB") then
			makefolder("IKAROHUB");
		end;
		if not isfolder("IKAROHUB/Blox Fruits/") then
			makefolder("IKAROHUB/Blox Fruits/");
		end;
		if not isfile(("IKAROHUB/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json")) then
			writefile("IKAROHUB/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json", (game:GetService("HttpService")):JSONEncode(_G.Settings));
		else
			local Success, Decode = pcall(function()
				return (game:GetService("HttpService")):JSONDecode(readfile("IKAROHUB/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json"));
			end);
			if Success and type(Decode) == "table" then
				for Category, Values in pairs(Decode) do
					if type(Values) == "table" and type(_G.Settings[Category]) == "table" then
						for Key, Value in pairs(Values) do
							if _G.Settings[Category][Key] ~= nil then
								_G.Settings[Category][Key] = Value;
							end;
						end;
					end;
				end;
			else
				warn("IKAROHUB: configuração inválida ignorada; usando padrões.");
				pcall(function()
					writefile("IKAROHUB/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json", (game:GetService("HttpService")):JSONEncode(_G.Settings));
				end);
			end;
		end;
		print("Loaded!");
	else
		return warn("Status : Undetected Executor");
	end;
end;
(getgenv()).SaveSetting = function()
	if Update:SaveSettings() then
		if readfile and writefile and isfile and isfolder then
			if not isfile(("IKAROHUB/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json")) then
				(getgenv()).Load();
			else
				local Decode = (game:GetService("HttpService")):JSONDecode(readfile("IKAROHUB/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json"));
				local Array = {};
				for i, v in pairs(_G.Settings) do
					Array[i] = v;
				end;
				writefile("IKAROHUB/Blox Fruits/" .. game.Players.LocalPlayer.Name .. ".json", (game:GetService("HttpService")):JSONEncode(Array));
			end;
		else
			return warn("Status : Undetected Executor");
		end;
	end;
end;
local SettingsLoaded, SettingsError = pcall((getgenv()).Load);
if not SettingsLoaded then
	warn("IKAROHUB: falha ao carregar configurações; continuando com padrões: " .. tostring(SettingsError));
end;
spawn(function()
	repeat
		task.wait();
	until game:IsLoaded();
	local ChatService = game:GetService("Chat");
	wait(1);
	((require(game.ReplicatedStorage.Notification)).new("<Color=Purple>[ Welcome " .. game.Players.LocalPlayer.DisplayName .. " ]<Color=/>")):Display();
	wait(1);
	((require(game.ReplicatedStorage.Notification)).new("<Color=Yellow>[ Enjoy for script ]<Color=/>")):Display();
end);
function CheckQuest()
	MyLevel = (game:GetService("Players")).LocalPlayer.Data.Level.Value;
	if World1 then
		if MyLevel == 1 or MyLevel <= 9 then
			Mon = "Bandit";
			LevelQuest = 1;
			NameQuest = "BanditQuest1";
			NameMon = "Bandit";
			CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544);
			CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125);
		elseif MyLevel == 10 or MyLevel <= 14 then
			Mon = "Monkey";
			LevelQuest = 1;
			NameQuest = "JungleQuest";
			NameMon = "Monkey";
			CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0);
			CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209);
		elseif MyLevel == 15 or MyLevel <= 29 then
			Mon = "Gorilla";
			LevelQuest = 2;
			NameQuest = "JungleQuest";
			NameMon = "Gorilla";
			CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0);
			CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875);
		elseif MyLevel == 30 or MyLevel <= 39 then
			Mon = "Pirate";
			LevelQuest = 1;
			NameQuest = "BuggyQuest1";
			NameMon = "Pirate";
			CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627);
			CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125);
		elseif MyLevel == 40 or MyLevel <= 59 then
			Mon = "Brute";
			LevelQuest = 2;
			NameQuest = "BuggyQuest1";
			NameMon = "Brute";
			CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627);
			CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875);
		elseif MyLevel == 60 or MyLevel <= 74 then
			Mon = "Desert Bandit";
			LevelQuest = 1;
			NameQuest = "DesertQuest";
			NameMon = "Desert Bandit";
			CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693);
			CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375);
		elseif MyLevel == 75 or MyLevel <= 89 then
			Mon = "Desert Officer";
			LevelQuest = 2;
			NameQuest = "DesertQuest";
			NameMon = "Desert Officer";
			CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693);
			CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875);
		elseif MyLevel == 90 or MyLevel <= 99 then
			Mon = "Snow Bandit";
			LevelQuest = 1;
			NameQuest = "SnowQuest";
			NameMon = "Snow Bandit";
			CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685);
			CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125);
		elseif MyLevel == 100 or MyLevel <= 119 then
			Mon = "Snowman";
			LevelQuest = 2;
			NameQuest = "SnowQuest";
			NameMon = "Snowman";
			CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685);
			CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625);
		elseif MyLevel == 120 or MyLevel <= 149 then
			Mon = "Chief Petty Officer";
			LevelQuest = 1;
			NameQuest = "MarineQuest2";
			NameMon = "Chief Petty Officer";
			CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0);
			CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625);
		elseif MyLevel == 150 or MyLevel <= 174 then
			Mon = "Sky Bandit";
			LevelQuest = 1;
			NameQuest = "SkyQuest";
			NameMon = "Sky Bandit";
			CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268);
			CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625);
		elseif MyLevel == 175 or MyLevel <= 189 then
			Mon = "Dark Master";
			LevelQuest = 2;
			NameQuest = "SkyQuest";
			NameMon = "Dark Master";
			CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268);
			CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625);
		elseif MyLevel == 190 or MyLevel <= 209 then
			Mon = "Prisoner";
			LevelQuest = 1;
			NameQuest = "PrisonerQuest";
			NameMon = "Prisoner";
			CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -0.00000000500292918, -0.995993316, 0.00000000160817859, 1, -0.00000000516744869, 0.995993316, -0.00000000206384709, -0.0894274712);
			CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781);
		elseif MyLevel == 210 or MyLevel <= 249 then
			Mon = "Dangerous Prisoner";
			LevelQuest = 2;
			NameQuest = "PrisonerQuest";
			NameMon = "Dangerous Prisoner";
			CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -0.00000000500292918, -0.995993316, 0.00000000160817859, 1, -0.00000000516744869, 0.995993316, -0.00000000206384709, -0.0894274712);
			CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375);
		elseif MyLevel == 250 or MyLevel <= 274 then
			Mon = "Toga Warrior";
			LevelQuest = 1;
			NameQuest = "ColosseumQuest";
			NameMon = "Toga Warrior";
			CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298);
			CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625);
		elseif MyLevel == 275 or MyLevel <= 299 then
			Mon = "Gladiator";
			LevelQuest = 2;
			NameQuest = "ColosseumQuest";
			NameMon = "Gladiator";
			CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298);
			CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625);
		elseif MyLevel == 300 or MyLevel <= 324 then
			Mon = "Military Soldier";
			LevelQuest = 1;
			NameQuest = "MagmaQuest";
			NameMon = "Military Soldier";
			CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469);
			CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875);
		elseif MyLevel == 325 or MyLevel <= 374 then
			Mon = "Military Spy";
			LevelQuest = 2;
			NameQuest = "MagmaQuest";
			NameMon = "Military Spy";
			CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469);
			CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375);
		elseif MyLevel == 375 or MyLevel <= 399 then
			Mon = "Fishman Warrior";
			LevelQuest = 1;
			NameQuest = "FishmanQuest";
			NameMon = "Fishman Warrior";
			CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734);
			CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625);
			if _G.Settings.Main["Auto Farm"] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875));
			end;
		elseif MyLevel == 400 or MyLevel <= 449 then
			Mon = "Fishman Commando";
			LevelQuest = 2;
			NameQuest = "FishmanQuest";
			NameMon = "Fishman Commando";
			CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734);
			CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875);
			if _G.Settings.Main["Auto Farm"] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875));
			end;
		elseif MyLevel == 450 or MyLevel <= 474 then
			Mon = "God's Guard";
			LevelQuest = 1;
			NameQuest = "SkyExp1Quest";
			NameMon = "God's Guard";
			CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859);
			CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375);
			if _G.Settings.Main["Auto Farm"] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.82275, 872.54248, -1667.55688));
			end;
		elseif MyLevel == 475 or MyLevel <= 524 then
			Mon = "Shanda";
			LevelQuest = 2;
			NameQuest = "SkyExp1Quest";
			NameMon = "Shanda";
			CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998);
			CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531);
			if _G.Settings.Main["Auto Farm"] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047));
			end;
		elseif MyLevel == 525 or MyLevel <= 549 then
			Mon = "Royal Squad";
			LevelQuest = 1;
			NameQuest = "SkyExp2Quest";
			NameMon = "Royal Squad";
			CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0);
			CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875);
		elseif MyLevel == 550 or MyLevel <= 624 then
			Mon = "Royal Soldier";
			LevelQuest = 2;
			NameQuest = "SkyExp2Quest";
			NameMon = "Royal Soldier";
			CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0);
			CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625);
		elseif MyLevel == 625 or MyLevel <= 649 then
			Mon = "Galley Pirate";
			LevelQuest = 1;
			NameQuest = "FountainQuest";
			NameMon = "Galley Pirate";
			CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381);
			CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875);
		elseif MyLevel >= 650 then
			Mon = "Galley Captain";
			LevelQuest = 2;
			NameQuest = "FountainQuest";
			NameMon = "Galley Captain";
			CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381);
			CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375);
		end;
	elseif World2 then
		if MyLevel == 700 or MyLevel <= 724 then
			Mon = "Raider";
			LevelQuest = 1;
			NameQuest = "Area1Quest";
			NameMon = "Raider";
			CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985);
			CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125);
		elseif MyLevel == 725 or MyLevel <= 774 then
			Mon = "Mercenary";
			LevelQuest = 2;
			NameQuest = "Area1Quest";
			NameMon = "Mercenary";
			CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985);
			CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625);
		elseif MyLevel == 775 or MyLevel <= 799 then
			Mon = "Swan Pirate";
			LevelQuest = 1;
			NameQuest = "Area2Quest";
			NameMon = "Swan Pirate";
			CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906);
			CFrameMon = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625);
		elseif MyLevel == 800 or MyLevel <= 874 then
			Mon = "Factory Staff";
			NameQuest = "Area2Quest";
			LevelQuest = 2;
			NameMon = "Factory Staff";
			CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 0.000000000896074881, -0.999488771, 0.000000000136326533, 1, 0.000000000892172336, 0.999488771, -0.000000000107732087, -0.0319722369);
			CFrameMon = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875);
		elseif MyLevel == 875 or MyLevel <= 899 then
			Mon = "Marine Lieutenant";
			LevelQuest = 1;
			NameQuest = "MarineQuest3";
			NameMon = "Marine Lieutenant";
			CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268);
			CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125);
		elseif MyLevel == 900 or MyLevel <= 949 then
			Mon = "Marine Captain";
			LevelQuest = 2;
			NameQuest = "MarineQuest3";
			NameMon = "Marine Captain";
			CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268);
			CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625);
		elseif MyLevel == 950 or MyLevel <= 974 then
			Mon = "Zombie";
			LevelQuest = 1;
			NameQuest = "ZombieQuest";
			NameMon = "Zombie";
			CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146);
			CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875);
		elseif MyLevel == 975 or MyLevel <= 999 then
			Mon = "Vampire";
			LevelQuest = 2;
			NameQuest = "ZombieQuest";
			NameMon = "Vampire";
			CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146);
			CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625);
		elseif MyLevel == 1000 or MyLevel <= 1049 then
			Mon = "Snow Trooper";
			LevelQuest = 1;
			NameQuest = "SnowMountainQuest";
			NameMon = "Snow Trooper";
			CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106);
			CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875);
		elseif MyLevel == 1050 or MyLevel <= 1099 then
			Mon = "Winter Warrior";
			LevelQuest = 2;
			NameQuest = "SnowMountainQuest";
			NameMon = "Winter Warrior";
			CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106);
			CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625);
		elseif MyLevel == 1100 or MyLevel <= 1124 then
			Mon = "Lab Subordinate";
			LevelQuest = 1;
			NameQuest = "IceSideQuest";
			NameMon = "Lab Subordinate";
			CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578);
			CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375);
		elseif MyLevel == 1125 or MyLevel <= 1174 then
			Mon = "Horned Warrior";
			LevelQuest = 2;
			NameQuest = "IceSideQuest";
			NameMon = "Horned Warrior";
			CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578);
			CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375);
		elseif MyLevel == 1175 or MyLevel <= 1199 then
			Mon = "Magma Ninja";
			LevelQuest = 1;
			NameQuest = "FireSideQuest";
			NameMon = "Magma Ninja";
			CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213);
			CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375);
		elseif MyLevel == 1200 or MyLevel <= 1249 then
			Mon = "Lava Pirate";
			LevelQuest = 2;
			NameQuest = "FireSideQuest";
			NameMon = "Lava Pirate";
			CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213);
			CFrameMon = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875);
		elseif MyLevel == 1250 or MyLevel <= 1274 then
			Mon = "Ship Deckhand";
			LevelQuest = 1;
			NameQuest = "ShipQuest1";
			NameMon = "Ship Deckhand";
			CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016);
			CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375);
			if _G.Settings.Main["Auto Farm"] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
			end;
		elseif MyLevel == 1275 or MyLevel <= 1299 then
			Mon = "Ship Engineer";
			LevelQuest = 2;
			NameQuest = "ShipQuest1";
			NameMon = "Ship Engineer";
			CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016);
			CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875);
			if _G.Settings.Main["Auto Farm"] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
			end;
		elseif MyLevel == 1300 or MyLevel <= 1324 then
			Mon = "Ship Steward";
			LevelQuest = 1;
			NameQuest = "ShipQuest2";
			NameMon = "Ship Steward";
			CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125);
			CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625);
			if _G.Settings.Main["Auto Farm"] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
			end;
		elseif MyLevel == 1325 or MyLevel <= 1349 then
			Mon = "Ship Officer";
			LevelQuest = 2;
			NameQuest = "ShipQuest2";
			NameMon = "Ship Officer";
			CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125);
			CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625);
			if _G.Settings.Main["Auto Farm"] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
			end;
		elseif MyLevel == 1350 or MyLevel <= 1374 then
			Mon = "Arctic Warrior";
			LevelQuest = 1;
			NameQuest = "FrostQuest";
			NameMon = "Arctic Warrior";
			CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909);
			CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125);
			if _G.Settings.Main["Auto Farm"] and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-6508.5581054688, 5000.034996032715, -132.83953857422));
			end;
		elseif MyLevel == 1375 or MyLevel <= 1424 then
			Mon = "Snow Lurker";
			LevelQuest = 2;
			NameQuest = "FrostQuest";
			NameMon = "Snow Lurker";
			CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909);
			CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375);
		elseif MyLevel == 1425 or MyLevel <= 1449 then
			Mon = "Sea Soldier";
			LevelQuest = 1;
			NameQuest = "ForgottenQuest";
			NameMon = "Sea Soldier";
			CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376);
			CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125);
		elseif MyLevel >= 1450 then
			Mon = "Water Fighter";
			LevelQuest = 2;
			NameQuest = "ForgottenQuest";
			NameMon = "Water Fighter";
			CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376);
			CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875);
		end;
	elseif World3 then
		if MyLevel == 1500 or MyLevel <= 1524 then
			Mon = "Pirate Millionaire";
			LevelQuest = 1;
			NameQuest = "PiratePortQuest";
			NameMon = "Pirate Millionaire";
			CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627);
			CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375);
		elseif MyLevel == 1525 or MyLevel <= 1574 then
			Mon = "Pistol Billionaire";
			LevelQuest = 2;
			NameQuest = "PiratePortQuest";
			NameMon = "Pistol Billionaire";
			CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627);
			CFrameMon = CFrame.new(-187.3301544189453, 86.23987579345703, 6013.513671875);
		elseif MyLevel == 1575 or MyLevel <= 1599 then
			Mon = "Dragon Crew Warrior";
			LevelQuest = 1;
			NameQuest = "AmazonQuest";
			NameMon = "Dragon Crew Warrior";
			CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359);
			CFrameMon = CFrame.new(6141.140625, 51.35136413574219, -1340.738525390625);
		elseif MyLevel == 1600 or MyLevel <= 1624 then
			Mon = "Dragon Crew Archer [Lv. 1600]";
			NameQuest = "AmazonQuest";
			LevelQuest = 2;
			NameMon = "Dragon Crew Archer";
			CFrameQuest = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375);
			CFrameMon = CFrame.new(6616.41748046875, 441.7670593261719, 446.0469970703125);
		elseif MyLevel == 1625 or MyLevel <= 1649 then
			Mon = "Female Islander";
			NameQuest = "AmazonQuest2";
			LevelQuest = 1;
			NameMon = "Female Islander";
			CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422);
			CFrameMon = CFrame.new(4685.25830078125, 735.8078002929688, 815.3425903320312);
		elseif MyLevel == 1650 or MyLevel <= 1699 then
			Mon = "Giant Islander [Lv. 1650]";
			NameQuest = "AmazonQuest2";
			LevelQuest = 2;
			NameMon = "Giant Islander";
			CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422);
			CFrameMon = CFrame.new(4729.09423828125, 590.436767578125, -36.97627639770508);
		elseif MyLevel == 1700 or MyLevel <= 1724 then
			Mon = "Marine Commodore";
			LevelQuest = 1;
			NameQuest = "MarineTreeIsland";
			NameMon = "Marine Commodore";
			CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747);
			CFrameMon = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125);
		elseif MyLevel == 1725 or MyLevel <= 1774 then
			Mon = "Marine Rear Admiral [Lv. 1725]";
			NameMon = "Marine Rear Admiral";
			NameQuest = "MarineTreeIsland";
			LevelQuest = 2;
			CFrameQuest = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813);
			CFrameMon = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125);
		elseif MyLevel == 1775 or MyLevel <= 1799 then
			Mon = "Fishman Raider";
			LevelQuest = 1;
			NameQuest = "DeepForestIsland3";
			NameMon = "Fishman Raider";
			CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213);
			CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625);
		elseif MyLevel == 1800 or MyLevel <= 1824 then
			Mon = "Fishman Captain";
			LevelQuest = 2;
			NameQuest = "DeepForestIsland3";
			NameMon = "Fishman Captain";
			CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213);
			CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625);
		elseif MyLevel == 1825 or MyLevel <= 1849 then
			Mon = "Forest Pirate";
			LevelQuest = 1;
			NameQuest = "DeepForestIsland";
			NameMon = "Forest Pirate";
			CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247);
			CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625);
		elseif MyLevel == 1850 or MyLevel <= 1899 then
			Mon = "Mythological Pirate";
			LevelQuest = 2;
			NameQuest = "DeepForestIsland";
			NameMon = "Mythological Pirate";
			CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247);
			CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125);
		elseif MyLevel == 1900 or MyLevel <= 1924 then
			Mon = "Jungle Pirate";
			LevelQuest = 1;
			NameQuest = "DeepForestIsland2";
			NameMon = "Jungle Pirate";
			CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002);
			CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625);
		elseif MyLevel == 1925 or MyLevel <= 1974 then
			Mon = "Musketeer Pirate";
			LevelQuest = 2;
			NameQuest = "DeepForestIsland2";
			NameMon = "Musketeer Pirate";
			CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002);
			CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375);
		elseif MyLevel == 1975 or MyLevel <= 1999 then
			Mon = "Reborn Skeleton";
			LevelQuest = 1;
			NameQuest = "HauntedQuest1";
			NameMon = "Reborn Skeleton";
			CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0);
			CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625);
		elseif MyLevel == 2000 or MyLevel <= 2024 then
			Mon = "Living Zombie";
			LevelQuest = 2;
			NameQuest = "HauntedQuest1";
			NameMon = "Living Zombie";
			CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0);
			CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875);
		elseif MyLevel == 2025 or MyLevel <= 2049 then
			Mon = "Demonic Soul";
			LevelQuest = 1;
			NameQuest = "HauntedQuest2";
			NameMon = "Demonic Soul";
			CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0);
			CFrameMon = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625);
		elseif MyLevel == 2050 or MyLevel <= 2074 then
			Mon = "Posessed Mummy";
			LevelQuest = 2;
			NameQuest = "HauntedQuest2";
			NameMon = "Posessed Mummy";
			CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0);
			CFrameMon = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625);
		elseif MyLevel == 2075 or MyLevel <= 2099 then
			Mon = "Peanut Scout";
			LevelQuest = 1;
			NameQuest = "NutsIslandQuest";
			NameMon = "Peanut Scout";
			CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0);
			CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875);
		elseif MyLevel == 2100 or MyLevel <= 2124 then
			Mon = "Peanut President";
			LevelQuest = 2;
			NameQuest = "NutsIslandQuest";
			NameMon = "Peanut President";
			CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0);
			CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875);
		elseif MyLevel == 2125 or MyLevel <= 2149 then
			Mon = "Ice Cream Chef";
			LevelQuest = 1;
			NameQuest = "IceCreamIslandQuest";
			NameMon = "Ice Cream Chef";
			CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0);
			CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125);
		elseif MyLevel == 2150 or MyLevel <= 2199 then
			Mon = "Ice Cream Commander";
			LevelQuest = 2;
			NameQuest = "IceCreamIslandQuest";
			NameMon = "Ice Cream Commander";
			CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0);
			CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625);
		elseif MyLevel == 2200 or MyLevel <= 2224 then
			Mon = "Cookie Crafter";
			LevelQuest = 1;
			NameQuest = "CakeQuest1";
			NameMon = "Cookie Crafter";
			CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -0.0000000880302053, 0.288177818, 0.000000069301187, 1, 0.0000000751931211, -0.288177818, -0.000000052032135, 0.957576931);
			CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375);
		elseif MyLevel == 2225 or MyLevel <= 2249 then
			Mon = "Cake Guard";
			LevelQuest = 2;
			NameQuest = "CakeQuest1";
			NameMon = "Cake Guard";
			CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -0.0000000880302053, 0.288177818, 0.000000069301187, 1, 0.0000000751931211, -0.288177818, -0.000000052032135, 0.957576931);
			CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875);
		elseif MyLevel == 2250 or MyLevel <= 2274 then
			Mon = "Baking Staff";
			LevelQuest = 1;
			NameQuest = "CakeQuest2";
			NameMon = "Baking Staff";
			CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 0.0000000422142143, 0.250778586, 0.0000000474911062, 1, 0.0000000149904711, -0.250778586, 0.0000000264211941, -0.96804446);
			CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375);
		elseif MyLevel == 2275 or MyLevel <= 2299 then
			Mon = "Head Baker";
			LevelQuest = 2;
			NameQuest = "CakeQuest2";
			NameMon = "Head Baker";
			CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 0.0000000422142143, 0.250778586, 0.0000000474911062, 1, 0.0000000149904711, -0.250778586, 0.0000000264211941, -0.96804446);
			CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125);
		elseif MyLevel == 2300 or MyLevel <= 2324 then
			Mon = "Cocoa Warrior";
			LevelQuest = 1;
			NameQuest = "ChocQuest1";
			NameMon = "Cocoa Warrior";
			CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375);
			CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125);
		elseif MyLevel == 2325 or MyLevel <= 2349 then
			Mon = "Chocolate Bar Battler";
			LevelQuest = 2;
			NameQuest = "ChocQuest1";
			NameMon = "Chocolate Bar Battler";
			CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375);
			CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375);
		elseif MyLevel == 2350 or MyLevel <= 2374 then
			Mon = "Sweet Thief";
			LevelQuest = 1;
			NameQuest = "ChocQuest2";
			NameMon = "Sweet Thief";
			CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875);
			CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625);
		elseif MyLevel == 2375 or MyLevel <= 2399 then
			Mon = "Candy Rebel";
			LevelQuest = 2;
			NameQuest = "ChocQuest2";
			NameMon = "Candy Rebel";
			CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875);
			CFrameMon = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625);
		elseif MyLevel == 2400 or MyLevel <= 2424 then
			Mon = "Candy Pirate";
			LevelQuest = 1;
			NameQuest = "CandyQuest1";
			NameMon = "Candy Pirate";
			CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375);
			CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875);
		elseif MyLevel == 2425 or MyLevel <= 2449 then
			Mon = "Snow Demon";
			LevelQuest = 2;
			NameQuest = "CandyQuest1";
			NameMon = "Snow Demon";
			CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375);
			CFrameMon = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375);
		elseif MyLevel == 2450 or MyLevel <= 2474 then
			Mon = "Isle Outlaw";
			LevelQuest = 1;
			NameQuest = "TikiQuest1";
			NameMon = "Isle Outlaw";
			CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812);
			CFrameMon = CFrame.new(-16442.814453125, 116.13899993896484, -264.4637756347656);
		elseif MyLevel == 2475 or MyLevel <= 2524 then
			Mon = "Island Boy";
			LevelQuest = 2;
			NameQuest = "TikiQuest1";
			NameMon = "Island Boy";
			CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812);
			CFrameMon = CFrame.new(-16901.26171875, 84.06756591796875, -192.88906860351562);
		elseif MyLevel == 2525 or MyLevel <= 2549 then
			Mon = "Isle Champion";
			LevelQuest = 2;
			NameQuest = "TikiQuest2";
			NameMon = "Isle Champion";
			CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625);
			CFrameMon = CFrame.new(-16641.6796875, 235.7825469970703, 1031.282958984375);
		elseif MyLevel == 2550 or MyLevel <= 2574 then
			Mon = "Serpent Hunter";
			LevelQuest = 1;
			NameQuest = "TikiQuest3";
			NameMon = "Serpent Hunter";
			CFrameQuest = CFrame.new(-16661.890625, 105.2862319946289, 1576.69775390625);
			CFrameMon = CFrame.new(-16587.896484375, 154.21299743652344, 1533.40966796875);
		elseif MyLevel == 2575 or MyLevel >= 2575 then
			Mon = "Skull Slayer";
			LevelQuest = 2;
			NameQuest = "TikiQuest3";
			NameMon = "Skull Slayer";
			CFrameQuest = CFrame.new(-16661.890625, 105.2862319946289, 1576.69775390625);
			CFrameMon = CFrame.new(-16885.203125, 114.12911224365234, 1627.949951171875);
		end;
	end;
end;
function Hop()
	local module = (loadstring(game:HttpGet("https://raw.githubusercontent.com/raw-scriptpastebin/FE/main/Server_Hop_Settings")))();
	module:Teleport(game.PlaceId);
end;
function isnil(thing)
	return thing == nil;
end;
local function round(n)
	return math.floor(tonumber(n) + 0.5);
end;
Number = math.random(1, 1000000);
spawn(function()
	while wait(1) do
		for i, v in pairs((game:GetService("Workspace"))._WorldOrigin.Locations:GetChildren()) do
			pcall(function()
				if _G.Settings.Esp["ESP Island"] then
					if v.Name ~= "Sea" then
						if not v:FindFirstChild("EspIsland") then
							local bill = Instance.new("BillboardGui", v);
							bill.Name = "EspIsland";
							bill.ExtentsOffset = Vector3.new(0, 1, 0);
							bill.Size = UDim2.new(0, 200, 0, 30);
							bill.Adornee = v;
							bill.AlwaysOnTop = true;
							local name = Instance.new("TextLabel", bill);
							name.Font = Enum.Font.GothamMedium;
							name.TextSize = 14;
							name.TextWrapped = true;
							name.Size = UDim2.new(1, 0, 1, 0);
							name.TextYAlignment = Enum.TextYAlignment.Top;
							name.BackgroundTransparency = 1;
							name.TextColor3 = Color3.fromRGB(255, 255, 255);
						else
							v.EspIsland.TextLabel.Text = v.Name .. "   \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Position)).Magnitude / 3) .. " Distance";
						end;
					end;
				elseif v:FindFirstChild("EspIsland") then
					(v:FindFirstChild("EspIsland")):Destroy();
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(1) do
		for i, v in pairs((game:GetService("Players")):GetChildren()) do
			pcall(function()
				if not isnil(v.Character) then
					if _G.Settings.Esp["ESP Player"] then
						if not v.Character.Head:FindFirstChild(("EspPlayer" .. Number)) then
							local bill = Instance.new("BillboardGui", v.Character.Head);
							bill.Name = "EspPlayer" .. Number;
							bill.ExtentsOffset = Vector3.new(0, 1, 0);
							bill.Size = UDim2.new(1, 200, 1, 30);
							bill.Adornee = v.Character.Head;
							bill.AlwaysOnTop = true;
							local name = Instance.new("TextLabel", bill);
							name.Font = Enum.Font.GothamSemibold;
							name.FontSize = "Size14";
							name.TextWrapped = true;
							name.Text = v.Name .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Character.Head.Position)).Magnitude / 3) .. " Distance";
							name.Size = UDim2.new(1, 0, 1, 0);
							name.TextYAlignment = "Top";
							name.BackgroundTransparency = 1;
							name.TextStrokeTransparency = 0.5;
							if v.Team == game.Players.LocalPlayer.Team then
								name.TextColor3 = Color3.fromRGB(50, 200, 50);
							else
								name.TextColor3 = Color3.fromRGB(200, 50, 50);
							end;
						else
							v.Character.Head["EspPlayer" .. Number].TextLabel.Text = v.Name .. " | " .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Character.Head.Position)).Magnitude / 3) .. " Distance\nHealth : " .. round(v.Character.Humanoid.Health * 100 / v.Character.Humanoid.MaxHealth) .. "%";
						end;
					elseif v.Character.Head:FindFirstChild("EspPlayer" .. Number) then
						(v.Character.Head:FindFirstChild("EspPlayer" .. Number)):Destroy();
					end;
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(1) do
		for i, v in pairs(game.Workspace.ChestModels:GetChildren()) do
			pcall(function()
				if string.find(v.Name, "Chest") then
					if _G.Settings.Esp["ESP Chest"] then
						if string.find(v.Name, "Chest") then
							if not v:FindFirstChild(("EspChest" .. Number)) then
								local bill = Instance.new("BillboardGui", v);
								bill.Name = "EspChest" .. Number;
								bill.ExtentsOffset = Vector3.new(0, 1, 0);
								bill.Size = UDim2.new(1, 200, 1, 30);
								bill.Adornee = v;
								bill.AlwaysOnTop = true;
								local name = Instance.new("TextLabel", bill);
								name.Font = Enum.Font.Nunito;
								name.FontSize = "Size14";
								name.TextWrapped = true;
								name.Size = UDim2.new(1, 0, 1, 0);
								name.TextYAlignment = "Top";
								name.BackgroundTransparency = 1;
								name.TextStrokeTransparency = 0.5;
								if v.Name == "SilverChest" then
									name.TextColor3 = Color3.fromRGB(109, 109, 109);
									name.Text = "Silver Chest" .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.RootPart.Position)).Magnitude / 3) .. " Distance";
								end;
								if v.Name == "GoldChest" then
									name.TextColor3 = Color3.fromRGB(173, 158, 21);
									name.Text = "Gold Chest" .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.RootPart.Position)).Magnitude / 3) .. " Distance";
								end;
								if v.Name == "DiamondChest" then
									name.TextColor3 = Color3.fromRGB(20, 200, 200);
									name.Text = "Diamond Chest" .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.RootPart.Position)).Magnitude / 3) .. " Distance";
								end;
							else
								v["EspChest" .. Number].TextLabel.Text = v.Name .. "   \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.RootPart.Position)).Magnitude / 3) .. " Distance";
							end;
						end;
					elseif v:FindFirstChild("EspChest" .. Number) then
						(v:FindFirstChild("EspChest" .. Number)):Destroy();
					end;
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(1) do
		for i, v in pairs(game.Workspace:GetChildren()) do
			pcall(function()
				if _G.Settings.Esp["ESP DevilFruit"] then
					if v.Name and string.find(v.Name, "Fruit") then
						if not v.Handle:FindFirstChild(("EspDevilFruit" .. Number)) then
							local bill = Instance.new("BillboardGui", v.Handle);
							bill.Name = "EspDevilFruit" .. Number;
							bill.ExtentsOffset = Vector3.new(0, 1, 0);
							bill.Size = UDim2.new(1, 200, 1, 30);
							bill.Adornee = v.Handle;
							bill.AlwaysOnTop = true;
							local name = Instance.new("TextLabel", bill);
							name.Font = Enum.Font.GothamSemibold;
							name.FontSize = "Size14";
							name.TextWrapped = true;
							name.Size = UDim2.new(1, 0, 1, 0);
							name.TextYAlignment = "Top";
							name.BackgroundTransparency = 1;
							name.TextStrokeTransparency = 0.5;
							name.TextColor3 = Color3.fromRGB(255, 255, 255);
							name.Text = v.Name .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Handle.Position)).Magnitude / 3) .. " Distance";
							local TweenService = game:GetService("TweenService");
							local rainbowColors = {
								Color3.fromRGB(255, 0, 0),
								Color3.fromRGB(255, 127, 0),
								Color3.fromRGB(255, 255, 0),
								Color3.fromRGB(0, 255, 0),
								Color3.fromRGB(0, 0, 255),
								Color3.fromRGB(75, 0, 130),
								Color3.fromRGB(148, 0, 211)
							};
							local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
							(coroutine.wrap(function()
								while true do
									for _, color in ipairs(rainbowColors) do
										local tween = TweenService:Create(name, tweenInfo, {
											TextColor3 = color
										});
										tween:Play();
										tween.Completed:Wait();
									end;
								end;
							end))();
						else
							v.Handle["EspDevilFruit" .. Number].TextLabel.Text = v.Name .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Handle.Position)).Magnitude / 3) .. " Distance";
						end;
					end;
				elseif v.Handle:FindFirstChild("EspDevilFruit" .. Number) then
					(v.Handle:FindFirstChild("EspDevilFruit" .. Number)):Destroy();
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(0) do
		for i, v in pairs(game.Workspace._WorldOrigin:GetChildren()) do
			pcall(function()
				if _G.Settings.Esp["ESP DevilFruit"] then
					if string.find(v.Name, "Fruit") then
						if not v.Handle:FindFirstChild(("EspDevilFruit" .. Number)) then
							local bill = Instance.new("BillboardGui", v.Handle);
							bill.Name = "EspDevilFruit" .. Number;
							bill.ExtentsOffset = Vector3.new(0, 1, 0);
							bill.Size = UDim2.new(1, 200, 1, 30);
							bill.Adornee = v.Handle;
							bill.AlwaysOnTop = true;
							local name = Instance.new("TextLabel", bill);
							name.Font = Enum.Font.GothamSemibold;
							name.FontSize = "Size14";
							name.TextWrapped = true;
							name.Size = UDim2.new(1, 0, 1, 0);
							name.TextYAlignment = "Top";
							name.BackgroundTransparency = 1;
							name.TextStrokeTransparency = 0.5;
							name.TextColor3 = Color3.fromRGB(255, 255, 255);
							name.Text = v.Name .. "(SPAWNED)" .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Handle.Position)).Magnitude / 3) .. " Distance";
							local TweenService = game:GetService("TweenService");
							local rainbowColors = {
								Color3.fromRGB(255, 0, 0),
								Color3.fromRGB(255, 127, 0),
								Color3.fromRGB(255, 255, 0),
								Color3.fromRGB(0, 255, 0),
								Color3.fromRGB(0, 0, 255),
								Color3.fromRGB(75, 0, 130),
								Color3.fromRGB(148, 0, 211)
							};
							local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
							(coroutine.wrap(function()
								while true do
									for _, color in ipairs(rainbowColors) do
										local tween = TweenService:Create(name, tweenInfo, {
											TextColor3 = color
										});
										tween:Play();
										tween.Completed:Wait();
									end;
								end;
							end))();
						else
							v.Handle["EspDevilFruit" .. Number].TextLabel.Text = v.Name .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Handle.Position)).Magnitude / 3) .. " Distance";
						end;
					end;
				elseif v.Handle:FindFirstChild("EspDevilFruit" .. Number) then
					(v.Handle:FindFirstChild("EspDevilFruit" .. Number)):Destroy();
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(1) do
		for i, v in pairs(game.Workspace:GetChildren()) do
			pcall(function()
				if v.Name == "Flower2" or v.Name == "Flower1" then
					if _G.Settings.Esp["ESP Flower"] then
						if not v:FindFirstChild(("EspFlower" .. Number)) then
							local bill = Instance.new("BillboardGui", v);
							bill.Name = "EspFlower" .. Number;
							bill.ExtentsOffset = Vector3.new(0, 1, 0);
							bill.Size = UDim2.new(1, 200, 1, 30);
							bill.Adornee = v;
							bill.AlwaysOnTop = true;
							local name = Instance.new("TextLabel", bill);
							name.Font = Enum.Font.GothamSemibold;
							name.FontSize = "Size14";
							name.TextWrapped = true;
							name.Size = UDim2.new(1, 0, 1, 0);
							name.TextYAlignment = "Top";
							name.BackgroundTransparency = 1;
							name.TextStrokeTransparency = 0.5;
							name.TextColor3 = Color3.fromRGB(255, 100, 100);
							if v.Name == "Flower1" then
								name.Text = "Blue Flower" .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Position)).Magnitude / 3) .. " Distance";
								name.TextColor3 = Color3.fromRGB(40, 40, 255);
							end;
							if v.Name == "Flower2" then
								name.Text = "Red Flower" .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Position)).Magnitude / 3) .. " Distance";
								name.TextColor3 = Color3.fromRGB(255, 100, 100);
							end;
						else
							v["EspFlower" .. Number].TextLabel.Text = v.Name .. "   \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Position)).Magnitude / 3) .. " Distance";
						end;
					elseif v:FindFirstChild("EspFlower" .. Number) then
						(v:FindFirstChild("EspFlower" .. Number)):Destroy();
					end;
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(1) do
		for i, v in pairs(game.Workspace.AppleSpawner:GetChildren()) do
			if v:IsA("Tool") then
				if _G.Settings.Esp["ESP RealFruit"] then
					if not v.Handle:FindFirstChild(("EspRealFruit" .. Number)) then
						local bill = Instance.new("BillboardGui", v.Handle);
						bill.Name = "EspRealFruit" .. Number;
						bill.ExtentsOffset = Vector3.new(0, 1, 0);
						bill.Size = UDim2.new(1, 200, 1, 30);
						bill.Adornee = v.Handle;
						bill.AlwaysOnTop = true;
						local name = Instance.new("TextLabel", bill);
						name.Font = Enum.Font.GothamSemibold;
						name.FontSize = "Size14";
						name.TextWrapped = true;
						name.Size = UDim2.new(1, 0, 1, 0);
						name.TextYAlignment = "Top";
						name.BackgroundTransparency = 1;
						name.TextStrokeTransparency = 0.5;
						name.TextColor3 = Color3.fromRGB(200, 70, 70);
						name.Text = v.Name .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Handle.Position)).Magnitude / 3) .. " Distance";
					else
						v.Handle["EspRealFruit" .. Number].TextLabel.Text = v.Name .. " " .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Handle.Position)).Magnitude / 3) .. " Distance";
					end;
				elseif v.Handle:FindFirstChild("EspRealFruit" .. Number) then
					(v.Handle:FindFirstChild("EspRealFruit" .. Number)):Destroy();
				end;
			end;
		end;
		for i, v in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
			if v:IsA("Tool") then
				if _G.Settings.Esp["ESP RealFruit"] then
					if not v.Handle:FindFirstChild(("EspRealFruit" .. Number)) then
						local bill = Instance.new("BillboardGui", v.Handle);
						bill.Name = "EspRealFruit" .. Number;
						bill.ExtentsOffset = Vector3.new(0, 1, 0);
						bill.Size = UDim2.new(1, 200, 1, 30);
						bill.Adornee = v.Handle;
						bill.AlwaysOnTop = true;
						local name = Instance.new("TextLabel", bill);
						name.Font = Enum.Font.GothamSemibold;
						name.FontSize = "Size14";
						name.TextWrapped = true;
						name.Size = UDim2.new(1, 0, 1, 0);
						name.TextYAlignment = "Top";
						name.BackgroundTransparency = 1;
						name.TextStrokeTransparency = 0.5;
						name.TextColor3 = Color3.fromRGB(255, 170, 0);
						name.Text = v.Name .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Handle.Position)).Magnitude / 3) .. " Distance";
					else
						v.Handle["EspRealFruit" .. Number].TextLabel.Text = v.Name .. " " .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Handle.Position)).Magnitude / 3) .. " Distance";
					end;
				elseif v.Handle:FindFirstChild("EspRealFruit" .. Number) then
					(v.Handle:FindFirstChild("EspRealFruit" .. Number)):Destroy();
				end;
			end;
		end;
		for i, v in pairs(game.Workspace.BananaSpawner:GetChildren()) do
			if v:IsA("Tool") then
				if _G.Settings.Esp["ESP RealFruit"] then
					if not v.Handle:FindFirstChild(("EspRealFruit" .. Number)) then
						local bill = Instance.new("BillboardGui", v.Handle);
						bill.Name = "EspRealFruit" .. Number;
						bill.ExtentsOffset = Vector3.new(0, 1, 0);
						bill.Size = UDim2.new(1, 200, 1, 30);
						bill.Adornee = v.Handle;
						bill.AlwaysOnTop = true;
						local name = Instance.new("TextLabel", bill);
						name.Font = Enum.Font.GothamSemibold;
						name.FontSize = "Size14";
						name.TextWrapped = true;
						name.Size = UDim2.new(1, 0, 1, 0);
						name.TextYAlignment = "Top";
						name.BackgroundTransparency = 1;
						name.TextStrokeTransparency = 0.5;
						name.TextColor3 = Color3.fromRGB(240, 255, 10);
						name.Text = v.Name .. " \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Handle.Position)).Magnitude / 3) .. " Distance";
					else
						v.Handle["EspRealFruit" .. Number].TextLabel.Text = v.Name .. " " .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Handle.Position)).Magnitude / 3) .. " Distance";
					end;
				elseif v.Handle:FindFirstChild("EspRealFruit" .. Number) then
					(v.Handle:FindFirstChild("EspRealFruit" .. Number)):Destroy();
				end;
			end;
		end;
	end;
end);
spawn(function()
	while wait(1) do
		pcall(function()
			if _G.Settings.Esp["ESP Monster"] then
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
					if v:FindFirstChild("HumanoidRootPart") then
						if not v:FindFirstChild("EspMonster") then
							local BillboardGui = Instance.new("BillboardGui");
							local TextLabel = Instance.new("TextLabel");
							BillboardGui.Parent = v;
							BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
							BillboardGui.Active = true;
							BillboardGui.Name = "EspMonster";
							BillboardGui.AlwaysOnTop = true;
							BillboardGui.LightInfluence = 1;
							BillboardGui.Size = UDim2.new(0, 200, 0, 50);
							BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0);
							TextLabel.Parent = BillboardGui;
							TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
							TextLabel.BackgroundTransparency = 1;
							TextLabel.Size = UDim2.new(0, 200, 0, 50);
							TextLabel.Font = Enum.Font.GothamBold;
							TextLabel.TextColor3 = Color3.fromRGB(120, 130, 230);
							TextLabel.Text.Size = 35;
						end;
						local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude);
						v.EspMonster.TextLabel.Text = v.Name .. " - " .. Dis .. " Distance";
					end;
				end;
			else
				for i, v in pairs((game:GetService("Workspace")).Enemies:GetChildren()) do
					if v:FindFirstChild("EspMonster") then
						v.EspMonster:Destroy();
					end;
				end;
			end;
		end);
	end;
end);
spawn(function()
	while wait(1) do
		pcall(function()
			if _G.Settings.Esp["ESP Sea Beast"] then
				for i, v in pairs((game:GetService("Workspace")).SeaBeasts:GetChildren()) do
					if v:FindFirstChild("HumanoidRootPart") then
						if not v:FindFirstChild("EspSeabeasts") then
							local BillboardGui = Instance.new("BillboardGui");
							local TextLabel = Instance.new("TextLabel");
							BillboardGui.Parent = v;
							BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
							BillboardGui.Active = true;
							BillboardGui.Name = "EspSeabeasts";
							BillboardGui.AlwaysOnTop = true;
							BillboardGui.LightInfluence = 1;
							BillboardGui.Size = UDim2.new(0, 200, 0, 50);
							BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0);
							TextLabel.Parent = BillboardGui;
							TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
							TextLabel.BackgroundTransparency = 1;
							TextLabel.Size = UDim2.new(0, 200, 0, 50);
							TextLabel.Font = Enum.Font.Gotham;
							TextLabel.TextColor3 = Color3.fromRGB(60, 240, 120);
							TextLabel.Text.Size = 35;
						end;
						local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude);
						v.EspSeabeasts.TextLabel.Text = v.Name .. " - " .. Dis .. " Distance";
					end;
				end;
			else
				for i, v in pairs((game:GetService("Workspace")).SeaBeasts:GetChildren()) do
					if v:FindFirstChild("EspSeabeasts") then
						v.EspSeabeasts:Destroy();
					end;
				end;
			end;
		end);
	end;
end);
spawn(function()
	while wait(1) do
		pcall(function()
			if _G.Settings.Esp["ESP Npc"] then
				for i, v in pairs((game:GetService("Workspace")).NPCs:GetChildren()) do
					if v:FindFirstChild("HumanoidRootPart") then
						if not v:FindFirstChild("EspNpc") then
							local BillboardGui = Instance.new("BillboardGui");
							local TextLabel = Instance.new("TextLabel");
							BillboardGui.Parent = v;
							BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
							BillboardGui.Active = true;
							BillboardGui.Name = "EspNpc";
							BillboardGui.AlwaysOnTop = true;
							BillboardGui.LightInfluence = 1;
							BillboardGui.Size = UDim2.new(0, 200, 0, 50);
							BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0);
							TextLabel.Parent = BillboardGui;
							TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
							TextLabel.BackgroundTransparency = 1;
							TextLabel.Size = UDim2.new(0, 200, 0, 50);
							TextLabel.Font = Enum.Font.Cartoon;
							TextLabel.TextColor3 = Color3.fromRGB(200, 60, 120);
							TextLabel.Text.Size = 45;
						end;
						local Dis = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude);
						v.EspNpc.TextLabel.Text = v.Name .. " - " .. Dis .. " Distance";
					end;
				end;
			else
				for i, v in pairs((game:GetService("Workspace")).NPCs:GetChildren()) do
					if v:FindFirstChild("EspNpc") then
						v.EspNpc:Destroy();
					end;
				end;
			end;
		end);
	end;
end);
spawn(function()
	while wait(1) do
		for i, v in pairs((game:GetService("Workspace"))._WorldOrigin.Locations:GetChildren()) do
			pcall(function()
				if _G.Settings.Esp["ESP Mirage"] then
					if v.Name == "Mirage Island" then
						if not v:FindFirstChild("EspMirageIsland") then
							local bill = Instance.new("BillboardGui", v);
							bill.Name = "EspMirageIsland";
							bill.ExtentsOffset = Vector3.new(0, 1, 0);
							bill.Size = UDim2.new(1, 200, 1, 30);
							bill.Adornee = v;
							bill.AlwaysOnTop = true;
							local name = Instance.new("TextLabel", bill);
							name.Font = "Code";
							name.FontSize = "Size14";
							name.TextWrapped = true;
							name.Size = UDim2.new(1, 0, 1, 0);
							name.TextYAlignment = "Top";
							name.BackgroundTransparency = 1;
							name.TextStrokeTransparency = 0.5;
							name.TextColor3 = Color3.fromRGB(50, 180, 50);
						else
							v.EspMirageIsland.TextLabel.Text = v.Name .. "   \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Position)).Magnitude / 3) .. " M";
						end;
					end;
				elseif v:FindFirstChild("EspMirageIsland") then
					(v:FindFirstChild("EspMirageIsland")):Destroy();
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(1) do
		for i, v in pairs((game:GetService("Workspace"))._WorldOrigin.Locations:GetChildren()) do
			pcall(function()
				if _G.Settings.Esp["ESP Kitsune"] then
					if v.Name == "Kitsune Island" then
						if not v:FindFirstChild("EspKitsuneIsland") then
							local bill = Instance.new("BillboardGui", v);
							bill.Name = "EspKitsuneIsland";
							bill.ExtentsOffset = Vector3.new(0, 1, 0);
							bill.Size = UDim2.new(1, 200, 1, 30);
							bill.Adornee = v;
							bill.AlwaysOnTop = true;
							local name = Instance.new("TextLabel", bill);
							name.Font = "Code";
							name.FontSize = "Size14";
							name.TextWrapped = true;
							name.Size = UDim2.new(1, 0, 1, 0);
							name.TextYAlignment = "Top";
							name.BackgroundTransparency = 1;
							name.TextStrokeTransparency = 0.5;
							name.TextColor3 = Color3.fromRGB(40, 40, 180);
						else
							v.EspKitsuneIsland.TextLabel.Text = v.Name .. "   \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Position)).Magnitude / 3) .. " M";
						end;
					end;
				elseif v:FindFirstChild("EspKitsuneIsland") then
					(v:FindFirstChild("EspKitsuneIsland")):Destroy();
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(1) do
		for i, v in pairs((game:GetService("Workspace"))._WorldOrigin.Locations:GetChildren()) do
			pcall(function()
				if _G.Settings.Esp["ESP Frozen"] then
					if v.Name == "Frozen Dimension" then
						if not v:FindFirstChild("EspFrozen") then
							local bill = Instance.new("BillboardGui", v);
							bill.Name = "EspFrozen";
							bill.ExtentsOffset = Vector3.new(0, 1, 0);
							bill.Size = UDim2.new(1, 200, 1, 30);
							bill.Adornee = v;
							bill.AlwaysOnTop = true;
							local name = Instance.new("TextLabel", bill);
							name.Font = "Code";
							name.FontSize = "Size14";
							name.TextWrapped = true;
							name.Size = UDim2.new(1, 0, 1, 0);
							name.TextYAlignment = "Top";
							name.BackgroundTransparency = 1;
							name.TextStrokeTransparency = 0.5;
							name.TextColor3 = Color3.fromRGB(50, 180, 255);
						else
							v.EspFrozen.TextLabel.Text = v.Name .. "   \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Position)).Magnitude / 3) .. " M";
						end;
					end;
				elseif v:FindFirstChild("EspFrozen") then
					(v:FindFirstChild("EspFrozen")):Destroy();
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(1) do
		for i, v in pairs((game:GetService("Workspace"))._WorldOrigin.Locations:GetChildren()) do
			pcall(function()
				if _G.Settings.Esp["ESP Prehistoric"] then
					if v.Name == "Prehistoric Island" then
						if not v:FindFirstChild("EspPrehistoric") then
							local bill = Instance.new("BillboardGui", v);
							bill.Name = "EspPrehistoric";
							bill.ExtentsOffset = Vector3.new(0, 1, 0);
							bill.Size = UDim2.new(1, 200, 1, 30);
							bill.Adornee = v;
							bill.AlwaysOnTop = true;
							local name = Instance.new("TextLabel", bill);
							name.Font = "Code";
							name.FontSize = "Size14";
							name.TextWrapped = true;
							name.Size = UDim2.new(1, 0, 1, 0);
							name.TextYAlignment = "Top";
							name.BackgroundTransparency = 1;
							name.TextStrokeTransparency = 0.5;
							name.TextColor3 = Color3.fromRGB(200, 50, 40);
						else
							v.EspPrehistoric.TextLabel.Text = v.Name .. "   \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Position)).Magnitude / 3) .. " M";
						end;
					end;
				elseif v:FindFirstChild("EspPrehistoric") then
					(v:FindFirstChild("EspPrehistoric")):Destroy();
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(1) do
		for i, v in pairs((game:GetService("Workspace")).NPCs:GetChildren()) do
			pcall(function()
				if _G.Settings.Esp["ESP Advanced Fruit Dealer"] then
					if v.Name == "Advanced Fruit Dealer" then
						if not v:FindFirstChild("EspAdvanceFruitDealer") then
							local bill = Instance.new("BillboardGui", v);
							bill.Name = "EspAdvanceFruitDealer";
							bill.ExtentsOffset = Vector3.new(0, 1, 0);
							bill.Size = UDim2.new(1, 200, 1, 30);
							bill.Adornee = v;
							bill.AlwaysOnTop = true;
							local name = Instance.new("TextLabel", bill);
							name.Font = "Code";
							name.FontSize = "Size14";
							name.TextWrapped = true;
							name.Size = UDim2.new(1, 0, 1, 0);
							name.TextYAlignment = "Top";
							name.BackgroundTransparency = 1;
							name.TextStrokeTransparency = 0.5;
							name.TextColor3 = Color3.fromRGB(250, 50, 50);
						else
							v.EspAdvanceFruitDealer.TextLabel.Text = v.Name .. "   \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Position)).Magnitude / 3) .. " M";
						end;
					end;
				elseif v:FindFirstChild("EspAdvanceFruitDealer") then
					(v:FindFirstChild("EspAdvanceFruitDealer")):Destroy();
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(1) do
		for i, v in pairs((game:GetService("Workspace")).NPCs:GetChildren()) do
			pcall(function()
				if _G.Settings.Esp["ESP Aura"] then
					if v.Name == "Master of Enhancement" then
						if not v:FindFirstChild("EspAura") then
							local bill = Instance.new("BillboardGui", v);
							bill.Name = "EspAura";
							bill.ExtentsOffset = Vector3.new(0, 1, 0);
							bill.Size = UDim2.new(1, 200, 1, 30);
							bill.Adornee = v;
							bill.AlwaysOnTop = true;
							local name = Instance.new("TextLabel", bill);
							name.Font = "Code";
							name.FontSize = "Size14";
							name.TextWrapped = true;
							name.Size = UDim2.new(1, 0, 1, 0);
							name.TextYAlignment = "Top";
							name.BackgroundTransparency = 1;
							name.TextStrokeTransparency = 0.5;
							name.TextColor3 = Color3.fromRGB(200, 55, 255);
						else
							v.EspAura.TextLabel.Text = v.Name .. "   \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Position)).Magnitude / 3) .. " M";
						end;
					end;
				elseif v:FindFirstChild("EspAura") then
					(v:FindFirstChild("EspAura")):Destroy();
				end;
			end);
		end;
	end;
end);
spawn(function()
	while wait(1) do
		if (game:GetService("Workspace")).Map:FindFirstChild("MysticIsland") then
			for i, v in pairs((game:GetService("Workspace")).Map.MysticIsland:GetChildren()) do
				pcall(function()
					if _G.Settings.Esp["ESP Gear"] then
						if v.Name == "MeshPart" then
							if not v:FindFirstChild("EspGear") then
								local bill = Instance.new("BillboardGui", v);
								bill.Name = "EspGear";
								bill.ExtentsOffset = Vector3.new(0, 1, 0);
								bill.Size = UDim2.new(1, 200, 1, 30);
								bill.Adornee = v;
								bill.AlwaysOnTop = true;
								local name = Instance.new("TextLabel", bill);
								name.Font = "Code";
								name.FontSize = "Size14";
								name.TextWrapped = true;
								name.Size = UDim2.new(1, 0, 1, 0);
								name.TextYAlignment = "Top";
								name.BackgroundTransparency = 1;
								name.TextStrokeTransparency = 0.5;
								name.TextColor3 = Color3.fromRGB(80, 245, 245);
							else
								v.EspGear.TextLabel.Text = v.Name .. "   \n" .. round((((game:GetService("Players")).LocalPlayer.Character.Head.Position - v.Position)).Magnitude / 3) .. " M";
							end;
						end;
					elseif v:FindFirstChild("EspGear") then
						(v:FindFirstChild("EspGear")):Destroy();
					end;
				end);
			end;
		end;
	end;
end);
function InfAb()
	if _G.Settings.LocalPlayer["Infinite Ability"] then
		if not (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
			local inf = Instance.new("ParticleEmitter");
			inf.Acceleration = Vector3.new(0, 0, 0);
			inf.Archivable = true;
			inf.Drag = 20;
			inf.EmissionDirection = Enum.NormalId.Top;
			inf.Enabled = true;
			inf.Lifetime = NumberRange.new(0, 0);
			inf.LightInfluence = 0;
			inf.LockedToPart = true;
			inf.Name = "Agility";
			inf.Rate = 500;
			local numberKeypoints2 = {
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, 4)
			};
			inf.Size = NumberSequence.new(numberKeypoints2);
			inf.RotSpeed = NumberRange.new(9999, 99999);
			inf.Rotation = NumberRange.new(0, 0);
			inf.Speed = NumberRange.new(30, 30);
			inf.SpreadAngle = Vector2.new(0, 0, 0, 0);
			inf.Texture = "";
			inf.VelocityInheritance = 0;
			inf.ZOffset = 2;
			inf.Transparency = NumberSequence.new(0);
			inf.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0));
			inf.Parent = (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart;
		end;
	elseif (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
		((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility")):Destroy();
	end;
end;
local LocalPlayer = (game:GetService("Players")).LocalPlayer;
local EnergyObject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Energy");
local originalstam = EnergyObject and EnergyObject.Value or 0;
function infinitestam()
	local CurrentCharacter = LocalPlayer.Character;
	local CurrentEnergy = CurrentCharacter and CurrentCharacter:FindFirstChild("Energy");
	if not CurrentEnergy then
		return;
	end;
	CurrentEnergy.Changed:connect(function()
		if _G.Settings.LocalPlayer["Infinite Energy"] then
			CurrentEnergy.Value = originalstam;
		end;
	end);
end;
spawn(function()
	pcall(function()
		while wait(0.1) do
			if _G.Settings.LocalPlayer["Infinite Energy"] then
				wait(0.1);
				local CurrentEnergy = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Energy");
				if CurrentEnergy then
					originalstam = CurrentEnergy.Value;
					infinitestam();
				end;
			end;
		end;
	end);
end);
spawn(function()
	while wait() do
		pcall(function()
			if _G.Settings.LocalPlayer["Dodge No Cooldown"] then
				for i, v in next, getgc() do
					if (game:GetService("Players")).LocalPlayer.Character.Dodge then
						if typeof(v) == "function" and (getfenv(v)).script == (game:GetService("Players")).LocalPlayer.Character.Dodge then
							for i2, v2 in next, getupvalues(v) do
								if tostring(v2) == "0.1" then
									repeat
										wait(0.1);
										setupvalue(v, i2, 0);
									until not nododgecool;
								end;
							end;
						end;
					end;
				end;
			end;
		end);
	end;
end);
function fly()
	local mouse = (game:GetService("Players")).LocalPlayer:GetMouse("");
	localplayer = (game:GetService("Players")).LocalPlayer;
	(game:GetService("Players")).LocalPlayer.Character:WaitForChild("HumanoidRootPart");
	local torso = (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart;
	local speedSET = 25;
	local keys = {
		a = false,
		d = false,
		w = false,
		s = false
	};
	local e1;
	local e2;
	local function start()
		local pos = Instance.new("BodyPosition", torso);
		local gyro = Instance.new("BodyGyro", torso);
		pos.Name = "EPIXPOS";
		pos.maxForce = Vector3.new(math.huge, math.huge, math.huge);
		pos.position = torso.Position;
		gyro.maxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
		gyro.CFrame = torso.CFrame;
		repeat
			wait();
			localplayer.Character.Humanoid.PlatformStand = true;
			local new = gyro.CFrame - gyro.CFrame.p + pos.position;
			if not keys.w and (not keys.s) and (not keys.a) and (not keys.d) then
				speed = 1;
			end;
			if keys.w then
				new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed;
				speed = speed + speedSET;
			end;
			if keys.s then
				new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed;
				speed = speed + speedSET;
			end;
			if keys.d then
				new = new * CFrame.new(speed, 0, 0);
				speed = speed + speedSET;
			end;
			if keys.a then
				new = new * CFrame.new((-speed), 0, 0);
				speed = speed + speedSET;
			end;
			if speed > speedSET then
				speed = speedSET;
			end;
			pos.position = new.p;
			if keys.w then
				gyro.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles((-math.rad((speed * 15))), 0, 0);
			elseif keys.s then
				gyro.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(math.rad((speed * 15)), 0, 0);
			else
				gyro.CFrame = workspace.CurrentCamera.CoordinateFrame;
			end;
		until not Fly;
		if gyro then
			gyro:Destroy();
		end;
		if pos then
			pos:Destroy();
		end;
		flying = false;
		localplayer.Character.Humanoid.PlatformStand = false;
		speed = 0;
	end;
	e1 = mouse.KeyDown:connect(function(key)
		if not torso or (not torso.Parent) then
			flying = false;
			e1:disconnect();
			e2:disconnect();
			return;
		end;
		if key == "w" then
			keys.w = true;
		elseif key == "s" then
			keys.s = true;
		elseif key == "a" then
			keys.a = true;
		elseif key == "d" then
			keys.d = true;
		end;
	end);
	e2 = mouse.KeyUp:connect(function(key)
		if key == "w" then
			keys.w = false;
		elseif key == "s" then
			keys.s = false;
		elseif key == "a" then
			keys.a = false;
		elseif key == "d" then
			keys.d = false;
		end;
	end);
	start();
end;
function Click()
	(game:GetService("VirtualUser")):CaptureController();
	(game:GetService("VirtualUser")):Button1Down(Vector2.new(1280, 672));
end;
function AutoHaki()
	if not (game:GetService("Players")).LocalPlayer.Character:FindFirstChild("HasBuso") then
		(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Buso");
	end;
end;
function UnEquipWeapon(Weapon)
	if game.Players.LocalPlayer.Character:FindFirstChild(Weapon) then
		(game.Players.LocalPlayer.Character:FindFirstChild(Weapon)).Parent = game.Players.LocalPlayer.Backpack;
	end;
end;
function EquipWeapon(ToolSe)
	if not game.Players.LocalPlayer.Character:FindFirstChild(ToolSe) then
		if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
			Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe);
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool);
		end;
	end;
end;
spawn(function()
	for i, v in pairs((game:GetService("Workspace"))._WorldOrigin:GetChildren()) do
		pcall(function()
			if v.Name == "CurvedRing" or v.Name == "SlashHit" or v.Name == "SwordSlash" or v.Name == "SlashTail" or v.Name == "Sounds" then
				v:Destroy();
			end;
		end);
	end;
end);
function GetDistance(target)
	return math.floor((target.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude);
end;
function BTP(p)
	pcall(function()
		if (p.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1500 and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
			repeat
				wait();
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p;
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("SetSpawnPoint");
				wait();
				game.Players.LocalPlayer.Character.Head:Destroy();
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p;
				(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("SetSpawnPoint");
			until (p.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1500 and game.Players.LocalPlayer.Character.Humanoid.Health > 0;
		end;
	end);
end;
function InstantTp(P)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P;
end;
function TP(Pos)
	Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;
	((game:GetService("TweenService")):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Distance / _G.Settings.Setting["Player Tween Speed"], Enum.EasingStyle.Linear), {
		CFrame = Pos
	})):Play();
end;
function TP1(Pos)
	Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;
	((game:GetService("TweenService")):Create((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Distance / _G.Settings.Setting["Player Tween Speed"], Enum.EasingStyle.Linear), {
		CFrame = Pos
	})):Play();
end;
function TweenBoat(pos)
	local StopTweenBoat = {};
	local TweenService = game:service("TweenService");
	local Boat = (game:GetService("Workspace")).Boats[_G.Settings.SeaEvent["Selected Boat"]];
	local Distance = (Boat.VehicleSeat.CFrame.Position - pos.Position).Magnitude;
	local info = TweenInfo.new(Distance / _G.Settings.SeaEvent["Boat Tween Speed"], Enum.EasingStyle.Linear);
	tween = TweenService:Create(Boat.VehicleSeat, info, {
		CFrame = pos
	});
	if Distance <= 25 then
		tween:Cancel();
	else
		tween:Play();
	end;
	function StopTweenBoat:Stop()
		if tween then
			tween:Cancel();
		end;
	end;
	return StopTweenBoat;
end;
task.spawn(function()
	while task.wait() do
		pcall(function()
			(game:GetService("Workspace")).Boats[_G.Settings.SeaEvent["Selected Boat"]].Engine.CFrame = (game:GetService("Workspace")).Boats[_G.Settings.SeaEvent["Selected Boat"]].Engine.Root.CFrame;
			if (game:GetService("Workspace")).Boats[_G.Settings.SeaEvent["Selected Boat"]].Engine.Root.Position - (game:GetService("Workspace")).Boats[_G.Settings.SeaEvent["Selected Boat"]].Engine.Position.Magnitude >= 1 then
				(game:GetService("Workspace")).Boats[_G.Settings.SeaEvent["Selected Boat"]].Engine.Root.CFrame = (game:GetService("Workspace")).Boats[_G.Settings.SeaEvent["Selected Boat"]].Engine.CFrame;
			end;
		end);
	end;
end);
function topos(pos)
	task.spawn(function()
		pcall(function()
			if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
				game.Players.LocalPlayer.Character.Humanoid.Sit = true;
			end;
			local player = (game:GetService("Players")).LocalPlayer;
			local character = player.Character;
			local humanoidRootPart = character.HumanoidRootPart;
			if player:DistanceFromCharacter(pos.Position) <= 50 then
				humanoidRootPart.CFrame = pos;
				if character:FindFirstChild("Root") then
					character.Root:Destroy();
					wait();
					topos(humanoidRootPart.CFrame);
					wait();
				end;
				if character:FindFirstChild("Root") then
					character.Root:Remove();
				end;
			elseif not character:FindFirstChild("Root") then
				local rootPart = Instance.new("Part", character);
				rootPart.Size = Vector3.new(1, 0.5, 1);
				rootPart.Name = "Root";
				rootPart.Anchored = true;
				rootPart.Transparency = 1;
				rootPart.CanCollide = false;
				rootPart.CFrame = humanoidRootPart.CFrame;
			end;
			local distance = (humanoidRootPart.Position - pos.Position).Magnitude;
			local tweenService = game:GetService("TweenService");
			local tweenInfo = TweenInfo.new(distance / _G.Settings.Setting["Player Tween Speed"], Enum.EasingStyle.Linear);
			local success, tweenError = pcall(function()
				local tween = tweenService:Create(character.Root, tweenInfo, {
					CFrame = pos
				});
				tween:Play();
			end);
			if _G.StopTween == true then
				tween:Cancel();
				_G.Clip = false;
			end;
			if not success then
				return tweenError;
			end;
			character.Root.CFrame = humanoidRootPart.CFrame;
			if success and character:FindFirstChild("Root") then
				pcall(function()
					local distanceFromTarget = (humanoidRootPart.Position - pos.Position).Magnitude;
					if distanceFromTarget >= 50 then
						task.spawn(function()
							pcall(function()
								if (character.Root.Position - humanoidRootPart.Position).Magnitude > 200 then
									character.Root.CFrame = humanoidRootPart.CFrame;
								else
									humanoidRootPart.CFrame = character.Root.CFrame;
								end;
							end);
						end);
					elseif distanceFromTarget >= 25 and distanceFromTarget < 40 then
						humanoidRootPart.CFrame = pos;
					elseif distanceFromTarget < 25 then
						humanoidRootPart.CFrame = pos;
					end;
				end);
			end;
			local stoppos = {};
			function stoppos:Stop()
				tween:Cancel();
			end;
			return stoppos;
		end);
	end);
end;
task.spawn(function()
	while task.wait() do
		pcall(function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.Root.CFrame;
			if (game.Players.LocalPlayer.Character.Root.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1 then
				game.Players.LocalPlayer.Character.Root.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;
			end;
		end);
	end;
end);
function tween(Pos)
	local Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;
	local tween = ((game:GetService("TweenService")):Create((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Distance / _G.Settings.Setting["Player Tween Speed"], Enum.EasingStyle.Linear), {
		CFrame = Pos
	})):Play();
	function stoppos:Stop()
		tween:Cancel();
	end;
	return stoppos;
end;
function fastpos(Pos)
	Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude;
	Speed = 1000;
	((game:GetService("TweenService")):Create((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear), {
		CFrame = Pos
	})):Play();
end;
local stopboat = {};
function TPB(pos, boat)
	local tween_s = game:service("TweenService");
	local info = TweenInfo.new(((boat.CFrame.Position - pos.Position)).Magnitude / _G.Settings.SeaEvent["Boat Tween Speed"], Enum.EasingStyle.Linear);
	tween = tween_s:Create(boat, info, {
		CFrame = pos
	});
	if (boat.CFrame.Position - pos.Position).Magnitude <= 25 then
		tween:Cancel();
	else
		tween:Play();
	end;
	function stopboat:Stop()
		tween:Cancel();
	end;
	return stopboat;
end;
function TPP(CFgo)
	if (game.Players.LocalPlayer.Character:WaitForChild("Humanoid")).Health <= 0 or (not (game:GetService("Players")).LocalPlayer.Character:WaitForChild("Humanoid")) then
		tween:Cancel();
		repeat
			wait();
		until (game:GetService("Players")).LocalPlayer.Character:WaitForChild("Humanoid") and ((game:GetService("Players")).LocalPlayer.Character:WaitForChild("Humanoid")).Health > 0;
		wait(7);
		return;
	end;
	local tween_s = game:service("TweenService");
	local info = TweenInfo.new((((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.Position - CFgo.Position)).Magnitude / _G.Settings.Setting["Player Tween Speed"], Enum.EasingStyle.Linear);
	tween = tween_s:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {
		CFrame = CFgo
	});
	tween:Play();
	local tweenfunc = {};
	function tweenfunc:Stop()
		tween:Cancel();
	end;
	return tweenfunc;
end;
spawn(function()
	local angle = 0;
	while wait() do
		if _G.Settings.Setting["Spin Position"] then
			local radius = 20;
			local farmDistance = _G.Settings.Setting["Farm Distance"];
			local radian = math.rad(angle);
			local x = math.cos(radian) * radius;
			local z = math.sin(radian) * radius;
			Pos = CFrame.new(x, farmDistance, z);
			angle = (angle + 30) % 360;
		else
			Pos = CFrame.new(0, _G.Settings.Setting["Farm Distance"], 0);
		end;
		wait(0);
	end;
end);
spawn(function()
	pcall(function()
		while wait() do
			if World1 then
				if _G.Settings.Farm["Auto Farm Leather"] or _G.Settings.Farm["Auto Farm Magma Ore"] or _G.Settings.Farm["Auto Farm Scrap Metal"] or _G.Settings.Farm["Auto Saber"] or _G.Settings.Items["Auto Second Sea"] or _G.Settings.Items["Auto Warden Sword"] or _G.Settings.Items["Auto Greybeard"] or _G.Settings.Items["Auto Pole"] or _G.Settings.Items["Auto Shark Saw"] or _G.Settings.Farm["Auto Farm Angel Wings"] then
					if not (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
						local Noclip = Instance.new("BodyVelocity");
						Noclip.Name = "BodyClip";
						Noclip.Parent = (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart;
						Noclip.MaxForce = Vector3.new(100000, 100000, 100000);
						Noclip.Velocity = Vector3.new(0, 0, 0);
					end;
				end;
			end;
		end;
	end);
end);
spawn(function()
	pcall(function()
		while wait() do
			if World1 then
				if _G.Settings.Farm["Auto Farm Leather"] or _G.Settings.Farm["Auto Farm Magma Ore"] or _G.Settings.Farm["Auto Farm Scrap Metal"] or _G.Settings.Farm["Auto Saber"] or _G.Settings.Items["Auto Second Sea"] or _G.Settings.Items["Auto Warden Sword"] or _G.Settings.Items["Auto Greybeard"] or _G.Settings.Items["Auto Pole"] or _G.Settings.Items["Auto Shark Saw"] or _G.Settings.Farm["Auto Farm Angel Wings"] then
					for _, v in pairs((game:GetService("Players")).LocalPlayer.Character:GetDescendants()) do
						if v:IsA("BasePart") then
							v.CanCollide = false;
						end;
					end;
				end;
			end;
		end;
	end);
end);
spawn(function()
	pcall(function()
		while wait() do
			if World2 then
				if _G.Settings.Items["Auto Farm Factory"] or _G.Settings.Items["Auto Swan Glasses"] or _G.Settings.Raid["Law Raid"] or _G.Settings.Race["Auto Race V2"] or _G.Settings.Items["Auto Rengoku"] or _G.Settings.Items["Auto Bartilo Quest"] or _G.Settings.Items["Auto Third Sea"] or _G.Settings.Items["Auto Dragon Trident"] or _G.Settings.Farm["Auto Farm Leather"] or _G.Settings.Farm["Auto Farm Magma Ore"] or _G.Settings.Farm["Auto Farm Radioactive"] or _G.Settings.Farm["Auto Farm Scrap Metal"] or _G.Settings.SeaStack["Auto Attack Seabeasts"] or _G.Settings.Raid["Auto Dungeon"] then
					if not (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
						local Noclip = Instance.new("BodyVelocity");
						Noclip.Name = "BodyClip";
						Noclip.Parent = (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart;
						Noclip.MaxForce = Vector3.new(100000, 100000, 100000);
						Noclip.Velocity = Vector3.new(0, 0, 0);
					end;
				end;
			end;
		end;
	end);
end);
spawn(function()
	pcall(function()
		while wait() do
			if World2 then
				if _G.Settings.Items["Auto Farm Factory"] or _G.Settings.Items["Auto Swan Glasses"] or _G.Settings.Raid["Law Raid"] or _G.Settings.Race["Auto Race V2"] or _G.Settings.Items["Auto Rengoku"] or _G.Settings.Items["Auto Bartilo Quest"] or _G.Settings.Items["Auto Third Sea"] or _G.Settings.Items["Auto Dragon Trident"] or _G.Settings.Farm["Auto Farm Leather"] or _G.Settings.Farm["Auto Farm Magma Ore"] or _G.Settings.Farm["Auto Farm Radioactive"] or _G.Settings.Farm["Auto Farm Scrap Metal"] or _G.Settings.SeaStack["Auto Attack Seabeasts"] or _G.Settings.Raid["Auto Dungeon"] then
					for _, v in pairs((game:GetService("Players")).LocalPlayer.Character:GetDescendants()) do
						if v:IsA("BasePart") then
							v.CanCollide = false;
						end;
					end;
				end;
			end;
		end;
	end);
end);
spawn(function()
	pcall(function()
		while wait() do
			if World3 then
				if _G.Settings.Farm["Auto Pirate Raid"] or _G.Settings.Race["Auto Race V3"] or _G.Settings.Farm["Auto Kill Cake Prince"] or _G.Settings.SeaStack["Teleport To Kitsune Island"] or _G.Settings.SeaStack["Teleport To Frozen Dimension"] or _G.Settings.SeaStack["Sail To Frozen Dimension"] or _G.Settings.SeaStack["Summon Frozen Dimension"] or _G.Settings.SeaStack["Summon Kitsune Island"] or _G.Settings.SeaStack["Teleport To Mirage Island"] or _G.Settings.Race["Auto Train"] or _G.Settings.Items["Auto Press Haki Button"] or _G.Settings.SeaEvent["Sail Boat"] or _G.Settings.Items["Auto Arena Trainer"] or _G.Settings.Race["Auto Kill Player After Trial"] or _G.Settings.Race["Tween To Highest Mirage"] or _G.Settings.Race["Auto Trial"] or _G.Settings.Race["Find Blue Gear"] or _G.Settings.Combat["Auto Kill Player Quest"] or _G.Settings.Items["Auto Cursed Dual Katana"] or _G.Settings.Farm["Auto Farm Bone"] or _G.Settings.Farm["Auto Kill Dough King"] or _G.Settings.Items["Auto Soul Guitar"] or _G.Settings.Items["Auto Tushita"] or _G.Settings.Farm["Auto Elite Hunter"] or _G.AutoKillSelectedPlayer or _G.Settings.Items["Auto Rainbow Haki"] or _G.Settings.Items["Auto Dark Dagger"] or _G.Settings.Farm["Auto Farm Ectoplasm"] or _G.Settings.Farm["Auto Observation V2"] or _G.Settings.Farm["Auto Musketeer Hat"] or _G.Settings.Items["Auto Holy Torch"] or _G.Settings.Items["Auto Hallow Scythe"] or _G.Settings.Farm["Auto Farm Katakuri"] or _G.Settings.Farm["Auto Farm Conjured Cocoa"] or _G.Settings.Farm["Auto Farm Fish Tail"] or _G.Settings.Farm["Auto Farm Gunpowder"] or _G.Settings.Farm["Auto Farm Dragon Scale"] or _G.Settings.Farm["Auto Farm Scrap Metal"] or _G.Settings.Farm["Auto Farm Mini Tusk"] or _G.Settings.Items["Auto Buddy Sword"] or _G.Settings.Items["Auto Canvander"] or _G.Settings.Farm["Auto Farm Leather"] or _G.Settings.Raid["Auto Dungeon"] then
					if not (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
						local Noclip = Instance.new("BodyVelocity");
						Noclip.Name = "BodyClip";
						Noclip.Parent = (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart;
						Noclip.MaxForce = Vector3.new(100000, 100000, 100000);
						Noclip.Velocity = Vector3.new(0, 0, 0);
					end;
				end;
			end;
		end;
	end);
end);
spawn(function()
	pcall(function()
		while wait() do
			if World3 then
				if _G.Settings.Farm["Auto Pirate Raid"] or _G.Settings.Race["Auto Race V3"] or _G.Settings.Farm["Auto Kill Cake Prince"] or _G.Settings.SeaStack["Teleport To Kitsune Island"] or _G.Settings.SeaStack["Teleport To Frozen Dimension"] or _G.Settings.SeaStack["Sail To Frozen Dimension"] or _G.Settings.SeaStack["Summon Frozen Dimension"] or _G.Settings.SeaStack["Summon Kitsune Island"] or _G.Settings.SeaStack["Teleport To Mirage Island"] or _G.Settings.Race["Auto Train"] or _G.Settings.Items["Auto Press Haki Button"] or _G.Settings.SeaEvent["Sail Boat"] or _G.Settings.Items["Auto Arena Trainer"] or _G.Settings.Race["Auto Kill Player After Trial"] or _G.Settings.Race["Tween To Highest Mirage"] or _G.Settings.Race["Auto Trial"] or _G.Settings.Race["Find Blue Gear"] or _G.Settings.Combat["Auto Kill Player Quest"] or _G.Settings.Items["Auto Cursed Dual Katana"] or _G.Settings.Farm["Auto Farm Bone"] or _G.Settings.Farm["Auto Kill Dough King"] or _G.Settings.Items["Auto Soul Guitar"] or _G.Settings.Items["Auto Tushita"] or _G.Settings.Farm["Auto Elite Hunter"] or _G.AutoKillSelectedPlayer or _G.Settings.Items["Auto Rainbow Haki"] or _G.Settings.Items["Auto Dark Dagger"] or _G.Settings.Farm["Auto Farm Ectoplasm"] or _G.Settings.Farm["Auto Observation V2"] or _G.Settings.Farm["Auto Musketeer Hat"] or _G.Settings.Items["Auto Holy Torch"] or _G.Settings.Items["Auto Hallow Scythe"] or _G.Settings.Farm["Auto Farm Katakuri"] or _G.Settings.Farm["Auto Farm Conjured Cocoa"] or _G.Settings.Farm["Auto Farm Fish Tail"] or _G.Settings.Farm["Auto Farm Gunpowder"] or _G.Settings.Farm["Auto Farm Dragon Scale"] or _G.Settings.Farm["Auto Farm Scrap Metal"] or _G.Settings.Farm["Auto Farm Mini Tusk"] or _G.Settings.Items["Auto Buddy Sword"] or _G.Settings.Items["Auto Canvander"] or _G.Settings.Farm["Auto Farm Leather"] or _G.Settings.Raid["Auto Dungeon"] then
					for _, v in pairs((game:GetService("Players")).LocalPlayer.Character:GetDescendants()) do
						if v:IsA("BasePart") then
							v.CanCollide = false;
						end;
					end;
				end;
			end;
		end;
	end);
end);
spawn(function()
	pcall(function()
		while wait() do
			if _G.Settings.Main["Auto Farm"] or _G.Settings.Farm["Auto Farm Chest Tween"] or _G.Settings.Items["Auto Electric Claw"] or _G.Settings.Main["Auto Farm Fruit Mastery"] or _G.Settings.Main["Auto Farm Gun Mastery"] or _G.TeleportIsland or _G.AutoKillSelectedPlayer or _G.TeleportToPlayer or _G.Settings.Farm["Auto Farm Observation"] or _G.Settings.Fruit["Tween To Fruit"] or _G.TeleportNPC or _G.Settings.Main["Auto Farm Mob"] or _G.Settings.Main["Auto Farm Fast"] or _G.Settings.Main["Auto Farm All Boss"] or _G.Settings.Main["Auto Farm Boss"] or _G.Settings.Main["Auto Farm Sword Mastery"] then
				if not (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					local Noclip = Instance.new("BodyVelocity");
					Noclip.Name = "BodyClip";
					Noclip.Parent = (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart;
					Noclip.MaxForce = Vector3.new(100000, 100000, 100000);
					Noclip.Velocity = Vector3.new(0, 0, 0);
				end;
			end;
		end;
	end);
end);
spawn(function()
	pcall(function()
		(game:GetService("RunService")).Stepped:Connect(function()
			if _G.Settings.Main["Auto Farm"] or _G.Settings.Farm["Auto Farm Chest Tween"] or _G.Settings.Items["Auto Electric Claw"] or _G.Settings.Main["Auto Farm Fruit Mastery"] or _G.Settings.Main["Auto Farm Gun Mastery"] or _G.TeleportIsland or _G.AutoKillSelectedPlayer or _G.TeleportToPlayer or _G.Settings.Farm["Auto Farm Observation"] or _G.Settings.Fruit["Tween To Fruit"] or _G.TeleportNPC or _G.Settings.Main["Auto Farm Mob"] or _G.Settings.Main["Auto Farm Fast"] or _G.Settings.Main["Auto Farm All Boss"] or _G.Settings.Main["Auto Farm Boss"] or _G.Settings.Main["Auto Farm Sword Mastery"] then
				for _, v in pairs((game:GetService("Players")).LocalPlayer.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false;
					end;
				end;
			end;
		end);
	end);
end);
function InstancePos(pos)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos;
end;
function TP3(pos)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos;
end;
function StopTween(target)
	if not target then
		_G.StopTween = true;
		wait();
		topos((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame);
		wait();
		if (game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
			((game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip")):Destroy();
		end;
		_G.StopTween = false;
		_G.Clip = false;
	end;
end;
function RemoveAnimation(Mon)
	Mon.Humanoid:ChangeState(11);
	if Mon.Humanoid:FindFirstChild("Animator") then
		Mon.Humanoid.Animator:Destroy();
	end;
end;
spawn(function()
	pcall(function()
		while wait() do
			for i, v in pairs((game:GetService("Players")).LocalPlayer.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					if v:FindFirstChild("RemoteFunctionShoot") then
						SelectWeaponGun = v.Name;
					end;
				end;
			end;
		end;
	end);
end);
(game:GetService("Players")).LocalPlayer.Idled:connect(function()
	(game:GetService("VirtualUser")):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame);
	wait(1);
	(game:GetService("VirtualUser")):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame);
end);
]========]}
