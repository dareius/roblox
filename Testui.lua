-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService") -- Useful for dragging updates

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Library Table
local UILib = {}

-- Configuration & Themes
local Themes = {
	Dark = {
		WindowBackground = Color3.fromRGB(40, 40, 40),
		WindowTransparency = 0.1,
		TitleBarBackground = Color3.fromRGB(50, 50, 50),
		TitleTextColor = Color3.fromRGB(255, 255, 255),
		CloseButtonBackground = Color3.fromRGB(255, 0, 0),
		CloseButtonHover = Color3.fromRGB(200, 0, 0),
		CloseButtonText = Color3.fromRGB(255, 255, 255),
		TabsBackground = Color3.fromRGB(35, 35, 35),
		TabsTransparency = 0.05,
		TabButtonBackground = Color3.fromRGB(50, 50, 50),
		TabButtonHover = Color3.fromRGB(65, 65, 65),
		TabButtonActive = Color3.fromRGB(70, 70, 70),
		TabButtonText = Color3.fromRGB(255, 255, 255),
		ElementBackground = Color3.fromRGB(50, 50, 50),
		ElementHover = Color3.fromRGB(65, 65, 65),
		ElementText = Color3.fromRGB(255, 255, 255),
		ContentBackgroundTransparency = 1,
		ScrollbarColor = Color3.fromRGB(80, 80, 80),
		ToggleOn = Color3.fromRGB(0, 170, 0),
		ToggleOff = Color3.fromRGB(80, 80, 80),
		SliderFill = Color3.fromRGB(0, 120, 255),
		SliderHandle = Color3.fromRGB(255, 255, 255),
		InputBackground = Color3.fromRGB(60, 60, 60),
		InputText = Color3.fromRGB(255, 255, 255),
		PlaceholderText = Color3.fromRGB(150, 150, 150),
		DropdownBackground = Color3.fromRGB(50, 50, 50),
		DropdownHover = Color3.fromRGB(65, 65, 65),
		DropdownText = Color3.fromRGB(255, 255, 255),
		DropdownBorder = Color3.fromRGB(80, 80, 80),
	},
	Light = {
		WindowBackground = Color3.fromRGB(240, 240, 240),
		WindowTransparency = 0.1,
		TitleBarBackground = Color3.fromRGB(220, 220, 220),
		TitleTextColor = Color3.fromRGB(0, 0, 0),
		CloseButtonBackground = Color3.fromRGB(255, 100, 100),
		CloseButtonHover = Color3.fromRGB(200, 80, 80),
		CloseButtonText = Color3.fromRGB(255, 255, 255),
		TabsBackground = Color3.fromRGB(240, 240, 240),
		TabsTransparency = 0.05,
		TabButtonBackground = Color3.fromRGB(220, 220, 220),
		TabButtonHover = Color3.fromRGB(200, 200, 200),
		TabButtonActive = Color3.fromRGB(190, 190, 190),
		TabButtonText = Color3.fromRGB(0, 0, 0),
		ElementBackground = Color3.fromRGB(220, 220, 220),
		ElementHover = Color3.fromRGB(200, 200, 200),
		ElementText = Color3.fromRGB(0, 0, 0),
		ContentBackgroundTransparency = 1,
		ScrollbarColor = Color3.fromRGB(180, 180, 180),
		ToggleOn = Color3.fromRGB(0, 170, 0),
		ToggleOff = Color3.fromRGB(180, 180, 180),
		SliderFill = Color3.fromRGB(0, 120, 255),
		SliderHandle = Color3.fromRGB(0, 0, 0),
		InputBackground = Color3.fromRGB(230, 230, 230),
		InputText = Color3.fromRGB(0, 0, 0),
		PlaceholderText = Color3.fromRGB(100, 100, 100),
		DropdownBackground = Color3.fromRGB(220, 220, 220),
		DropdownHover = Color3.fromRGB(200, 200, 200),
		DropdownText = Color3.fromRGB(0, 0, 0),
		DropdownBorder = Color3.fromRGB(150, 150, 150),
	}
}

-- Utility: Draggable Function
local function makeDraggable(guiObject, dragHandle)
    local dragging, dragInput, dragStart, startPos
    local handle = dragHandle or guiObject

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                local delta = input.Position - dragStart
                local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                guiObject.Position = newPosition
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if input == dragInput then
                 dragging = false
            end
        end
    end)
end

