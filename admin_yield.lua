-- [[ 👑 LS ADMIN YIELD REBUILT MASTER v5 ]] --
-- Cleaned Version: Removed Invisible & Fling Player commands
-- Updated: Added Minimize to Round Movable Logo Icon Functionality & Admin Auto-Leave Safety Engine

if IY_LOADED and not (_G.IY_DEBUG == true) then
	return
end
pcall(function() getgenv().IY_LOADED = true end)

local COREGUI = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

-- LS Premium Blue Palette Colors
local PremiumBlue = Color3.fromRGB(0, 170, 255)
local DarkSlate = Color3.fromRGB(15, 15, 20)
local JetBlack = Color3.fromRGB(12, 12, 16)
local HeaderColor = Color3.fromRGB(22, 22, 30)
local TextColor = Color3.fromRGB(255, 255, 255)

-- Global Core Script Mechanics
local targetSpeed = 16
local targetJump = 50
local flySpeed = 50
local gravityVal = 196.2
local fovVal = 70
local flying = false
local noclip = false
local infJump = false
local shiftLockEnabled = false
local noFogEnabled = false

-- Storage Cache for NoFog Restoration
local lightingCache = {
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    Atmosphere = nil,
    Sky = nil
}

local Commands = {}
local PanelOpenTriggers = {}
local LiveValueUpdaters = {}

-- ==========================================
-- [[ AUTOMATED ADMIN DETECTOR ENGINE ]]
-- ==========================================
local function checkPlayerAndSafetyLeave(player)
    if player == LocalPlayer then return end
    
    -- Safe check for Group-based Game Admins/Creators or official Roblox staff badges
    pcall(function()
        if game.CreatorType == Enum.CreatorType.Group then
            if player:GetRankInGroup(game.CreatorId) >= 200 then
                LocalPlayer:Kick("👑 [LS Anti-Ban]: Emergency Disconnect! A Game Group Admin joined.")
            end
        else
            if player.UserId == game.CreatorId then
                LocalPlayer:Kick("👑 [LS Anti-Ban]: Emergency Disconnect! The Game Creator joined.")
            end
        end
        
        if player:IsInGroup(1200769) then -- Official Roblox Staff Group ID
            LocalPlayer:Kick("👑 [LS Anti-Ban]: Emergency Disconnect! Official Roblox Staff Member detected entering the server.")
        end
     pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.ClassName == "SafetyMock" then
             LocalPlayer:Kick("👑 [LS Anti-Ban]: Client Safe Exit Traced.")
        end
     end)
    end)
end

-- Scan anyone currently in the server on launch
for _, player in ipairs(Players:GetPlayers()) do
    checkPlayerAndSafetyLeave(player)
end

-- Constantly listen for any staff connecting mid-game
Players.PlayerAdded:Connect(checkPlayerAndSafetyLeave)
-- ==========================================

-- Base Protected Container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LS_Admin_Yield_Master"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = COREGUI

-- Main Window Framework
local Holder = Instance.new("Frame")
Holder.Name = "MainFrame"
Holder.Parent = ScreenGui
Holder.Active = true
Holder.Draggable = true
Holder.BackgroundColor3 = DarkSlate
Holder.Position = UDim2.new(1, -260, 1, -260)
Holder.Size = UDim2.new(0, 250, 0, 240)
Holder.ZIndex = 10
Instance.new("UICorner", Holder).CornerRadius = UDim.new(0, 6)

-- UPGRADED PREMIUM OUTER BORDER
local stroke = Instance.new("UIStroke", Holder)
stroke.Color = PremiumBlue
stroke.Thickness = 2                   
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Transparency = 0.15             

-- Header Banner Label
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Holder
Title.BackgroundColor3 = HeaderColor
Title.Size = UDim2.new(1, 0, 0, 28)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.Text = "👑 LS Admin Yield v5"
Title.TextColor3 = PremiumBlue
Title.ZIndex = 12
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 6)

-- MINIMIZE BUTTON (PC Style '—' Icon)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = Holder
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Position = UDim2.new(1, -28, 0, 2)
MinimizeBtn.Text = "—"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 14
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.ZIndex = 13

