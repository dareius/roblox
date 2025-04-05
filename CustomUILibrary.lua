--// CustomUILibrary.lua
-- Rayfield-Style Premium UI Library for Roblox
-- Author: voided4356 on discord 

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Library = {}
Library.__index = Library

local Themes = {
    ["Midnight"] = {
        Background = Color3.fromRGB(20, 20, 30),
        Accent = Color3.fromRGB(0, 120, 255),
        Text = Color3.fromRGB(255, 255, 255),
        Section = Color3.fromRGB(30, 30, 40),
        Button = Color3.fromRGB(40, 40, 50),
    },
    
}

local CurrentTheme = Themes["Midnight"]

local function createUICorner(radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    return corner
end

function Library:AddTheme(name, themeTable)
    Themes[name] = themeTable
end

function Library:CreateWindow(config)
    local self = setmetatable({}, Library)
    self.Tabs = {}

    CurrentTheme = Themes[config.Theme] or Themes["Midnight"]

    local gui = Instance.new("ScreenGui")
    gui.Name = "CustomUILibrary"
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 500, 0, 320)
    main.Position = UDim2.new(0.5, -250, 0.5, -160)
    main.BackgroundColor3 = CurrentTheme.Background
    main.BorderSizePixel = 0
    main.Parent = gui
    main.Active = true
    main.Draggable = true
    createUICorner(12).Parent = main

    local title = Instance.new("TextLabel")
    title.Text = config.Title or "Custom UI"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = CurrentTheme.Text
    title.Parent = main

    local tabHolder = Instance.new("Frame")
    tabHolder.Size = UDim2.new(0, 120, 1, -40)
    tabHolder.Position = UDim2.new(0, 0, 0, 40)
    tabHolder.BackgroundColor3 = CurrentTheme.Section
    tabHolder.BorderSizePixel = 0
    tabHolder.Parent = main
    createUICorner(0).Parent = tabHolder

    local contentHolder = Instance.new("Frame")
    contentHolder.Size = UDim2.new(1, -120, 1, -40)
    contentHolder.Position = UDim2.new(0, 120, 0, 40)
    contentHolder.BackgroundColor3 = CurrentTheme.Background
    contentHolder.BorderSizePixel = 0
    contentHolder.Parent = main

    function self:CreateTab(name)
        local tab = {}
        tab.Sections = {}

        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, 0, 0, 30)
        tabBtn.BackgroundColor3 = CurrentTheme.Button
        tabBtn.Text = name
        tabBtn.TextColor3 = CurrentTheme.Text
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.TextSize = 14
        tabBtn.Parent = tabHolder
        createUICorner(6).Parent = tabBtn

        local tabPage = Instance.new("Frame")
        tabPage.Size = UDim2.new(1, 0, 1, 0)
        tabPage.BackgroundTransparency = 1
        tabPage.Visible = false
        tabPage.Parent = contentHolder

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 8)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tabPage

        tab.Content = tabPage

        tabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(self.Tabs) do
                t.Content.Visible = false
            end
            tabPage.Visible = true
        end)

        function tab:CreateSection(titleText)
            local section = {}

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -10, 0, 30)
            container.BackgroundColor3 = CurrentTheme.Section
            container.Parent = tabPage
            createUICorner(8).Parent = container

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -10, 1, 0)
            label.Position = UDim2.new(0, 5, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = titleText
            label.Font = Enum.Font.GothamBold
            label.TextColor3 = CurrentTheme.Text
            label.TextSize = 16
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = container

            local sectionLayout = Instance.new("UIListLayout")
            sectionLayout.Padding = UDim.new(0, 6)
            sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            sectionLayout.Parent = container

            function section:CreateButton(text, callback)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -10, 0, 30)
                btn.BackgroundColor3 = CurrentTheme.Button
                btn.Text = text
                btn.TextColor3 = CurrentTheme.Text
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 14
                btn.Parent = container
                createUICorner(6).Parent = btn
                btn.MouseButton1Click:Connect(callback)
            end

            function section:CreateToggle(text, default, callback)
                local toggle = Instance.new("TextButton")
                toggle.Size = UDim2.new(1, -10, 0, 30)
                toggle.BackgroundColor3 = CurrentTheme.Button
                toggle.Text = text .. ": OFF"
                toggle.TextColor30
