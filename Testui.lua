-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Library Table
local UILib = {}

-- Configuration & Themes
local Themes = {
	Dark = {
		WindowBackground = Color3.fromRGB(32, 32, 32), -- Slightly darker
		WindowTransparency = 0, -- Solid background
		TitleBarBackground = Color3.fromRGB(40, 40, 40),
		TitleTextColor = Color3.fromRGB(230, 230, 230), -- Slightly less pure white
		CloseButtonBackground = Color3.fromRGB(230, 60, 60), -- More muted red
		CloseButtonHover = Color3.fromRGB(200, 50, 50),
		CloseButtonText = Color3.fromRGB(255, 255, 255),
		TabsBackground = Color3.fromRGB(30, 30, 30),
		TabsTransparency = 0,
		TabButtonBackground = Color3.fromRGB(45, 45, 45),
		TabButtonHover = Color3.fromRGB(60, 60, 60),
		TabButtonActive = Color3.fromRGB(70, 70, 70),
		TabButtonText = Color3.fromRGB(200, 200, 200),
		TabButtonActiveText = Color3.fromRGB(255, 255, 255), -- Highlight active tab text
		ElementBackground = Color3.fromRGB(45, 45, 45),
		ElementHover = Color3.fromRGB(60, 60, 60),
		ElementText = Color3.fromRGB(200, 200, 200),
		ContentBackgroundTransparency = 1, -- Content area itself is transparent
		ScrollbarColor = Color3.fromRGB(80, 80, 80),
		ToggleOn = Color3.fromRGB(50, 170, 50), -- More vibrant green
		ToggleOff = Color3.fromRGB(80, 80, 80),
		ToggleHandle = Color3.fromRGB(200, 200, 200),
		SliderFill = Color3.fromRGB(50, 120, 255), -- More vibrant blue
		SliderHandle = Color3.fromRGB(255, 255, 255),
		InputBackground = Color3.fromRGB(55, 55, 55),
		InputText = Color3.fromRGB(230, 230, 230),
		PlaceholderText = Color3.fromRGB(120, 120, 120),
		DropdownBackground = Color3.fromRGB(45, 45, 45),
		DropdownHover = Color3.fromRGB(60, 60, 60),
		DropdownText = Color3.fromRGB(200, 200, 200),
		DropdownOptionHover = Color3.fromRGB(55, 55, 55), -- Hover for individual options
		SectionBackground = Color3.fromRGB(38, 38, 38), -- Slightly different background for sections
		SectionHeaderColor = Color3.fromRGB(230, 230, 230),
	},
	Light = {
		WindowBackground = Color3.fromRGB(230, 230, 230),
		WindowTransparency = 0,
		TitleBarBackground = Color3.fromRGB(210, 210, 210),
		TitleTextColor = Color3.fromRGB(20, 20, 20),
		CloseButtonBackground = Color3.fromRGB(255, 100, 100),
		CloseButtonHover = Color3.fromRGB(220, 80, 80),
		CloseButtonText = Color3.fromRGB(255, 255, 255),
		TabsBackground = Color3.fromRGB(220, 220, 220),
		TabsTransparency = 0,
		TabButtonBackground = Color3.fromRGB(200, 200, 200),
		TabButtonHover = Color3.fromRGB(180, 180, 180),
		TabButtonActive = Color3.fromRGB(170, 170, 170),
		TabButtonText = Color3.fromRGB(50, 50, 50),
		TabButtonActiveText = Color3.fromRGB(0, 0, 0),
		ElementBackground = Color3.fromRGB(200, 200, 200),
		ElementHover = Color3.fromRGB(180, 180, 180),
		ElementText = Color3.fromRGB(50, 50, 50),
		ContentBackgroundTransparency = 1,
		ScrollbarColor = Color3.fromRGB(150, 150, 150),
		ToggleOn = Color3.fromRGB(50, 170, 50),
		ToggleOff = Color3.fromRGB(180, 180, 180),
		ToggleHandle = Color3.fromRGB(50, 50, 50),
		SliderFill = Color3.fromRGB(50, 120, 255),
		SliderHandle = Color3.fromRGB(50, 50, 50),
		InputBackground = Color3.fromRGB(210, 210, 210),
		InputText = Color3.fromRGB(20, 20, 20),
		PlaceholderText = Color3.fromRGB(100, 100, 100),
		DropdownBackground = Color3.fromRGB(200, 200, 200),
		DropdownHover = Color3.fromRGB(180, 180, 180),
		DropdownText = Color3.fromRGB(50, 50, 50),
		DropdownOptionHover = Color3.fromRGB(190, 190, 190),
		SectionBackground = Color3.fromRGB(215, 215, 215),
		SectionHeaderColor = Color3.fromRGB(20, 20, 20),
	}
}