-- MOVABLE ROUND LOGO ICON (When Minimized)
local LogoIcon = Instance.new("TextButton")
LogoIcon.Name = "LS_LogoIcon"
LogoIcon.Parent = ScreenGui
LogoIcon.Size = UDim2.new(0, 50, 0, 50)
LogoIcon.Position = UDim2.new(1, -70, 0.5, -25) 
LogoIcon.BackgroundColor3 = DarkSlate
LogoIcon.Text = "LS"
LogoIcon.Font = Enum.Font.GothamBold
LogoIcon.TextSize = 18
LogoIcon.TextColor3 = PremiumBlue
LogoIcon.Visible = false
LogoIcon.Active = true
LogoIcon.Draggable = true
LogoIcon.ZIndex = 20
Instance.new("UICorner", LogoIcon).CornerRadius = UDim.new(1, 0) 

local LogoStroke = Instance.new("UIStroke", LogoIcon)
LogoStroke.Color = PremiumBlue
LogoStroke.Thickness = 2
LogoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Minimize & Restore Window Functionality
MinimizeBtn.MouseButton1Click:Connect(function()
    Holder.Visible = false
    LogoIcon.Visible = true
end)

LogoIcon.MouseButton1Click:Connect(function()
    LogoIcon.Visible = false
    Holder.Visible = true
end)

-- Inner Base Frame Body
local Dark = Instance.new("Frame")
Dark.Name = "Dark"
Dark.Parent = Holder
Dark.BackgroundColor3 = JetBlack
Dark.Position = UDim2.new(0, 0, 0, 56)
Dark.Size = UDim2.new(1, 0, 1, -56)
Dark.ZIndex = 11

-- Interactive Execution Text Box
local Cmdbar = Instance.new("TextBox")
Cmdbar.Name = "Cmdbar"
Cmdbar.Parent = Holder
Cmdbar.BackgroundTransparency = 1
Cmdbar.Position = UDim2.new(0, 10, 0, 28)
Cmdbar.Size = UDim2.new(1, -20, 0, 28)
Cmdbar.Font = Enum.Font.Gotham
Cmdbar.TextSize = 12
Cmdbar.TextColor3 = TextColor
Cmdbar.PlaceholderText = "⚡ Type Command Here..."
Cmdbar.TextXAlignment = Enum.TextXAlignment.Left
Cmdbar.ZIndex = 12

-- Scrolling Frame Area
local CMDsF = Instance.new("ScrollingFrame")
CMDsF.Name = "CMDs"
CMDsF.Parent = Dark
CMDsF.BackgroundTransparency = 1
CMDsF.Position = UDim2.new(0, 6, 0, 6)
CMDsF.Size = UDim2.new(1, -12, 1, -12)
CMDsF.ScrollBarImageColor3 = PremiumBlue
CMDsF.ScrollBarThickness = 4
CMDsF.ZIndex = 12

local cmdListLayout = Instance.new("UIListLayout")
cmdListLayout.Parent = CMDsF
cmdListLayout.SortOrder = Enum.SortOrder.LayoutOrder
cmdListLayout.Padding = UDim.new(0, 4)

cmdListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    CMDsF.CanvasSize = UDim2.new(0, 0, 0, cmdListLayout.AbsoluteContentSize.Y + 15)
end)

-- Shared Function to Draw Settings Panel
local function createActionPanel(titleName, setupContentFunc)
    if Holder:FindFirstChild("ActionPanel") then
        Holder.ActionPanel:Destroy()
    end
    
    local ActionPanel = Instance.new("Frame")
    ActionPanel.Name = "ActionPanel"
    ActionPanel.Parent = Holder
    ActionPanel.BackgroundColor3 = JetBlack
    ActionPanel.Size = UDim2.new(1, 0, 1, -28)
    ActionPanel.Position = UDim2.new(1, 0, 0, 28)
    ActionPanel.ZIndex = 40
    Instance.new("UICorner", ActionPanel).CornerRadius = UDim.new(0, 6)
    
    local panelStroke = Instance.new("UIStroke", ActionPanel)
    panelStroke.Color = PremiumBlue
    panelStroke.Thickness = 2
    panelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    panelStroke.Transparency = 0.15
    
    local PanelTitle = Instance.new("TextLabel")
    PanelTitle.Parent = ActionPanel
    PanelTitle.Text = "⚙️ " .. titleName .. " Settings"
    PanelTitle.Font = Enum.Font.GothamBold
    PanelTitle.TextSize = 12
    PanelTitle.TextColor3 = PremiumBlue
    PanelTitle.BackgroundColor3 = HeaderColor
    PanelTitle.Size = UDim2.new(1, 0, 0, 26)
    PanelTitle.ZIndex = 42
    Instance.new("UICorner", PanelTitle).CornerRadius = UDim.new(0, 6)

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = ActionPanel
    CloseBtn.Text = "✕"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Size = UDim2.new(0, 24, 0, 24)
    CloseBtn.Position = UDim2.new(1, -26, 0, 1)
    CloseBtn.TextSize = 12
    CloseBtn.ZIndex = 43
    
    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(ActionPanel, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Position = UDim2.new(1, 0, 0, 28)}):Play()
        task.wait(0.15)
        ActionPanel:Destroy()
    end)
    
    setupContentFunc(ActionPanel)
    TweenService:Create(ActionPanel, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 0, 0, 28)}):Play()
