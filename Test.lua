-- Enhanced Modern GUI Library for Roblox
-- Mobile-friendly with minimize, dropdowns, multi-dropdowns, paragraphs and more

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
    HoverColor = Color3.fromRGB(45, 45, 65),
    
    -- Animation Settings
    AnimationSpeed = 0.25,
    EasingStyle = Enum.EasingStyle.Quart,
    EasingDirection = Enum.EasingDirection.Out,
    
    -- Sizes
    WindowSize = UDim2.new(0, 550, 0, 400),
    MinimizedSize = UDim2.new(0, 550, 0, 50),
    TabButtonSize = UDim2.new(1, -10, 0, 35),
    ElementHeight = 35,
    Padding = 8,
    
    -- Mobile Detection
    IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
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

local function GetInputPosition(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        return input.Position
    else
        return UserInputService:GetMouseLocation()
    end
end

-- Library Functions
function Library:CreateWindow(config)
    config = config or {}
    
    local Window = {
        Name = config.Name or "GUI Library",
        IntroText = config.IntroText or "Welcome to the GUI",
        ConfigFolder = config.ConfigFolder or "GUIConfig",
        Tabs = {},
        CurrentTab = nil,
        Minimized = false
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
    TitleLabel.Size = UDim2.new(1, -140, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Window.Name
    TitleLabel.TextColor3 = Config.TextColor
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = TitleBar
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -80, 0, 10)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 85)
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Config.TextColor
    MinimizeButton.TextSize = 20
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = TitleBar
    
    CreateCorner(MinimizeButton, 6)
    
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
    
    -- Content Wrapper (for minimize animation)
    local ContentWrapper = Instance.new("Frame")
    ContentWrapper.Name = "ContentWrapper"
    ContentWrapper.Size = UDim2.new(1, 0, 1, -50)
    ContentWrapper.Position = UDim2.new(0, 0, 0, 50)
    ContentWrapper.BackgroundTransparency = 1
    ContentWrapper.Parent = MainFrame
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 150, 1, -10)
    TabContainer.Position = UDim2.new(0, 10, 0, 10)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = ContentWrapper
    
    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    TabList.Parent = TabContainer
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -170, 1, -20)
    ContentContainer.Position = UDim2.new(0, 160, 0, 10)
    ContentContainer.BackgroundColor3 = Config.SecondaryColor
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = ContentWrapper
    
    CreateCorner(ContentContainer, 8)
    
    -- Mobile-friendly dragging functionality
    local dragging = false
    local dragStart = nil
    local startPos = nil
    local dragConnection = nil
    
    local function StartDrag(input)
        dragging = true
        dragStart = GetInputPosition(input)
        startPos = MainFrame.Position
        
        if dragConnection then
            dragConnection:Disconnect()
        end
        
        if Config.IsMobile then
            dragConnection = UserInputService.TouchMoved:Connect(function(touch, gameProcessed)
                if not gameProcessed and dragging then
                    local currentPos = touch.Position
                    local delta = currentPos - dragStart
                    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)
        else
            dragConnection = UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local delta = input.Position - dragStart
                    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)
        end
    end
    
    local function EndDrag()
        dragging = false
        if dragConnection then
            dragConnection:Disconnect()
            dragConnection = nil
        end
    end
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            StartDrag(input)
        end
    end)
    
    if Config.IsMobile then
        UserInputService.TouchEnded:Connect(function(touch, gameProcessed)
            EndDrag()
        end)
    else
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                EndDrag()
            end
        end)
    end
    
    -- Minimize functionality
    function Window:Minimize()
        Window.Minimized = not Window.Minimized
        
        if Window.Minimized then
            CreateTween(MainFrame, {Size = Config.MinimizedSize}):Play()
            CreateTween(ContentWrapper, {Size = UDim2.new(1, 0, 0, 0)}):Play()
            MinimizeButton.Text = "+"
        else
            CreateTween(MainFrame, {Size = Config.WindowSize}):Play()
            CreateTween(ContentWrapper, {Size = UDim2.new(1, 0, 1, -50)}):Play()
            MinimizeButton.Text = "−"
        end
    end
    
    MinimizeButton.MouseButton1Click:Connect(function()
        Window:Minimize()
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
        
        function Tab:CreateParagraph(config)
            config = config or {}
            
            local ParagraphFrame = Instance.new("Frame")
            ParagraphFrame.Name = "ParagraphFrame"
            ParagraphFrame.Size = UDim2.new(1, 0, 0, 80)
            ParagraphFrame.BackgroundColor3 = Config.BackgroundColor
            ParagraphFrame.BorderSizePixel = 0
            ParagraphFrame.Parent = TabContent
            
            CreateCorner(ParagraphFrame, 6)
            
            local ParagraphTitle = Instance.new("TextLabel")
            ParagraphTitle.Size = UDim2.new(1, -20, 0, 25)
            ParagraphTitle.Position = UDim2.new(0, 10, 0, 5)
            ParagraphTitle.BackgroundTransparency = 1
            ParagraphTitle.Text = config.Title or "Paragraph"
            ParagraphTitle.TextColor3 = Config.TextColor
            ParagraphTitle.TextSize = 16
            ParagraphTitle.TextXAlignment = Enum.TextXAlignment.Left
            ParagraphTitle.Font = Enum.Font.GothamBold
            ParagraphTitle.Parent = ParagraphFrame
            
            local ParagraphContent = Instance.new("TextLabel")
            ParagraphContent.Size = UDim2.new(1, -20, 1, -30)
            ParagraphContent.Position = UDim2.new(0, 10, 0, 25)
            ParagraphContent.BackgroundTransparency = 1
            ParagraphContent.Text = config.Content or "This is a paragraph of text."
            ParagraphContent.TextColor3 = Config.SecondaryTextColor
            ParagraphContent.TextSize = 12
            ParagraphContent.TextXAlignment = Enum.TextXAlignment.Left
            ParagraphContent.TextYAlignment = Enum.TextYAlignment.Top
            ParagraphContent.TextWrapped = true
            ParagraphContent.Font = Enum.Font.Gotham
            ParagraphContent.Parent = ParagraphFrame
            
            -- Auto-resize based on text
            local textSize = game:GetService("TextService"):GetTextSize(
                ParagraphContent.Text,
                ParagraphContent.TextSize,
                ParagraphContent.Font,
                Vector2.new(ParagraphContent.AbsoluteSize.X, math.huge)
            )
            
            ParagraphFrame.Size = UDim2.new(1, 0, 0, math.max(80, textSize.Y + 35))
            
            return {
                SetTitle = function(title)
                    ParagraphTitle.Text = title
                end,
                SetContent = function(content)
                    ParagraphContent.Text = content
                    local newTextSize = game:GetService("TextService"):GetTextSize(
                        content,
                        ParagraphContent.TextSize,
                        ParagraphContent.Font,
                        Vector2.new(ParagraphContent.AbsoluteSize.X, math.huge)
                    )
                    ParagraphFrame.Size = UDim2.new(1, 0, 0, math.max(80, newTextSize.Y + 35))
                end
            }
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
            
            local function HandleInput(inputPos)
                local relativePos = inputPos.X - SliderTrack.AbsolutePosition.X
                local percentage = math.clamp(relativePos / SliderTrack.AbsoluteSize.X, 0, 1)
                value = min + (max - min) * percentage
                UpdateSlider()
            end
            
            SliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    HandleInput(GetInputPosition(input))
                end
            end)
            
            if Config.IsMobile then
                UserInputService.TouchMoved:Connect(function(touch, gameProcessed)
                    if dragging then
                        HandleInput(touch.Position)
                    end
                end)
                
                UserInputService.TouchEnded:Connect(function()
                    dragging = false
                end)
            else
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        HandleInput(input.Position)
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
            end
            
            UpdateSlider()
            
            return {
                Set = function(newValue)
                    value = math.clamp(newValue, min, max)
                    UpdateSlider()
                end
            }
        end
        
        function Tab:CreateDropdown(config)
            config = config or {}
            
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Name = "DropdownFrame"
            DropdownFrame.Size = UDim2.new(1, 0, 0, Config.ElementHeight)
            DropdownFrame.BackgroundColor3 = Config.BackgroundColor
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Parent = TabContent
            
            CreateCorner(DropdownFrame, 6)
            
            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Size = UDim2.new(1, -10, 1, -10)
            DropdownButton.Position = UDim2.new(0, 5, 0, 5)
            DropdownButton.BackgroundColor3 = Config.SecondaryColor
            DropdownButton.BorderSizePixel = 0
            DropdownButton.Text = config.Default or config.Options[1] or "Select Option"
            DropdownButton.TextColor3 = Config.TextColor
            DropdownButton.TextSize = 14
            DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
            DropdownButton.Font = Enum.Font.Gotham
            DropdownButton.Parent = DropdownFrame
            
            CreateCorner(DropdownButton, 4)
            
            local DropdownArrow = Instance.new("TextLabel")
            DropdownArrow.Size = UDim2.new(0, 20, 1, 0)
            DropdownArrow.Position = UDim2.new(1, -25, 0, 0)
            DropdownArrow.BackgroundTransparency = 1
            DropdownArrow.Text = "▼"
            DropdownArrow.TextColor3 = Config.AccentColor
            DropdownArrow.TextSize = 12
            DropdownArrow.Font = Enum.Font.Gotham
            DropdownArrow.Parent = DropdownButton
            
            local DropdownList = Instance.new("Frame")
            DropdownList.Name = "DropdownList"
            DropdownList.Size = UDim2.new(1, 0, 0, 0)
            DropdownList.Position = UDim2.new(0, 0, 1, 5)
            DropdownList.BackgroundColor3 = Config.SecondaryColor
            DropdownList.BorderSizePixel = 0
            DropdownList.Visible = false
            DropdownList.ZIndex = 10
            DropdownList.Parent = DropdownFrame
            
            CreateCorner(DropdownList, 6)
            CreateStroke(DropdownList, Config.BorderColor, 1)
            
            local ListLayout = Instance.new("UIListLayout")
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListLayout.Parent = DropdownList
            
            local options = config.Options or {"Option 1", "Option 2", "Option 3"}
            local selectedValue = config.Default or options[1]
            local isOpen = false
            
            local function CreateOption(optionText, index)
                local OptionButton = Instance.new("TextButton")
                OptionButton.Size = UDim2.new(1, 0, 0, 30)
                OptionButton.BackgroundColor3 = Config.SecondaryColor
                OptionButton.BorderSizePixel = 0
                OptionButton.Text = optionText
                OptionButton.TextColor3 = Config.TextColor
                OptionButton.TextSize = 12
                OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.Parent = DropdownList
                
                local OptionPadding = Instance.new("UIPadding")
                OptionPadding.PaddingLeft = UDim.new(0, 10)
                OptionPadding.Parent = OptionButton
                
                OptionButton.MouseEnter:Connect(function()
                    CreateTween(OptionButton, {BackgroundColor3 = Config.HoverColor}):Play()
                end)
                
                OptionButton.MouseLeave:Connect(function()
                    CreateTween(OptionButton, {BackgroundColor3 = Config.SecondaryColor}):Play()
                end)
                
                OptionButton.MouseButton1Click:Connect(function()
                    selectedValue = optionText
                    DropdownButton.Text = optionText
                    isOpen = false
                    
                    CreateTween(DropdownList, {Size = UDim2.new(1, 0, 0, 0)}):Play()
                    CreateTween(DropdownArrow, {Rotation = 0}):Play()
                    wait(0.2)
                    DropdownList.Visible = false
                    
                    if config.Callback then
                        config.Callback(optionText)
                    end
                end)
            end
            
            for i, option in ipairs(options) do
                CreateOption(option, i)
            end
            
            DropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                
                if isOpen then
                    DropdownList.Visible = true
                    CreateTween(DropdownList, {Size = UDim2.new(1, 0, 0, #options * 30)}):Play()
                    CreateTween(DropdownArrow, {Rotation = 180}):Play()
                    
                    -- Expand dropdown frame
                    CreateTween(DropdownFrame, {Size = UDim2.new(1, 0, 0, Config.ElementHeight + (#options * 30) + 5)}):Play()
                else
                    CreateTween(DropdownList, {Size = UDim2.new(1, 0, 0, 0)}):Play()
                    CreateTween(DropdownArrow, {Rotation = 0}):Play()
                    CreateTween(DropdownFrame, {Size = UDim2.new(1, 0, 0, Config.ElementHeight)}):Play()
                    wait(0.2)
                    DropdownList.Visible = false
                end
            end)
            
            return {
                Set = function(value)
                    if table.find(options, value) then
                        selectedValue = value
                        DropdownButton.Text = value
                        if config.Callback then
                            config.Callback(value)
                        end
                    end
                end,
                Get = function()
                    return selectedValue
                end,
                SetOptions = function(newOptions)
                    options = newOptions
                    for _, child in ipairs(DropdownList:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    for i, option in ipairs(options) do
                        CreateOption(option, i)
                    end
                end
            }
        end
        
        function Tab:CreateMultiDropdown(config)
            config = config or {}
            
            local MultiDropdownFrame = Instance.new("Frame")
            MultiDropdownFrame.Name = "MultiDropdownFrame"
            MultiDropdownFrame.Size = UDim2.new(1, 0, 0, Config.ElementHeight)
            MultiDropdownFrame.BackgroundColor3 = Config.BackgroundColor
            MultiDropdownFrame.BorderSizePixel = 0
            MultiDropdownFrame.Parent = TabContent
            
            CreateCorner(MultiDropdownFrame, 6)
            
            local MultiDropdownButton = Instance.new("TextButton")
            MultiDropdownButton.Size = UDim2.new(1, -10, 1, -10)
            MultiDropdownButton.Position = UDim2.new(0, 5, 0, 5)
            MultiDropdownButton.BackgroundColor3 = Config.SecondaryColor
            MultiDropdownButton.BorderSizePixel = 0
            MultiDropdownButton.Text = "Select Options"
            MultiDropdownButton.TextColor3 = Config.TextColor
            MultiDropdownButton.TextSize = 14
            MultiDropdownButton.TextXAlignment = Enum.TextXAlignment.Left
            MultiDropdownButton.Font = Enum.Font.Gotham
            MultiDropdownButton.Parent = MultiDropdownFrame
            
            CreateCorner(MultiDropdownButton, 4)
            
            local MultiDropdownArrow = Instance.new("TextLabel")
            MultiDropdownArrow.Size = UDim2.new(0, 20, 1, 0)
            MultiDropdownArrow.Position = UDim2.new(1, -25, 0, 0)
            MultiDropdownArrow.BackgroundTransparency = 1
            MultiDropdownArrow.Text = "▼"
            MultiDropdownArrow.TextColor3 = Config.AccentColor
            MultiDropdownArrow.TextSize = 12
            MultiDropdownArrow.Font = Enum.Font.Gotham
            MultiDropdownArrow.Parent = MultiDropdownButton
            
            local MultiDropdownList = Instance.new("Frame")
            MultiDropdownList.Name = "MultiDropdownList"
            MultiDropdownList.Size = UDim2.new(1, 0, 0, 0)
            MultiDropdownList.Position = UDim2.new(0, 0, 1, 5)
            MultiDropdownList.BackgroundColor3 = Config.SecondaryColor
            MultiDropdownList.BorderSizePixel = 0
            MultiDropdownList.Visible = false
            MultiDropdownList.ZIndex = 10
            MultiDropdownList.Parent = MultiDropdownFrame
            
            CreateCorner(MultiDropdownList, 6)
            CreateStroke(MultiDropdownList, Config.BorderColor, 1)
            
            local MultiListLayout = Instance.new("UIListLayout")
            MultiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            MultiListLayout.Parent = MultiDropdownList
            
            local options = config.Options or {"Option 1", "Option 2", "Option 3", "Option 4"}
            local selectedValues = {}
            local isOpen = false
            
            local function UpdateButtonText()
                if #selectedValues == 0 then
                    MultiDropdownButton.Text = "Select Options"
                elseif #selectedValues == 1 then
                    MultiDropdownButton.Text = selectedValues[1]
                else
                    MultiDropdownButton.Text = selectedValues[1] .. " (+" .. (#selectedValues - 1) .. " more)"
                end
            end
            
            local function CreateMultiOption(optionText, index)
                local OptionFrame = Instance.new("Frame")
                OptionFrame.Size = UDim2.new(1, 0, 0, 30)
                OptionFrame.BackgroundColor3 = Config.SecondaryColor
                OptionFrame.BorderSizePixel = 0
                OptionFrame.Parent = MultiDropdownList
                
                local OptionCheckbox = Instance.new("TextButton")
                OptionCheckbox.Size = UDim2.new(0, 20, 0, 20)
                OptionCheckbox.Position = UDim2.new(0, 10, 0, 5)
                OptionCheckbox.BackgroundColor3 = Config.BorderColor
                OptionCheckbox.BorderSizePixel = 0
                OptionCheckbox.Text = ""
                OptionCheckbox.Parent = OptionFrame
                
                CreateCorner(OptionCheckbox, 4)
                
                local CheckboxCheck = Instance.new("TextLabel")
                CheckboxCheck.Size = UDim2.new(1, 0, 1, 0)
                CheckboxCheck.BackgroundTransparency = 1
                CheckboxCheck.Text = "✓"
                CheckboxCheck.TextColor3 = Config.TextColor
                CheckboxCheck.TextSize = 14
                CheckboxCheck.Font = Enum.Font.GothamBold
                CheckboxCheck.Visible = false
                CheckboxCheck.Parent = OptionCheckbox
                
                local OptionLabel = Instance.new("TextLabel")
                OptionLabel.Size = UDim2.new(1, -40, 1, 0)
                OptionLabel.Position = UDim2.new(0, 35, 0, 0)
                OptionLabel.BackgroundTransparency = 1
                OptionLabel.Text = optionText
                OptionLabel.TextColor3 = Config.TextColor
                OptionLabel.TextSize = 12
                OptionLabel.TextXAlignment = Enum.TextXAlignment.Left
                OptionLabel.Font = Enum.Font.Gotham
                OptionLabel.Parent = OptionFrame
                
                local isSelected = table.find(selectedValues, optionText) ~= nil
                
                local function UpdateCheckbox()
                    if isSelected then
                        CreateTween(OptionCheckbox, {BackgroundColor3 = Config.AccentColor}):Play()
                        CheckboxCheck.Visible = true
                    else
                        CreateTween(OptionCheckbox, {BackgroundColor3 = Config.BorderColor}):Play()
                        CheckboxCheck.Visible = false
                    end
                end
                
                OptionFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        isSelected = not isSelected
                        
                        if isSelected then
                            table.insert(selectedValues, optionText)
                        else
                            local index = table.find(selectedValues, optionText)
                            if index then
                                table.remove(selectedValues, index)
                            end
                        end
                        
                        UpdateCheckbox()
                        UpdateButtonText()
                        
                        if config.Callback then
                            config.Callback(selectedValues)
                        end
                    end
                end)
                
                OptionFrame.MouseEnter:Connect(function()
                    CreateTween(OptionFrame, {BackgroundColor3 = Config.HoverColor}):Play()
                end)
                
                OptionFrame.MouseLeave:Connect(function()
                    CreateTween(OptionFrame, {BackgroundColor3 = Config.SecondaryColor}):Play()
                end)
                
                UpdateCheckbox()
            end
            
            for i, option in ipairs(options) do
                CreateMultiOption(option, i)
            end
            
            MultiDropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                
                if isOpen then
                    MultiDropdownList.Visible = true
                    CreateTween(MultiDropdownList, {Size = UDim2.new(1, 0, 0, #options * 30)}):Play()
                    CreateTween(MultiDropdownArrow, {Rotation = 180}):Play()
                    
                    -- Expand dropdown frame
                    CreateTween(MultiDropdownFrame, {Size = UDim2.new(1, 0, 0, Config.ElementHeight + (#options * 30) + 5)}):Play()
                else
                    CreateTween(MultiDropdownList, {Size = UDim2.new(1, 0, 0, 0)}):Play()
                    CreateTween(MultiDropdownArrow, {Rotation = 0}):Play()
                    CreateTween(MultiDropdownFrame, {Size = UDim2.new(1, 0, 0, Config.ElementHeight)}):Play()
                    wait(0.2)
                    MultiDropdownList.Visible = false
                end
            end)
            
            UpdateButtonText()
            
            return {
                Set = function(values)
                    selectedValues = values or {}
                    UpdateButtonText()
                    
                    -- Update all checkboxes
                    for _, child in ipairs(MultiDropdownList:GetChildren()) do
                        if child:IsA("Frame") then
                            local optionText = child:FindFirstChild("TextLabel") and child.TextLabel.Text
                            if optionText then
                                local checkbox = child:FindFirstChild("TextButton")
                                local check = checkbox and checkbox:FindFirstChild("TextLabel")
                                local isSelected = table.find(selectedValues, optionText) ~= nil
                                
                                if isSelected then
                                    CreateTween(checkbox, {BackgroundColor3 = Config.AccentColor}):Play()
                                    if check then check.Visible = true end
                                else
                                    CreateTween(checkbox, {BackgroundColor3 = Config.BorderColor}):Play()
                                    if check then check.Visible = false end
                                end
                            end
                        end
                    end
                    
                    if config.Callback then
                        config.Callback(selectedValues)
                    end
                end,
                Get = function()
                    return selectedValues
                end,
                Clear = function()
                    selectedValues = {}
                    UpdateButtonText()
                    
                    for _, child in ipairs(MultiDropdownList:GetChildren()) do
                        if child:IsA("Frame") then
                            local checkbox = child:FindFirstChild("TextButton")
                            local check = checkbox and checkbox:FindFirstChild("TextLabel")
                            CreateTween(checkbox, {BackgroundColor3 = Config.BorderColor}):Play()
                            if check then check.Visible = false end
                        end
                    end
                    
                    if config.Callback then
                        config.Callback(selectedValues)
                    end
                end
            }
        end
        
        function Tab:CreateTextBox(config)
            config = config or {}
            
            local TextBoxFrame = Instance.new("Frame")
            TextBoxFrame.Name = "TextBoxFrame"
            TextBoxFrame.Size = UDim2.new(1, 0, 0, Config.ElementHeight)
            TextBoxFrame.BackgroundColor3 = Config.BackgroundColor
            TextBoxFrame.BorderSizePixel = 0
            TextBoxFrame.Parent = TabContent
            
            CreateCorner(TextBoxFrame, 6)
            
            local TextBoxLabel = Instance.new("TextLabel")
            TextBoxLabel.Size = UDim2.new(0.4, 0, 1, 0)
            TextBoxLabel.Position = UDim2.new(0, 10, 0, 0)
            TextBoxLabel.BackgroundTransparency = 1
            TextBoxLabel.Text = config.Text or "TextBox"
            TextBoxLabel.TextColor3 = Config.TextColor
            TextBoxLabel.TextSize = 14
            TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextBoxLabel.Font = Enum.Font.Gotham
            TextBoxLabel.Parent = TextBoxFrame
            
            local TextBox = Instance.new("TextBox")
            TextBox.Size = UDim2.new(0.55, -10, 0, 25)
            TextBox.Position = UDim2.new(0.45, 0, 0.5, -12.5)
            TextBox.BackgroundColor3 = Config.SecondaryColor
            TextBox.BorderSizePixel = 0
            TextBox.Text = config.Default or ""
            TextBox.PlaceholderText = config.PlaceholderText or "Enter text..."
            TextBox.TextColor3 = Config.TextColor
            TextBox.PlaceholderColor3 = Config.SecondaryTextColor
            TextBox.TextSize = 12
            TextBox.Font = Enum.Font.Gotham
            TextBox.ClearButtonEnabled = true
            TextBox.Parent = TextBoxFrame
            
            CreateCorner(TextBox, 4)
            
            local TextBoxPadding = Instance.new("UIPadding")
            TextBoxPadding.PaddingLeft = UDim.new(0, 8)
            TextBoxPadding.PaddingRight = UDim.new(0, 8)
            TextBoxPadding.Parent = TextBox
            
            TextBox.FocusLost:Connect(function(enterPressed)
                if config.Callback then
                    config.Callback(TextBox.Text, enterPressed)
                end
            end)
            
            TextBox.Focused:Connect(function()
                CreateTween(TextBox, {BackgroundColor3 = Config.HoverColor}):Play()
            end)
            
            TextBox.FocusLost:Connect(function()
                CreateTween(TextBox, {BackgroundColor3 = Config.SecondaryColor}):Play()
            end)
            
            return {
                Set = function(text)
                    TextBox.Text = text
                    if config.Callback then
                        config.Callback(text, false)
                    end
                end,
                Get = function()
                    return TextBox.Text
                end
            }
        end
        
        function Tab:CreateKeybind(config)
            config = config or {}
            
            local KeybindFrame = Instance.new("Frame")
            KeybindFrame.Name = "KeybindFrame"
            KeybindFrame.Size = UDim2.new(1, 0, 0, Config.ElementHeight)
            KeybindFrame.BackgroundColor3 = Config.BackgroundColor
            KeybindFrame.BorderSizePixel = 0
            KeybindFrame.Parent = TabContent
            
            CreateCorner(KeybindFrame, 6)
            
            local KeybindLabel = Instance.new("TextLabel")
            KeybindLabel.Size = UDim2.new(0.6, 0, 1, 0)
            KeybindLabel.Position = UDim2.new(0, 10, 0, 0)
            KeybindLabel.BackgroundTransparency = 1
            KeybindLabel.Text = config.Text or "Keybind"
            KeybindLabel.TextColor3 = Config.TextColor
            KeybindLabel.TextSize = 14
            KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
            KeybindLabel.Font = Enum.Font.Gotham
            KeybindLabel.Parent = KeybindFrame
            
            local KeybindButton = Instance.new("TextButton")
            KeybindButton.Size = UDim2.new(0.35, -10, 0, 25)
            KeybindButton.Position = UDim2.new(0.65, 0, 0.5, -12.5)
            KeybindButton.BackgroundColor3 = Config.SecondaryColor
            KeybindButton.BorderSizePixel = 0
            KeybindButton.Text = config.Default and config.Default.Name or "None"
            KeybindButton.TextColor3 = Config.TextColor
            KeybindButton.TextSize = 12
            KeybindButton.Font = Enum.Font.Gotham
            KeybindButton.Parent = KeybindFrame
            
            CreateCorner(KeybindButton, 4)
            
            local currentKey = config.Default
            local listening = false
            
            local function UpdateKeybind(key)
                currentKey = key
                KeybindButton.Text = key and key.Name or "None"
                
                if config.Callback then
                    config.Callback(key)
                end
            end
            
            KeybindButton.MouseButton1Click:Connect(function()
                if listening then return end
                
                listening = true
                KeybindButton.Text = "Press key..."
                
                local connection
                connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        connection:Disconnect()
                        listening = false
                        UpdateKeybind(input.KeyCode)
                    elseif input.UserInputType == Enum.UserInputType.MouseButton1 or 
                           input.UserInputType == Enum.UserInputType.MouseButton2 then
                        connection:Disconnect()
                        listening = false
                        UpdateKeybind(input.UserInputType)
                    end
                end)
            end)
            
            -- Listen for keybind activation
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed or listening then return end
                
                if currentKey and (input.KeyCode == currentKey or input.UserInputType == currentKey) then
                    if config.Callback then
                        config.Callback(currentKey)
                    end
                end
            end)
            
            return {
                Set = function(key)
                    UpdateKeybind(key)
                end,
                Get = function()
                    return currentKey
                end
            }
        end
        
        function Tab:CreateColorPicker(config)
            config = config or {}
            
            local ColorPickerFrame = Instance.new("Frame")
            ColorPickerFrame.Name = "ColorPickerFrame"
            ColorPickerFrame.Size = UDim2.new(1, 0, 0, Config.ElementHeight)
            ColorPickerFrame.BackgroundColor3 = Config.BackgroundColor
            ColorPickerFrame.BorderSizePixel = 0
            ColorPickerFrame.Parent = TabContent
            
            CreateCorner(ColorPickerFrame, 6)
            
            local ColorPickerLabel = Instance.new("TextLabel")
            ColorPickerLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ColorPickerLabel.Position = UDim2.new(0, 10, 0, 0)
            ColorPickerLabel.BackgroundTransparency = 1
            ColorPickerLabel.Text = config.Text or "Color Picker"
            ColorPickerLabel.TextColor3 = Config.TextColor
            ColorPickerLabel.TextSize = 14
            ColorPickerLabel.TextXAlignment = Enum.TextXAlignment.Left
            ColorPickerLabel.Font = Enum.Font.Gotham
            ColorPickerLabel.Parent = ColorPickerFrame
            
            local ColorDisplay = Instance.new("Frame")
            ColorDisplay.Size = UDim2.new(0, 25, 0, 25)
            ColorDisplay.Position = UDim2.new(1, -35, 0.5, -12.5)
            ColorDisplay.BackgroundColor3 = config.Default or Config.AccentColor
            ColorDisplay.BorderSizePixel = 0
            ColorDisplay.Parent = ColorPickerFrame
            
            CreateCorner(ColorDisplay, 4)
            CreateStroke(ColorDisplay, Config.BorderColor, 1)
            
            local currentColor = config.Default or Config.AccentColor
            
            ColorDisplay.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    -- Simple color randomizer for demo (in real implementation, you'd want a proper color picker)
                    currentColor = Color3.fromRGB(
                        math.random(0, 255),
                        math.random(0, 255),
                        math.random(0, 255)
                    )
                    
                    CreateTween(ColorDisplay, {BackgroundColor3 = currentColor}):Play()
                    
                    if config.Callback then
                        config.Callback(currentColor)
                    end
                end
            end)
            
            return {
                Set = function(color)
                    currentColor = color
                    CreateTween(ColorDisplay, {BackgroundColor3 = color}):Play()
                    if config.Callback then
                        config.Callback(color)
                    end
                end,
                Get = function()
                    return currentColor
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
    
    function Window:Destroy()
        ScreenGui:Destroy()
    end
    
    -- Intro Animation
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    CreateTween(MainFrame, {Size = Config.WindowSize}, 0.5):Play()
    
    return Window
end

return Library
