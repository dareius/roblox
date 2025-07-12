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
    local player = Players.LocalPlayer
    self.PlayerGui = player:WaitForChild("PlayerGui")
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "UILibraryGui"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.Parent = self.PlayerGui
    self.Window = nil
    return self
end

-- Create a window with 70% height
function UILibrary:CreateWindow(config)
    if self.Window then
        self:DestroyWindow()
    end

    local window = {
        Config = config or {},
        Title = config.Title or "My Window",
        Version = config.Version or "v1.0.0",
        Tabs = {},
        SelectedTab = nil
    }

    -- Main frame with 70% height
    window.MainFrame = Instance.new("Frame")
    window.MainFrame.Size = UDim2.new(0.6, 0, 0.7, 0) -- Updated to 70% height
    window.MainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
    window.MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    window.MainFrame.BorderSizePixel = 0
    window.MainFrame.Parent = self.ScreenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 12)
    uiCorner.Parent = window.MainFrame

    -- Drag handle (top 30%)
    local dragHandle = Instance.new("Frame")
    dragHandle.Size = UDim2.new(1, 0, 0.3, 0)
    dragHandle.Position = UDim2.new(0, 0, 0, 0)
    dragHandle.BackgroundTransparency = 1
    dragHandle.Parent = window.MainFrame

    -- Title label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.9, 0, 0.15, 0)
    titleLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = window.Title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = window.MainFrame

    -- Version label
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
    versionLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
    versionLabel.BackgroundTransparency = 1
    versionLabel.Text = window.Version
    versionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    versionLabel.TextScaled = true
    versionLabel.Font = Enum.Font.Gotham
    versionLabel.TextXAlignment = Enum.TextXAlignment.Left
    versionLabel.Parent = window.MainFrame

    -- Dragging setup
    window.Dragging = false
    window.DragStart = nil
    window.StartPos = nil
    window.TargetPos = nil
    window.LerpSpeed = 0.2

    local function lerp(a, b, t)
        return a + (b - a) * t
    end

    local function updateInput(input)
        if not window.Dragging then return end
        local delta = input.Position - window.DragStart
        window.TargetPos = UDim2.new(window.StartPos.X.Scale, window.StartPos.X.Offset + delta.X, window.StartPos.Y.Scale, window.StartPos.Y.Offset + delta.Y)
    end

    dragHandle.InputBegan:Connect(function(input)
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

    UserInputService.InputChanged:Connect(function(input)
        if window.Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateInput(input)
        end
    end)

    window.Connection = RunService.RenderStepped:Connect(function()
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

    -- Tab selection
    function window:SelectTab(tab)
        if self.SelectedTab then
            self.SelectedTab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            self.SelectedTab.Content.Visible = false
        end
        self.SelectedTab = tab
        tab.Button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        tab.Content.Visible = true
    end

    -- Add tab method
    function window:AddTab(tabName)
        local index = #self.Tabs
        local tab = {}
        tab.Button = Instance.new("TextButton")
        tab.Button.Size = UDim2.new(0.2, 0, 0.1, 0)
        tab.Button.Position = UDim2.new(0.05 + (0.22 * index), 0, 0.3, 0)
        tab.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tab.Button.Text = tabName -- User-defined tab name
        tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        tab.Button.Font = Enum.Font.Gotham
        tab.Button.TextScaled = true
        tab.Button.Parent = self.MainFrame

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = tab.Button

        tab.Content = Instance.new("Frame")
        tab.Content.Size = UDim2.new(0.9, 0, 0.53, 0)
        tab.Content.Position = UDim2.new(0.05, 0, 0.42, 0)
        tab.Content.BackgroundTransparency = 1
        tab.Content.Visible = false
        tab.Content.Parent = self.MainFrame

        tab.Button.MouseButton1Click:Connect(function()
            self:SelectTab(tab)
        end)

        table.insert(self.Tabs, tab)

        if not self.SelectedTab then
            self:SelectTab(tab)
        end

        return tab
    end

    self.Window = window
    return window
end

-- Destroy window
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

-- Destroy UI
function UILibrary:Destroy()
    self:DestroyWindow()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
end

return UILibrary
