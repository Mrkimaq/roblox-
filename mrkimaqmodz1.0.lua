-- 🔹 Kimaq Modz Full Script (Draggable Button + Login + Sidebar UI + Fly Toggle + Dual Get Key)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local hrp = player.Character and player.Character:WaitForChild("HumanoidRootPart")

-- =====================
-- 🔹 GUI Root
-- =====================
local gui = Instance.new("ScreenGui")
gui.Name = "KimaqModz"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- =====================
-- 🔹 Tombol Kimaq Modz (Draggable)
-- =====================
local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0,160,0,50)
openButton.Position = UDim2.new(0.05,0,0.2,0)
openButton.BackgroundColor3 = Color3.fromRGB(240,240,240)
openButton.TextColor3 = Color3.fromRGB(30,30,30)
openButton.Text = "Kimaq Modz"
openButton.Font = Enum.Font.GothamBold
openButton.TextSize = 18
openButton.Parent = gui
Instance.new("UICorner", openButton).CornerRadius = UDim.new(0,15)

-- Drag logic
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    openButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                    startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
openButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = openButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
openButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- =====================
-- 🔹 LOGIN FRAME
-- =====================
local loginFrame = Instance.new("Frame")
loginFrame.Size = UDim2.new(0,350,0,220)
loginFrame.Position = UDim2.new(0.5,-175,0.5,-110)
loginFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
loginFrame.Visible = false
loginFrame.Parent = gui
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0,15)

local loginStroke = Instance.new("UIStroke")
loginStroke.Color = Color3.fromRGB(180,180,255)
loginStroke.Thickness = 1.5
loginStroke.Parent = loginFrame

local titleLogin = Instance.new("TextLabel")
titleLogin.Size = UDim2.new(1,0,0,40)
titleLogin.Text = "🔑 Kimaq Modz Key Login"
titleLogin.Font = Enum.Font.GothamBold
titleLogin.TextSize = 18
titleLogin.TextColor3 = Color3.fromRGB(40,40,40)
titleLogin.BackgroundTransparency = 1
titleLogin.Parent = loginFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8,0,0,35)
keyBox.Position = UDim2.new(0.1,0,0.35,0)
keyBox.PlaceholderText = "Enter Key..."
keyBox.Text = ""
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.TextColor3 = Color3.fromRGB(50,50,50)
keyBox.BackgroundColor3 = Color3.fromRGB(245,245,245)
keyBox.Parent = loginFrame
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0,10)

local loginBtn = Instance.new("TextButton")
loginBtn.Size = UDim2.new(0.6,0,0,35)
loginBtn.Position = UDim2.new(0.2,0,0.65,0)
loginBtn.Text = "Login"
loginBtn.Font = Enum.Font.GothamBold
loginBtn.TextSize = 16
loginBtn.TextColor3 = Color3.fromRGB(255,255,255)
loginBtn.BackgroundColor3 = Color3.fromRGB(70,140,255)
loginBtn.Parent = loginFrame
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0,10)

-- 🔹 Dua tombol Get Key
local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Size = UDim2.new(0.4,0,0,30)
getKeyBtn.Position = UDim2.new(0.05,0,0.85,0)
getKeyBtn.Text = "Get Key #1"
getKeyBtn.Font = Enum.Font.Gotham
getKeyBtn.TextSize = 14
getKeyBtn.TextColor3 = Color3.fromRGB(255,255,255)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(120,200,100)
getKeyBtn.Parent = loginFrame
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0,10)

local getKeyBtn2 = Instance.new("TextButton")
getKeyBtn2.Size = UDim2.new(0.4,0,0,30)
getKeyBtn2.Position = UDim2.new(0.55,0,0.85,0)
getKeyBtn2.Text = "Get Key #2"
getKeyBtn2.Font = Enum.Font.Gotham
getKeyBtn2.TextSize = 14
getKeyBtn2.TextColor3 = Color3.fromRGB(255,255,255)
getKeyBtn2.BackgroundColor3 = Color3.fromRGB(100,180,220)
getKeyBtn2.Parent = loginFrame
Instance.new("UICorner", getKeyBtn2).CornerRadius = UDim.new(0,10)

-- 🔹 URL Keys
local KEY_URL = "https://raw.githubusercontent.com/Mrkimaq/roblox-/refs/heads/main/pasword.txt"
local KEY_URL2 = "https://pastebin.com/raw/yourbackupkey" -- ganti sesuai link kamu

