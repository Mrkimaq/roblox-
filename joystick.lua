-- KimaqModz — Left D-Pad (WASD) + Right Vertical (Space/C) (NON-DRAGGABLE)
-- Exploit mode: uses keypress/keyrelease (Synapse/KRNL/etc)
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- CONFIG
local LEFT_W = 0x57   -- W
local LEFT_A = 0x41   -- A
local LEFT_S = 0x53   -- S
local LEFT_D = 0x44   -- D

local RIGHT_UP   = 0x20 -- Space
local RIGHT_DOWN = 0x43 -- C

local LEFT_PANEL_SIZE  = Vector2.new(170, 170)
local RIGHT_PANEL_SIZE = Vector2.new(100, 140)
local BUTTON_SIZE_LEFT = 56
local BUTTON_SIZE_RIGHT = 56

-- safe wrappers for exploit functions
local function safePress(k) pcall(function() keypress(k) end) end
local function safeRelease(k) pcall(function() keyrelease(k) end) end

-- create gui root
local gui = Instance.new("ScreenGui")
gui.Name = "KimaqModz_DP_RV_NoDrag"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

-- helper to create circular arrow button (text arrow)
local function createArrowButton(parent, size, pos, arrowChar, keycode)
    local btn = Instance.new("ImageButton")
    btn.Size = UDim2.new(0, size, 0, size)
    btn.Position = pos
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.BackgroundTransparency = 1
    btn.Parent = parent

    -- shadow
    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, 8, 1, 8)
    shadow.Position = UDim2.new(0.5, 6, 0.5, 6)
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundColor3 = Color3.fromRGB(0,0,0)
    shadow.BackgroundTransparency = 0.75
    shadow.BorderSizePixel = 0
    shadow.Parent = btn
    local sc = Instance.new("UICorner", shadow)
    sc.CornerRadius = UDim.new(1,0)

    -- circle
    local circ = Instance.new("Frame")
    circ.Size = UDim2.new(1,0,1,0)
    circ.Position = UDim2.new(0,0,0,0)
    circ.BackgroundColor3 = Color3.fromRGB(255,255,255)
    circ.BackgroundTransparency = 0.06
    circ.BorderSizePixel = 0
    circ.Parent = btn
    local cc = Instance.new("UICorner", circ)
    cc.CornerRadius = UDim.new(1,0)

    -- inner dark core
    local core = Instance.new("Frame")
    core.Size = UDim2.new(0.86,0,0.86,0)
    core.Position = UDim2.new(0.5,0,0.5,0)
    core.AnchorPoint = Vector2.new(0.5,0.5)
    core.BackgroundColor3 = Color3.fromRGB(28,28,28)
    core.BorderSizePixel = 0
    core.Parent = circ
    local coreCorner = Instance.new("UICorner", core)
    coreCorner.CornerRadius = UDim.new(1,0)

    -- arrow label
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0.6,0,0.6,0)
    arrow.AnchorPoint = Vector2.new(0.5,0.5)
    arrow.Position = UDim2.new(0.5,0,0.5,0)
    arrow.BackgroundTransparency = 1
    arrow.Text = arrowChar
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 32
    arrow.TextColor3 = Color3.fromRGB(255,255,255)
    arrow.Parent = core

    -- press handling
    local pressed = false
    local function onPress()
        if pressed then return end
        pressed = true
        core.BackgroundColor3 = Color3.fromRGB(70,70,70)
        safePress(keycode)
    end
    local function onRelease()
        if not pressed then return end
        pressed = false
        core.BackgroundColor3 = Color3.fromRGB(28,28,28)
        safeRelease(keycode)
    end

    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            onPress()
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    onRelease()
                end
            end)
        end
    end)
    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            onRelease()
        end
    end)

    return btn
end

