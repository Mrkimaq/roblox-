-- MrKimaq Mod Menu v1.10 (Full: Safe Speed + Smooth Fly + WallHack + Invisible + Security Login)

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Config
local baseSpeed = 16
local customSpeed = 50
local speedEnabled = false
local wallhackEnabled = false
local invisibleEnabled = false
local flying = false
local flySpeed = 50
local verticalVelocity = 0
local maxVerticalSpeed = 100

-- GUI
local screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.Name = "MrKimaqModMenu"

-- Main Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 340, 0, 350)
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,12)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = ">>> MR KIMAQ MOD 1.10 <<<"
title.TextColor3 = Color3.fromRGB(0,255,128)
title.Font = Enum.Font.FredokaOne
title.TextSize = 20
spawn(function()
    while task.wait(0.1) do
        title.Text = title.Text:sub(2)..title.Text:sub(1,1)
    end
end)

-- Tabs
local tabFrame = Instance.new("Frame", mainFrame)
tabFrame.Size = UDim2.new(1,0,0,30)
tabFrame.Position = UDim2.new(0,0,0,30)
tabFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
Instance.new("UICorner", tabFrame).CornerRadius = UDim.new(0,12)

local function createTabButton(text,pos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.33, -3, 1, 0)
    btn.Position = UDim2.new(pos,pos*2,0,0)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = tabFrame
    return btn
end

local securityBtn = createTabButton("Security",0)
local cheatBtn = createTabButton("Cheat",0.33)
local speedBtn = createTabButton("Speed",0.66)

-- Content Frame
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1,-10,1,-70)
contentFrame.Position = UDim2.new(0,5,0,65)
contentFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0,8)

-- ====================
-- Security Frame
-- ====================
local securityFrame = Instance.new("Frame", contentFrame)
securityFrame.Size = UDim2.new(1,0,1,0)
securityFrame.BackgroundTransparency = 1

-- Password input
local passwordLabel = Instance.new("TextLabel", securityFrame)
passwordLabel.Size = UDim2.new(1,0,0,30)
passwordLabel.Position = UDim2.new(0,0,0,10)
passwordLabel.BackgroundTransparency = 1
passwordLabel.Text = "Enter Password:"
passwordLabel.TextColor3 = Color3.fromRGB(180,180,180)
passwordLabel.Font = Enum.Font.FredokaOne
passwordLabel.TextSize = 16

local passwordBox = Instance.new("TextBox", securityFrame)
passwordBox.Size = UDim2.new(0,200,0,35)
passwordBox.Position = UDim2.new(0,10,0,50)
passwordBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
passwordBox.TextColor3 = Color3.fromRGB(255,255,255)
passwordBox.Font = Enum.Font.GothamBold
passwordBox.TextSize = 16
passwordBox.PlaceholderText = "Password..."
passwordBox.ClearTextOnFocus = true
passwordBox.TextEditable = true
passwordBox.TextScaled = false
passwordBox.TextXAlignment = Enum.TextXAlignment.Left
passwordBox.TextYAlignment = Enum.TextYAlignment.Center
passwordBox.MultiLine = false

-- Submit button
local submitBtn = Instance.new("TextButton", securityFrame)
submitBtn.Size = UDim2.new(0,100,0,35)
submitBtn.Position = UDim2.new(0,220,0,50)
submitBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
submitBtn.Text = "Login"
submitBtn.TextColor3 = Color3.fromRGB(255,255,255)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 14
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0,6)

-- Info label
local infoLabel = Instance.new("TextLabel", securityFrame)
infoLabel.Size = UDim2.new(1,0,0,30)
infoLabel.Position = UDim2.new(0,0,0,95)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = ""
infoLabel.TextColor3 = Color3.fromRGB(255,0,0)
infoLabel.Font = Enum.Font.FredokaOne
infoLabel.TextSize = 14

-- Password logic
local correctPassword = "fan" -- ganti sesuai password yang diinginkan

submitBtn.MouseButton1Click:Connect(function()
    if passwordBox.Text == correctPassword then
        infoLabel.Text = "Password benar!"
        cheatBtn.Visible = true
        speedBtn.Visible = true
    else
        infoLabel.Text = "Password error!"
        cheatBtn.Visible = false
        speedBtn.Visible = false
    end
end)

-- Hide cheat & speed tabs until login
cheatBtn.Visible = false
speedBtn.Visible = false

-- ====================
-- Cheat Frame
-- ====================
local cheatFrame = Instance.new("Frame", contentFrame)
cheatFrame.Size = UDim2.new(1,0,1,0)
cheatFrame.BackgroundTransparency = 1
cheatFrame.Visible = false

-- WallHack Button
local wallhackBtn = Instance.new("TextButton", cheatFrame)
wallhackBtn.Size = UDim2.new(0,120,0,35)
wallhackBtn.Position = UDim2.new(0,10,0,10)
wallhackBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
wallhackBtn.Text = "WallHack: OFF"
wallhackBtn.TextColor3 = Color3.fromRGB(255,255,255)
wallhackBtn.Font = Enum.Font.GothamBold
wallhackBtn.TextSize = 14
Instance.new("UICorner", wallhackBtn).CornerRadius = UDim.new(0,8)

local originalCollisions = {}
local function setWallhack(state)
    wallhackEnabled = state
    if wallhackEnabled then
        wallhackBtn.BackgroundColor3 = Color3.fromRGB(0,170,127)
        wallhackBtn.Text = "WallHack: ON"
        for _,obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:IsDescendantOf(character) then
                originalCollisions[obj] = obj.CanCollide
                obj.CanCollide = false
            end
        end
    else
        wallhackBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
        wallhackBtn.Text = "WallHack: OFF"
        for obj,coll in pairs(originalCollisions) do
            if obj and obj.Parent then obj.CanCollide = coll end
        end
        originalCollisions = {}
    end
