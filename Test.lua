-- Modern GUI Library for Roblox
-- Similar to OrionLib/Rayfield with smooth animations and modern design

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Library = {}
Library.__index = Library

-- Configuration
local Config = {
    -- Theme Colors
    BackgroundColor = Color3.fromRGB(25, 25, 35),
    SecondaryColor = Color3.fromRGB(35, 35, 50),
    AccentColor = Color3.fromRGB(100, 150, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    SecondaryTextColor = Color3.fromRGB(180, 180, 180),
    BorderColor = Color3.fromRGB(60, 60, 80),
    
    -- Animation Settings
    AnimationSpeed = 0.25,
    EasingStyle = Enum.EasingStyle.Quart,
    EasingDirection = Enum.EasingDirection.Out,
    
    -- Sizes
    WindowSize = UDim2.new(0, 550, 0, 400),
    TabButtonSize = UDim2.new(1, -10, 0, 35),
    ElementHeight = 35,
    Padding = 8
}

-- Utility Functions
local function CreateTween(object, properties, duration)
    duration = duration or Config.AnimationSpeed
    local tweenInfo = TweenInfo.new(duration, Config.EasingStyle, Config.EasingDirection)
    return TweenService:Create(object, tweenInfo, properties)
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Config.BorderColor
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

local function CreateGradient(parent, colors, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(colors)
    gradient.Rotation = rotation or 0
    gradient.Parent = parent
    return gradient
end

-- Library Functions
function Library:CreateWindow(config)
    config = config or {}
    
    local Window = {
        Name = config.Name or "GUI Library",
        IntroText = config.IntroText or "Welcome to the GUI",
        ConfigFolder = config.ConfigFolder or "GUIConfig",
        Tabs = {},
        CurrentTab = nil
    }
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = Config.WindowSize
    MainFrame.Position = UDim2.new(0.5, -Config.WindowSize.X.Offset/2, 0.5, -Config.WindowSize.Y.Offset/2)
    MainFrame.BackgroundColor3 = Config.BackgroundColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    CreateCorner(MainFrame, 12)
    CreateStroke(MainFrame, Config.BorderColor, 1)
    
    -- Drop Shadow Effect
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.8
    Shadow.ZIndex = MainFrame.ZIndex - 1
    Shadow.Parent = MainFrame
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = Config.SecondaryColor
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    CreateCorner(TitleBar, 12)
    
    -- Title Bar Bottom Corner Fix
    local TitleBarFix = Instance.new("Frame")
    TitleBarFix.Size = UDim2.new(1, 0, 0, 12)
    TitleBarFix.Position = UDim2.new(0, 0, 1, -12)
    TitleBarFix.BackgroundColor3 = Config.SecondaryColor
    TitleBarFix.BorderSizePixel = 0
    TitleBarFix.Parent = TitleBar
    
    -- Title Text
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Window.Name
    TitleLabel.TextColor3 = Config.TextColor
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = TitleBar
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 10)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Config.TextColor
    CloseButton.TextSize = 20
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TitleBar
    
    CreateCorner(CloseButton, 6)
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 150, 1, -60)
    TabContainer.Position = UDim2.new(0, 10, 0, 60)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = MainFrame
    
    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    TabList.Parent = TabContainer
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -170, 1, -70)
    ContentContainer.Position = UDim2.new(0, 160, 0, 60)
    ContentContainer.BackgroundColor3 = Config.SecondaryColor
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame
    
    CreateCorner(ContentContainer, 8)
    
    -- Dragging functionality
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        CreateTween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3):Play()
        wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Window Methods
    function Window:CreateTab(config)
        config = config or {}
        
        local Tab = {
            Name = config.Name or "Tab",
            Icon = config.Icon or "",
            Elements = {},
            Active = false
        }
        
        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = Tab.Name .. "Button"
        TabButton.Size = Config.TabButtonSize
        TabButton.BackgroundColor3 = Config.BackgroundColor
        TabButton.BorderSizePixel = 0
        TabButton.Text = Tab.Name
        TabButton.TextColor3 = Config.SecondaryTextColor
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.Gotham
        TabButton.Parent = TabContainer
        
        CreateCorner(TabButton, 6)
        
        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = Tab.Name .. "Content"
        TabContent.Size = UDim2.new(1, -20, 1, -20)
        TabContent.Position = UDim2.new(0, 10, 0, 10)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Config.AccentColor
        TabContent.Visible = false
        TabContent.Parent = ContentContainer
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, Config.Padding)
        ContentList.Parent = TabContent
        
        -- Auto-resize content
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 20)
        end)
        
        -- Tab Selection
        TabButton.MouseButton1Click:Connect(function()
            Window:SelectTab(Tab)
        end)
        
        -- Tab Methods
        function Tab:CreateLabel(config)
            config = config or {}
            
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Size = UDim2.new(1, 0, 0, Config.ElementHeight)
            Label.BackgroundTransparency = 1
            Label.Text = config.Text or "Label"
            Label.TextColor3 = Config.TextColor
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Font = Enum.Font.Gotham
            Label.Parent = TabContent
            
            return Label
        end
        
        function Tab:CreateButton(config)
            config = config or {}
            
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Size = UDim2.new(1, 0, 0, Config.ElementHeight)
            Button.BackgroundColor3 = Config.AccentColor
            Button.BorderSizePixel = 0
            Button.Text = config.Text or "Button"
            Button.TextColor3 = Config.TextColor
            Button.TextSize = 14
            Button.Font = Enum.Font.Gotham
            Button.Parent = TabContent
            
            CreateCorner(Button, 6)
            
            -- Button Animation
            Button.MouseEnter:Connect(function()
                CreateTween(Button, {BackgroundColor3 = Config.AccentColor:lerp(Color3.new(1,1,1), 0.1)}):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                CreateTween(Button, {BackgroundColor3 = Config.AccentColor}):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                CreateTween(Button, {Size = UDim2.new(1, -4, 0, Config.ElementHeight - 4)}):Play()
                wait(0.1)
                CreateTween(Button, {Size = UDim2.new(1, 0, 0, Config.ElementHeight)}):Play()
                
                if config.Callback then
                    config.Callback()
                end
            end)
            
            return Button
        end
        
        function Tab:CreateToggle(config)
            config = config or {}
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Size = UDim2.new(1, 0, 0, Config.ElementHeight)
            ToggleFrame.BackgroundColor3 = Config.BackgroundColor
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent
            
            CreateCorner(ToggleFrame, 6)
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = config.Text or "Toggle"
            ToggleLabel.TextColor3 = Config.TextColor
            ToggleLabel.TextSize = 14
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleButton.BackgroundColor3 = Config.BorderColor
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            CreateCorner(ToggleButton, 10)
            
            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
            ToggleIndicator.Position = UDim2.new(0, 2, 0, 2)
            ToggleIndicator.BackgroundColor3 = Config.TextColor
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Parent = ToggleButton
            
            CreateCorner(ToggleIndicator, 8)
            
            local toggled = config.Default or false
            
            local function UpdateToggle()
                if toggled then
                    CreateTween(ToggleButton, {BackgroundColor3 = Config.AccentColor}):Play()
                    CreateTween(ToggleIndicator, {Position = UDim2.new(1, -18, 0, 2)}):Play()
                else
                    CreateTween(ToggleButton, {BackgroundColor3 = Config.BorderColor}):Play()
                    CreateTween(ToggleIndicator, {Position = UDim2.new(0, 2, 0, 2)}):Play()
                end
                
                if config.Callback then
                    config.Callback(toggled)
                end
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                UpdateToggle()
            end)
            
            UpdateToggle()
            
            return {
                Set = function(value)
                    toggled = value
                    UpdateToggle()
                end
            }
        end
        
        function Tab:CreateSlider(config)
            config = config or {}
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = "SliderFrame"
            SliderFrame.Size = UDim2.new(1, 0, 0, Config.ElementHeight * 1.5)
            SliderFrame.BackgroundColor3 = Config.BackgroundColor
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabContent
            
            CreateCorner(SliderFrame, 6)
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Size = UDim2.new(1, -10, 0, 20)
            SliderLabel.Position = UDim2.new(0, 10, 0, 5)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = config.Text or "Slider"
            SliderLabel.TextColor3 = Config.TextColor
            SliderLabel.TextSize = 14
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.Parent = SliderFrame
            
            local SliderTrack = Instance.new("Frame")
            SliderTrack.Size = UDim2.new(1, -20, 0, 4)
            SliderTrack.Position = UDim2.new(0, 10, 0, 30)
            SliderTrack.BackgroundColor3 = Config.BorderColor
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Parent = SliderFrame
            
            CreateCorner(SliderTrack, 2)
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new(0, 0, 1, 0)
            SliderFill.BackgroundColor3 = Config.AccentColor
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderTrack
            
            CreateCorner(SliderFill, 2)
            
            local SliderHandle = Instance.new("Frame")
            SliderHandle.Size = UDim2.new(0, 16, 0, 16)
            SliderHandle.Position = UDim2.new(0, -8, 0, -6)
            SliderHandle.BackgroundColor3 = Config.AccentColor
            SliderHandle.BorderSizePixel = 0
            SliderHandle.Parent = SliderTrack
            
            CreateCorner(SliderHandle, 8)
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0, 50, 0, 20)
            ValueLabel.Position = UDim2.new(1, -50, 0, 5)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(config.Default or config.Min or 0)
            ValueLabel.TextColor3 = Config.AccentColor
            ValueLabel.TextSize = 12
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Font = Enum.Font.Gotham
            ValueLabel.Parent = SliderFrame
            
            local min = config.Min or 0
            local max = config.Max or 100
            local value = config.Default or min
            local dragging = false
            
            local function UpdateSlider()
                local percentage = (value - min) / (max - min)
                CreateTween(SliderFill, {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
                CreateTween(SliderHandle, {Position = UDim2.new(percentage, -8, 0, -6)}):Play()
                ValueLabel.Text = tostring(math.floor(value))
                
                if config.Callback then
                    config.Callback(value)
                end
            end
            
            SliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local mousePos = UserInputService:GetMouseLocation()
                    local relativePos = mousePos.X - SliderTrack.AbsolutePosition.X
                    local percentage = math.clamp(relativePos / SliderTrack.AbsoluteSize.X, 0, 1)
                    value = min + (max - min) * percentage
                    UpdateSlider()
                end
            end)
            
            UpdateSlider()
            
            return {
                Set = function(newValue)
                    value = math.clamp(newValue, min, max)
                    UpdateSlider()
                end
            }
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- Select first tab automatically
        if #Window.Tabs == 1 then
            Window:SelectTab(Tab)
        end
        
        return Tab
    end
    
    function Window:SelectTab(tab)
        -- Deselect all tabs
        for _, t in pairs(Window.Tabs) do
            t.Active = false
            local button = TabContainer:FindFirstChild(t.Name .. "Button")
            local content = ContentContainer:FindFirstChild(t.Name .. "Content")
            
            if button then
                CreateTween(button, {BackgroundColor3 = Config.BackgroundColor, TextColor3 = Config.SecondaryTextColor}):Play()
            end
            if content then
                content.Visible = false
            end
        end
        
        -- Select new tab
        tab.Active = true
        local button = TabContainer:FindFirstChild(tab.Name .. "Button")
        local content = ContentContainer:FindFirstChild(tab.Name .. "Content")
        
        if button then
            CreateTween(button, {BackgroundColor3 = Config.AccentColor, TextColor3 = Config.TextColor}):Play()
        end
        if content then
            content.Visible = true
        end
        
        Window.CurrentTab = tab
    end
    
    -- Intro Animation
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    CreateTween(MainFrame, {Size = Config.WindowSize}, 0.5):Play()
    
    return Window
end

return Library
