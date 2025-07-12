-- ModuleScript in ReplicatedStorage named "UILibrary"
local UILibrary = {}
UILibrary.__index = UILibrary

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Create a new UI instance
function UILibrary.new()
    local self = setmetatable({}, UILibrary)
    
    -- Get the local player
    local player = Players.LocalPlayer
    self.PlayerGui = player:WaitForChild("PlayerGui")

    -- Create ScreenGui (empty until window is created)
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "UILibraryGui"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.Parent = self.PlayerGui

    -- Track window
    self.Window = nil

    return self
end

-- Create a single window
function UILibrary:CreateWindow(config)
    -- Destroy existing window if it exists
    if self.Window then
        self:DestroyWindow()
    end

    local window = {}
    window.Config = config or {}
    window.Title = config.Title or "My Window"
    window.Version = config.Version or "v1.0.0"

    -- Create main frame
    window.MainFrame = Instance.new("Frame")
    window.MainFrame.Size = UDim2.new(0.6, 0, 0.6, 0) -- 60% of screen width and height
    window.MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0) -- Centered
    window.MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Pure black
    window.MainFrame.BorderSizePixel = 0
    window.MainFrame.Parent = self.ScreenGui

    -- Add corner rounding
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 12)
    uiCorner.Parent = window.MainFrame

    -- Create title label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.15, 0)
    titleLabel.Position = UDim2.new(0, 0, 0.05, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = window.Title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = window.MainFrame

    -- Create version label
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(1, 0, 0.1, 0)
    versionLabel.Position = UDim2.new(0, 0, 0.2, 0)
    versionLabel.BackgroundTransparency = 1
    versionLabel.Text = window.Version
    versionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    versionLabel.TextScaled = true
    versionLabel.Font = Enum.Font.Gotham
    versionLabel.TextSize = 0.7 * titleLabel.TextSize -- Smaller than title
    versionLabel.Parent = window.MainFrame

    -- Dragging variables
    window.Dragging = false
    window.DragStart = nil
    window.StartPos = nil
    window.TargetPos = nil
    window.LerpSpeed = 0.2 -- Smooth dragging

    -- Dragging functionality
    local function lerp(a, b, t)
        return a + (b - a) * t
    end

    local function updateInput(input)
        if not window.Dragging then return end
        local delta = input.Position - window.DragStart
        window.TargetPos = UDim2.new(window.StartPos.X.Scale, window.StartPos.X.Offset + delta.X, window.StartPos.Y.Scale, window.StartPos.Y.Offset + delta.Y)
    end

    window.MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            window.Dragging = true
            window.DragStart = input.Position
            window.StartPos = window.MainFrame.Position
            window.TargetPos = window.MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    window.Dragging = false
                end
            end)
        end
    end)

    window.MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            updateInput(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if window.Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateInput(input)
        end
    end)

    -- Smooth dragging loop
    window.Connection = RunService.RenderStepped:Connect(function(deltaTime)
        if window.Dragging and window.TargetPos then
            local currentPos = window.MainFrame.Position
            local newX = lerp(currentPos.X.Offset, window.TargetPos.X.Offset, window.LerpSpeed)
            local newY = lerp(currentPos.Y.Offset, window.TargetPos.Y.Offset, window.LerpSpeed)
            window.MainFrame.Position = UDim2.new(currentPos.X.Scale, newX, currentPos.Y.Scale, newY)
        end
    end)

    -- Fade-in animation
    window.MainFrame.BackgroundTransparency = 1
    titleLabel.TextTransparency = 1
    versionLabel.TextTransparency = 1
    local fadeIn = TweenService:Create(window.MainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0})
    fadeIn:Play()
    TweenService:Create(titleLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    TweenService:Create(versionLabel, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

    -- Store window
    self.Window = window

    return window
end

-- Destroy the current window
function UILibrary:DestroyWindow()
    if self.Window then
        if self.Window.Connection then
            self.Window.Connection:Disconnect()
        end
        if self.Window.MainFrame then
            self.Window.MainFrame:Destroy()
        end
        self.Window = nil
    end
end

-- Destroy the UI entirely
function UILibrary:Destroy()
    self:DestroyWindow()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
    self = nil
end

return UILibrary
