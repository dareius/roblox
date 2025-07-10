-- NeonUILib.lua

local NeonUILib = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

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

local function makeDraggable(dragHandle, frame)
    local dragging, dragStart, startPos

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function NeonUILib:CreateWindow(config)
    config = config or {}
    local screenSize = workspace.CurrentCamera.ViewportSize

    local titleText = config.Title or "Untitled"
    local versionText = config.Version

    local width = (config.Width == "auto" or not config.Width) and math.floor(screenSize.X * 0.6) or config.Width
    local height = (config.Height == "auto" or not config.Height) and math.floor(screenSize.Y * 0.6) or config.Height

    local player = Players.LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "NeonUI_" .. titleText:gsub("%s+", "")
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.Parent = game:GetService("CoreGui")

    local main = Instance.new("Frame", gui)
    main.Name = "MainFrame"
    main.Size = UDim2.new(0, width, 0, height)
    main.Position = UDim2.new(0.5, -width / 2, 0.5, -height / 2)
    main.BackgroundColor3 = Theme.Background
    main.BorderSizePixel = 0
    Instance.new("UICorner", main).CornerRadius = Theme.CornerRadius

    local glow = Instance.new("ImageLabel", main)
    glow.Size = UDim2.new(1, 60, 1, 60)
    glow.Position = UDim2.new(0, -30, 0, -30)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://4996891970"
    glow.ImageColor3 = Theme.WindowOutline
    glow.ImageTransparency = Theme.GlowTransparency
    glow.ZIndex = 0

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

    if versionText then
        local version = Instance.new("TextLabel", main)
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

    local tabHolder = Instance.new("Frame", main)
    tabHolder.Name = "TabHolder"
    tabHolder.Size = UDim2.new(1, -20, 0, 36)
    tabHolder.Position = UDim2.new(0, 10, 0, 70)
    tabHolder.BackgroundTransparency = 1

    local tabLayout = Instance.new("UIListLayout", tabHolder)
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 6)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local content = Instance.new("Frame", main)
    content.Name = "Content"
    content.Size = UDim2.new(1, -20, 1, -116)
    content.Position = UDim2.new(0, 10, 0, 110)
    content.BackgroundTransparency = 1

    makeDraggable(title, main)

    local tabs = {}
    local currentTab

    local function switchTab(name)
        for tabName, tabData in pairs(tabs) do
            tabData.Frame.Visible = false
            tabData.Button.BackgroundColor3 = Theme.TabColor
        end
        tabs[name].Frame.Visible = true
        tabs[name].Button.BackgroundColor3 = Theme.SelectedTabColor
        currentTab = name
    end

    local function createTab(name)
        local tabButton = Instance.new("TextButton", tabHolder)
        tabButton.Size = UDim2.new(0, 100, 1, 0)
        tabButton.Text = name
        tabButton.Name = name
        tabButton.BackgroundColor3 = Theme.TabColor
        tabButton.TextColor3 = Theme.TitleColor
        tabButton.Font = Theme.Font
        tabButton.TextSize = 16
        tabButton.AutoButtonColor = false
        Instance.new("UICorner", tabButton).CornerRadius = Theme.CornerRadius

        local tabFrame = Instance.new("Frame", content)
        tabFrame.Name = name .. "_Content"
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false

        tabButton.MouseButton1Click:Connect(function()
            switchTab(name)
        end)

        tabs[name] = {
            Button = tabButton,
            Frame = tabFrame,
            CreateLabel = function(_, text)
                local label = Instance.new("TextLabel", tabFrame)
                label.Size = UDim2.new(1, -20, 0, 30)
                label.Position = UDim2.new(0, 10, 0, #tabFrame:GetChildren() * 35)
                label.Text = text
                label.TextColor3 = Theme.TitleColor
                label.Font = Theme.Font
                label.TextSize = 16
                label.BackgroundTransparency = 1
                label.TextXAlignment = Enum.TextXAlignment.Left
                return label
            end,
        }

        -- Auto select first tab
        if not currentTab then
            switchTab(name)
        end

        return tabs[name]
    end

    return {
        Gui = gui,
        Frame = main,
        CreateTab = createTab,
        Tabs = tabs,
        Theme = Theme,
    }
end

return NeonUILib
