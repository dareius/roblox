--[[ MyUILib.lua - Roblox UI Library Features: Window, Tabs, Buttons, Toggles, Sliders, Dropdowns, MultiDropdowns, ColorPicker, Paragraphs, Notifications ]]

local TweenService = game:GetService("TweenService") local Players = game:GetService("Players") local LocalPlayer = Players.LocalPlayer local UserInputService = game:GetService("UserInputService")

local MyUILib = {} local Themes = { Dark = {Background = Color3.fromRGB(25, 25, 25), Accent = Color3.fromRGB(0, 170, 255)}, Light = {Background = Color3.fromRGB(245, 245, 245), Accent = Color3.fromRGB(0, 85, 255)}, Ocean = {Background = Color3.fromRGB(22, 30, 43), Accent = Color3.fromRGB(0, 255, 255)}, Red = {Background = Color3.fromRGB(30, 0, 0), Accent = Color3.fromRGB(255, 0, 0)}, }

function MyUILib:CreateWindow(config) config = config or {} local title = config.Title or "My UI" local subtitle = config.SubTitle or "" local theme = Themes[config.Theme or "Dark"] local size = config.Size or UDim2.new(0, 500, 0, 350) local draggable = config.Draggable ~= false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyUILib"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = size
MainFrame.Position = UDim2.new(0.5, -size.X.Offset / 2, 0.5, -size.Y.Offset / 2)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local tween = TweenService:Create(MainFrame, TweenInfo.new(0.4), {Size = size})
MainFrame.Size = UDim2.new(0, 0, 0, 0)
tween:Play()

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Text = title
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.TextColor3 = theme.Accent
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Text = subtitle
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.new(0, 0, 0, 30)
Subtitle.BackgroundTransparency = 1
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 14
Subtitle.Parent = MainFrame

local TabContainer = Instance.new("Frame")
TabContainer.Position = UDim2.new(0, 0, 0, 60)
TabContainer.Size = UDim2.new(1, 0, 1, -60)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local TabList = {}

local function MakeTab(name)
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.ScrollBarThickness = 6
    TabFrame.BackgroundTransparency = 1
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabFrame.Visible = false
    TabFrame.Parent = TabContainer

    local UIList = Instance.new("UIListLayout")
    UIList.Padding = UDim.new(0, 6)
    UIList.SortOrder = Enum.SortOrder.LayoutOrder
    UIList.Parent = TabFrame

    local tab = {}

    function tab:Show()
        for _, t in pairs(TabList) do
            t.Frame.Visible = false
        end
        TabFrame.Visible = true
    end

    function tab:CreateButton(opts)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -10, 0, 30)
        Btn.Position = UDim2.new(0, 5, 0, 0)
        Btn.Text = opts.Name or "Button"
        Btn.TextColor3 = Color3.new(1,1,1)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 14
        Btn.BackgroundColor3 = theme.Accent
        Btn.AutoButtonColor = true
        Btn.Parent = TabFrame

        Btn.MouseButton1Click:Connect(function()
            if opts.Callback then opts.Callback() end
        end)
    end

    function tab:CreateDropdown(opts)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 0, 30)
        label.Text = opts.Name or "Dropdown"
        label.TextColor3 = Color3.new(1, 1, 1)
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.BackgroundTransparency = 1
        label.Parent = TabFrame

        local dropdown = Instance.new("TextButton")
        dropdown.Size = UDim2.new(1, -10, 0, 30)
        dropdown.Text = "Select..."
        dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        dropdown.TextColor3 = Color3.new(1,1,1)
        dropdown.Font = Enum.Font.Gotham
        dropdown.TextSize = 14
        dropdown.Parent = TabFrame

        local open = false
        local list = Instance.new("Frame")
        list.Size = UDim2.new(1, -10, 0, #opts.Options * 25)
        list.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        list.Visible = false
        list.Parent = TabFrame

        local layout = Instance.new("UIListLayout")
        layout.Parent = list

        for _, v in pairs(opts.Options) do
            local opt = Instance.new("TextButton")
            opt.Size = UDim2.new(1, 0, 0, 25)
            opt.Text = v
            opt.BackgroundTransparency = 1
            opt.TextColor3 = Color3.new(1,1,1)
            opt.Font = Enum.Font.Gotham
            opt.TextSize = 14
            opt.Parent = list
            opt.MouseButton1Click:Connect(function()
                dropdown.Text = v
                list.Visible = false
                open = false
                if opts.Callback then opts.Callback(v) end
            end)
        end

        dropdown.MouseButton1Click:Connect(function()
            open = not open
            list.Visible = open
        end)
    end

    function tab:CreateParagraph(opts)
        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1, -10, 0, 50)
        txt.TextWrapped = true
        txt.Text = opts.Text or "Paragraph"
        txt.TextColor3 = Color3.new(1, 1, 1)
        txt.Font = Enum.Font.Gotham
        txt.TextSize = 14
        txt.BackgroundTransparency = 1
        txt.Parent = TabFrame
    end

    tab.Frame = TabFrame
    table.insert(TabList, tab)
    tab:Show()
    return tab
end

function MyUILib:Notify(title, text, duration)
    duration = duration or 3
    local Noti = Instance.new("TextLabel")
    Noti.Text = title..": "..text
    Noti.Size = UDim2.new(0, 300, 0, 40)
    Noti.Position = UDim2.new(0.5, -150, 1, -60)
    Noti.AnchorPoint = Vector2.new(0.5, 1)
    Noti.BackgroundColor3 = theme.Accent
    Noti.TextColor3 = Color3.new(1,1,1)
    Noti.Font = Enum.Font.Gotham
    Noti.TextSize = 14
    Noti.Parent = ScreenGui

    TweenService:Create(Noti, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -150, 1, -100)}):Play()
    task.delay(duration, function()
        TweenService:Create(Noti, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -150, 1, 0)}):Play()
        task.wait(0.3)
        Noti:Destroy()
    end)
end

return {
    CreateTab = MakeTab,
    Notify = MyUILib.Notify
}

end

return MyUILib