-- =====================
-- 🔹 MAIN MENU (Sidebar + Pages)
-- =====================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,550,0,350)
mainFrame.Position = UDim2.new(0.5,-275,0.5,-175)
mainFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
mainFrame.Visible = false
mainFrame.Parent = gui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,20)

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(220,220,220)
stroke.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1,0,0,45)
titleBar.BackgroundColor3 = Color3.fromRGB(250,250,250)
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0,20)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.5,0,1,0)
titleLabel.Position = UDim2.new(0,15,0,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Kimaq Modz"
titleLabel.TextColor3 = Color3.fromRGB(40,40,40)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,22,0,22)
closeBtn.Position = UDim2.new(1,-35,0.5,-11)
closeBtn.BackgroundColor3 = Color3.fromRGB(255,80,80)
closeBtn.Text = ""
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0,120,1,-45)
sidebar.Position = UDim2.new(0,0,0,45)
sidebar.BackgroundColor3 = Color3.fromRGB(248,248,248)
sidebar.Parent = mainFrame
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,15)

-- Content
local content = Instance.new("Frame")
content.Size = UDim2.new(1,-120,1,-45)
content.Position = UDim2.new(0,120,0,45)
content.BackgroundColor3 = Color3.fromRGB(255,255,255)
content.Parent = mainFrame
Instance.new("UICorner", content).CornerRadius = UDim.new(0,15)

-- Pages & Sidebar Buttons
local pages = {}
local function createPage(name)
    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = name.."Page"
    scroll.Size = UDim2.new(1,-20,1,-20)
    scroll.Position = UDim2.new(0,10,0,10)
    scroll.BackgroundTransparency = 1
    scroll.Visible = false
    scroll.Parent = content
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.ScrollBarThickness = 6

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 20)
    end)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-10,0,40)
    label.Text = name.." Settings"
    label.TextColor3 = Color3.fromRGB(40,40,40)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.BackgroundTransparency = 1
    label.LayoutOrder = 0
    label.Parent = scroll

    pages[name] = scroll
    return scroll
end

local function createTab(name, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-20,0,35)
    btn.Position = UDim2.new(0,10,0,(order-1)*45+10)
    btn.BackgroundColor3 = Color3.fromRGB(235,235,235)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(60,60,60)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)
    return btn
end

-- Buat halaman
local tabNames = {"Visual","Teleport","Security"}
for i,name in ipairs(tabNames) do
    local btn = createTab(name,i)
    local page = createPage(name)
    btn.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible = false end
        page.Visible = true
    end)
end
pages["Visual"].Visible = true

-- =====================
-- 🔹 Helper: Create iOS Style Toggle
-- =====================
local function createToggle(parent, name, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-10,0,40)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6,0,1,0)
    label.Text = name
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(40,40,40)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0,50,0,24)
    toggleBtn.Position = UDim2.new(1,-60,0.5,-12)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(220,220,220)
    toggleBtn.Text = ""
    toggleBtn.Parent = frame
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1,0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0,20,0,20)
    knob.Position = UDim2.new(0,2,0.5,-10)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.Parent = toggleBtn
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(100,200,100)
            knob:TweenPosition(UDim2.new(1,-22,0.5,-10), "Out", "Sine", 0.2, true)
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(220,220,220)
            knob:TweenPosition(UDim2.new(0,2,0.5,-10), "Out", "Sine", 0.2, true)
        end
        if callback then callback(state) end
    end)
end

-- =====================
-- 🔹 LOGIN SESSION
-- =====================
local isLoggedIn = false

openButton.MouseButton1Click:Connect(function()
    if isLoggedIn then
        mainFrame.Visible = not mainFrame.Visible
    else
        loginFrame.Visible = true
    end
end)

loginBtn.MouseButton1Click:Connect(function()
    local success, response = pcall(function()
        return game:HttpGet(KEY_URL)
    end)
    if not success then
        keyBox.Text = ""
        keyBox.PlaceholderText = "⚠️ Failed to Fetch Key"
        return
    end
    local githubKey = response:gsub("%s+","")
    if keyBox.Text == githubKey then
        loginFrame.Visible = false
        mainFrame.Visible = true
        pages["Visual"].Visible = true
        isLoggedIn = true
        print("✅ Key Verified! Main Menu Opened.")
    else
        keyBox.Text = ""
        keyBox.PlaceholderText = "❌ Invalid Key"
    end
end)

-- Tombol Get Key
getKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(KEY_URL)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title="Kimaq Modz",
        Text="Key link #1 copied!",
        Duration=5
    })
end)

getKeyBtn2.MouseButton1Click:Connect(function()
    setclipboard(KEY_URL2)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title="Kimaq Modz",
        Text="Key link #2 copied!",
        Duration=5
    })
end)

-- =====================
-- 🔹 Fly Logic + Joystick Call
-- =====================
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local flyEnabled = false
local flySpeed = 50

local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(1e5,1e5,1e5)

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(1e5,1e5,1e5)

local humanoid
local joystickGui -- simpan reference biar bisa dihapus