end

local function addcmd(cleanDisplayName, internalCommandKey, onClickPanelSetup)
    local CmdButton = Instance.new("TextButton")
    CmdButton.Name = cleanDisplayName
    CmdButton.Parent = CMDsF
    CmdButton.BackgroundColor3 = DarkSlate
    CmdButton.Size = UDim2.new(1, 0, 0, 28)
    CmdButton.Font = Enum.Font.GothamMedium
    CmdButton.TextSize = 12
    CmdButton.Text = "  " .. cleanDisplayName
    CmdButton.TextColor3 = TextColor
    CmdButton.TextXAlignment = Enum.TextXAlignment.Left
    CmdButton.ZIndex = 15
    Instance.new("UICorner", CmdButton).CornerRadius = UDim.new(0, 4)
    
    local function openPanel()
        if onClickPanelSetup then
            createActionPanel(cleanDisplayName, onClickPanelSetup)
        else
            if Commands[internalCommandKey:lower()] then
                Commands[internalCommandKey:lower()]({})
            end
        end
    end
    
    CmdButton.MouseButton1Click:Connect(openPanel)
    PanelOpenTriggers[internalCommandKey:lower()] = openPanel
end

local function registerAction(key, func)
    Commands[key:lower()] = func
end

-- [[ FLIGHT ENGINE CORE ]] --
local function runFlightEngine()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    
    if not flying then
        if root:FindFirstChild("FlyBG") then root.FlyBG:Destroy() end
        if root:FindFirstChild("FlyBV") then root.FlyBV:Destroy() end
        hum.PlatformStand = false
        return
    end
    
    if root:FindFirstChild("FlyBG") then root.FlyBG:Destroy() end
    if root:FindFirstChild("FlyBV") then root.FlyBV:Destroy() end
    
    hum.PlatformStand = true
    local bg = Instance.new("BodyGyro", root)
    bg.Name = "FlyBG"
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = root.CFrame
    
    local bv = Instance.new("BodyVelocity", root)
    bv.Name = "FlyBV"
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    
    task.spawn(function()
        local cam = workspace.CurrentCamera
        while flying and root and root.Parent do
            task.wait()
            if hum.MoveDirection.Magnitude > 0 then
                bv.velocity = cam.CFrame.LookVector * flySpeed
            else
                bv.velocity = Vector3.new(0, 0.1, 0)
            end
            bg.cframe = cam.CFrame
        end
    end)
end

-- [[ REGISTER GLOBAL HANDLERS ]] --
registerAction("fly", function(args) 
    flying = true 
    if args and args[1] then flySpeed = tonumber(args[1]) or flySpeed end 
    runFlightEngine() 
    if LiveValueUpdaters["fly"] then LiveValueUpdaters["fly"]() end
end)
registerAction("unfly", function() 
    flying = false 
    runFlightEngine() 
    if LiveValueUpdaters["fly"] then LiveValueUpdaters["fly"]() end
end)
registerAction("speed", function(args) 
    targetSpeed = args and args[1] and tonumber(args[1]) or 16 
    pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = targetSpeed end) 
    if LiveValueUpdaters["speed"] then LiveValueUpdaters["speed"]() end