-- Utility: Draggable Function (Improved)
local function makeDraggable(guiObject, dragHandle)
    local dragging, dragInput, dragStart, startPos
    local handle = dragHandle or guiObject

    local function processMove(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            -- Clamp the new position to stay within screen bounds (optional but good practice)
            local newPosX = math.clamp(startPos.X.Offset + delta.X, -guiObject.AbsoluteSize.X * guiObject.AnchorPoint.X, UserInputService.ViewportSize.X - guiObject.AbsoluteSize.X * (1 - guiObject.AnchorPoint.X))
            local newPosY = math.clamp(startPos.Y.Offset + delta.Y, -guiObject.AbsoluteSize.Y * guiObject.AnchorPoint.Y, UserInputService.ViewportSize.Y - guiObject.AbsoluteSize.Y * (1 - guiObject.AnchorPoint.Y))

            guiObject.Position = UDim2.new(0, newPosX, 0, newPosY) -- Use offset for dragging
        end
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragInput = input
            dragStart = input.Position
            startPos = guiObject.AbsolutePosition -- Use absolute position for calculation
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    dragInput = nil
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(processMove)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if input == dragInput then
                 dragging = false
                 dragInput = nil
            end
        end
    end)
end

-- Hover Effect Utility
local function addHoverEffect(guiObject, normalColor, hoverColor, duration)
	local duration = duration or 0.15
	local conn1, conn2, conn3

	local function onHover()
		TweenService:Create(guiObject, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundColor3 = hoverColor }):Play()
	end

	local function onLeave()
		TweenService:Create(guiObject, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundColor3 = normalColor }):Play()
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

-- Base Element Styling (Helper function to apply common styles)
local function styleElement(element, theme, cornerRadius)
	element.BorderSizePixel = 0
	Instance.new("UICorner", element).CornerRadius = UDim.new(0, cornerRadius or 6)
	Instance.new("UIPadding", element).Padding = UDim.new(0, 8, 0, 8) -- Default internal padding
end


-- --- UI Element Creation Helpers ---

local function createButton(tabFrame, theme, text, callback)
	local button = Instance.new("TextButton")
	button.Name = "Button_" .. text:gsub("[^%w%s]", ""):gsub("%s+", "_")
	button.Size = UDim2.new(1, 0, 0, 30) -- Consistent element height
	button.BackgroundColor3 = theme.ElementBackground
	button.TextColor3 = theme.ElementText
	button.Font = Enum.Font.Gotham -- Consistent Font
	button.TextSize = 14
	button.AutoButtonColor = false
	button.TextXAlignment = Enum.TextXAlignment.Center -- Center text

	styleElement(button, theme) -- Apply base styling

	addHoverEffect(button, theme.ElementBackground, theme.ElementHover)

	button.MouseButton1Click:Connect(function()
		pcall(callback)
	end)

	button.Parent = tabFrame -- Parent after styling
	return button
end

local function createToggle(tabFrame, theme, text, defaultState, callback)
	local frame = Instance.new("Frame")
	frame.Name = "Toggle_" .. text:gsub("[^%w%s]", ""):gsub("%s+", "_")
	frame.Size = UDim2.new(1, 0, 0, 30)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0

	local layout = Instance.new("UIListLayout", frame)
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Padding = UDim.new(0, 8)
	layout.DominantAxis = Enum.DominantAxis.Height -- Important for horizontal layout in auto-sized frame

	local label = Instance.new("TextLabel")
	label.Text = text
	label.Size = UDim2.new(1, -40, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = theme.ElementText
	label.TextSize = 14
	label.Font = Enum.Font.Gotham
	label.TextXAlignment = Enum.TextXAlignment.Left

	local toggleButton = Instance.new("TextButton") -- The visual toggle
	toggleButton.Size = UDim2.new(0, 35, 0, 20) -- Wider for switch appearance
	toggleButton.BackgroundColor3 = defaultState and theme.ToggleOn or theme.ToggleOff
	toggleButton.BackgroundTransparency = 0
	toggleButton.Text = ""
	toggleButton.AutoButtonColor = false
	toggleButton.BorderSizePixel = 0
	Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 10) -- Pill shape

	local handle = Instance.new("Frame", toggleButton)
	handle.Size = UDim2.new(0, 16, 0, 16) -- Handle size
	handle.AnchorPoint = Vector2.new(0.5, 0.5)
	handle.Position = defaultState and UDim2.new(1, -10, 0.5, 0) or UDim2.new(0, 10, 0.5, 0) -- Initial position
	handle.BackgroundColor3 = theme.ToggleHandle
	handle.BorderSizePixel = 0
	Instance.new("UICorner", handle).CornerRadius = UDim.new(0, 8) -- Round handle

	local state = defaultState
	local function updateToggleVisual(animate)
		local targetColor = state and theme.ToggleOn or theme.ToggleOff
		local targetHandlePos = state and UDim2.new(1, -10, 0.5, 0) or UDim2.new(0, 10, 0.5, 0)
		local duration = animate and 0.15 or 0 -- Animate only if requested

		TweenService:Create(toggleButton, TweenInfo.new(duration), { BackgroundColor3 = targetColor }):Play()
		TweenService:Create(handle, TweenInfo.new(duration), { Position = targetHandlePos }):Play()
	end

	toggleButton.MouseButton1Click:Connect(function()
		state = not state
		updateToggleVisual(true) -- Animate the change
		pcall(callback, state)
	end)

	-- Initial visual update (no animation)
	updateToggleVisual(false)

	label.Parent = frame
	toggleButton.Parent = frame -- Parent after styling

	frame.Parent = tabFrame -- Parent the container frame
	return frame