local function loadJoystick()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Mrkimaq/roblox-/refs/heads/main/fly.txt"))()
    end)
    if success and result then
        joystickGui = result -- biasanya return GUI atau function
    else
        warn("❌ Joystick gagal dimuat:", result)
    end
end

local function removeJoystick()
    if joystickGui and typeof(joystickGui) == "Instance" then
        joystickGui:Destroy()
        joystickGui = nil
    end
end

local function startFlying()
    if not player.Character then return end
    hrp = player.Character:WaitForChild("HumanoidRootPart")
    humanoid = player.Character:WaitForChild("Humanoid")
    flyEnabled = true
    bodyVelocity.Parent = hrp
    bodyGyro.Parent = hrp
    humanoid.PlatformStand = true
    loadJoystick()
end

local function stopFlying()
    flyEnabled = false
    bodyVelocity.Parent = nil
    bodyGyro.Parent = nil
    if humanoid then humanoid.PlatformStand = false end
    removeJoystick()
end

-- Gerakan kamera arah
RunService.RenderStepped:Connect(function()
    if flyEnabled and hrp then
        local dir = Vector3.zero
        local camCF = Camera.CFrame
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += camCF.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= camCF.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= camCF.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += camCF.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.E) then dir += Vector3.yAxis end
        if UIS:IsKeyDown(Enum.KeyCode.Q) then dir -= Vector3.yAxis end
        if dir.Magnitude > 0 then dir = dir.Unit end
        bodyVelocity.Velocity = dir * flySpeed
        bodyGyro.CFrame = camCF
    end
end)

-- 🔹 Toggle untuk Fly di tab Visual
createToggle(pages["Visual"], "Fly", function(state)
    if state then
        startFlying()
    else
        stopFlying()
    end
end)

-- =====================
-- 🔹 Invisible Logic
-- =====================
local invis_on = false

local function setTransparency(character, transparency)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            part.Transparency = transparency
        end
    end
end

local function startInvisibility()
    invis_on = true
    if not player.Character then return end

    local savedpos = player.Character.HumanoidRootPart.CFrame
    task.wait()
    player.Character:MoveTo(Vector3.new(-25.95, 84, 3537.55))
    task.wait(0.15)

    local Seat = Instance.new("Seat", workspace)
    Seat.Anchored = false
    Seat.CanCollide = false
    Seat.Name = "invischair"
    Seat.Transparency = 1
    Seat.Position = Vector3.new(-25.95, 84, 3537.55)

    local Weld = Instance.new("Weld", Seat)
    Weld.Part0 = Seat
    Weld.Part1 = player.Character:FindFirstChild("Torso") or player.Character:FindFirstChild("UpperTorso")

    task.wait()
    Seat.CFrame = savedpos
    setTransparency(player.Character, 0.5)

    game.StarterGui:SetCore("SendNotification", {
        Title = "Invis (ON)",
        Duration = 3,
        Text = "STATUS:"
    })
end

local function stopInvisibility()
    invis_on = false
    local invisChair = workspace:FindFirstChild("invischair")
    if invisChair then invisChair:Destroy() end
    if player.Character then
        setTransparency(player.Character, 0)
    end
    game.StarterGui:SetCore("SendNotification", {
        Title = "Invis (OFF)",
        Duration = 3,
        Text = "STATUS:"
    })
end

-- 🔹 Toggle untuk Invisible di tab Visual
createToggle(pages["Visual"], "Invisible", function(state)
    if state then
        startInvisibility()
    else
        stopInvisibility()
    end
end)


--- =====================
-- 🔹 Walhack (Noclip)
-- =====================
local walhackEnabled = false

RunService.Stepped:Connect(function()
    if walhackEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- =====================
-- 🔹 Walhack (Noclip terbatas)
-- =====================
local walhackEnabled = false

RunService.Stepped:Connect(function()
    if walhackEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    elseif player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") and not part.CanCollide then
                part.CanCollide = true
            end
        end
    end
end)

createToggle(pages["Visual"], "Walhack", function(state)
    walhackEnabled = state
    print(state and "✅ Walhack ON" or "❌ Walhack OFF")
end)



-- =====================
-- 🔹 Teleport Logic
-- =====================
local teleportEnabled = false

local function startTeleport()
    teleportEnabled = true
    print("✅ Teleport Mode ON")
    -- nanti bisa isi logika teleport otomatis di sini
end

local function stopTeleport()
    teleportEnabled = false
    print("❌ Teleport Mode OFF")
    -- matikan / reset logika teleport di sini
end

-- 🔹 Toggle untuk Teleport di tab Teleport
createToggle(pages["Teleport"], "Teleport", function(state)
    if state then
        startTeleport()
    else
        stopTeleport()
    end
end)


-- Respawn Handler
player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    hrp = char:WaitForChild("HumanoidRootPart")
end)

-- Tombol Close di MainFrame
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)