end)
registerAction("jumppower", function(args) 
    targetJump = args and args[1] and tonumber(args[1]) or 50 
    pcall(function() LocalPlayer.Character.Humanoid.UseJumpPower = true LocalPlayer.Character.Humanoid.JumpPower = targetJump end) 
    if LiveValueUpdaters["jumppower"] then LiveValueUpdaters["jumppower"]() end
end)
registerAction("noclip", function() 
    noclip = true 
    if LiveValueUpdaters["noclip"] then LiveValueUpdaters["noclip"]() end
    task.spawn(function() while noclip do if LocalPlayer.Character then for _, p in ipairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end task.wait() end end) 
end)
registerAction("clip", function() 
    noclip = false 
    if LiveValueUpdaters["noclip"] then LiveValueUpdaters["noclip"]() end
end)

UserInputService.JumpRequest:Connect(function() 
    if infJump then 
        pcall(function() LocalPlayer.Character.Humanoid:ChangeState("Jumping") end) 
    end 
end)
registerAction("infjump", function() infJump = true if LiveValueUpdaters["infjump"] then LiveValueUpdaters["infjump"]() end end)
registerAction("uninfjump", function() infJump = false if LiveValueUpdaters["infjump"] then LiveValueUpdaters["infjump"]() end end)

registerAction("kill", function() pcall(function() LocalPlayer.Character:BreakJoints() end) end)
registerAction("freeze", function() pcall(function() LocalPlayer.Character.HumanoidRootPart.Anchored = true end) end)
registerAction("unfreeze", function() pcall(function() LocalPlayer.Character.HumanoidRootPart.Anchored = false end) end)

registerAction("gravity", function(args) gravityVal = args and args[1] and tonumber(args[1]) or 196.2 workspace.Gravity = gravityVal if LiveValueUpdaters["gravity"] then LiveValueUpdaters["gravity"]() end end)
registerAction("fov", function(args) fovVal = args and args[1] and tonumber(args[1]) or 70 workspace.CurrentCamera.FieldOfView = fovVal if LiveValueUpdaters["fov"] then LiveValueUpdaters["fov"]() end end)

RunService.RenderStepped:Connect(function()
    if shiftLockEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local cam = workspace.CurrentCamera
        local root = LocalPlayer.Character.HumanoidRootPart
        cam.CFrame = cam.CFrame * CFrame.new(1.7, 0.5, 0)
        local lookVector = cam.CFrame.LookVector
        root.CFrame = CFrame.new(root.Position, Vector3.new(root.Position.X + lookVector.X, root.Position.Y, root.Position.Z + lookVector.Z))
    end
end)
registerAction("shiftlock", function() shiftLockEnabled = true if LiveValueUpdaters["shiftlock"] then LiveValueUpdaters["shiftlock"]() end end)
registerAction("unshiftlock", function() shiftLockEnabled = false if LiveValueUpdaters["shiftlock"] then LiveValueUpdaters["shiftlock"]() end end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if noFogEnabled then
            pcall(function()
                if Lighting.FogEnd ~= 9e9 then
                    lightingCache.FogEnd = Lighting.FogEnd
                    lightingCache.FogStart = Lighting.FogStart
                    Lighting.FogEnd = 9e9
                    Lighting.FogStart = 9e9
                end
                for _, v in ipairs(Lighting:GetChildren()) do
                    if v:IsA("Atmosphere") or v:IsA("Clouds") or v:IsA("Sky") then
                        if not lightingCache.Atmosphere and v:IsA("Atmosphere") then lightingCache.Atmosphere = v:Clone() end
                        if not lightingCache.Sky and v:IsA("Sky") then lightingCache.Sky = v:Clone() end
                        v:Destroy()
                    end
                end
            end)
        end
    end
end)

registerAction("nofog", function() noFogEnabled = true if LiveValueUpdaters["nofog"] then LiveValueUpdaters["nofog"]() end end)
registerAction("unnofog", function() 
    noFogEnabled = false 
    pcall(function()
        Lighting.FogEnd = lightingCache.FogEnd
        Lighting.FogStart = lightingCache.FogStart
        if lightingCache.Atmosphere then lightingCache.Atmosphere:Clone().Parent = Lighting end
        if lightingCache.Sky then lightingCache.Sky:Clone().Parent = Lighting end
    end)
    if LiveValueUpdaters["nofog"] then LiveValueUpdaters["nofog"]() end 
end)


-- [[ GENERATING UI CONFIG INTERFACES ]] --