end

local function createSlider(tabFrame, theme, text, min, max, initial, callback)
	local frame = Instance.new("Frame")
	frame.Name = "Slider_" .. text:gsub("[^%w%s]", ""):gsub("%s+", "_")
	frame.Size = UDim2.new(1, 0, 0, 50) -- Taller frame for label and slider
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0

	local layout = Instance.new("UIListLayout", frame)
	layout.FillDirection = Enum.FillDirection.Vertical
	layout.VerticalAlignment = Enum.Top
	layout.Padding = UDim.new(0, 4)

	local label = Instance.new("TextLabel")
	label.Text = text -- Initial text, will be updated
	label.Size = UDim2.new(1, 0, 0, 15)
	label.BackgroundTransparency = 1
	label.TextColor3 = theme.ElementText
	label.TextSize = 14
	label.Font = Enum.Font.Gotham
	label.TextXAlignment = Enum.TextXAlignment.Left

	local sliderFrame = Instance.new("Frame")
	sliderFrame.Size = UDim2.new(1, 0, 0, 8) -- Thinner slider track
	sliderFrame.BackgroundColor3 = theme.ElementBackground
	sliderFrame.BorderSizePixel = 0
	Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 4)

	local sliderFill = Instance.new("Frame", sliderFrame)
	sliderFill.Size = UDim2.new(0, 0, 1, 0)
	sliderFill.BackgroundColor3 = theme.SliderFill
	sliderFill.BorderSizePixel = 0
	Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(0, 4)

	local sliderHandle = Instance.new("Frame", sliderFrame) -- Use Frame for a simpler handle
	sliderHandle.Size = UDim2.new(0, 16, 0, 16)
	sliderHandle.Position = UDim2.new(0, -8, 0.5, -8) -- Position handle
	sliderHandle.BackgroundColor3 = theme.SliderHandle
	sliderHandle.BackgroundTransparency = 0
	sliderHandle.ZIndex = 2
	Instance.new("UICorner", sliderHandle).CornerRadius = UDim.new(0, 8)

	local currentValue = math.clamp(initial or min, min, max)
	local isDragging = false

	local function updateSliderVisual(value, animate)
		local clampedValue = math.clamp(value, min, max)
		local ratio = (clampedValue - min) / (max - min)
		local duration = animate and 0.1 or 0 -- Animate if requested

		TweenService:Create(sliderFill, TweenInfo.new(duration), { Size = UDim2.new(ratio, 0, 1, 0) }):Play()
		TweenService:Create(sliderHandle, TweenInfo.new(duration), { Position = UDim2.new(ratio, -sliderHandle.Size.X.Offset / 2, 0.5, -sliderHandle.Size.Y.Offset / 2) }):Play()

		label.Text = text .. ": " .. string.format("%.1f", clampedValue)
	end

	-- Implement dragging
	local dragStartMousePos
	local dragStartHandlePos

	sliderHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = true
			dragStartMousePos = input.Position
			dragStartHandlePos = sliderHandle.Position
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			local delta = input.Position - dragStartMousePos
			local newHandleXOffset = dragStartHandlePos.X.Offset + delta.X

			-- Calculate the new value based on the handle's desired offset
			local sliderTrackWidth = sliderFrame.AbsoluteSize.X - sliderHandle.AbsoluteSize.X
			local clampedHandleOffset = math.clamp(newHandleXOffset, -sliderHandle.Size.X.Offset/2, sliderTrackWidth + sliderHandle.Size.X.Offset/2)

			local percent = (clampedHandleOffset + sliderHandle.Size.X.Offset/2) / sliderFrame.AbsoluteSize.X -- Calculate percentage based on slider frame width
			currentValue = min + percent * (max - min)

			updateSliderVisual(currentValue, false) -- Don't animate while dragging
			pcall(callback, currentValue)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = false
			-- Snap handle to closest value visually after drag ends (optional)
			updateSliderVisual(currentValue, true)
		end
	end)

	-- Allow clicking on the track to jump
	sliderFrame.MouseButton1Click:Connect(function(x, y)
		local mousePos = UserInputService:GetMouseLocation()
		local relativePos = mousePos - sliderFrame.AbsolutePosition
		local percent = math.clamp(relativePos.X / sliderFrame.AbsoluteSize.X, 0, 1)
		currentValue = min + percent * (max - min)
		updateSliderVisual(currentValue, true) -- Animate the jump
		pcall(callback, currentValue)
	end)


	-- Initial visual update
	updateSliderVisual(currentValue, false)

	label.Parent = frame
	sliderFrame.Parent = frame

	frame.Parent = tabFrame
	return frame
