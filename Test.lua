-- Void UI Library Module
local Void = {}

-- Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Function to create a window
function Void:CreateWin(settings)
    -- Validate settings
    if not settings or type(settings) ~= "table" then
        error("Void:CreateWin requires a settings table")
    end

    -- Default settings
    local defaultSettings = {
        Title = "Void UI",
        Version = "1.0.0",
        Size = UDim2.new(0.6, 0, 0.6, 0), -- 60% of screen width and height
    }

    -- Merge provided settings with defaults
    for key, value in pairs(defaultSettings) do
        if settings[key] == nil then
            settings[key] = value
        end
    end

    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VoidUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create main window (Frame)
    local window = Instance.new("Frame")
    window.Name = "Window"
    window.Size = settings.Size
    window.Position = UDim2.new(0.2, 0, 0.2, 0) -- Center the window (20% offset from edges)
    window.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark background
    window.BorderSizePixel = 0
    window.Parent = screenGui

    -- Add corner rounding
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = window

    -- Create title label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(0, 200, 0, 24) -- Semi-small title
    titleLabel.Position = UDim2.new(0, 10, 0, 10) -- Top-left with padding
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = settings.Title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 18 -- Semi-small font size
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = window

    -- Create version label
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Name = "Version"
    versionLabel.Size = UDim2.new(0, 200, 0, 16) -- Smaller than title
    versionLabel.Position = UDim2.new(0, 10, 0, 34) -- Below title
    versionLabel.BackgroundTransparency = 1
    versionLabel.Text = "v" .. settings.Version
    versionLabel.TextColor3 = Color3.fromRGB(150, 150, 150) -- Lighter gray for version
    versionLabel.TextSize = 14 -- Smaller font size
    versionLabel.Font = Enum.Font.SourceSans
    versionLabel.TextXAlignment = Enum.TextXAlignment.Left
    versionLabel.Parent = window

    -- Make window draggable
    local dragging, dragInput, dragStart, startPos
    local function updateInput(input)
        local delta = input.Position - dragStart
        window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    window.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = window.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    window.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)

    -- Return window object for further customization
    return {
        Window = window,
        ScreenGui = screenGui
    }
end

return Void