-- Hover Effect Utility
local function addHoverEffect(guiObject, normalColor, hoverColor)
	local conn1, conn2, conn3

	local function onHover()
		TweenService:Create(guiObject, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundColor3 = hoverColor }):Play()
	end

	local function onLeave()
		TweenService:Create(guiObject, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundColor3 = normalColor }):Play()
	end

	conn1 = guiObject.MouseEnter:Connect(onHover)
	conn2 = guiObject.MouseLeave:Connect(onLeave)

	-- Handle cases where the mouse leaves the game window
	conn3 = UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and not guiObject:IsMouseOver() then
			onLeave()
		end
	end)

	-- Clean up connections when the object is destroyed
	guiObject.AncestryChanged:Connect(function()
		if not guiObject.Parent then
			conn1:Disconnect()
			conn2:Disconnect()
			conn3:Disconnect()
		end
	end)
end

-- Main Window Creation Function
function UILib:CreateWindow(config)
    local config = config or {}
    local Title = config.Title or "Your Hub"
    local Size = config.Size or UDim2.new(0, 600, 0, 400)
    local ThemeName = config.Theme or "Dark"
    local CornerRadius = config.CornerRadius or 12
    local InitialPosition = config.Position -- New: Optional initial position
    local MinSize = config.MinSize or Vector2.new(200, 150) -- New: Minimum window size

    local Theme = Themes[ThemeName] or Themes.Dark -- Default to Dark if theme name is invalid

    local ScreenGui = Instance.new("ScreenGui", PlayerGui)
    ScreenGui.Name = "UILib_Window_" .. Title:gsub("[^%w%s]", ""):gsub("%s+", "_") -- More robust naming
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false -- Keep the GUI when character respawns

    local Main = Instance.new("Frame")
    Main.Name = "MainWindow"
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Position = InitialPosition or UDim2.new(0.5, 0, 0.5, 0) -- Use initial position if provided
    Main.Size = Size
    Main.BackgroundColor3 = Theme.WindowBackground
    Main.BackgroundTransparency = Theme.WindowTransparency
    Main.ClipsDescendants = true
    Main.BorderSizePixel = 0 -- Remove default border
    Main.Parent = ScreenGui

	-- Add a UIAspectRatioConstraint or minimum size handling if needed for resizing

    local Corner = Instance.new("UICorner", Main)
    Corner.CornerRadius = UDim.new(0, CornerRadius)

    -- Inner stroke/border for definition
    local InnerStroke = Instance.new("Frame", Main)
    InnerStroke.Size = UDim2.new(1, -2, 1, -2)
    InnerStroke.Position = UDim2.new(0, 1, 0, 1)
    InnerStroke.BackgroundTransparency = 0.9 -- Subtle
    InnerStroke.BackgroundColor3 = Color3.new(1, 1, 1) -- Or Theme based
    InnerStroke.BorderSizePixel = 0
     Instance.new("UICorner", InnerStroke).CornerRadius = UDim.new(0, CornerRadius - 1 > 0 and CornerRadius - 1 or 0)


    -- Optional: Add a simple drop shadow Frame behind Main if the ImageLabel isn't preferred
    -- local ShadowFrame = Instance.new("Frame")
    -- ShadowFrame.Size = Size + UDim2.new(0, 20, 0, 20) -- Adjust size for shadow
    -- ShadowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    -- ShadowFrame.Position = Main.Position
    -- ShadowFrame.BackgroundColor3 = Color3.new(0,0,0)
    -- ShadowFrame.BackgroundTransparency = 0.6
    -- ShadowFrame.ZIndex = Main.ZIndex - 1
    -- Instance.new("UICorner", ShadowFrame).CornerRadius = UDim.new(0, CornerRadius + 10)
    -- ShadowFrame.Parent = ScreenGui -- Parent to ScreenGui to be behind Main

	-- Let's stick with the ImageLabel for now but adjust its properties
	local Shadow = Instance.new("ImageLabel", Main)
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 100, 1, 100) -- Slightly larger for better shadow spread
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://1316045217" -- Standard shadow image
    Shadow.ImageColor3 = Color3.new(0,0,0) -- Make the shadow black
    Shadow.ImageTransparency = 0.55
    Shadow.BackgroundTransparency = 1
	Shadow.ScaleType = Enum.ScaleType.Slice -- Slice for better scaling
	Shadow.SliceCenter = Rect.new(10, 10, 118, 118) -- Adjust slice center based on image

    local TitleBar = Instance.new("Frame", Main)
	TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 35) -- Slightly taller title bar
	TitleBar.Position = UDim2.new(0, 0, 0, -CornerRadius) -- Position slightly higher to account for corner radius
    TitleBar.BackgroundColor3 = Theme.TitleBarBackground
	TitleBar.BorderSizePixel = 0
    -- Using a separate corner instance for the top corners only
	local TitleBarCorner = Instance.new("UICorner", TitleBar)
	TitleBarCorner.CornerRadius = UDim.new(0, CornerRadius) -- This makes all corners round, need to mask or use a separate frame

	-- Alternative: Create a frame just for the top part of the title bar
	local TopBarVisual = Instance.new("Frame", TitleBar)
	TopBarVisual.Size = UDim2.new(1, 0, 1, CornerRadius)
	TopBarVisual.Position = UDim2.new(0, 0, 0, 0)
	TopBarVisual.BackgroundColor3 = Theme.TitleBarBackground
	TopBarVisual.BorderSizePixel = 0
	Instance.new("UICorner", TopBarVisual).CornerRadius = UDim.new(0, CornerRadius) -- Only this frame gets top corners
	TitleBar.ClipsDescendants = true -- Clip the lower part


    local TitleLabel = Instance.new("TextLabel", TitleBar)
	TitleLabel.Name = "TitleLabel"
    TitleLabel.Text = Title
    TitleLabel.Size = UDim2.new(1, -80, 1, 0) -- Give more space for close button
    TitleLabel.Position = UDim2.new(0, 15, 0, 0) -- Indent text
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextColor3 = Theme.TitleTextColor
    TitleLabel.TextSize = 20 -- Slightly larger title text
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.TextYAlignment = Enum.TextYAlignment.Center

    local CloseButton = Instance.new("TextButton", TitleBar)
	CloseButton.Name = "CloseButton"
    CloseButton.Text = "X"
    CloseButton.Size = UDim2.new(0, 30, 0, 30) -- Fixed size button
    CloseButton.Position = UDim2.new(1, -40, 0.5, -15) -- Position from the right, centered vertically
    CloseButton.BackgroundColor3 = Theme.CloseButtonBackground
    CloseButton.TextColor3 = Theme.CloseButtonText
    CloseButton.Font = Enum.Font.Gotham
    CloseButton.TextSize = 18
    CloseButton.AutoButtonColor = false -- Disable default hover
	CloseButton.BorderSizePixel = 0
	Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6) -- Small corner radius for the button

	-- Add hover effect to Close Button
	addHoverEffect(CloseButton, Theme.CloseButtonBackground, Theme.CloseButtonHover)

    CloseButton.MouseButton1Click:Connect(function()
        -- Closing animation
		TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = Main.Position + UDim2.new(0, 0, 0, 50), -- Move down slightly while fading
			BackgroundTransparency = 1,
			Size = Main.Size * 0.95 -- Shrink slightly
		}):Play()
		TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = Main.Size * 0.95 -- Shrink slightly
		}):Play()
		Shadow:TweenTransparency(1, "Out", "Quad", 0.3, true)

		-- Destroy after animation
		delay(0.3, function()
			ScreenGui:Destroy()
		end)
    end)

    local Tabs = Instance.new("Frame", Main)
	Tabs.Name = "Tabs"
    Tabs.Position = UDim2.new(0, 10, 0, 45) -- Indent Tabs frame
    Tabs.Size = UDim2.new(0, 140, 1, -55) -- Slightly adjust size
    Tabs.BackgroundColor3 = Theme.TabsBackground
    Tabs.BackgroundTransparency = Theme.TabsTransparency
	Tabs.BorderSizePixel = 0
    Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0, 8)

    local TabList = Instance.new("UIListLayout", Tabs)
	TabList.Name = "TabListLayout"
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 8) -- Increase padding slightly
	TabList.FillDirection = Enum.FillDirection.Vertical
	TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabList.VerticalAlignment = Enum.VerticalAlignment.Top

    local Content = Instance.new("Frame", Main)
	Content.Name = "Content"
    Content.Position = UDim2.new(0, 160, 0, 45) -- Position Content next to Tabs
    Content.Size = UDim2.new(1, -170, 1, -55) -- Fill the remaining space
    Content.BackgroundTransparency = Theme.ContentBackgroundTransparency
	Content.BorderSizePixel = 0

	-- Add a ScrollingFrame for Content
	local ContentScroll = Instance.new("ScrollingFrame", Content)
	ContentScroll.Size = UDim2.new(1, 0, 1, 0)
	ContentScroll.BackgroundTransparency = 1
	ContentScroll.BorderSizePixel = 0
	ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be updated by UIListLayout/UIAutomaticSize
	ContentScroll.ScrollBarThickness = 6
	ContentScroll.ScrollBarColor3 = Theme.ScrollbarColor
	ContentScroll.ScrollingDirection = Enum.ScrollingDirection.Y

    local function switchTab(toFrame)
        -- Animate tab switching
        for _, v in ipairs(ContentScroll:GetChildren()) do
            if v:IsA("Frame") then
                if v == toFrame then
                    -- Fade in and set visible
                    TweenService:Create(v, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 1, ZIndex = 2 }):Play() -- Assuming background transparency is 1, adjust if not
                    v.Visible = true
                else
                    -- Fade out and hide
					-- Ensure other tabs are hidden quickly
					if v.Visible then
						TweenService:Create(v, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play() -- assuming bg transparency is 1
						v.Visible = false
					end
                end
            end
        end
    end

    local windowAPI = {} -- API returned to the user

    function windowAPI:CreateTab(name)
        local tabBtn = Instance.new("TextButton", Tabs)
		tabBtn.Name = "TabButton_" .. name:gsub("[^%w%s]", ""):gsub("%s+", "_")
        tabBtn.Text = name
        tabBtn.Size = UDim2.new(1, -20, 0, 35) -- Slightly larger tab buttons, indent from sides
        tabBtn.Position = UDim2.new(0, 10, 0, 0)
        tabBtn.BackgroundColor3 = Theme.TabButtonBackground
        tabBtn.TextColor3 = Theme.TabButtonText
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.TextSize = 15 -- Slightly larger text
        tabBtn.BorderSizePixel = 0
        tabBtn.AutoButtonColor = false
        Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)

        -- Add hover effect to Tab Button
		addHoverEffect(tabBtn, Theme.TabButtonBackground, Theme.TabButtonHover)

        local tabFrame = Instance.new("Frame", ContentScroll) -- Parent tab frame to ScrollingFrame
		tabFrame.Name = "TabContent_" .. name:gsub("[^%w%s]", ""):gsub("%s+", "_")
        tabFrame.Size = UDim2.new(1, 0, 0, 0) -- Size updated by UIListLayout and UIAutomaticSize
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false -- Initially hidden

		-- Use UIAutomaticSize to size the tabFrame based on its contents
		local autoSize = Instance.new("UIAutomaticSize", tabFrame)
		autoSize.AutomaticSize = Enum.AutomaticSize.Y -- Automatically size height based on children

        local tabList = Instance.new("UIListLayout", tabFrame)
		tabList.Name = "ContentListLayout"
        tabList.Padding = UDim.new(0, 8) -- Padding between elements
        tabList.SortOrder = Enum.SortOrder.LayoutOrder
		tabList.FillDirection = Enum.FillDirection.Vertical
		tabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
		tabList.VerticalAlignment = Enum.VerticalAlignment.Top
		Instance.new("UIPadding", tabFrame).Padding = UDim.new(0, 10, 0, 10) -- Add internal padding to the tab frame

        tabBtn.MouseButton1Click:Connect(function()
            switchTab(tabFrame)
			-- Add a visual indicator for the active tab button
			for _, btn in ipairs(Tabs:GetChildren()) do
				if btn:IsA("TextButton") then
					if btn == tabBtn then
						TweenService:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = Theme.TabButtonActive }):Play()
					else
						TweenService:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = Theme.TabButtonBackground }):Play()
					end
				end
			end
        end)

        -- Auto-select the first tab created
        if #ContentScroll:GetChildren() == 1 then
            switchTab(tabFrame)
			TweenService:Create(tabBtn, TweenInfo.new(0.2), { BackgroundColor3 = Theme.TabButtonActive }):Play()
        end

        local tabAPI = {} -- API for adding elements to this tab

        -- --- UI Elements ---

        -- Button
        function tabAPI:AddButton(text, callback)
            local button = Instance.new("TextButton", tabFrame)
			button.Name = "Button_" .. text:gsub("[^%w%s]", ""):gsub("%s+", "_")
            button.Text = text
            button.Size = UDim2.new(1, 0, 0, 30)
            button.BackgroundColor3 = Theme.ElementBackground
            button.TextColor3 = Theme.ElementText
            button.Font = Enum.Font.Gotham
            button.TextSize = 14
            button.AutoButtonColor = false -- Disable default hover
			button.BorderSizePixel = 0
            Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
			Instance.new("UIPadding", button).Padding = UDim.new(0, 5) -- Add padding inside button

			-- Add hover effect
			addHoverEffect(button, Theme.ElementBackground, Theme.ElementHover)

            button.MouseButton1Click:Connect(function()
                pcall(callback) -- Use pcall for safety
            end)
			return button -- Return the created element
        end

		-- Toggle/Checkbox
		function tabAPI:AddToggle(text, defaultState, callback)
			local frame = Instance.new("Frame", tabFrame)
			frame.Name = "Toggle_" .. text:gsub("[^%w%s]", ""):gsub("%s+", "_")
			frame.Size = UDim2.new(1, 0, 0, 30)
			frame.BackgroundTransparency = 1
			frame.BorderSizePixel = 0

			local layout = Instance.new("UIListLayout", frame)
			layout.FillDirection = Enum.FillDirection.Horizontal
			layout.VerticalAlignment = Enum.VerticalAlignment.Center
			layout.Padding = UDim.new(0, 8)

			local label = Instance.new("TextLabel", frame)
			label.Text = text
			label.Size = UDim2.new(1, -40, 1, 0) -- Takes most of the space
			label.BackgroundTransparency = 1
			label.TextColor3 = Theme.ElementText
			label.TextSize = 14
			label.Font = Enum.Font.Gotham
			label.TextXAlignment = Enum.TextXAlignment.Left

			local toggleButton = Instance.new("TextButton", frame)
			toggleButton.Size = UDim2.new(0, 20, 0, 20) -- Square toggle button
			toggleButton.BackgroundColor3 = defaultState and Theme.ToggleOn or Theme.ToggleOff
			toggleButton.BackgroundTransparency = 0
			toggleButton.Text = "" -- No text
			toggleButton.AutoButtonColor = false
			toggleButton.BorderSizePixel = 0
			Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 4) -- Slight corner radius

			local state = defaultState
			local function updateToggleVisual()
				local targetColor = state and Theme.ToggleOn or Theme.ToggleOff
				TweenService:Create(toggleButton, TweenInfo.new(0.15), { BackgroundColor3 = targetColor }):Play()
			end

			toggleButton.MouseButton1Click:Connect(function()
				state = not state
				updateToggleVisual()
				pcall(callback, state) -- Pass the new state to the callback
			end)

			-- Initial visual update
			updateToggleVisual()

			return frame -- Return the container frame
		end

		-- Slider
		function tabAPI:AddSlider(text, min, max, initial, callback)
			local frame = Instance.new("Frame", tabFrame)
			frame.Name = "Slider_" .. text:gsub("[^%w%s]", ""):gsub("%s+", "_")
			frame.Size = UDim2.new(1, 0, 0, 40) -- Taller frame for slider and label
			frame.BackgroundTransparency = 1
			frame.BorderSizePixel = 0

			local labelLayout = Instance.new("UIListLayout", frame)
			labelLayout.FillDirection = Enum.FillDirection.Vertical
			labelLayout.VerticalAlignment = Enum.Top
			labelLayout.Padding = UDim.new(0, 4)

			local label = Instance.new("TextLabel", frame)
			label.Text = text
			label.Size = UDim2.new(1, 0, 0, 15)
			label.BackgroundTransparency = 1
			label.TextColor3 = Theme.ElementText
			label.TextSize = 14
			label.Font = Enum.Font.Gotham
			label.TextXAlignment = Enum.TextXAlignment.Left

			local sliderFrame = Instance.new("Frame", frame)
			sliderFrame.Size = UDim2.new(1, 0, 0, 15) -- Frame containing the slider track and handle
			sliderFrame.BackgroundColor3 = Theme.ElementBackground -- Slider track background
			sliderFrame.BorderSizePixel = 0
			Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 7)

			local sliderFill = Instance.new("Frame", sliderFrame)
			sliderFill.Size = UDim2.new(0, 0, 1, 0) -- Fill size will be updated
			sliderFill.BackgroundColor3 = Theme.SliderFill -- Slider fill color
			sliderFill.BorderSizePixel = 0
			Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(0, 7)

			local sliderHandle = Instance.new("ImageLabel", sliderFrame) -- Use ImageLabel for potential custom handle image
			sliderHandle.Size = UDim2.new(0, 20, 0, 20) -- Handle size
			sliderHandle.Position = UDim2.new(0, -10, 0.5, -10) -- Position handle
			sliderHandle.Image = "" -- Optional handle image
			sliderHandle.BackgroundColor3 = Theme.SliderHandle
			sliderHandle.BackgroundTransparency = 0
			sliderHandle.ZIndex = 2 -- Make handle appear on top
			sliderHandle.Draggable = true -- Make the handle draggable
			Instance.new("UICorner", sliderHandle).CornerRadius = UDim.new(0, 10) -- Round handle

			local currentValue = initial or min
			local isDragging = false

			local function updateSliderVisual(value)
				local clampedValue = math.clamp(value, min, max)
				local ratio = (clampedValue - min) / (max - min)
				sliderFill.Size = UDim2.new(ratio, 0, 1, 0)
				sliderHandle.Position = UDim2.new(ratio, -sliderHandle.Size.X.Offset / 2, 0.5, -sliderHandle.Size.Y.Offset / 2)

				-- Update label text with current value (optional)
				label.Text = text .. ": " .. string.format("%.1f", clampedValue) -- Format to one decimal place
			end

			-- Implement dragging for the handle
			sliderHandle.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isDragging = true
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					local mousePos = UserInputService:GetMouseLocation()
					local relativePos = mousePos - sliderFrame.AbsolutePosition
					local percent = math.clamp(relativePos.X / sliderFrame.AbsoluteSize.X, 0, 1)
					currentValue = min + percent * (max - min)
					updateSliderVisual(currentValue)
					pcall(callback, currentValue) -- Call callback while dragging
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isDragging = false
				end
			end)

			-- Allow clicking on the track to jump
			sliderFrame.MouseButton1Click:Connect(function(x, y)
				local mousePos = UserInputService:GetMouseLocation()
				local relativePos = mousePos - sliderFrame.AbsolutePosition
				local percent = math.clamp(relativePos.X / sliderFrame.AbsoluteSize.X, 0, 1)
				currentValue = min + percent * (max - min)
				updateSliderVisual(currentValue)
				pcall(callback, currentValue)
			end)


			-- Initial visual update
			updateSliderVisual(currentValue)

			return frame -- Return the container frame
		end

		-- Textbox
		function tabAPI:AddTextbox(text, placeholder, defaultText, callback)
			local frame = Instance.new("Frame", tabFrame)
			frame.Name = "Textbox_" .. text:gsub("[^%w%s]", ""):gsub("%s+", "_")
			frame.Size = UDim2.new(1, 0, 0, 50) -- Taller frame for label and textbox
			frame.BackgroundTransparency = 1
			frame.BorderSizePixel = 0

			local layout = Instance.new("UIListLayout", frame)
			layout.FillDirection = Enum.FillDirection.Vertical
			layout.VerticalAlignment = Enum.Top
			layout.Padding = UDim.new(0, 4)

			local label = Instance.new("TextLabel", frame)
			label.Text = text
			label.Size = UDim2.new(1, 0, 0, 15)
			label.BackgroundTransparency = 1
			label.TextColor3 = Theme.ElementText
			label.TextSize = 14
			label.Font = Enum.Font.Gotham
			label.TextXAlignment = Enum.TextXAlignment.Left

			local textbox = Instance.new("TextBox", frame)
			textbox.Size = UDim2.new(1, 0, 0, 25) -- Textbox size
			textbox.PlaceholderText = placeholder or ""
			textbox.Text = defaultText or ""
			textbox.BackgroundColor3 = Theme.InputBackground
			textbox.TextColor3 = Theme.InputText
			textbox.PlaceholderColor3 = Theme.PlaceholderText
			textbox.Font = Enum.Font.Gotham
			textbox.TextSize = 14
			textbox.ClearTextOnFocus = false -- Don't clear text on focus
			textbox.BorderSizePixel = 0
			Instance.new("UICorner", textbox).CornerRadius = UDim.new(0, 6)
			Instance.new("UIPadding", textbox).Padding = UDim.new(0, 8) -- Internal padding

			-- Callback on text change or focus lost
			textbox.FocusLost:Connect(function(enterPressed)
				if enterPressed or not textbox.Focused then
					pcall(callback, textbox.Text, enterPressed)
				end
			end)

			return textbox -- Return the textbox itself
		end

		-- Label
		function tabAPI:AddLabel(text)
			local label = Instance.new("TextLabel", tabFrame)
			label.Name = "Label_" .. text:gsub("[^%w%s]", ""):gsub("%s+", "_")
			label.Text = text
			label.Size = UDim2.new(1, 0, 0, 20) -- Height might adjust with TextWrapped
			label.BackgroundTransparency = 1
			label.TextColor3 = Theme.ElementText
			label.TextSize = 16 -- Slightly larger for labels
			label.Font = Enum.Font.GothamBold -- Bolder for labels
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.TextWrapped = true -- Allow text to wrap
			label.AutomaticSize = Enum.AutomaticSize.Y -- Automatically size height based on content

			return label -- Return the label
		end

		-- Dropdown (Simplified)
		function tabAPI:AddDropdown(text, options, callback)
			local frame = Instance.new("Frame", tabFrame)
			frame.Name = "Dropdown_" .. text:gsub("[^%w%s]", ""):gsub("%s+", "_")
			frame.Size = UDim2.new(1, 0, 0, 30) -- Base size for the closed dropdown
			frame.BackgroundTransparency = 1
			frame.BorderSizePixel = 0

			local layout = Instance.new("UIListLayout", frame)
			layout.FillDirection = Enum.FillDirection.Vertical
			layout.VerticalAlignment = Enum.Top
			layout.Padding = UDim.new(0, 4)

			local label = Instance.new("TextLabel", frame)
			label.Text = text
			label.Size = UDim2.new(1, -30, 1, 0) -- Space for arrow
			label.BackgroundTransparency = 1
			label.TextColor3 = Theme.ElementText
			label.TextSize = 14
			label.Font = Enum.Font.Gotham
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.TextYAlignment = Enum.TextYAlignment.Center

			local toggleButton = Instance.new("TextButton", frame) -- The button that shows the selected option
			toggleButton.Size = UDim2.new(1, 0, 0, 30)
			toggleButton.BackgroundColor3 = Theme.DropdownBackground
			toggleButton.TextColor3 = Theme.DropdownText
			toggleButton.Font = Enum.Font.Gotham
			toggleButton.TextSize = 14
			toggleButton.TextXAlignment = Enum.TextXAlignment.Left
			toggleButton.TextYAlignment = Enum.TextYAlignment.Center
			toggleButton.AutoButtonColor = false
			toggleButton.BorderSizePixel = 1
			toggleButton.BorderColor3 = Theme.DropdownBorder
			Instance.new("UIPadding", toggleButton).Padding = UDim.new(0, 8)
			Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 6)

			-- Dropdown arrow indicator (using TextLabel for simplicity)
			local arrowLabel = Instance.new("TextLabel", toggleButton)
			arrowLabel.Size = UDim2.new(0, 20, 1, 0)
			arrowLabel.Position = UDim2.new(1, -25, 0, 0)
			arrowLabel.BackgroundTransparency = 1
			arrowLabel.TextColor3 = Theme.DropdownText
			arrowLabel.TextSize = 14
			arrowLabel.Font = Enum.Font.SourceSans -- Simple font for characters
			arrowLabel.Text = "▼" -- Down arrow character
			arrowLabel.TextXAlignment = Enum.TextXAlignment.Right
			arrowLabel.TextYAlignment = Enum.TextYAlignment.Center

			-- Dropdown options frame (initially hidden)
			local optionsFrame = Instance.new("Frame", frame)
			optionsFrame.Size = UDim2.new(1, 0, 0, 0) -- Size updated by UIListLayout and content
			optionsFrame.BackgroundTransparency = 0 -- Make background visible for the options list
			optionsFrame.BackgroundColor3 = Theme.DropdownBackground
			optionsFrame.BorderSizePixel = 1
			optionsFrame.BorderColor3 = Theme.DropdownBorder
			optionsFrame.Visible = false -- Initially hidden
			optionsFrame.ZIndex = 3 -- Ensure options appear above other elements
			Instance.new("UICorner", optionsFrame).CornerRadius = UDim.new(0, 6)
			local optionsPadding = Instance.new("UIPadding", optionsFrame)
			optionsPadding.Padding = UDim.new(0, 5)

			local optionsLayout = Instance.new("UIListLayout", optionsFrame)
			optionsLayout.FillDirection = Enum.FillDirection.Vertical
			optionsLayout.VerticalAlignment = Enum.Top
			optionsLayout.Padding = UDim.new(0, 2)
			local optionsAutoSize = Instance.new("UIAutomaticSize", optionsFrame)
			optionsAutoSize.AutomaticSize = Enum.AutomaticSize.Y

			local isDropdownOpen = false
			local selectedOption = options and options[1] or "None" -- Default to the first option

			local function setSelectedText(text)
				toggleButton.Text = text
				selectedOption = text
			end

			local function closeDropdown()
				if isDropdownOpen then
					TweenService:Create(optionsFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, 0) }):Play()
					delay(0.2, function()
						optionsFrame.Visible = false
						isDropdownOpen = false
					end)
					TweenService:Create(arrowLabel, TweenInfo.new(0.2), { Rotation = 0 }):Play() -- Rotate arrow back
				end
			end

			local function openDropdown()
				if not isDropdownOpen then
					optionsFrame.Visible = true
					TweenService:Create(optionsFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, optionsLayout.AbsoluteContentSize.Y + optionsPadding.Padding.Top.Offset + optionsPadding.Padding.Bottom.Offset) }):Play()
					isDropdownOpen = true
					TweenService:Create(arrowLabel, TweenInfo.new(0.2), { Rotation = 180 }):Play() -- Rotate arrow down
				end
			end

			-- Populate options
			if options then
				for _, optionText in ipairs(options) do
					local optionButton = Instance.new("TextButton", optionsFrame)
					optionButton.Size = UDim2.new(1, 0, 0, 25)
					optionButton.BackgroundColor3 = Theme.DropdownBackground
					optionButton.TextColor3 = Theme.DropdownText
					optionButton.Font = Enum.Font.Gotham
					optionButton.TextSize = 14
					optionButton.Text = optionText
					optionButton.AutoButtonColor = false
					optionButton.BorderSizePixel = 0
					optionButton.TextXAlignment = Enum.TextXAlignment.Left
					optionButton.TextYAlignment = Enum.TextYAlignment.Center
					Instance.new("UIPadding", optionButton).Padding = UDim.new(0, 5)

					-- Add hover effect to option buttons
					addHoverEffect(optionButton, Theme.DropdownBackground, Theme.DropdownHover)

					optionButton.MouseButton1Click:Connect(function()
						setSelectedText(optionText)
						closeDropdown()
						pcall(callback, optionText) -- Call callback with the selected option
					end)
				end
			end

			-- Toggle dropdown visibility
			toggleButton.MouseButton1Click:Connect(function()
				if isDropdownOpen then
					closeDropdown()
				else
					openDropdown()
				end
			end)

			-- Close dropdown when clicking outside
			UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
				if not gameProcessedEvent and isDropdownOpen then
					local mousePos = input.Position
					local toggleButtonAbsolute = toggleButton.AbsolutePosition
					local toggleButtonSize = toggleButton.AbsoluteSize
					local optionsFrameAbsolute = optionsFrame.AbsolutePosition
					local optionsFrameSize = optionsFrame.AbsoluteSize

					-- Check if the click is outside both the toggle button and the options frame
					local outsideToggle = mousePos.X < toggleButtonAbsolute.X or mousePos.X > toggleButtonAbsolute.X + toggleButtonSize.X or
										  mousePos.Y < toggleButtonAbsolute.Y or mousePos.Y > toggleButtonAbsolute.Y + toggleButtonSize.Y

					local outsideOptions = mousePos.X < optionsFrameAbsolute.X or mousePos.X > optionsFrameAbsolute.X + optionsFrameSize.X or
										   mousePos.Y < optionsFrameAbsolute.Y or mousePos.Y > optionsFrameAbsolute.Y + optionsFrameSize.Y

					if outsideToggle and outsideOptions then
						closeDropdown()
					end
				end
			end)

			-- Set initial selected text
			setSelectedText(selectedOption)

			-- Return the container frame
			return frame
		end

        -- --- End UI Elements ---

        return tabAPI
    end

    -- Opening animation
    local initialSize = Main.Size -- Store initial size
    Main.Size = UDim2.new(0, 0, 0, 0) -- Start from zero size
	Main.BackgroundTransparency = 1
	Shadow.ImageTransparency = 1

    TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = initialSize,
		BackgroundTransparency = Theme.WindowTransparency
    }):Play()
	TweenService:Create(Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = initialSize + UDim2.new(0, 100, 0, 100), -- Animate shadow size with window
		ImageTransparency = 0.55
    }):Play()


    -- Dragging
    makeDraggable(Main, TitleBar) -- Make the window draggable by the title bar

    return windowAPI
end

return UILib
