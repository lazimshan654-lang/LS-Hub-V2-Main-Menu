local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Version = Instance.new("TextLabel")
local Status = Instance.new("TextLabel")
local BarBG = Instance.new("Frame")
local Bar = Instance.new("Frame")

ScreenGui.Parent = game:GetService("CoreGui")

local Sound = Instance.new("Sound")
Sound.Parent = game:GetService("SoundService")
Sound.SoundId = "rbxassetid://9118828563"
Sound.Volume = 5

Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true
Frame.Size = UDim2.new(0, 290, 0, 115)
Frame.Position = UDim2.new(0.5, -145, 0.5, -58)
Frame.BackgroundColor3 = Color3.fromRGB(12,12,20)
Frame.BorderSizePixel = 0

local Corner = Instance.new("UICorner")
Corner.Parent = Frame

local Stroke = Instance.new("UIStroke")
Stroke.Parent = Frame
Stroke.Color = Color3.fromRGB(0,170,255)
Stroke.Thickness = 1.5

Title.Parent = Frame
Title.Size = UDim2.new(1,0,0,35)
Title.BackgroundTransparency = 1
Title.Text = "LS Robux Eligibility Check"
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

Version.Parent = Frame
Version.Size = UDim2.new(1,0,0,18)
Version.Position = UDim2.new(0,0,0,25)
Version.BackgroundTransparency = 1
Version.Text = "LS Reward Scanner v2.0"
Version.TextColor3 = Color3.fromRGB(150,150,150)
Version.Font = Enum.Font.Gotham
Version.TextScaled = true

Status.Parent = Frame
Status.Size = UDim2.new(1,-20,0,25)
Status.Position = UDim2.new(0,10,0,55)
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.new(1,1,1)
Status.Font = Enum.Font.Gotham
Status.TextScaled = true

BarBG.Parent = Frame
BarBG.Size = UDim2.new(0.9,0,0,12)
BarBG.Position = UDim2.new(0.05,0,0.82,0)
BarBG.BackgroundColor3 = Color3.fromRGB(25,25,35)

local Corner2 = Instance.new("UICorner")
Corner2.Parent = BarBG

Bar.Parent = BarBG
Bar.Size = UDim2.new(0,0,1,0)
Bar.BackgroundColor3 = Color3.fromRGB(0,170,255)

local Corner3 = Instance.new("UICorner")
Corner3.Parent = Bar

local player = game.Players.LocalPlayer
local username = player.Name

local messages = {
	"Checking Account Age...",
	"Checking Reward Eligibility...",
	"Contacting Robux Servers...",
	"Verifying Username...",
	"Calculating Bonus Rewards...",
	"Generating Reward Report...",
	"Final Verification..."
}

for i, msg in ipairs(messages) do
	Sound:Play()
	Status.Text = msg .. " [" .. math.random(10,99) .. "%]"

	Bar:TweenSize(
		UDim2.new(i/#messages,0,1,0),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		1.5,
		true
	)

	task.wait(1.8)
end

task.wait(1)

local scans = {
    "Scanning Account...",
    "Found User: "..username,
    "Checking LS Database...",
    "Checking Eligibility...",
    "Reviewing Reward History...",
    "Analyzing Robux Activity...",
    "Searching For Bonus Rewards...",
    "Contacting Reward Servers...",

    "🎉 Potential Reward Found!",
    "Reward Value: 1000000 Robux",
    "Verifying Reward...",
    "Checking Common Sense...",

    "ERROR: Common Sense Not Found 🤡",
    "Free Robux Found: 0",

    "Reviewing Evidence...",
    "✓ Free Robux search detected",
    "✓ Suspicious excitement detected",
    "✓ Falling for obvious bait detected",

    "🚨 Scam Awareness Test Complete",
    "Result: Professional Robux Hunter Detected 🤡",

    "Lesson Learned +1",
    "Remember: Free Robux generators are fake 😂"
}

for _, scan in ipairs(scans) do
Sound:Play()
	Status.Text = scan
	task.wait(1.3)
end

task.wait(2)

Status.Text = "🎁 Reward Verification Failed"
Sound:Play()
task.wait(1.5)

Status.Text = "💰 Free Robux Awarded: 0"
Sound:Play()
task.wait(1.5)

Status.Text = "🧠 Common Sense: Not Found"
Sound:Play()
task.wait(1.5)

Status.Text = "⚠ Scam Resistance: Critical"
Sound:Play()
task.wait(1.5)

Status.Text = "🤡 Robux Generator Detected"
Sound:Play()
task.wait(2)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:FindFirstChild("HumanoidRootPart")

Status.Text = "🚀 Sending Robux Hunter To Reality..."
Sound:Play()
task.wait(0.1)

if hrp then
	hrp.AssemblyLinearVelocity = Vector3.new(
		0,
		10000,
		0
	)
end

task.wait(1)

Status.Text = "📡 Signal Lost..."

task.wait(1.5)

Status.Text = "❌ User Has Returned To Reality"

task.wait(2)

ScreenGui:Destroy()
