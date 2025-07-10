-- NeonUILib.lua

local NeonUILib = {}

--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

--// Theme
local Theme = {
    Background = Color3.fromRGB(10, 10, 10),
    WindowOutline = Color3.fromRGB(0, 255, 150),
    TitleColor = Color3.fromRGB(255, 255, 255),
    VersionColor = Color3.fromRGB(120, 120, 120),
    TabColor = Color3.fromRGB(20, 20, 20),
    SelectedTabColor = Color3.fromRGB(0, 255, 150),
    Font = Enum.Font.GothamSemibold,
    CornerRadius = UDim.new(0, 8),
    GlowTransparency = 0.6,
}

--// Drag Function
local function makeDraggable(dragHandle, object)
    local dragging, dragStart, startPos

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = object.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            object.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

--// Main Window Creator
function NeonUILib:CreateWindow(config)
    config = config or {}
    local titleText = config.Title or "Untitled"
    local versionText = config.Version
    local screenSize = workspace.CurrentCamera.ViewportSize

    -- Auto size
    local width = (config.Width == "auto" or not config.Width) and math.floor(screenSize.X * 0.6) or config.Width
    local height = (config.Height == "auto" or not config.Height) and math.floor(screenSize.Y * 0.6) or config.Height

    -- Gui
    local player = Players.LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "NeonUI_" .. titleText:gsub("%s+", "")
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.IgnoreGuiInset = true
    gui.Parent = (pcall(function() return game:GetService("CoreGui") end) and game.CoreGui) or player:WaitForChild("PlayerGui")

    -- Main Frame
    local main = Instance.new("Frame")
    main.Name = "MainFrame"
    main.Size = UDim2.new(0, width, 0, height)
    main.Position = UDim2.new(0.5, -width / 2, 0.5, -height / 2)
    main.BackgroundColor3 = Theme.Background
    main.BorderSizePixel = 0
    main.Parent = gui

    Instance.new("UICorner", main).CornerRadius = Theme.CornerRadius

    -- Glow
    local glow = Instance.new("ImageLabel", main)
    glow.Name = "Glow"
    glow.Size = UDim2.new(1, 60, 1, 60)
    glow.Position = UDim2.new(0, -30, 0, -30)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://4996891970"
    glow.ImageColor3 = Theme.WindowOutline
    glow.ImageTransparency = Theme.GlowTransparency
    glow.ZIndex = 0

    -- Title
    local title = Instance.new("TextLabel", main)
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

    -- Version (optional)
    if versionText then
        local version = Instance.new("TextLabel", main)
        version.Name = "Version"
        version.Size = UDim2.new(1, -20, 0, 18)
        version.Position = UDim2.new(0, 10, 0, 44)
        version.Text = tostring(versionText)
        version.TextColor3 = Theme.VersionColor
        version.Font = Theme.Font
        version.TextSize = 14
        version.BackgroundTransparency = 1
        version.TextXAlignment = Enum.TextXAlignment.Left
        version.ZIndex = 2
    end

    -- Tab bar
    local tabHolder = Instance.new("Frame", main)
    tabHolder.Name = "TabHolder"
    tabHolder.Size = UDim2.new(0, width, 0, 30)
    tabHolder.Position = UDim2.new(0, 0, 0, 70)
    tabHolder.BackgroundColor3 = Theme.Background
    tabHolder.BorderSizePixel = 0

    local tabLayout = Instance.new("UIListLayout", tabHolder)
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 6)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Content container
    local contentContainer = Instance.new("Frame", main)
    contentContainer.Name = "Content"
    contentContainer.BackgroundTransparency = 1
    contentContainer.Size = UDim2.new(1, -20, 1, -110)
    contentContainer.Position = UDim2.new(0, 10, 0, 105)

    -- Tabs API
    local tabs = {}
    local currentTab = nil

    local function createTab(name)
        local tabButton = Instance.new("TextButton", tabHolder)
        tabButton.Size = UDim2.new(0, 100, 1, 0)
        tabButton.Text = name
        tabButton.BackgroundColor3 = Theme.TabColor
        tabButton.TextColor3 = Theme.TitleColor
        tabButton.Font = Theme.Font
        tabButton.TextSize = 16
        tabButton.AutoButtonColor = false

        local corner = Instance.new("UICorner", tabButton)
        corner.CornerRadius = Theme.CornerRadius

        local tabFrame = Instance.new("Frame", contentContainer)
        tabFrame.Name = name .. "_Content"
        tabFrame.BackgroundTransparency = 1
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.Visible = false

        tabs[name] = {
            Button = tabButton,
            Frame = tabFrame
        }

        tabButton.MouseButton1Click:Connect(function()
            if currentTab then
                tabs[currentTab].Frame.Visible = false
                tabs[currentTab].Button.BackgroundColor3 = Theme.TabColor
            end
            tabFrame.Visible = true
            tabButton.BackgroundColor3 = Theme.SelectedTabColor
            currentTab = name
        end)

        -- Auto-select first tab
        if not currentTab then
            tabButton:Activate()
        end

        return tabFrame
    end

    -- Enable dragging
    makeDraggable(title, main)

    return {
        Gui = gui,
        Frame = main,
        CreateTab = createTab,
        Tabs = tabs,
        Theme = Theme
    }
end

return NeonUILib
