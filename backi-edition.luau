repeat task.wait() until game:IsLoaded() and game:GetService("Players").LocalPlayer

local function missing(t, f, fallback)
	if type(f) == t then return f end
	return fallback
end

local function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

cloneref = missing("function", cloneref, function(...) return ... end)
queueteleport = missing("function", queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport))
waxwritefile, waxreadfile = writefile, readfile
writefile = missing("function", waxwritefile) and function(file, data, safe)
	if safe == true then return pcall(waxwritefile, file, data) end
	waxwritefile(file, data)
end
readfile = missing("function", waxreadfile) and function(file, safe)
	if safe == true then return pcall(waxreadfile, file) end
	return waxreadfile(file)
end
isfile = missing("function", isfile, readfile and function(file)
	local success, result = pcall(function()
		return readfile(file)
	end)
	return success and result ~= nil and result ~= ""
end)
makefolder = missing("function", makefolder)
isfolder = missing("function", isfolder)
waxgetcustomasset = missing("function", getcustomasset or getsynasset)

Services = setmetatable({}, {
	__index = function(self, name)
		local success, cache = pcall(function()
			return cloneref(game:GetService(name))
		end)
		if success then
			rawset(self, name, cache)
			return cache
		else
			pcall(error, string.format("Invalid Roblox Service >: %s", tostring(name)))
		end
	end
})

local Debris: Debris = Services.Debris
local CoreGui: CoreGui = Services.CoreGui

if game.PlaceId ~= 18687417158 then
	local Hint = Instance.new("Hint")
	Hint.Text = "wrong place - script executed >: Forsaken - Backi Edition."
	Hint.Parent = CoreGui
	
	game:GetService("Debris"):AddItem(Hint, 10.5)
end

local ContentProvider: ContentProvider = Services.ContentProvider
local TweenService: TweenService = Services.TweenService
local Players: Players = Services.Players

local LogLevel = {
	Info = 1,
	Warning = 2,
	Error = 3
}

local function Debug(content, level)
	local prefix = "[TaskKill - Forsaken Backi Edition]: %s"
	local contentStr = tostring(content)
	local OutputContent = prefix:format(contentStr)

	if level == LogLevel.Info then
		print(OutputContent)
	elseif level == LogLevel.Warning then
		warn(OutputContent)
	elseif level == LogLevel.Error then
		error(OutputContent)
	else
		print(OutputContent)
	end
end

local Players: Players = Services.Players
local TweenService: TweenService = Services.TweenService
local StarterGui: StarterGui = Services.StarterGui

local LocalUser = Players.LocalPlayer
local rnd = Random.new(os.clock())

local Hitboxes = workspace:WaitForChild("Hitboxes")
local InvalidHitbox = BrickColor.new("Persimmon")

PARENT = nil
if get_hidden_gui or gethui then
	local hiddenUI = get_hidden_gui or gethui
	local Main = Instance.new("ScreenGui")
	Main.Name = "Taskhub | Backi Edition."
	Main.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
	Main.Parent = hiddenUI()
	PARENT = Main
elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
	local Main = Instance.new("ScreenGui")
	Main.Name = "Taskhub | Backi Edition."
	Main.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
	syn.protect_gui(Main)
	Main.Parent = CoreGui
	PARENT = Main
elseif CoreGui:FindFirstChild("RobloxGui") then
	PARENT = CoreGui.RobloxGui
else
	local Main = Instance.new("ScreenGui")
	Main.Name = "Taskhub | Backi Edition."
	Main.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
	Main.Parent = CoreGui
	PARENT = Main
end

local LobSound = Instance.new("Sound")
LobSound.Volume = 1

local LobImg = Instance.new("ImageLabel")
LobImg.AnchorPoint = Vector2.new(.5, .5)
LobImg.Position = UDim2.new(.5, 0, .5, 0)
LobImg.Size = UDim2.new(1, 0, 1, 0)
LobImg.BorderSizePixel = 0
LobImg.Visible = true
LobImg.Active = false
LobImg.Selectable = false
LobImg.Interactable = false

local Debounce = false

local Sounds = {
	[1] = "rbxassetid://131803555321436",
	[2] = "rbxassetid://70542612197339",
	[3] = "rbxassetid://97537650507170",
	[4] = "rbxassetid://2796806401",
	[5] = "rbxassetid://74554489344594",
	[6] = "rbxassetid://129247666293361",
	[7] = "rbxassetid://92665389750132",
	[8] = "rbxassetid://81079187158300",
	[9] = "rbxassetid://139366645110326",
	[10] = "rbxassetid://119377232200519"
}

local Images = {}

if not isfolder("Taskhub-BackiEdition") then
	makefolder("Taskhub-BackiEdition")