end

local function createTextbox(tabFrame, theme, text, placeholder, defaultText, callback)
	local frame = Instance.new("Frame")
	frame.Name = "Textbox_" .. text:gsub("[^%w%s]", ""):gsub("%s+", "_")
	frame.Size = UDim2.new(1, 0, 0, 50)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0

	local layout = Instance.new("UIListLayout", frame)
	layout.FillDirection = Enum.FillDirection.Vertical
	layout.VerticalAlignment = Enum.Top
	layout.Padding = UDim.new(0, 4)

	local label = Instance.new("TextLabel")
	label.Text = text
	label.Size = UDim2.new(1, 0, 0, 15)
	label.BackgroundTransparency = 1
	label.TextColor3 = theme.ElementText
	label.TextSize = 14
	label.Font = Enum.Font.Gotham
	label.TextXAlignment = Enum.TextXAlignment.Left

	local textbox = Instance.new("TextBox")
	textbox.Size = UDim2.new(1, 0, 0, 25)
	textbox.PlaceholderText = placeholder or ""
	textbox.Text = defaultText or ""
	textbox.BackgroundColor3 = theme.InputBackground
	textbox.TextColor3 = theme.InputText
	textbox.PlaceholderColor3 = theme.PlaceholderText
	textbox.Font = Enum.Font.Gotham
	textbox.TextSize = 14
	textbox.ClearTextOnFocus = false
	textbox.BorderSizePixel = 0
	Instance.new("UICorner", textbox).CornerRadius = UDim.new(0, 6)
	Instance.new("UIPadding", textbox).Padding = UDim.new(0, 8)

	-- Callback on text change or focus lost
	textbox.FocusLost:Connect(function(enterPressed)
		if enterPressed or not textbox.Focused then -- Check if enter was pressed OR focus was truly lost
			pcall(callback, textbox.Text, enterPressed)
		end
	end)

	label.Parent = frame
	textbox.Parent = frame

	frame.Parent = tabFrame
	return textbox
end

local function createLabel(tabFrame, theme, text)
	local label = Instance.new("TextLabel")
	label.Name = "Label_" .. text:gsub("[^%w%s]", ""):gsub("%s+", "_")
	label.Text = text
	label.Size = UDim2.new(1, 0, 0, 0) -- Automatic height
	label.BackgroundTransparency = 1
	label.TextColor3 = theme.ElementText
	label.TextSize = 16
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextWrapped = true
	label.AutomaticSize = Enum.AutomaticSize.Y
	label.TextYAlignment = Enum.TextYAlignment.Top -- Align wrapped text to top

	label.Parent = tabFrame
	return label
end

