--// FlowUI.lua
-- FlowUI: A minimal, advanced Roblox UI library with a left-side tab bar
-- Designed with a dark, semi-transparent style similar to your image.

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local FlowUI = {}
FlowUI.__index = FlowUI

-- Single style settings with transparency values for a unified look.
local UIStyles = {
    Background = Color3.fromRGB(25, 25, 25),
    BackgroundTransparency = 0.2,
    Section = Color3.fromRGB(30, 30, 30),
    SectionTransparency = 0.15,
    Button = Color3.fromRGB(40, 40, 40),
    ButtonTransparency = 0.1,
    Tab = Color3.fromRGB(35, 35, 35),
    TabTransparency = 0.15,
    Text = Color3.fromRGB(235, 235, 235),
    Accent = Color3.fromRGB(70, 70, 70),
    AccentTransparency = 0,
    TopBarTransparency = 0,
}

local function createUICorner(radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    return corner
end

local function notifyError(errMsg)
    local errFrame = Instance.new("Frame")
    errFrame.Size = UDim2.new(0, 300, 0, 60)
    errFrame.Position = UDim2.new(0.5, -150, 0, 40)
    errFrame.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    errFrame.BackgroundTransparency = 0.1
    errFrame.Parent = PlayerGui
    createUICorner(8).Parent = errFrame

    local errLabel = Instance.new("TextLabel")
    errLabel.Size = UDim2.new(1, 0, 1, 0)
    errLabel.BackgroundTransparency = 1
    errLabel.Text = "Error: " .. errMsg
    errLabel.TextColor3 = Color3.new(1,1,1)
    errLabel.Font = Enum.Font.GothamBold
    errLabel.TextSize = 14
    errLabel.Parent = errFrame

    task.delay(3, function()
        errFrame:Destroy()
    end)
end

-- CreateWindow: Builds a draggable window with a top bar and a left-side tab bar.
function FlowUI:CreateWindow(title)
    local self = setmetatable({}, FlowUI)
    self.Tabs = {}

    local gui = Instance.new("ScreenGui")
    gui.Name = "FlowUI"
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 600, 0, 400)
    main.Position = UDim2.new(0.5, -300, 0.5, -200)
    main.BackgroundColor3 = UIStyles.Background
    main.BackgroundTransparency = UIStyles.BackgroundTransparency
    main.Parent = gui
    main.Active = true
    main.Draggable = true
    createUICorner(8).Parent = main

    -- Top Bar
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 40)
    topBar.BackgroundColor3 = UIStyles.Background
    topBar.BackgroundTransparency = UIStyles.TopBarTransparency
    topBar.Parent = main

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "FlowUI"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 22
    titleLabel.TextColor3 = UIStyles.Text
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.Parent = topBar

    -- Left-side Tab Bar
    local tabHolder = Instance.new("Frame")
    tabHolder.Size = UDim2.new(0, 140, 1, -40)
    tabHolder.Position = UDim2.new(0, 0, 0, 40)
    tabHolder.BackgroundColor3 = UIStyles.Tab
    tabHolder.BackgroundTransparency = UIStyles.TabTransparency
    tabHolder.Parent = main
    createUICorner(0).Parent = tabHolder

    -- Content Holder (for tab pages)
    local contentHolder = Instance.new("Frame")
    contentHolder.Size = UDim2.new(1, -140, 1, -40)
    contentHolder.Position = UDim2.new(0, 140, 0, 40)
    contentHolder.BackgroundColor3 = UIStyles.Background
    contentHolder.BackgroundTransparency = UIStyles.BackgroundTransparency
    contentHolder.Parent = main

    function self:CreateTab(tabName)
        local tab = {}
        tab.Sections = {}

        -- Tab Button on the left
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, 0, 0, 40)
        tabBtn.BackgroundColor3 = UIStyles.Button
        tabBtn.BackgroundTransparency = UIStyles.ButtonTransparency
        tabBtn.Text = tabName
        tabBtn.TextColor3 = UIStyles.Text
        tabBtn.Font = Enum.Font.GothamBold
        tabBtn.TextSize = 16
        tabBtn.Parent = tabHolder
        createUICorner(6).Parent = tabBtn

        -- Tab content as a scrolling frame
        local tabPage = Instance.new("ScrollingFrame")
        tabPage.Size = UDim2.new(1, 0, 1, 0)
        tabPage.BackgroundTransparency = 1
        tabPage.Visible = false
        tabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabPage.ScrollBarThickness = 6
        tabPage.Parent = contentHolder

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 8)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tabPage
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabPage.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
        end)

        tab.Content = tabPage

        tabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(self.Tabs) do
                t.Visible = false
            end
            tabPage.Visible = true
        end)

        function tab:CreateSection(sectionName)
            local section = {}

            local sectionHeader = Instance.new("TextLabel")
            sectionHeader.Size = UDim2.new(1, -20, 0, 30)
            sectionHeader.Position = UDim2.new(0, 10, 0, 0)
            sectionHeader.BackgroundTransparency = 1
            sectionHeader.Text = sectionName
            sectionHeader.Font = Enum.Font.GothamBold
            sectionHeader.TextSize = 16
            sectionHeader.TextColor3 = UIStyles.Text
            sectionHeader.TextXAlignment = Enum.TextXAlignment.Left
            sectionHeader.Parent = tabPage

            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -20, 0, 40)
            container.Position = UDim2.new(0, 10, 0, 30)
            container.BackgroundColor3 = UIStyles.Section
            container.BackgroundTransparency = UIStyles.SectionTransparency
            container.Parent = tabPage

            local containerLayout = Instance.new("UIListLayout")
            containerLayout.Padding = UDim.new(0, 6)
            containerLayout.SortOrder = Enum.SortOrder.LayoutOrder
            containerLayout.Parent = container
            containerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                container.Size = UDim2.new(1, -20, 0, containerLayout.AbsoluteContentSize.Y)
            end)

            -- Example UI elements (you can add more as needed)

            function section:CreateButton(text, callback)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 35)
                btn.BackgroundColor3 = UIStyles.Button
                btn.BackgroundTransparency = UIStyles.ButtonTransparency
                btn.Text = text
                btn.TextColor3 = UIStyles.Text
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 16
                btn.Parent = container
                createUICorner(6).Parent = btn
                btn.MouseButton1Click:Connect(function()
                    local s, e = pcall(callback)
                    if not s then notifyError("Button error: " .. tostring(e)) end
                end)
            end

            function section:CreateToggle(text, default, callback)
                local toggle = Instance.new("TextButton")
                toggle.Size = UDim2.new(1, 0, 0, 35)
                toggle.BackgroundColor3 = UIStyles.Button
                toggle.BackgroundTransparency = UIStyles.ButtonTransparency
                local state = default or false
                toggle.Text = text .. ": " .. (state and "ON" or "OFF")
                toggle.TextColor3 = UIStyles.Text
                toggle.Font = Enum.Font.Gotham
                toggle.TextSize = 16
                toggle.Parent = container
                createUICorner(6).Parent = toggle
                toggle.MouseButton1Click:Connect(function()
                    state = not state
                    toggle.Text = text .. ": " .. (state and "ON" or "OFF")
                    local s, e = pcall(function() callback(state) end)
                    if not s then notifyError("Toggle error: " .. tostring(e)) end
                end)
            end

            function section:CreateSlider(text, min, max, default, callback)
                local sliderLabel = Instance.new("TextLabel")
                sliderLabel.Size = UDim2.new(1, 0, 0, 20)
                sliderLabel.BackgroundTransparency = 1
                sliderLabel.Text = text .. ": " .. tostring(default)
                sliderLabel.TextColor3 = UIStyles.Text
                sliderLabel.Font = Enum.Font.Gotham
                sliderLabel.TextSize = 16
                sliderLabel.Parent = container

                local slider = Instance.new("Frame")
                slider.Size = UDim2.new(1, 0, 0, 20)
                slider.BackgroundColor3 = UIStyles.Button
                slider.BackgroundTransparency = UIStyles.ButtonTransparency
                slider.Parent = container
                createUICorner(6).Parent = slider

                local fill = Instance.new("Frame")
                fill.BackgroundColor3 = UIStyles.Accent
                fill.BackgroundTransparency = UIStyles.AccentTransparency
                local pct = math.clamp((default - min) / (max - min), 0, 1)
                fill.Size = UDim2.new(pct, 0, 1, 0)
                fill.Parent = slider

                local dragging = false
                slider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                slider.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local rel = math.clamp(input.Position.X - slider.AbsolutePosition.X, 0, slider.AbsoluteSize.X)
                        local newPct = rel / slider.AbsoluteSize.X
                        fill.Size = UDim2.new(newPct, 0, 1, 0)
                        local val = math.floor(min + (max - min) * newPct)
                        sliderLabel.Text = text .. ": " .. tostring(val)
                        local s, e = pcall(function() callback(val) end)
                        if not s then notifyError("Slider error: " .. tostring(e)) end
                    end
                end)
            end

            function section:CreateTextbox(labelText, placeholder, callback)
                local boxLabel = Instance.new("TextLabel")
                boxLabel.Size = UDim2.new(1, 0, 0, 20)
                boxLabel.BackgroundTransparency = 1
                boxLabel.Text = labelText
                boxLabel.TextColor3 = UIStyles.Text
                boxLabel.Font = Enum.Font.Gotham
                boxLabel.TextSize = 16
                boxLabel.Parent = container

                local textbox = Instance.new("TextBox")
                textbox.Size = UDim2.new(1, 0, 0, 60)
                textbox.BackgroundColor3 = UIStyles.Button
                textbox.BackgroundTransparency = UIStyles.ButtonTransparency
                textbox.PlaceholderText = placeholder
                textbox.TextColor3 = UIStyles.Text
                textbox.Font = Enum.Font.Gotham
                textbox.TextSize = 16
                textbox.MultiLine = true
                textbox.TextWrapped = true
                textbox.ClearTextOnFocus = false
                textbox.Parent = container
                createUICorner(6).Parent = textbox

                textbox.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        local s, e = pcall(function() callback(textbox.Text) end)
                        if not s then notifyError("Textbox error: " .. tostring(e)) end
                    end
                end)
            end

            function section:CreateColorPicker(labelText, defaultColor, callback)
                local pickerLabel = Instance.new("TextLabel")
                pickerLabel.Size = UDim2.new(1, 0, 0, 20)
                pickerLabel.BackgroundTransparency = 1
                pickerLabel.Text = labelText
                pickerLabel.TextColor3 = UIStyles.Text
                pickerLabel.Font = Enum.Font.Gotham
                pickerLabel.TextSize = 16
                pickerLabel.Parent = container

                local colorBtn = Instance.new("TextButton")
                colorBtn.Size = UDim2.new(1, 0, 0, 30)
                colorBtn.BackgroundColor3 = defaultColor
                colorBtn.BackgroundTransparency = 0
                colorBtn.Text = ""
                colorBtn.Parent = container
                createUICorner(6).Parent = colorBtn

                colorBtn.MouseButton1Click:Connect(function()
                    local palette = Instance.new("Frame")
                    palette.Size = UDim2.new(0, 200, 0, 80)
                    palette.Position = colorBtn.AbsolutePosition + Vector2.new(0, colorBtn.AbsoluteSize.Y)
                    palette.BackgroundColor3 = UIStyles.Section
                    palette.BackgroundTransparency = UIStyles.SectionTransparency
                    palette.Parent = PlayerGui
                    createUICorner(6).Parent = palette

                    local colors = {
                        Color3.fromRGB(255,0,0),
                        Color3.fromRGB(0,255,0),
                        Color3.fromRGB(0,0,255),
                        Color3.fromRGB(255,255,0),
                        Color3.fromRGB(255,0,255),
                        Color3.fromRGB(0,255,255),
                        Color3.fromRGB(255,255,255),
                        Color3.fromRGB(0,0,0)
                    }

                    local grid = Instance.new("UIGridLayout")
                    grid.CellSize = UDim2.new(0, 48, 0, 48)
                    grid.CellPadding = UDim2.new(0, 4, 0, 4)
                    grid.Parent = palette

                    for _, clr in ipairs(colors) do
                        local clrBtn = Instance.new("TextButton")
                        clrBtn.Size = UDim2.new(0, 48, 0, 48)
                        clrBtn.BackgroundColor3 = clr
                        clrBtn.Text = ""
                        clrBtn.Parent = palette
                        createUICorner(4).Parent = clrBtn
                        clrBtn.MouseButton1Click:Connect(function()
                            colorBtn.BackgroundColor3 = clr
                            local s, e = pcall(function() callback(clr) end)
                            if not s then notifyError("ColorPicker error: " .. tostring(e)) end
                            palette:Destroy()
                        end)
                    end
                    task.delay(5, function()
                        if palette and palette.Parent then palette:Destroy() end
                    end)
                end)
            end

            function section:CreateCheckbox(text, default, callback)
                local checkbox = Instance.new("TextButton")
                checkbox.Size = UDim2.new(1, 0, 0, 35)
                checkbox.BackgroundColor3 = UIStyles.Button
                checkbox.BackgroundTransparency = UIStyles.ButtonTransparency
                local state = default or false
                checkbox.Text = (state and "[X] " or "[ ] ") .. text
                checkbox.TextColor3 = UIStyles.Text
                checkbox.Font = Enum.Font.Gotham
                checkbox.TextSize = 16
                checkbox.Parent = container
                createUICorner(6).Parent = checkbox
                checkbox.MouseButton1Click:Connect(function()
                    state = not state
                    checkbox.Text = (state and "[X] " or "[ ] ") .. text
                    local s, e = pcall(function() callback(state) end)
                    if not s then notifyError("Checkbox error: " .. tostring(e)) end
                end)
            end

            function section:CreateProgressBar(text, default, callback)
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0, 20)
                label.BackgroundTransparency = 1
                label.Text = text .. ": " .. tostring(default) .. "%"
                label.TextColor3 = UIStyles.Text
                label.Font = Enum.Font.Gotham
                label.TextSize = 16
                label.Parent = container

                local bar = Instance.new("Frame")
                bar.Size = UDim2.new(1, 0, 0, 20)
                bar.BackgroundColor3 = UIStyles.Button
                bar.BackgroundTransparency = UIStyles.ButtonTransparency
                bar.Parent = container
                createUICorner(6).Parent = bar

                local fill = Instance.new("Frame")
                fill.BackgroundColor3 = UIStyles.Accent
                fill.BackgroundTransparency = UIStyles.AccentTransparency
                local pct = math.clamp(default / 100, 0, 1)
                fill.Size = UDim2.new(pct, 0, 1, 0)
                fill.Parent = bar

                function label:SetProgress(val)
                    local newPct = math.clamp(val / 100, 0, 1)
                    fill.Size = UDim2.new(newPct, 0, 1, 0)
                    label.Text = text .. ": " .. tostring(val) .. "%"
                    pcall(function() callback(val) end)
                end
            end

            function section:CreateLabel(text)
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, 0, 0, 20)
                lbl.BackgroundTransparency = 1
                lbl.Text = text
                lbl.TextColor3 = UIStyles.Text
                lbl.Font = Enum.Font.Gotham
                lbl.TextSize = 16
                lbl.Parent = container
            end

            return section
        end

        self.Tabs[tabName] = tabPage
        return tab
    end

    function self:CreateNotification(title, message, duration)
        local notif = Instance.new("Frame")
        notif.Size = UDim2.new(0, 300, 0, 80)
        notif.Position = UDim2.new(1, -310, 0, 50)
        notif.BackgroundColor3 = UIStyles.Button
        notif.BackgroundTransparency = UIStyles.ButtonTransparency
        notif.Parent = PlayerGui
        createUICorner(8).Parent = notif

        local tLabel = Instance.new("TextLabel")
        tLabel.Size = UDim2.new(1, 0, 0, 30)
        tLabel.BackgroundTransparency = 1
        tLabel.Text = title
        tLabel.TextColor3 = UIStyles.Text
        tLabel.Font = Enum.Font.GothamBold
        tLabel.TextSize = 18
        tLabel.Parent = notif

        local mLabel = Instance.new("TextLabel")
        mLabel.Size = UDim2.new(1, 0, 0, 40)
        mLabel.Position = UDim2.new(0, 0, 0, 30)
        mLabel.BackgroundTransparency = 1
        mLabel.Text = message
        mLabel.TextColor3 = UIStyles.Text
        mLabel.Font = Enum.Font.Gotham
        mLabel.TextSize = 16
        mLabel.Parent = notif

        TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, -310, 0, 100)}):Play()
        task.delay(duration, function()
            TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1,310,0,100)}):Play()
            task.wait(0.6)
            notif:Destroy()
        end)
    end

    return self
end

return FlowUI