-- === LEFT PANEL (WASD) ===
local leftPanel = Instance.new("Frame")
leftPanel.Name = "LeftDP"
leftPanel.Size = UDim2.new(0, LEFT_PANEL_SIZE.X, 0, LEFT_PANEL_SIZE.Y)
leftPanel.Position = UDim2.new(0, 12, 1, -LEFT_PANEL_SIZE.Y - 12)
leftPanel.BackgroundTransparency = 1
leftPanel.BorderSizePixel = 0
leftPanel.Parent = gui
-- NOTE: non-draggable — no makeDraggable call

-- positions relative to panel center
local centerX = LEFT_PANEL_SIZE.X * 0.5
local centerY = LEFT_PANEL_SIZE.Y * 0.5
local offset = 44

-- create arrows (pixel positions -> UDim2)
local function pxToUDim2(px, py)
    return UDim2.new(0, px, 0, py)
end

createArrowButton(leftPanel, BUTTON_SIZE_LEFT, pxToUDim2(centerX, centerY - offset), "▲", LEFT_W)   -- Up -> W
createArrowButton(leftPanel, BUTTON_SIZE_LEFT, pxToUDim2(centerX, centerY + offset), "▼", LEFT_S)   -- Down -> S
createArrowButton(leftPanel, BUTTON_SIZE_LEFT, pxToUDim2(centerX - offset, centerY), "◀", LEFT_A)   -- Left -> A
createArrowButton(leftPanel, BUTTON_SIZE_LEFT, pxToUDim2(centerX + offset, centerY), "▶", LEFT_D)   -- Right -> D

-- small hint under left panel
local leftHint = Instance.new("TextLabel")
leftHint.Size = UDim2.new(0, LEFT_PANEL_SIZE.X, 0, 18)
leftHint.Position = UDim2.new(0, 0, 0, LEFT_PANEL_SIZE.Y + 6)
leftHint.BackgroundTransparency = 1
leftHint.Text = "Movement"
leftHint.Font = Enum.Font.Gotham
leftHint.TextSize = 12
leftHint.TextColor3 = Color3.fromRGB(200,200,200)
leftHint.TextXAlignment = Enum.TextXAlignment.Center
leftHint.Parent = leftPanel

-- === RIGHT PANEL (Only Up and Down) ===
local rightPanel = Instance.new("Frame")
rightPanel.Name = "RightDV"
rightPanel.Size = UDim2.new(0, RIGHT_PANEL_SIZE.X, 0, RIGHT_PANEL_SIZE.Y)
rightPanel.Position = UDim2.new(1, -RIGHT_PANEL_SIZE.X - 12, 1, -RIGHT_PANEL_SIZE.Y - 12)
rightPanel.BackgroundTransparency = 1
rightPanel.BorderSizePixel = 0
rightPanel.Parent = gui
-- NOTE: non-draggable — no makeDraggable call

-- center coords for right panel
local rcx = RIGHT_PANEL_SIZE.X * 0.5
local rcy = RIGHT_PANEL_SIZE.Y * 0.5
local roff = 34

-- Up = Space, Down = C
createArrowButton(rightPanel, BUTTON_SIZE_RIGHT, pxToUDim2(rcx, rcy - roff), "▲", RIGHT_UP)
createArrowButton(rightPanel, BUTTON_SIZE_RIGHT, pxToUDim2(rcx, rcy + roff), "▼", RIGHT_DOWN)

local rightHint = Instance.new("TextLabel")
rightHint.Size = UDim2.new(0, RIGHT_PANEL_SIZE.X, 0, 18)
rightHint.Position = UDim2.new(0, 0, 0, RIGHT_PANEL_SIZE.Y + 6)
rightHint.BackgroundTransparency = 1
rightHint.Text = "Action"
rightHint.Font = Enum.Font.Gotham
rightHint.TextSize = 12
rightHint.TextColor3 = Color3.fromRGB(200,200,200)
rightHint.TextXAlignment = Enum.TextXAlignment.Center
rightHint.Parent = rightPanel

print("KimaqModz: Left (WASD) + Right (Space/C) loaded (exploit mode, NON-DRAGGABLE).")
