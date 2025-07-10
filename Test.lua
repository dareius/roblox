-- NeonUILib.lua

local NeonUILib = {}

--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

--// Theme settings
local Theme = {
    Background = Color3.fromRGB(10, 10, 10),
    WindowOutline = Color3.fromRGB(0, 255, 150), -- Neon green glow
    TitleColor = Color3.fromRGB(255, 255, 255),
    VersionColor = Color3.fromRGB(120, 120, 120),
    Font = Enum.Font.GothamSemibold,
    CornerRadius = UDim.new(0, 8),
    GlowTransparency = 0.6,
    Padding = 12,
}

--// Main Window Creator
function NeonUILib:CreateWindow(config)
    config = config or {}

    local titleText = config.Title or "Untitled"
    local versionText = config.Version or nil
    local width = config.Width or 400
    local height = config.Height or 300

    --// Setup ScreenGui
    local player = Players.LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "NeonUI_" .. titleText:gsub("%s+", "")
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.IgnoreGuiInset = true

    pcall(function()
        gui.Parent = game:GetService("CoreGui")
    end)

    if not gui.Parent then
        gui.Parent = player:WaitForChild("PlayerGui")
    end

    --// Main Frame
    local main = Instance.new("Frame")
    main.Name = "MainFrame"
    main.Size = UDim2.new(0, width, 0, height)
    main.Position = UDim2.new(0.5, -width / 2, 0.5, -height / 2)
    main.BackgroundColor3 = Theme.Background
    main.BorderSizePixel = 0
    main.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = Theme.CornerRadius
    corner.Parent = main

    --// Glow
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.Size = UDim2.new(1, 60, 1, 60)
    glow.Position = UDim2.new(0, -30, 0, -30)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://4996891970" -- Glow image
    glow.ImageColor3 = Theme.WindowOutline
    glow.ImageTransparency = Theme.GlowTransparency
    glow.ZIndex = 0
    glow.Parent = main

    --// Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 8)
    title.Text = titleText
    title.TextColor3 = Theme.TitleColor
    title.Font = Theme.Font
    title.TextSize = 24
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 2
    title.Parent = main

    --// Optional Version
    if versionText then
        local version = Instance.new("TextLabel")
        version.Name = "Version"
        version.Size = UDim2.new(1, -20, 0, 20)
        version.Position = UDim2.new(0, 10, 0, 44)
        version.Text = tostring(versionText)
        version.TextColor3 = Theme.VersionColor
        version.Font = Theme.Font
        version.TextSize = 14
        version.BackgroundTransparency = 1
        version.TextXAlignment = Enum.TextXAlignment.Left
        version.ZIndex = 2
        version.Parent = main
    end

    --// Dragging System
    local dragging, dragStart, startPos = false, nil, nil

    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)

    title.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    --// Return API
    return {
        Gui = gui,
        Frame = main,
        Title = title,
        Theme = Theme
    }
end

return NeonUILib