addcmd("Fly", "fly", function(p)
    local ToggleBtn = Instance.new("TextButton", p)
    ToggleBtn.Size = UDim2.new(1, -30, 0, 32)
    ToggleBtn.Position = UDim2.new(0, 15, 0, 40)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 12
    ToggleBtn.TextColor3 = TextColor
    ToggleBtn.ZIndex = 45
    
    local Lbl = Instance.new("TextLabel", p)
    Lbl.Text = "Fly Speed Velocity:"
    Lbl.Font = Enum.Font.GothamMedium
    Lbl.TextColor3 = PremiumBlue
    Lbl.Size = UDim2.new(0, 150, 0, 20)
    Lbl.Position = UDim2.new(0, 15, 0, 85)
    Lbl.BackgroundTransparency = 1
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 45

    local Box = Instance.new("TextBox", p)
    Box.Size = UDim2.new(1, -30, 0, 28)
    Box.Position = UDim2.new(0, 15, 0, 110)
    Box.BackgroundColor3 = HeaderColor
    Box.TextColor3 = TextColor
    Box.Font = Enum.Font.Gotham
    Box.ZIndex = 45
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", Box).Color = PremiumBlue
    
    local function refreshFlyUI()
        ToggleBtn.BackgroundColor3 = flying and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(180, 50, 50)
        ToggleBtn.Text = flying and "FLYING: ENABLED" or "FLYING: DISABLED"
        Box.Text = tostring(flySpeed)
    end
    refreshFlyUI()
    LiveValueUpdaters["fly"] = refreshFlyUI
    
    ToggleBtn.MouseButton1Click:Connect(function()
        if flying then Commands["unfly"]() else Commands["fly"]({}) end
    end)
    
    Box.FocusLost:Connect(function()
        flySpeed = tonumber(Box.Text) or flySpeed
        if flying then runFlightEngine() end
    end)
end)

addcmd("Speed", "speed", function(p)
    local Box = Instance.new("TextBox", p)
    Box.Size = UDim2.new(1, -30, 0, 32)
    Box.Position = UDim2.new(0, 15, 0, 45)
    Box.BackgroundColor3 = HeaderColor
    Box.Font = Enum.Font.Gotham
    Box.TextColor3 = TextColor
    Box.ZIndex = 45
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", Box).Color = PremiumBlue
    
    local Btn = Instance.new("TextButton", p)
    Btn.Size = UDim2.new(1, -30, 0, 32)
    Btn.Position = UDim2.new(0, 15, 0, 90)
    Btn.BackgroundColor3 = PremiumBlue
    Btn.Font = Enum.Font.GothamBold
    Btn.Text = "CONFIRM WALKSPEED"
    Btn.TextColor3 = DarkSlate
    Btn.ZIndex = 45
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    
    local function refreshSpeedUI() Box.Text = tostring(targetSpeed) end
    refreshSpeedUI()
    LiveValueUpdaters["speed"] = refreshSpeedUI
    
    Btn.MouseButton1Click:Connect(function()
        targetSpeed = tonumber(Box.Text) or 16
        Commands["speed"]({targetSpeed})
    end)
end)

addcmd("Noclip", "noclip", function(p)
    local ToggleBtn = Instance.new("TextButton", p)
    ToggleBtn.Size = UDim2.new(1, -30, 0, 45)
    ToggleBtn.Position = UDim2.new(0, 15, 0, 50)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 12
    ToggleBtn.TextColor3 = TextColor
    ToggleBtn.ZIndex = 45
    
    local function refreshNoclipUI()
        ToggleBtn.BackgroundColor3 = noclip and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(180, 50, 50)
        ToggleBtn.Text = noclip and "COLLISIONS: PASS-THROUGH" or "COLLISIONS: NORMAL"
    end
    refreshNoclipUI()
    LiveValueUpdaters["noclip"] = refreshNoclipUI
    
    ToggleBtn.MouseButton1Click:Connect(function()
        if noclip then Commands["clip"]() else Commands["noclip"]() end
    end)
end)

