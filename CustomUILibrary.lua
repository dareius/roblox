--// AdvancedUILibrary.lua
-- Advanced, Modular, and Robust UI Library for Roblox
-- Author: AdvancedDev (inspired by Rayfield and enhanced further)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Library = {}
Library.__index = Library

-- Themes (you can add more themes or allow dynamic runtime theme changes)
local Themes = {
	["Midnight"] = {
		Background = Color3.fromRGB(20,20,30),
		Accent = Color3.fromRGB(0,120,255),
		Text = Color3.fromRGB(255,255,255),
		Section = Color3.fromRGB(30,30,40),
		Button = Color3.fromRGB(40,40,50),
	},
	["Ocean"] = {
		Background = Color3.fromRGB(10,25,35),
		Accent = Color3.fromRGB(0,180,255),
		Text = Color3.fromRGB(235,255,255),
		Section = Color3.fromRGB(20,40,60),
		Button = Color3.fromRGB(30,60,90),
	},
	["Sunset"] = {
		Background = Color3.fromRGB(45,20,30),
		Accent = Color3.fromRGB(255,120,100),
		Text = Color3.fromRGB(255,240,230),
		Section = Color3.fromRGB(60,30,40),
		Button = Color3.fromRGB(80,40,50),
	},
	["Cyber"] = {
		Background = Color3.fromRGB(15,15,25),
		Accent = Color3.fromRGB(255,0,255),
		Text = Color3.fromRGB(200,200,255),
		Section = Color3.fromRGB(30,30,50),
		Button = Color3.fromRGB(50,30,70),
	},
	-- More themes can be added here
}

local CurrentTheme = Themes["Midnight"]

local function createUICorner(radius)
	local success, corner = pcall(function()
		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(0, radius)
		return c
	end)
	return success and corner or nil
end