local function createDropdown(tabFrame, theme, text, options, callback)
	local frame = Instance.new("Frame")
	frame.Name = "Dropdown_" .. text:gsub("[^%w%s]", ""):gsub("%s+", "_")
	frame.Size = UDim2.new(1, 0, 0, 30) -- Base size for the closed dropdown (just the button height)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0

	-- Use UIListLayout here too to arrange the label and the button/options vertically
	local layout = Instance.new("UIListLayout", frame)
	layout.FillDirection = Enum.FillDirection.Vertical
	layout.VerticalAlignment = Enum.Top
	layout.Padding = UDim.new(0, 4)
	layout.AutomaticSize = Enum.AutomaticSize.Y -- Frame's height adjusts if options are visible

	local label = Instance.new("TextLabel")
	label.Text = text
	label.Size = UDim2.new(1, 0, 0, 15)
	label.BackgroundTransparency = 1
	label.TextColor3 = theme.ElementText
	label.TextSize = 14
	label.Font = Enum.Font.Gotham
	label.TextXAlignment = Enum.TextXAlignment.Left

	local toggleButton = Instance.new("TextButton")
	toggleButton.Size = UDim2.new(1, 0, 0, 30) -- Button size
	toggleButton.BackgroundColor3 = theme.DropdownBackground
	toggleButton.TextColor3 = theme.DropdownText
	toggleButton.Font = Enum.Font.Gotham
	toggleButton.TextSize = 14
	toggleButton.TextXAlignment = Enum.TextXAlignment.Left
	toggleButton.TextYAlignment = Enum.TextYAlignment.Center
	toggleButton.AutoButtonColor = false
	toggleButton.BorderSizePixel = 0 -- No border on button itself
	Instance.new("UIPadding", toggleButton).Padding = UDim.new(0, 8)
	Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 6)

	-- Dropdown arrow
	local arrowLabel = Instance.new("TextLabel", toggleButton)
	arrowLabel.Size = UDim2.new(0, 20, 1, 0)
	arrowLabel.Position = UDim2.new(1, -25, 0, 0)
	arrowLabel.BackgroundTransparency = 1
	arrowLabel.TextColor3 = theme.DropdownText
	arrowLabel.TextSize = 14
	arrowLabel.Font = Enum.Font.SourceSans
	arrowLabel.Text = "▼"
	arrowLabel.TextXAlignment = Enum.TextXAlignment.Right
	arrowLabel.TextYAlignment = Enum.TextYAlignment.Center

	-- Dropdown options frame
	local optionsFrame = Instance.new("Frame")
	optionsFrame.Size = UDim2.new(1, 0, 0, 0) -- Starts closed
	optionsFrame.BackgroundTransparency = 0
	optionsFrame.BackgroundColor3 = theme.DropdownBackground
	optionsFrame.BorderSizePixel = 1
	optionsFrame.BorderColor3 = Color3.fromRGB(80, 80, 80) -- Consistent border color
	optionsFrame.Visible = false
	optionsFrame.ZIndex = 3
	Instance.new("UICorner", optionsFrame).CornerRadius = UDim.new(0, 6) -- Match button corner
	local optionsPadding = Instance.new("UIPadding", optionsFrame)
	optionsPadding.Padding = UDim.new(0, 5)

	local optionsLayout = Instance.new("UIListLayout", optionsFrame)
	optionsLayout.FillDirection = Enum.FillDirection.Vertical
	optionsLayout.VerticalAlignment = Enum.Top
	optionsLayout.Padding = UDim.new(0, 2)
	local optionsAutoSize = Instance.new("UIAutomaticSize", optionsFrame)
	optionsAutoSize.AutomaticSize = Enum.AutomaticSize.Y

	local isDropdownOpen = false
	local selectedOption = options and options[1] or "None"

	local function setSelectedText(text)
		toggleButton.Text = text
		selectedOption = text
	end

	local function closeDropdown()
		if isDropdownOpen then
			-- Animate closing
			TweenService:Create(optionsFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, 0) }):Play()
			delay(0.2, function()
				optionsFrame.Visible = false
				isDropdownOpen = false
			end)
			TweenService:Create(arrowLabel, TweenInfo.new(0.2), { Rotation = 0 }):Play()
		end
	end

	local function openDropdown()
		if not isDropdownOpen then
			optionsFrame.Visible = true
			-- Calculate target height including padding
			local targetHeight = optionsLayout.AbsoluteContentSize.Y + optionsPadding.Padding.Top.Offset + optionsPadding.Padding.Bottom.Offset
			TweenService:Create(optionsFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, targetHeight) }):Play()
			isDropdownOpen = true
			TweenService:Create(arrowLabel, TweenInfo.new(0.2), { Rotation = 180 }):Play()
		end
	end

	-- Populate options
	if options then
		for _, optionText in ipairs(options) do
			local optionButton = Instance.new("TextButton", optionsFrame)
			optionButton.Size = UDim2.new(1, 0, 0, 25)
			optionButton.BackgroundColor3 = theme.DropdownBackground
			optionButton.TextColor3 = theme.DropdownText
			optionButton.Font = Enum.Font.Gotham
			optionButton.TextSize = 14
			optionButton.Text = optionText
			optionButton.AutoButtonColor = false
			optionButton.BorderSizePixel = 0
			optionButton.TextXAlignment = Enum.TextXAlignment.Left
			optionButton.TextYAlignment = Enum.TextYAlignment.Center
			Instance.new("UIPadding", optionButton).Padding = UDim.new(0, 5)

			addHoverEffect(optionButton, theme.DropdownBackground, theme.DropdownOptionHover) -- Specific hover for options

			optionButton.MouseButton1Click:Connect(function()
				setSelectedText(optionText)
				closeDropdown()
				pcall(callback, optionText)
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
		if not gameProcessedEvent and isDropdownOpen and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			local mousePos = input.Position
			local toggleButtonAbsolute = toggleButton.AbsolutePosition
			local toggleButtonSize = toggleButton.AbsoluteSize
			local optionsFrameAbsolute = optionsFrame.AbsolutePosition
			local optionsFrameSize = optionsFrame.AbsoluteSize

			-- Check if the click is outside BOTH the toggle button AND the options frame
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

	label.Parent = frame
	toggleButton.Parent = frame
	optionsFrame.Parent = frame -- Options frame is parented within the dropdown frame

	frame.Parent = tabFrame
	return frame
end

local function createSection(tabFrame, theme, title)
	local frame = Instance.new("Frame")
	frame.Name = "Section_" .. title:gsub("[^%w%s]", ""):gsub("%s+", "_")
	frame.Size = UDim2.new(1, 0, 0, 0) -- Automatic height
	frame.BackgroundColor3 = theme.SectionBackground
	frame.BackgroundTransparency = 0
	frame.BorderSizePixel = 0
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6) -- Rounded corners for sections

	local layout = Instance.new("UIListLayout", frame)
	layout.FillDirection = Enum.FillDirection.Vertical
	layout.VerticalAlignment = Enum.Top
	layout.Padding = UDim.new(0, 6) -- Padding between elements within the section
	layout.AutomaticSize = Enum.AutomaticSize.Y -- Section height based on contents

	local padding = Instance.new("UIPadding", frame)
	padding.Padding = UDim.new(0, 10, 0, 10) -- Internal padding for the section

	local titleLabel = Instance.new("TextLabel", frame)
	titleLabel.Text = title
	titleLabel.Size = UDim2.new(1, 0, 0, 20)
	titleLabel.BackgroundTransparency = 1
	titleLabel.TextColor3 = theme.SectionHeaderColor
	titleLabel.TextSize = 16
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextWrapped = true
	titleLabel.AutomaticSize = Enum.AutomaticSize.Y

	local sectionAPI = {}
	sectionAPI.Frame = frame -- Allow direct access to the section frame

	-- Functions to add elements directly to the section
	function sectionAPI:AddButton(text, callback)
		return createButton(frame, theme, text, callback) -- Parent to section frame
	end

	function sectionAPI:AddToggle(text, defaultState, callback)
		return createToggle(frame, theme, text, defaultState, callback) -- Parent to section frame
	end

	function sectionAPI:AddSlider(text, min, max, initial, callback)
		return createSlider(frame, theme, text, min, max, initial, callback) -- Parent to section frame
	end

	function sectionAPI:AddTextbox(text, placeholder, defaultText, callback)
		return createTextbox(frame, theme, text, placeholder, defaultText, callback) -- Parent to section frame
	end

	function sectionAPI:AddLabel(text)
		return createLabel(frame, theme, text) -- Parent to section frame
	end

	function sectionAPI:AddDropdown(text, options, callback)
		return createDropdown(frame, theme, text, options, callback) -- Parent to section frame
	end

	frame.Parent = tabFrame -- Parent section frame to tab frame
	return sectionAPI