addcmd("JumpPower", "jumppower", function(p)
    local Box = Instance.new("TextBox", p)
    Box.Size = UDim2.new(1, -30, 0, 32)
    Box.Position = UDim2.new(0, 15, 0, 45)
    Box.BackgroundColor3 = HeaderColor
    Box.Font = Enum.Font.Gotham
    Box.TextColor3 = TextColor
    Box.ZIndex = 45
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", Box).Color = PremiumBlue
    
    local Btn = Instance.new("TextButton", p)
    Btn.Size = UDim2.new(1, -30, 0, 32)
    Btn.Position = UDim2.new(0, 15, 0, 90)
    Btn.BackgroundColor3 = PremiumBlue
    Btn.Font = Enum.Font.GothamBold
    Btn.Text = "UPDATE JUMP CAPACITY"
    Btn.TextColor3 = DarkSlate
    Btn.ZIndex = 45
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    
    local function refreshJumpUI() Box.Text = tostring(targetJump) end
    refreshJumpUI()
    LiveValueUpdaters["jumppower"] = refreshJumpUI
    
    Btn.MouseButton1Click:Connect(function()
        targetJump = tonumber(Box.Text) or 50
        Commands["jumppower"]({targetJump})
    end)
end)

addcmd("Gravity Engine", "gravity", function(p)
    local Box = Instance.new("TextBox", p)
    Box.Size = UDim2.new(1, -30, 0, 32)
    Box.Position = UDim2.new(0, 15, 0, 45)
    Box.BackgroundColor3 = HeaderColor
    Box.TextColor3 = TextColor
    Box.Font = Enum.Font.Gotham
    Box.ZIndex = 45
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
    
    local Btn = Instance.new("TextButton", p)
    Btn.Size = UDim2.new(1, -30, 0, 32)
    Btn.Position = UDim2.new(0, 15, 0, 90)
    Btn.BackgroundColor3 = PremiumBlue
    Btn.Text = "SET WORLD GRAVITY"
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = DarkSlate
    Btn.ZIndex = 45
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    
    local function refreshGravityUI() Box.Text = tostring(gravityVal) end
    refreshGravityUI()
    LiveValueUpdaters["gravity"] = refreshGravityUI
    
    Btn.MouseButton1Click:Connect(function() Commands["gravity"]({Box.Text}) end)
end)

addcmd("FOV Adjuster", "fov", function(p)
    local Box = Instance.new("TextBox", p)
    Box.Size = UDim2.new(1, -30, 0, 32)
    Box.Position = UDim2.new(0, 15, 0, 45)
    Box.BackgroundColor3 = HeaderColor
    Box.TextColor3 = TextColor
    Box.Font = Enum.Font.Gotham
    Box.ZIndex = 45
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
    
    local Btn = Instance.new("TextButton", p)
    Btn.Size = UDim2.new(1, -30, 0, 32)
    Btn.Position = UDim2.new(0, 15, 0, 90)
    Btn.BackgroundColor3 = PremiumBlue
    Btn.Text = "SET RENDER FOV"
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = DarkSlate
    Btn.ZIndex = 45
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
    
    local function refreshFOVUI() Box.Text = tostring(fovVal) end
    refreshFOVUI()
    LiveValueUpdaters["fov"] = refreshFOVUI
    
    Btn.MouseButton1Click:Connect(function() Commands["fov"]({Box.Text}) end)
end)

addcmd("Infinite Jump Loop", "infjump", function(p)
    local ToggleBtn = Instance.new("TextButton", p)
    ToggleBtn.Size = UDim2.new(1, -30, 0, 45)
    ToggleBtn.Position = UDim2.new(0, 15, 0, 50)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 12
    ToggleBtn.TextColor3 = TextColor
    ToggleBtn.ZIndex = 45
    
    local function refreshInfUI()
        ToggleBtn.BackgroundColor3 = infJump and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(180, 50, 50)
        ToggleBtn.Text = infJump and "INF JUMP: ACTIVE" or "INF JUMP: INACTIVE"
    end
    refreshInfUI()
    LiveValueUpdaters["infjump"] = refreshInfUI
    
    ToggleBtn.MouseButton1Click:Connect(function()
        if infJump then Commands["uninfjump"]() else Commands["infjump"]() end
    end)
end)

