-- obfs is crazy with this

local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local LocalUser = Players.LocalPlayer

if not isfolder("Taskhub-BackiEdition") then
	makefolder("Taskhub-BackiEdition")
end

local Hitboxes = workspace.Hitboxes

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

local function LoadImageFromBase64(name, url)
	local encoded = game:HttpGet(url)
	writefile(string.format("Taskhub-BackiEdition/%s", name), base64decode(encoded))
	print(string.format("[TaskHub - BackHubi Edition]: Asset Loaded >: %s", name))
	return getcustomasset(string.format("Taskhub-BackiEdition/%s", name))
end

Images[1] = LoadImageFromBase64("Backi1.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image1.txt")
Images[2] = LoadImageFromBase64("Backi2.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image2.txt")
Images[3] = LoadImageFromBase64("Backi3.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image3.txt")
Images[4] = LoadImageFromBase64("Backi4.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image4.txt")
Images[5] = LoadImageFromBase64("Backi5.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image5.txt")
Images[6] = LoadImageFromBase64("Backi6.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image6.txt")
Images[7] = LoadImageFromBase64("Backi7.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image7.txt")
Images[8] = LoadImageFromBase64("Backi8.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image8.txt")
Images[9] = LoadImageFromBase64("Backi9.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image9.txt")
Images[10] = LoadImageFromBase64("Backi10.png", "https://raw.githubusercontent.com/not-taskkill/op-rep/refs/heads/main/Images/TaskHub-BackHubi/Image10.txt")

local function RandomSound()
	local index = math.random(1, #Sounds)
	return Sounds[index]
end

StarterGui:SetCore("SendNotification", {
	Title = "Taskhub | Backi Edition.",
	Text = "Check the console and wait for all images load.",
	Duration = 10.5
})

local function RandomImage()
	local index = math.random(1, #Images)
	return Images[index]
end

local Debounce = false

local Invalid = BrickColor.new("Persimmon")
local Valid = BrickColor.new("Olivine")

local Handler = Instance.new("ScreenGui")
Handler.Enabled = true
Handler.ResetOnSpawn = false
Handler.Name = "TaskHub - BackHubi Edition."
Handler.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
Handler.Parent = gethui()

local ImgLabel = Instance.new("ImageLabel")
ImgLabel.Visible = true
ImgLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImgLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ImgLabel.Size = UDim2.new(1, 0, 1, 0)
ImgLabel.BackgroundTransparency = 1
ImgLabel.ImageTransparency = 1
ImgLabel.Image = RandomImage()
ImgLabel.Parent = Handler

local Sound = Instance.new("Sound")
Sound.Volume = 1
Sound.Parent = Handler

local function goodtween(Sound: Sound)
	if Debounce then return end
	Debounce = true
	
	ImgLabel.ImageTransparency = 0
	
	if not Sound.IsLoaded then
		Sound.Loaded:Wait()
	end
	
	local twif = TweenInfo.new(Sound.TimeLength)
	local Goal = {
		ImageTransparency = 1
	}
	
	local epictween = TweenService:Create(ImgLabel, twif, Goal)
	
	Sound:Play()
	epictween:Play()
	
	epictween.Completed:Connect(function()
		Debounce = false
	end)
end

Hitboxes.ChildAdded:Connect(function(Kid)
	if Kid.BrickColor == Invalid then
		return
	end
	
	if Kid.Name:find(LocalUser.Name) then
		ImgLabel.Image = RandomImage()
		Sound.SoundId = RandomSound()
		
		goodtween(Sound)
	end
end)
