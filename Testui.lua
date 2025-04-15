-- MyUILib.lua
local TweenService = game:GetService("TweenService")

local Library = {}
Library.__index = Library

local Theme = {
    Background = Color3.fromRGB(30, 30, 30),
    Foreground = Color3.fromRGB(45, 45, 45),
    Text = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(70, 130, 180)
}

function Library:MakeDraggable(frame)
    local dragging, offset
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            offset = Vector2.new(input.Position.X - frame.AbsolutePosition.X, input.Position.Y - frame.AbsolutePosition.Y)
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            frame.Position = UDim2.new(0, input.Position.X - offset.X, 0, input.Position.Y - offset.Y)
        end
    end)
end

function Library:CreateWindow(config)
    local self = setmetatable({}, Library)

    local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = config.Title or "MyUILib"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 550, 0, 400)
    main.Position = UDim2.new(0.5, -275, 0.5, -200)
    main.BackgroundColor3 = Theme.Background
    main.BorderSizePixel = 0
    main.AnchorPoint = Vector2.new(0.5, 0.5)

    local uicorner = Instance.new("UICorner", main)
    uicorner.CornerRadius = UDim.new(0, 8)

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = config.Title or "Executor UI"
    title.TextColor3 = Theme.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24

    self.MainFrame = main
    self.Tabs = {}

    self:MakeDraggable(main)

    function self:CreateTab(name)
        local tab = {}
        local tabFrame = Instance.new("Frame", main)
        tabFrame.Name = name
        tabFrame.Size = UDim2.new(1, 0, 1, -40)
        tabFrame.Position = UDim2.new(0, 0, 0, 40)
        tabFrame.BackgroundTransparency = 1

        local layout = Instance.new("UIListLayout", tabFrame)
        layout.Padding = UDim.new(0, 6)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        function tab:CreateButton(data)
            local btn = Instance.new("TextButton", tabFrame)
            btn.Size = UDim2.new(1, -20, 0, 32)
            btn.Position = UDim2.new(0, 10, 0, 0)
            btn.BackgroundColor3 = Theme.Foreground
            btn.TextColor3 = Theme.Text
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 16
            btn.Text = data.Name or "Button"
            btn.AutoButtonColor = false

            local corner = Instance.new("UICorner", btn)
            corner.CornerRadius = UDim.new(0, 6)

            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Foreground}):Play()
            end)

            btn.MouseButton1Click:Connect(function()
                if data.Callback then data.Callback() end
            end)
        end

        tabFrame.Visible = true
        table.insert(self.Tabs, tab)
        return tab
    end

    return self
end

return Library