addcmd("Anchor/Freeze", "freeze", function(p)
    local FreezeBtn = Instance.new("TextButton", p)
    FreezeBtn.Size = UDim2.new(1, -30, 0, 35)
    FreezeBtn.Position = UDim2.new(0, 15, 0, 45)
    FreezeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    FreezeBtn.Font = Enum.Font.GothamBold
    FreezeBtn.Text = "💥 FREEZE CHARACTER"
    FreezeBtn.TextColor3 = TextColor
    FreezeBtn.ZIndex = 45
    Instance.new("UICorner", FreezeBtn).CornerRadius = UDim.new(0, 4)
    
    local UnfreezeBtn = Instance.new("TextButton", p)
    UnfreezeBtn.Size = UDim2.new(1, -30, 0, 35)
    UnfreezeBtn.Position = UDim2.new(0, 15, 0, 95)
    UnfreezeBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
    UnfreezeBtn.Font = Enum.Font.GothamBold
    UnfreezeBtn.Text = "🟢 UNFREEZE RELEASE"
    UnfreezeBtn.TextColor3 = TextColor
    UnfreezeBtn.ZIndex = 45
    Instance.new("UICorner", UnfreezeBtn).CornerRadius = UDim.new(0, 4)
    
    FreezeBtn.MouseButton1Click:Connect(function() Commands["freeze"]() end)
    UnfreezeBtn.MouseButton1Click:Connect(function() Commands["unfreeze"]() end)
end)

addcmd("Force Character Sit", "sit", function(p)
    local SitBtn = Instance.new("TextButton", p)
    SitBtn.Size = UDim2.new(1, -30, 0, 40)
    SitBtn.Position = UDim2.new(0, 15, 0, 60)
    SitBtn.BackgroundColor3 = PremiumBlue
    SitBtn.Font = Enum.Font.GothamBold
    SitBtn.Text = "🪑 TRIGGER SIT NOW"
    SitBtn.TextColor3 = DarkSlate
    SitBtn.ZIndex = 45
    Instance.new("UICorner", SitBtn).CornerRadius = UDim.new(0, 4)
    
    SitBtn.MouseButton1Click:Connect(function()
        pcall(function() 
            LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.6, 0)
            LocalPlayer.Character.Humanoid.Sit = true 
        end)
    end)
end)

addcmd("Enable Shiftlock Feature", "shiftlock", function(p)
    local ToggleBtn = Instance.new("TextButton", p)
    ToggleBtn.Size = UDim2.new(1, -30, 0, 45)
    ToggleBtn.Position = UDim2.new(0, 15, 0, 50)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 12
    ToggleBtn.TextColor3 = TextColor
    ToggleBtn.ZIndex = 45
    
    local function refreshShiftUI()
        ToggleBtn.BackgroundColor3 = shiftLockEnabled and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(180, 50, 50)
        ToggleBtn.Text = shiftLockEnabled and "SHIFTLOCK: ON" or "SHIFTLOCK: OFF"
    end
    refreshShiftUI()
    LiveValueUpdaters["shiftlock"] = refreshShiftUI
    
    ToggleBtn.MouseButton1Click:Connect(function()
        if shiftLockEnabled then Commands["unshiftlock"]() else Commands["shiftlock"]() end
    end)
end)

addcmd("NoFog (Sea Events)", "nofog", function(p)
    local ToggleBtn = Instance.new("TextButton", p)
    ToggleBtn.Size = UDim2.new(1, -30, 0, 45)
    ToggleBtn.Position = UDim2.new(0, 15, 0, 50)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 12
    ToggleBtn.TextColor3 = TextColor
    ToggleBtn.ZIndex = 45
    
    local function refreshFogUI()
        ToggleBtn.BackgroundColor3 = noFogEnabled and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(180, 50, 50)
        ToggleBtn.Text = noFogEnabled and "NOFOG: ENABLED" or "NOFOG: DISABLED"
    end
    refreshFogUI()
    LiveValueUpdaters["nofog"] = refreshFogUI
    
    ToggleBtn.MouseButton1Click:Connect(function()
        if noFogEnabled then Commands["unnofog"]() else Commands["nofog"]() end
    end)
end)

addcmd("Kill Character", "kill", nil)

-- [[ TEXT ENGINE PARSER & REAL ADMIN CHAT HOOK INTERCEPT ]] --
local function runTextCommand(rawText)
    local cleanText = rawText:gsub("^;", "")
    local args = string.split(cleanText, " ")
    local cmdName = args[1]:lower()
    table.remove(args, 1)
    
    if Commands[cmdName] then
        task.spawn(Commands[cmdName], args)
        if PanelOpenTriggers[cmdName] then
            PanelOpenTriggers[cmdName]()
        end
    end
end

Cmdbar.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        runTextCommand(Cmdbar.Text)
        Cmdbar.Text = ""
    end
end)

LocalPlayer.Chatted:Connect(function(message)
    if string.sub(message, 1, 1) == ";" then
        runTextCommand(message)
    end
end)