local function notifyError(errMsg)
	-- Advanced error notifier with fade-out animation
	local errFrame = Instance.new("Frame")
	errFrame.Size = UDim2.new(0, 300, 0, 80)
	errFrame.Position = UDim2.new(0.5, -150, 0, 50)
	errFrame.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	errFrame.Parent = PlayerGui
	local cc = createUICorner(8)
	if cc then cc.Parent = errFrame end
	
	local errLabel = Instance.new("TextLabel")
	errLabel.Size = UDim2.new(1, 0, 1, 0)
	errLabel.BackgroundTransparency = 1
	errLabel.Text = "Error: " .. errMsg
	errLabel.TextColor3 = Color3.new(1,1,1)
	errLabel.Font = Enum.Font.GothamBold
	errLabel.TextSize = 16
	errLabel.Parent = errFrame
	
	delay(3, function()
		local tween = TweenService:Create(errFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
		tween:Play()
		tween.Completed:Wait()
		errFrame:Destroy()
	end)
end

function Library:AddTheme(name, themeTable)
	local success, err = pcall(function() Themes[name] = themeTable end)
	if not success then
		notifyError("AddTheme failed: " .. tostring(err))
	end
end

-- CreateWindow: Main container with header, tab holder, and dynamic scrolling content
function Library:CreateWindow(config)
	local self = setmetatable({}, Library)
	self.Tabs = {}
	CurrentTheme = Themes[config.Theme] or Themes["Midnight"]
	
	local gui = Instance.new("ScreenGui")
	gui.Name = "AdvancedUILibrary"
	gui.ResetOnSpawn = false
	gui.Parent = PlayerGui
	
	local main = Instance.new("Frame")
	main.Size = UDim2.new(0, 600, 0, 400)
	main.Position = UDim2.new(0.5, -300, 0.5, -200)
	main.BackgroundColor3 = CurrentTheme.Background
	main.BorderSizePixel = 0
	main.Parent = gui
	main.Active = true
	main.Draggable = true
	local mainCorner = createUICorner(12)
	if mainCorner then mainCorner.Parent = main end
	
	-- Header
	local header = Instance.new("Frame")
	header.Size = UDim2.new(1, 0, 0, 40)
	header.BackgroundTransparency = 1
	header.Parent = main
	
	local title = Instance.new("TextLabel")
	title.Text = config.Title or "Advanced UI"
	title.Size = UDim2.new(1, 0, 1, 0)
	title.BackgroundTransparency = 1
	title.Font = Enum.Font.GothamBold
	title.TextSize = 22
	title.TextColor3 = CurrentTheme.Text
	title.Parent = header
	
	-- Tab Holder
	local tabHolder = Instance.new("Frame")
	tabHolder.Size = UDim2.new(0, 140, 1, -40)
	tabHolder.Position = UDim2.new(0, 0, 0, 40)
	tabHolder.BackgroundColor3 = CurrentTheme.Section
	tabHolder.BorderSizePixel = 0
	tabHolder.Parent = main
	local tabHolderCorner = createUICorner(0)
	if tabHolderCorner then tabHolderCorner.Parent = tabHolder end
	
	-- Content Holder (tabs container)
	local contentHolder = Instance.new("Frame")
	contentHolder.Size = UDim2.new(1, -140, 1, -40)
	contentHolder.Position = UDim2.new(0, 140, 0, 40)
	contentHolder.BackgroundColor3 = CurrentTheme.Background
	contentHolder.BorderSizePixel = 0
	contentHolder.Parent = main
	
	function self:CreateTab(name)
		local tab = {}
		tab.Sections = {}
		
		local tabBtn = Instance.new("TextButton")
		tabBtn.Size = UDim2.new(1, 0, 0, 35)
		tabBtn.BackgroundColor3 = CurrentTheme.Button
		tabBtn.Text = name
		tabBtn.TextColor3 = CurrentTheme.Text
		tabBtn.Font = Enum.Font.GothamSemibold
		tabBtn.TextSize = 16
		tabBtn.Parent = tabHolder
		local btnCorner = createUICorner(6)
		if btnCorner then btnCorner.Parent = tabBtn end
		
		-- Each tab gets its own scrolling frame as content
		local tabPage = Instance.new("ScrollingFrame")
		tabPage.Size = UDim2.new(1, 0, 1, 0)
		tabPage.BackgroundTransparency = 1
		tabPage.Visible = false
		tabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
		tabPage.ScrollBarThickness = 6
		tabPage.Parent = contentHolder
		
		local tabLayout = Instance.new("UIListLayout")
		tabLayout.Padding = UDim.new(0, 8)
		tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
		tabLayout.Parent = tabPage
		tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			tabPage.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y)
		end)
		
		tab.Content = tabPage
		
		tabBtn.MouseButton1Click:Connect(function()
			for _, t in pairs(self.Tabs) do
				t.Content.Visible = false
			end
			tabPage.Visible = true
		end)
		
		-- CreateSection: Container with auto-resize and scroll support.
		function tab:CreateSection(titleText)
			local section = {}
			local container = Instance.new("Frame")
			container.Size = UDim2.new(1, -20, 0, 40)
			container.BackgroundColor3 = CurrentTheme.Section
			container.Parent = tabPage
			local containerCorner = createUICorner(8)
			if containerCorner then containerCorner.Parent = container end
			
			local sectionHeader = Instance.new("TextLabel")
			sectionHeader.Size = UDim2.new(1, -10, 0, 25)
			sectionHeader.Position = UDim2.new(0, 5, 0, 0)
			sectionHeader.BackgroundTransparency = 1
			sectionHeader.Text = titleText
			sectionHeader.Font = Enum.Font.GothamBold
			sectionHeader.TextColor3 = CurrentTheme.Text
			sectionHeader.TextSize = 18
			sectionHeader.TextXAlignment = Enum.TextXAlignment.Left
			sectionHeader.Parent = container
			
			local contentFrame = Instance.new("Frame")
			contentFrame.Size = UDim2.new(1, -10, 0, 0)
			contentFrame.Position = UDim2.new(0, 5, 0, 30)
			contentFrame.BackgroundTransparency = 1
			contentFrame.Parent = container
			
			local contentLayout = Instance.new("UIListLayout")
			contentLayout.Padding = UDim.new(0, 6)
			contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
			contentLayout.Parent = contentFrame
			contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				contentFrame.Size = UDim2.new(1, -10, 0, contentLayout.AbsoluteContentSize.Y)
				container.Size = UDim2.new(1, -20, 0, contentLayout.AbsoluteContentSize.Y + 35)
			end)
			
			-- Advanced UI Elements (Buttons, Toggles, Sliders, Dropdowns, etc.)
			
			function section:CreateButton(text, callback)
				local btn = Instance.new("TextButton")
				btn.Size = UDim2.new(1, 0, 0, 30)
				btn.BackgroundColor3 = CurrentTheme.Button
				btn.Text = text
				btn.TextColor3 = CurrentTheme.Text
				btn.Font = Enum.Font.Gotham
				btn.TextSize = 16
				btn.Parent = contentFrame
				local btnCorner = createUICorner(6)
				if btnCorner then btnCorner.Parent = btn end
				btn.MouseButton1Click:Connect(function()
					local success, err = pcall(callback)
					if not success then notifyError("Button error: " .. tostring(err)) end
				end)
			end
			
			function section:CreateToggle(text, default, callback)
				local toggle = Instance.new("TextButton")
				toggle.Size = UDim2.new(1, 0, 0, 30)
				toggle.BackgroundColor3 = CurrentTheme.Button
				local state = default or false
				toggle.Text = text .. ": " .. (state and "ON" or "OFF")
				toggle.TextColor3 = CurrentTheme.Text
				toggle.Font = Enum.Font.Gotham
				toggle.TextSize = 16
				toggle.Parent = contentFrame
				local togCorner = createUICorner(6)
				if togCorner then togCorner.Parent = toggle end
				toggle.MouseButton1Click:Connect(function()
					state = not state
					toggle.Text = text .. ": " .. (state and "ON" or "OFF")
					local success, err = pcall(function() callback(state) end)
					if not success then notifyError("Toggle error: " .. tostring(err)) end
				end)
			end
			
			function section:CreateSlider(text, min, max, default, callback)
				local sliderLabel = Instance.new("TextLabel")
				sliderLabel.Size = UDim2.new(1, 0, 0, 20)
				sliderLabel.BackgroundTransparency = 1
				sliderLabel.Text = text .. ": " .. tostring(default)
				sliderLabel.TextColor3 = CurrentTheme.Text
				sliderLabel.Font = Enum.Font.Gotham
				sliderLabel.TextSize = 16
				sliderLabel.Parent = contentFrame
				
				local slider = Instance.new("Frame")
				slider.Size = UDim2.new(1, 0, 0, 20)
				slider.BackgroundColor3 = CurrentTheme.Button
				slider.Parent = contentFrame
				local sliderCorner = createUICorner(6)
				if sliderCorner then sliderCorner.Parent = slider end
				
				local fill = Instance.new("Frame")
				fill.BackgroundColor3 = CurrentTheme.Accent
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
						local success, err = pcall(function() callback(val) end)
						if not success then notifyError("Slider error: " .. tostring(err)) end
					end
				end)
			end
			
			function section:CreateDropdown(title, list, callback)
				local drop = Instance.new("TextButton")
				drop.Size = UDim2.new(1, 0, 0, 30)
				drop.BackgroundColor3 = CurrentTheme.Button
				drop.Text = title
				drop.TextColor3 = CurrentTheme.Text
				drop.Font = Enum.Font.Gotham
				drop.TextSize = 16
				drop.Parent = contentFrame
				local dropCorner = createUICorner(6)
				if dropCorner then dropCorner.Parent = drop end
				
				local open = false
				local dropdownItems = {}
				local function closeDropdown()
					open = false
					for _, item in pairs(dropdownItems) do
						if item and item.Parent then
							item:Destroy()
						end
					end
					dropdownItems = {}
				end
				
				drop.MouseButton1Click:Connect(function()
					if open then
						closeDropdown()
					else
						open = true
						for i, item in ipairs(list) do
							local opt = Instance.new("TextButton")
							opt.Size = UDim2.new(1, 0, 0, 30)
							opt.BackgroundColor3 = CurrentTheme.Section
							opt.Text = tostring(item)
							opt.TextColor3 = CurrentTheme.Text
							opt.Font = Enum.Font.Gotham
							opt.TextSize = 15
							opt.Parent = contentFrame
							opt.LayoutOrder = i + 100
							local oc = createUICorner(6)
							if oc then oc.Parent = opt end
							opt.MouseButton1Click:Connect(function()
								drop.Text = title .. ": " .. tostring(item)
								local success, err = pcall(function() callback(item) end)
								if not success then notifyError("Dropdown error: " .. tostring(err)) end
								closeDropdown()
							end)
							table.insert(dropdownItems, opt)
						end
						local conn
						conn = UserInputService.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0,36)
								if mousePos.X < drop.AbsolutePosition.X or mousePos.X > drop.AbsolutePosition.X + drop.AbsoluteSize.X or mousePos.Y < drop.AbsolutePosition.Y or mousePos.Y > drop.AbsolutePosition.Y + drop.AbsoluteSize.Y then
									closeDropdown()
									conn:Disconnect()
								end
							end
						end)
					end
				end)
			end
			
			function section:CreateTextbox(labelText, placeholder, callback)
				local boxLabel = Instance.new("TextLabel")
				boxLabel.Size = UDim2.new(1, 0, 0, 20)
				boxLabel.BackgroundTransparency = 1
				boxLabel.Text = labelText
				boxLabel.TextColor3 = CurrentTheme.Text
				boxLabel.Font = Enum.Font.Gotham
				boxLabel.TextSize = 16
				boxLabel.Parent = contentFrame
				
				local textbox = Instance.new("TextBox")
				textbox.Size = UDim2.new(1, 0, 0, 60)
				textbox.BackgroundColor3 = CurrentTheme.Button
				textbox.PlaceholderText = placeholder
				textbox.TextColor3 = CurrentTheme.Text
				textbox.Font = Enum.Font.Gotham
				textbox.TextSize = 16
				textbox.MultiLine = true
				textbox.TextWrapped = true
				textbox.ClearTextOnFocus = false
				textbox.Parent = contentFrame
				local tc = createUICorner(6)
				if tc then tc.Parent = textbox end
				
				textbox.FocusLost:Connect(function(enterPressed)
					if enterPressed then
						local success, err = pcall(function() callback(textbox.Text) end)
						if not success then notifyError("Textbox error: " .. tostring(err)) end
					end
				end)
			end
			
			function section:CreateKeybind(labelText, defaultKey, callback)
				local bindLabel = Instance.new("TextLabel")
				bindLabel.Size = UDim2.new(1, 0, 0, 20)
				bindLabel.BackgroundTransparency = 1
				bindLabel.Text = labelText .. ": " .. tostring(defaultKey.Name)
				bindLabel.TextColor3 = CurrentTheme.Text
				bindLabel.Font = Enum.Font.Gotham
				bindLabel.TextSize = 16
				bindLabel.Parent = contentFrame
				
				local currentKey = defaultKey
				bindLabel.InputBegan:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.Backspace then
						local connection
						connection = UserInputService.InputBegan:Connect(function(newInput)
							if newInput.UserInputType == Enum.UserInputType.Keyboard then
								currentKey = newInput.KeyCode
								bindLabel.Text = labelText .. ": " .. tostring(currentKey.Name)
								local success, err = pcall(function() callback(currentKey) end)
								if not success then notifyError("Keybind error: " .. tostring(err)) end
								connection:Disconnect()
							end
						end)
					end
				end)
			end
			
			function section:CreateColorPicker(labelText, defaultColor, callback)
				local pickerLabel = Instance.new("TextLabel")
				pickerLabel.Size = UDim2.new(1, 0, 0, 20)
				pickerLabel.BackgroundTransparency = 1
				pickerLabel.Text = labelText
				pickerLabel.TextColor3 = CurrentTheme.Text
				pickerLabel.Font = Enum.Font.Gotham
				pickerLabel.TextSize = 16
				pickerLabel.Parent = contentFrame
				
				local colorBtn = Instance.new("TextButton")
				colorBtn.Size = UDim2.new(1, 0, 0, 30)
				colorBtn.BackgroundColor3 = defaultColor
				colorBtn.Text = ""
				colorBtn.Parent = contentFrame
				local cc = createUICorner(6)
				if cc then cc.Parent = colorBtn end
				
				colorBtn.MouseButton1Click:Connect(function()
					-- Advanced palette: open a palette frame
					local palette = Instance.new("Frame")
					palette.Size = UDim2.new(0, 200, 0, 80)
					palette.Position = colorBtn.AbsolutePosition + Vector2.new(0, colorBtn.AbsoluteSize.Y)
					palette.BackgroundColor3 = CurrentTheme.Section
					palette.Parent = PlayerGui
					local pc = createUICorner(6)
					if pc then pc.Parent = palette end
					
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
						local success, err = pcall(function()
							local cc = createUICorner(4)
							if cc then cc.Parent = clrBtn end
						end)
						clrBtn.MouseButton1Click:Connect(function()
							colorBtn.BackgroundColor3 = clr
							local s, e = pcall(function() callback(clr) end)
							if not s then notifyError("ColorPicker error: " .. tostring(e)) end
							palette:Destroy()
						end)
					end
					delay(5, function()
						if palette and palette.Parent then palette:Destroy() end
					end)
				end)
			end
			
			function section:CreateLabel(text)
				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(1, 0, 0, 20)
				label.BackgroundTransparency = 1
				label.Text = text
				label.TextColor3 = CurrentTheme.Text
				label.Font = Enum.Font.Gotham
				label.TextSize = 16
				label.Parent = contentFrame
			end
			
			-- Additional elements can be added here (e.g., multi-select lists, radial selectors, etc.)
			
			-- Additional element: Checkbox
			function section:CreateCheckbox(text, default, callback)
				local checkbox = Instance.new("TextButton")
				checkbox.Size = UDim2.new(1, 0, 0, 30)
				checkbox.BackgroundColor3 = CurrentTheme.Button
				local state = default or false
				checkbox.Text = (state and "[X] " or "[ ] ") .. text
				checkbox.TextColor3 = CurrentTheme.Text
				checkbox.Font = Enum.Font.Gotham
				checkbox.TextSize = 16
				checkbox.Parent = contentFrame
				local cc = createUICorner(6)
				if cc then cc.Parent = checkbox end
				checkbox.MouseButton1Click:Connect(function()
					state = not state
					checkbox.Text = (state and "[X] " or "[ ] ") .. text
					local s, e = pcall(function() callback(state) end)
					if not s then notifyError("Checkbox error: " .. tostring(e)) end
				end)
			end
			
			-- Additional element: Progress Bar
			function section:CreateProgressBar(text, default, callback)
				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(1, 0, 0, 20)
				label.BackgroundTransparency = 1
				label.Text = text .. ": " .. tostring(default) .. "%"
				label.TextColor3 = CurrentTheme.Text
				label.Font = Enum.Font.Gotham
				label.TextSize = 16
				label.Parent = contentFrame
				
				local bar = Instance.new("Frame")
				bar.Size = UDim2.new(1, 0, 0, 20)
				bar.BackgroundColor3 = CurrentTheme.Button
				bar.Parent = contentFrame
				local bc = createUICorner(6)
				if bc then bc.Parent = bar end
				
				local fill = Instance.new("Frame")
				fill.BackgroundColor3 = CurrentTheme.Accent
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
			
			table.insert(tab.Sections, section)
			return section
		end
		
		table.insert(self.Tabs, tab)
		return tab
	end
	
	-- CreateNotification: A sleek notification system with animation.
	function Library:CreateNotification(title, message, duration)
		local notif = Instance.new("Frame")
		notif.Size = UDim2.new(0, 300, 0, 80)
		notif.Position = UDim2.new(1, -310, 0, 50)
		notif.BackgroundColor3 = CurrentTheme.Button
		notif.Parent = PlayerGui
		local nc = createUICorner(8)
		if nc then nc.Parent = notif end
		
		local tLabel = Instance.new("TextLabel")
		tLabel.Size = UDim2.new(1, 0, 0, 30)
		tLabel.BackgroundTransparency = 1
		tLabel.Text = title
		tLabel.TextColor3 = CurrentTheme.Text
		tLabel.Font = Enum.Font.GothamBold
		tLabel.TextSize = 18
		tLabel.Parent = notif
		
		local mLabel = Instance.new("TextLabel")
		mLabel.Size = UDim2.new(1, 0, 0, 40)
		mLabel.Position = UDim2.new(0, 0, 0, 30)
		mLabel.BackgroundTransparency = 1
		mLabel.Text = message
		mLabel.TextColor3 = CurrentTheme.Text
		mLabel.Font = Enum.Font.Gotham
		mLabel.TextSize = 16
		mLabel.Parent = notif
		
		TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, -310, 0, 100)}):Play()
		delay(duration, function()
			TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1,310,0,100)}):Play()
			wait(0.6)
			notif:Destroy()
		end)
	end
	
	return self
end

return Library