end

local function LoadAssetAsync(path: string, url: string)
	local encoded = game:HttpGetAsync(url)
	waxwritefile(("Taskhub-BackiEdition/%s"):format(path), base64decode(encoded))
	Debug(("Asset Loaded >: %s"):format(path), 1)
	return waxgetcustomasset(("Taskhub-BackiEdition/%s"):format(path))
end

local function SendMessageFromCore(content)
	StarterGui:SetCore("SendNotification", {
		Title = content.Title or "",
		Text = content.Text or "",
		Duration = content.Duration or 5
	})
end

Images[1] = LoadAssetAsync("BackImage1.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image1.txt")
Images[2] = LoadAssetAsync("BackImage2.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image2.txt")
Images[3] = LoadAssetAsync("BackImage3.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image3.txt")
Images[4] = LoadAssetAsync("BackImage4.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image4.txt")
Images[5] = LoadAssetAsync("BackImage5.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image5.txt")
Images[6] = LoadAssetAsync("BackImage6.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image6.txt")
Images[7] = LoadAssetAsync("BackImage7.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image7.txt")
Images[8] = LoadAssetAsync("BackImage8.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image8.txt")
Images[9] = LoadAssetAsync("BackImage9.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image9.txt")
Images[10] = LoadAssetAsync("BackImage10.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image10.txt")
Images[11] = LoadAssetAsync("BackImage11.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image11.txt")
Images[12] = LoadAssetAsync("BackImage12.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image12.txt")
Images[13] = LoadAssetAsync("BackImage13.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image13.txt")
Images[14] = LoadAssetAsync("BackImage14.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image14.txt")
Images[15] = LoadAssetAsync("BackImage15.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image15.txt")
Images[16] = LoadAssetAsync("BackImage16.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image16.txt")
Images[17] = LoadAssetAsync("BackImage17.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image17.txt")
Images[18] = LoadAssetAsync("BackImage18.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image18.txt")
Images[19] = LoadAssetAsync("BackImage19.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image19.txt")
Images[20] = LoadAssetAsync("BackImage20.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image20.txt")
Images[21] = LoadAssetAsync("BackImage21.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image21.txt")
Images[22] = LoadAssetAsync("BackImage22.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image22.txt")

Sounds[11] = LoadAssetAsync("YouFlirpingTwitt.mp3", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Musics/you%20flirping%20twit.txt")

SendMessageFromCore({
	Title = "TaskKill - Forsaken Backi Edition.",
	Text = "All Images Has loaded.",
	Duration = 5
})

local function drawFromTable(array)
	if #array == 0 then return nil end
	local index = rnd:NextInteger(1, #array)
	return array[index]
end

local function CreateImageSound()
	local ImgLabel = Instance.new("ImageLabel")
	ImgLabel.Visible = true
	ImgLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImgLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImgLabel.Size = UDim2.new(1, 0, 1, 0)
	ImgLabel.BackgroundTransparency = 1
	ImgLabel.ImageTransparency = 1
	local img = drawFromTable(Images)
	if img then
		ImgLabel.Image = img
	else
		Debug("Falha ao Carregar o Id da Imagem", 2)
		ImgLabel.Image = ""
	end

	local soundInstance = Instance.new("Sound")
	soundInstance.Volume = 1
	local soundId = drawFromTable(Sounds)
	if soundId then
		soundInstance.SoundId = soundId
	else
		Debug("Falha ao Carregar o Id do Sound", 2)
		soundInstance.SoundId = ""
	end
	
	ImgLabel.Parent = PARENT
	soundInstance.Parent = PARENT
	
	Debug(("time length da sound : %s"):format(tostring(soundInstance.TimeLength)), 1)
	
	if not soundInstance.IsLoaded then
		Debug("o thread atual vai parar até que a sound seja carregada..", 2)
		soundInstance.Loaded:Wait()
	end
	
	local TWInfo = TweenInfo.new(soundInstance.TimeLength)
	local Goal = {}
	Goal.ImageTransparency = 1
	
	local Tween = TweenService:Create(ImgLabel, TWInfo, Goal)
	
	ImgLabel.ImageTransparency = 0
	
	soundInstance:Play()
	Tween:Play()
	
	local con1
	con1 = Tween.Completed:Connect(function()
		con1:Disconnect()
		con1 = nil
		
		pcall(game.Destroy, ImgLabel)
		pcall(game.Destroy, soundInstance)
		return
	end)
end

Hitboxes.ChildAdded:Connect(function(Kid: BasePart)
	if Kid.BrickColor == InvalidHitbox then return end
	
	if Kid.Name:find(LocalUser.Name) then
		CreateImageSound()
	end
end)
