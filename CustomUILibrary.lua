
local TweenService = game:GetService("TweenService") local UserInputService = game:GetService("UserInputService") local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Library = {} Library.__index = Library

local Themes = { ["Midnight"] = { Background = Color3.fromRGB(20, 20, 30), Accent = Color3.fromRGB(0, 120, 255), Text = Color3.fromRGB(255, 255, 255), Section = Color3.fromRGB(30, 30, 40), Button = Color3.fromRGB(40, 40, 50), }, ["Ocean"] = { Background = Color3.fromRGB(10, 25, 35), Accent = Color3.fromRGB(0, 180, 255), Text = Color3.fromRGB(235, 255, 255), Section = Color3.fromRGB(20, 40, 60), Button = Color3.fromRGB(30, 60, 90), }, ["Sunset"] = { Background = Color3.fromRGB(45, 20, 30), Accent = Color3.fromRGB(255, 120, 100), Text = Color3.fromRGB(255, 240, 230), Section = Color3.fromRGB(60, 30, 40), Button = Color3.fromRGB(80, 40, 50), }, ["Cyber"] = { Background = Color3.fromRGB(15, 15, 25), Accent = Color3.fromRGB(255, 0, 255), Text = Color3.fromRGB(200, 200, 255), Section = Color3.fromRGB(30, 30, 50), Button = Color3.fromRGB(50, 30, 70), } }

local CurrentTheme = Themes["Midnight"]

local function createUICorner(radius) local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, radius) return corner end

function Library:AddTheme(name, themeTable) Themes[name] = themeTable end

function Library:CreateWindow(config) local self = setmetatable({}, Library) self.Tabs = {}

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
            toggle.TextColor3 = CurrentTheme.Text
            toggle.Font = Enum.Font.Gotham
            toggle.TextSize = 14
            toggle.Parent = container
            createUICorner(6).Parent = toggle
            local toggled = default or false
            toggle.Text = text .. ": " .. (toggled and "ON" or "OFF")
            toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                toggle.Text = text .. ": " .. (toggled and "ON" or "OFF")
                callback(toggled)
            end)
        end

        function section:CreateSlider(text, min, max, default, callback)
            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Size = UDim2.new(1, -10, 0, 20)
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Text = text .. ": " .. tostring(default)
            sliderLabel.TextColor3 = CurrentTheme.Text
            sliderLabel.Font = Enum.Font.Gotham
            sliderLabel.TextSize = 14
            sliderLabel.Parent = container

            local slider = Instance.new("TextButton")
            slider.Size = UDim2.new(1, -10, 0, 20)
            slider.BackgroundColor3 = CurrentTheme.Button
            slider.Text = ""
            slider.Parent = container
            createUICorner(6).Parent = slider

            local fill = Instance.new("Frame")
            fill.BackgroundColor3 = CurrentTheme.Accent
            fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
            fill.Parent = slider

            local dragging = false
            slider.InputBegan:Connect(function(input)
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
                    local rel = input.Position.X - slider.AbsolutePosition.X
                    local pct = math.clamp(rel / slider.AbsoluteSize.X, 0, 1)
                    fill.Size = UDim2.new(pct, 0, 1, 0)
                    local val = math.floor(min + (max - min) * pct)
                    sliderLabel.Text = text .. ": " .. val
                    callback(val)
                end
            end)
        end

        function section:CreateDropdown(title, list, callback)
            local drop = Instance.new("TextButton")
            drop.Size = UDim2.new(1, -10, 0, 30)
            drop.BackgroundColor3 = CurrentTheme.Button
            drop.Text = title
            drop.TextColor3 = CurrentTheme.Text
            drop.Font = Enum.Font.Gotham
            drop.TextSize = 14
            drop.Parent = container
            createUICorner(6).Parent = drop

            local open = false
            drop.MouseButton1Click:Connect(function()
                open = not open
                for _, item in ipairs(list) do
                    local opt = Instance.new("TextButton")
                    opt.Size = UDim2.new(1, -10, 0, 30)
                    opt.BackgroundColor3 = CurrentTheme.Section
                    opt.Text = tostring(item)
                    opt.TextColor3 = CurrentTheme.Text
                    opt.Font = Enum.Font.Gotham
                    opt.TextSize = 13
                    opt.Parent = container
                    createUICorner(6).Parent = opt
                    opt.MouseButton1Click:Connect(function()
                        drop.Text = title .. ": " .. tostring(item)
                        callback(item)
                        open = false
                        for _, child in ipairs(container:GetChildren()) do
                            if child:IsA("TextButton") and child ~= drop then
                                child:Destroy()
                            end
                        end
                    end)
                end
            end)
        end

        table.insert(tab.Sections, section)
        return section
    end

    table.insert(self.Tabs, tab)
    return tab
end

return self

end

return Library