end


-- Main Window Creation Function
function UILib:CreateWindow(config)
    local config = config or {}
    local Title = config.Title or "Your Hub"
    local Size = config.Size or UDim2.new(0, 600, 0, 400)
    local ThemeName = config.Theme or "Dark"
    local CornerRadius = config.CornerRadius or 10 -- Slightly reduced default radius
    local InitialPosition = config.Position
    local MinSize = config.MinSize or Vector2.new(250, 200) -- Slightly larger minimum size

    local Theme = Themes[ThemeName] or Themes.Dark

    local ScreenGui = Instance.new("ScreenGui", PlayerGui)
    ScreenGui.Name = "UILib_Window_" .. Title:gsub("[^%w%s]", ""):gsub("%s+", "_")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    local Main = Instance.new("Frame")
    Main.Name = "MainWindow"
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Position = InitialPosition or UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = Size
    Main.BackgroundColor3 = Theme.WindowBackground
    Main.BackgroundTransparency = Theme.WindowTransparency
    Main.ClipsDescendants = true
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
	Main.ZIndex = 1 -- Base ZIndex

	local Corner = Instance.new("UICorner", Main)
    Corner.CornerRadius = UDim.new(0, CornerRadius)

	-- Drop shadow (Improved positioning and slicing)
	local Shadow = Instance.new("ImageLabel", ScreenGui) -- Parent shadow to ScreenGui to avoid clipping issues
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Main.AnchorPoint
    Shadow.Position = Main.Position
    Shadow.Size = Main.Size + UDim2.new(0, 100, 0, 100)
    Shadow.ZIndex = Main.ZIndex - 1 -- Render behind the main window
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageColor3 = Color3.new(0,0,0)
    Shadow.ImageTransparency = 0.6 -- Slightly more opaque shadow
    Shadow.BackgroundTransparency = 1
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(10, 10, 118, 118)

	-- Keep Shadow's position and size updated with the Main window
	Main:GetPropertyChangedSignal("Position"):Connect(function()
		Shadow.Position = Main.Position
	end)
	Main:GetPropertyChangedSignal("Size"):Connect(function()
		Shadow.Size = Main.Size + UDim2.new(0, 100, 0, 100)
	end)


    local TitleBar = Instance.new("Frame", Main)
	TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
	TitleBar.Position = UDim2.new(0, 0, 0, -CornerRadius) -- Position slightly higher
    TitleBar.BackgroundColor3 = Theme.TitleBarBackground
	TitleBar.BorderSizePixel = 0
	TitleBar.ZIndex = 2 -- Above main content

	local TopBarVisual = Instance.new("Frame", TitleBar) -- Frame for top corners
	TopBarVisual.Size = UDim2.new(1, 0, 1, CornerRadius)
	TopBarVisual.Position = UDim2.new(0, 0, 0, 0)
	TopBarVisual.BackgroundColor3 = Theme.TitleBarBackground
	TopBarVisual.BorderSizePixel = 0
	Instance.new("UICorner", TopBarVisual).CornerRadius = UDim.new(0, CornerRadius)
	TitleBar.ClipsDescendants = true

    local TitleLabel = Instance.new("TextLabel", TitleBar)
	TitleLabel.Name = "TitleLabel"
    TitleLabel.Text = Title
    TitleLabel.Size = UDim2.new(1, -80, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextColor3 = Theme.TitleTextColor
    TitleLabel.TextSize = 20
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
	TitleLabel.ZIndex = 3 -- Above title bar background

    local CloseButton = Instance.new("TextButton", TitleBar)
	CloseButton.Name = "CloseButton"
    CloseButton.Text = "X"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0.5, -15)
    CloseButton.BackgroundColor3 = Theme.CloseButtonBackground
    CloseButton.TextColor3 = Theme.CloseButtonText
    CloseButton.Font = Enum.Font.Gotham
    CloseButton.TextSize = 18
    CloseButton.AutoButtonColor = false
	CloseButton.BorderSizePixel = 0
	CloseButton.ZIndex = 3 -- Above title bar background
	Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)

	addHoverEffect(CloseButton, Theme.CloseButtonBackground, Theme.CloseButtonHover)

    CloseButton.MouseButton1Click:Connect(function()
        -- Closing animation
		local closeTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		TweenService:Create(Main, closeTweenInfo, {
			Position = Main.Position + UDim2.new(0, 0, 0, 50),
			BackgroundTransparency = 1,
			Size = Main.Size * 0.95
		}):Play()
		TweenService:Create(Shadow, closeTweenInfo, {
			Size = Shadow.Size * 0.95,
			ImageTransparency = 1
		}):Play()

		delay(0.3, function()
			ScreenGui:Destroy()
		end)
    end)

    local Tabs = Instance.new("Frame", Main)
	Tabs.Name = "Tabs"
    Tabs.Position = UDim2.new(0, 10, 0, 45)
    Tabs.Size = UDim2.new(0, 140, 1, -55)
    Tabs.BackgroundColor3 = Theme.TabsBackground
    Tabs.BackgroundTransparency = Theme.TabsTransparency
	Tabs.BorderSizePixel = 0
	Tabs.ZIndex = 2
    Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0, 8)

    local TabList = Instance.new("UIListLayout", Tabs)
	TabList.Name = "TabListLayout"
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 8)
	TabList.FillDirection = Enum.FillDirection.Vertical
	TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabList.VerticalAlignment = Enum.VerticalAlignment.Top
	-- Add padding inside the tabs frame
	Instance.new("UIPadding", Tabs).Padding = UDim.new(0, 5, 0, 5)


    local Content = Instance.new("Frame", Main)
	Content.Name = "Content"
    Content.Position = UDim2.new(0, 160, 0, 45)
    Content.Size = UDim2.new(1, -170, 1, -55)
    Content.BackgroundTransparency = Theme.ContentBackgroundTransparency
	Content.BorderSizePixel = 0
	Content.ZIndex = 2

	local ContentScroll = Instance.new("ScrollingFrame", Content)
	ContentScroll.Size = UDim2.new(1, 0, 1, 0)
	ContentScroll.BackgroundTransparency = 1
	ContentScroll.BorderSizePixel = 0
	ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be updated
	ContentScroll.ScrollBarThickness = 6
	ContentScroll.ScrollBarColor3 = Theme.ScrollbarColor
	ContentScroll.ScrollingDirection = Enum.ScrollingDirection.Y
	ContentScroll.AutomaticCanvasSize = Enum.AutomaticCanvasSize.Y -- Automatically size canvas height

    local function switchTab(toFrame)
        for _, v in ipairs(ContentScroll:GetChildren()) do
            if v:IsA("Frame") and v.Name:find("TabContent_") then -- Explicitly check for tab content frames
                if v == toFrame then
                    -- Fade in and set visible
					v.BackgroundTransparency = 1 -- Ensure it starts transparent for the tween
                    v.Visible = true
                    TweenService:Create(v, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0 }):Play() -- Tween transparency to 0 if needed, or just set visible
                else
                    -- Hide other tabs immediately
                    v.Visible = false
					v.BackgroundTransparency = 1
                end
            end
        end
    end

    local windowAPI = {} -- API returned to the user

    function windowAPI:CreateTab(name)
        local tabBtn = Instance.new("TextButton", Tabs)
		tabBtn.Name = "TabButton_" .. name:gsub("[^%w%s]", ""):gsub("%s+", "_")
        tabBtn.Text = name
        tabBtn.Size = UDim2.new(1, -10, 0, 30) -- Standard button size within the tab list
        tabBtn.Position = UDim2.new(0, 5, 0, 0) -- Center within Tabs frame padding
        tabBtn.BackgroundColor3 = Theme.TabButtonBackground
        tabBtn.TextColor3 = Theme.TabButtonText
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.TextSize = 14
        tabBtn.BorderSizePixel = 0
        tabBtn.AutoButtonColor = false
		tabBtn.TextXAlignment = Enum.TextXAlignment.Center -- Center tab button text
        Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)

        addHoverEffect(tabBtn, Theme.TabButtonBackground, Theme.TabButtonHover)

        local tabFrame = Instance.new("Frame", ContentScroll) -- Parent tab frame to ScrollingFrame
		tabFrame.Name = "TabContent_" .. name:gsub("[^%w%s]", ""):gsub("%s+", "_")
        tabFrame.Size = UDim2.new(1, 0, 0, 0) -- Automatic height
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false -- Initially hidden
        tabFrame.ZIndex = 2

		local autoSize = Instance.new("UIAutomaticSize", tabFrame)
		autoSize.AutomaticSize = Enum.AutomaticSize.Y

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
			-- Update tab button appearance
			for _, btn in ipairs(Tabs:GetChildren()) do
				if btn:IsA("TextButton") and btn.Name:find("TabButton_") then
					if btn == tabBtn then
						TweenService:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = Theme.TabButtonActive }):Play()
						TweenService:Create(btn, TweenInfo.new(0.2), { TextColor3 = Theme.TabButtonActiveText }):Play()
					else
						TweenService:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = Theme.TabButtonBackground }):Play()
						TweenService:Create(btn, TweenInfo.new(0.2), { TextColor3 = Theme.TabButtonText }):Play()
					end
				end
			end
        end)

        -- Auto-select the first tab created after it's parented
        if #ContentScroll:GetChildren() == 1 then
            switchTab(tabFrame)
			TweenService:Create(tabBtn, TweenInfo.new(0.2), { BackgroundColor3 = Theme.TabButtonActive }):Play()
			TweenService:Create(tabBtn, TweenInfo.new(0.2), { TextColor3 = Theme.TabButtonActiveText }):Play()
        end

        local tabAPI = {}

        -- Expose creation functions via tabAPI, passing the tabFrame and theme
        function tabAPI:AddButton(text, callback)
			return createButton(tabFrame, Theme, text, callback)
        end

		function tabAPI:AddToggle(text, defaultState, callback)
			return createToggle(tabFrame, Theme, text, defaultState, callback)
		end

		function tabAPI:AddSlider(text, min, max, initial, callback)
			return createSlider(tabFrame, Theme, text, min, max, initial, callback)
		end

		function tabAPI:AddTextbox(text, placeholder, defaultText, callback)
			return createTextbox(tabFrame, Theme, text, placeholder, defaultText, callback)
		end

		function tabAPI:AddLabel(text)
			return createLabel(tabFrame, Theme, text)
		end

		function tabAPI:AddDropdown(text, options, callback)
			return createDropdown(tabFrame, Theme, text, options, callback)
		end

		function tabAPI:AddSection(title)
			return createSection(tabFrame, Theme, title)
		end

        return tabAPI
    end

    -- Opening animation
    local initialSize = Main.Size
    local initialPosition = Main.Position -- Store initial position
    Main.Size = UDim2.new(0, 0, 0, 0)
	Main.BackgroundTransparency = 1
	Shadow.ImageTransparency = 1
	Main.Position = Main.Position + UDim2.new(0, 0, 0, 50) -- Start slightly below

    TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = initialSize,
		Position = initialPosition, -- Tween to the correct initial position
		BackgroundTransparency = Theme.WindowTransparency
    }):Play()
	TweenService:Create(Shadow, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = initialSize + UDim2.new(0, 100, 0, 100),
		Position = initialPosition, -- Tween shadow to correct position
		ImageTransparency = 0.6
    }):Play()


    -- Dragging
    makeDraggable(Main, TitleBar)

    return windowAPI
end

return UILib
