--[[
    UILib v3 - Draggable, Resizable, Dark Theme
    By ChatGPT for user with enhanced visuals in mind
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local UILib = {}
local dragging, dragInput, dragStart, startPos
local windowAPI = {}

function UILib:CreateWindow(config)
    local config = config or {}
    local Title = config.Title or "Your Hub"
    local Size = config.Size or UDim2.new(0, 600, 0, 400)
    local Theme = config.Theme or "Dark"
    local CornerRadius = config.CornerRadius or 12

    local ScreenGui = Instance.new("ScreenGui", PlayerGui)
    ScreenGui.Name = "UILib_v3"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    local Main = Instance.new("Frame")
    Main.Name = "MainWindow"
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = Size
    Main.BackgroundColor3 = Theme == "Dark" and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(240, 240, 240)
    Main.BackgroundTransparency = 0.1
    Main.ClipsDescendants = true
    Main.Parent = ScreenGui

    local Corner = Instance.new("UICorner", Main)
    Corner.CornerRadius = UDim.new(0, CornerRadius)

    local Shadow = Instance.new("ImageLabel", Main)
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 60, 1, 60)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageTransparency = 0.55
    Shadow.BackgroundTransparency = 1

    local TitleBar = Instance.new("Frame", Main)
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Theme == "Dark" and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(220, 220, 220)
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, CornerRadius)

    local TitleLabel = Instance.new("TextLabel", TitleBar)
    TitleLabel.Text = Title
    TitleLabel.Size = UDim2.new(1, -40, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextColor3 = Theme == "Dark" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local CloseButton = Instance.new("TextButton", TitleBar)
    CloseButton.Text = "X"
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.BackgroundColor3 = Theme == "Dark" and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 100, 100)
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.Gotham
    CloseButton.TextSize = 18
    CloseButton.AutoButtonColor = false
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local Tabs = Instance.new("Frame", Main)
    Tabs.Position = UDim2.new(0, 0, 0, 45)
    Tabs.Size = UDim2.new(0, 140, 1, -45)
    Tabs.BackgroundColor3 = Theme == "Dark" and Color3.fromRGB(35, 35, 35) or Color3.fromRGB(240, 240, 240)
    Tabs.BackgroundTransparency = 0.05
    Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0, 8)

    local TabList = Instance.new("UIListLayout", Tabs)
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 6)

    local Content = Instance.new("Frame", Main)
    Content.Position = UDim2.new(0, 150, 0, 45)
    Content.Size = UDim2.new(1, -160, 1, -55)
    Content.BackgroundTransparency = 1

    local function switchTab(toFrame)
        for _, v in ipairs(Content:GetChildren()) do
            if v:IsA("Frame") then
                v.Visible = false
            end
        end
        toFrame.Visible = true
    end

    function windowAPI:CreateTab(name)
        local tabBtn = Instance.new("TextButton", Tabs)
        tabBtn.Text = name
        tabBtn.Size = UDim2.new(1, -10, 0, 30)
        tabBtn.Position = UDim2.new(0, 5, 0, 0)
        tabBtn.BackgroundColor3 = Theme == "Dark" and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(220, 220, 220)
        tabBtn.TextColor3 = Theme == "Dark" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.TextSize = 14
        tabBtn.BorderSizePixel = 0
        tabBtn.AutoButtonColor = false
        Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)

        local tabFrame = Instance.new("Frame", Content)
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false

        local tabList = Instance.new("UIListLayout", tabFrame)
        tabList.Padding = UDim.new(0, 6)
        tabList.SortOrder = Enum.SortOrder.LayoutOrder

        tabBtn.MouseButton1Click:Connect(function()
            switchTab(tabFrame)
        end)

        if #Content:GetChildren() == 1 then
            switchTab(tabFrame)
        end

        local tabAPI = {}

        function tabAPI:AddButton(text, callback)
            local button = Instance.new("TextButton", tabFrame)
            button.Text = text
            button.Size = UDim2.new(1, 0, 0, 30)
            button.BackgroundColor3 = Theme == "Dark" and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(240, 240, 240)
            button.TextColor3 = Theme == "Dark" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
            button.Font = Enum.Font.Gotham
            button.TextSize = 14
            button.AutoButtonColor = true
            Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

            button.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end

        return tabAPI
    end

    -- Opening animation
    Main.Position = UDim2.new(0.5, 0, 0.5, -400)
    Main.BackgroundTransparency = 1
    TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 0.1
    }):Play()

    -- Dragging
    makeDraggable(Main)

    return windowAPI
end

return UILib