end
wallhackBtn.MouseButton1Click:Connect(function() setWallhack(not wallhackEnabled) end)

-- Invisible Button
local invisibleBtn = Instance.new("TextButton", cheatFrame)
invisibleBtn.Size = UDim2.new(0,120,0,35)
invisibleBtn.Position = UDim2.new(0,10,0,55)
invisibleBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
invisibleBtn.Text = "Invisible: OFF"
invisibleBtn.TextColor3 = Color3.fromRGB(255,255,255)
invisibleBtn.Font = Enum.Font.GothamBold
invisibleBtn.TextSize = 14
Instance.new("UICorner", invisibleBtn).CornerRadius = UDim.new(0,8)

local storedParts = {}
local storedClothing = {}
local function setInvisible(state)
    invisibleEnabled = state
    if not character then return end
    if invisibleEnabled then
        invisibleBtn.BackgroundColor3 = Color3.fromRGB(0,170,127)
        invisibleBtn.Text = "Invisible: ON"
        storedParts, storedClothing = {},{}
        for _,part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                storedParts[part] = part.Transparency
                part.Transparency = 1
            elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
                storedParts[part.Handle] = part.Handle.Transparency
                part.Handle.Transparency = 1
            elseif part:IsA("Clothing") then
                storedClothing[part] = part:Clone()
                part:Destroy()
            end
        end
    else
        invisibleBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
        invisibleBtn.Text = "Invisible: OFF"
        for part,orig in pairs(storedParts) do
            if part and part.Parent then part.Transparency = orig end
        end
        for _,clone in pairs(storedClothing) do
            if clone and character then clone.Parent = character end
        end
    end
end
invisibleBtn.MouseButton1Click:Connect(function() setInvisible(not invisibleEnabled) end)

-- Fly Button
local flyBtn = Instance.new("TextButton", cheatFrame)
flyBtn.Size = UDim2.new(0,120,0,35)
flyBtn.Position = UDim2.new(0,10,0,100)
flyBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
flyBtn.Text = "Fly: OFF"
flyBtn.TextColor3 = Color3.fromRGB(255,255,255)
flyBtn.Font = Enum.Font.GothamBold
flyBtn.TextSize = 14
Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0,8)

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        flyBtn.BackgroundColor3 = Color3.fromRGB(0,170,127)
        flyBtn.Text = "Fly: ON"
    else
        flyBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
        flyBtn.Text = "Fly: OFF"
    end
end)

-- Fly movement
RunService.RenderStepped:Connect(function()
    if rootPart then
        if flying then
            rootPart.Velocity = Vector3.new(0, flySpeed, 0)
        else
            verticalVelocity = 0
        end
    end
end)

-- ====================
-- Speed Frame
-- ====================
local speedFrame = Instance.new("Frame", contentFrame)
speedFrame.Size = UDim2.new(1,0,1,0)
speedFrame.BackgroundTransparency = 1
speedFrame.Visible = false

local toggleBtn = Instance.new("TextButton", speedFrame)
toggleBtn.Size = UDim2.new(0,120,0,35)
toggleBtn.Position = UDim2.new(0,10,0,10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
toggleBtn.Text = "Speed: OFF"
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0,8)

local speeds = {20,50,100,200,300}
local selectedBtn = nil
for i,v in ipairs(speeds) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,60,0,30)
    btn.Position = UDim2.new(0,10+(i-1)*65,0,60)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.Text = tostring(v)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = speedFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0,0,0)
    stroke.Parent = btn
    btn.MouseButton1Click:Connect(function()
        customSpeed = v
        if speedEnabled and humanoid then humanoid.WalkSpeed = customSpeed end
        if selectedBtn and selectedBtn:FindFirstChildOfClass("UIStroke") then
            selectedBtn.UIStroke.Color = Color3.fromRGB(0,0,0)
        end
        stroke.Color = Color3.fromRGB(0,128,255)
        selectedBtn = btn
    end)
end

toggleBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    if speedEnabled then
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0,170,127)
        toggleBtn.Text = "Speed: ON"
        if humanoid then humanoid.WalkSpeed = customSpeed end
    else
        toggleBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
        toggleBtn.Text = "Speed: OFF"
        if humanoid then humanoid.WalkSpeed = baseSpeed end
    end
end)

-- ====================
-- Tab switch
-- ====================
local function switchTab(tab)
    securityFrame.Visible = (tab=="security")
    cheatFrame.Visible = (tab=="cheat")
    speedFrame.Visible = (tab=="speed")
end
securityBtn.MouseButton1Click:Connect(function() switchTab("security") end)
cheatBtn.MouseButton1Click:Connect(function() switchTab("cheat") end)
speedBtn.MouseButton1Click:Connect(function() switchTab("speed") end)

-- ====================
-- Main toggle button
-- ====================
local mainBtn = Instance.new("TextButton", screenGui)
mainBtn.Size = UDim2.new(0,150,0,40)
mainBtn.Position = UDim2.new(0.5,-75,0.1,0)
mainBtn.BackgroundColor3 = Color3.fromRGB(0,170,127)
mainBtn.Text = "Mr Kimaq Mod"
mainBtn.TextColor3 = Color3.fromRGB(255,255,255)
mainBtn.Font = Enum.Font.FredokaOne
mainBtn.TextSize = 18
Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0,10)
mainBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- ====================
-- Respawn handler
-- ====================
player.CharacterAdded:Connect(function(char)
    character = char
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    if speedEnabled then humanoid.WalkSpeed = customSpeed else humanoid.WalkSpeed = baseSpeed end
    if wallhackEnabled then setWallhack(true) end
    if invisibleEnabled then setInvisible(true) end
end)
