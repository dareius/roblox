--// FlowUI.lua
-- A minimal, dark-themed Roblox UI library styled like the provided screenshot.

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local FlowUI = {}
FlowUI.__index = FlowUI

-- Single style definition (colors, transparency, etc.)
local UIStyles = {
    Background = Color3.fromRGB(25, 25, 25),    -- Main background
    BackgroundTransparency = 0.05,             -- Slightly see-through
    Section = Color3.fromRGB(30, 30, 30),      -- For frames/sections
    Button = Color3.fromRGB(40, 40, 40),       -- For buttons, dropdown triggers
    Text = Color3.fromRGB(235, 235, 235),      -- Light text
    Accent = Color3.fromRGB(70, 70, 70),       -- For highlights (e.g. fill)
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
    errLabel.TextColor3 = Color3.fromRGB(255,255,255)
    errLabel.Font = Enum.Font.GothamBold
    errLabel.TextSize = 14
    errLabel.Parent = errFrame

    task.delay(3, function()
        errFrame:Destroy()
    end)
end

function FlowUI:CreateWindow(title)
    local self = setmetatable({}, FlowUI)
    self.Tabs = {}

    local gui = Instance.new("ScreenGui")
    gui.Name = "FlowUI"
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 600, 0, 300)
    main.Position = UDim2.new(0.5, -300, 0.5, -150)
    main.BackgroundColor3 = UIStyles.Background
    main.BackgroundTransparency = UIStyles.BackgroundTransparency
    main.Parent = gui
    main.Active = true
    main.Draggable = true
    createUICorner(8).Parent = main

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 40)
    topBar.BackgroundTransparency = 1
    topBar.Parent = main

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "Flow"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 20
    titleLabel.TextColor3 = UIStyles.Text
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.Parent = topBar

    local contentHolder = Instance.new("Frame")
    contentHolder.Size = UDim2.new(1, 0, 1, -40)
    contentHolder.Position = UDim2.new(0, 0, 0, 40)
    contentHolder.BackgroundColor3 = UIStyles.Background
    contentHolder.BackgroundTransparency = UIStyles.BackgroundTransparency
    contentHolder.Parent = main

    function self:CreateTab(tabName)
        local tab = {}
        tab.Sections = {}

        local tabFrame = Instance.new("ScrollingFrame")
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabFrame.ScrollBarThickness = 4
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.Parent = contentHolder

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 8)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tabFrame
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
        end)

        tab.Content = tabFrame

        -- For switching tabs, you can show/hide tabFrame externally
        -- or keep a simple single-tab UI if desired.
        self.Tabs[tabName] = tabFrame

        function tab:CreateSection(sectionName)
            local section = {}

            local sectionLabel = Instance.new("TextLabel")
            sectionLabel.Size = UDim2.new(1, -20, 0, 30)
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.Text = sectionName
            sectionLabel.Font = Enum.Font.GothamBold
            sectionLabel.TextSize = 16
            sectionLabel.TextColor3 = UIStyles.Text
            sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            sectionLabel.Position = UDim2.new(0, 10, 0, 0)
            sectionLabel.Parent = tabFrame

            function section:CreateDropdown(dropName, list, callback)
                local dropFrame = Instance.new("Frame")
                dropFrame.Size = UDim2.new(1, -20, 0, 30)
                dropFrame.BackgroundColor3 = UIStyles.Button
                dropFrame.BackgroundTransparency = 0
                dropFrame.Parent = tabFrame
                createUICorner(6).Parent = dropFrame

                local dropBtn = Instance.new("TextButton")
                dropBtn.Size = UDim2.new(1, -10, 1, 0)
                dropBtn.Position = UDim2.new(0, 5, 0, 0)
                dropBtn.BackgroundTransparency = 1
                dropBtn.Text = dropName
                dropBtn.Font = Enum.Font.Gotham
                dropBtn.TextSize = 14
                dropBtn.TextColor3 = UIStyles.Text
                dropBtn.TextXAlignment = Enum.TextXAlignment.Left
                dropBtn.Parent = dropFrame

                local open = false
                local items = {}

                local function closeDropdown()
                    open = false
                    for _, itm in ipairs(items) do
                        itm:Destroy()
                    end
                    items = {}
                end

                dropBtn.MouseButton1Click:Connect(function()
                    if open then
                        closeDropdown()
                    else
                        open = true
                        for i, opt in ipairs(list) do
                            local optBtn = Instance.new("TextButton")
                            optBtn.Size = UDim2.new(1, -20, 0, 30)
                            optBtn.BackgroundColor3 = UIStyles.Section
                            optBtn.Text = tostring(opt)
                            optBtn.Font = Enum.Font.Gotham
                            optBtn.TextSize = 13
                            optBtn.TextColor3 = UIStyles.Text
                            optBtn.Position = UDim2.new(0, 10, 0, 30 + (i * 32))
                            optBtn.Parent = dropFrame
                            createUICorner(6).Parent = optBtn

                            optBtn.MouseButton1Click:Connect(function()
                                dropBtn.Text = dropName .. ": " .. tostring(opt)
                                pcall(callback, opt)
                                closeDropdown()
                            end)
                            table.insert(items, optBtn)
                        end
                    end
                end)
            end

            return section
        end

        return tab
    end

    return self
end

return FlowUI
