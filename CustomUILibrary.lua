--// CustomUILibrary.lua
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Library = {}
Library.__index = Library

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
	["Forest"] = {
		Background = Color3.fromRGB(15,40,15),
		Accent = Color3.fromRGB(50,205,50),
		Text = Color3.fromRGB(230,255,230),
		Section = Color3.fromRGB(25,55,25),
		Button = Color3.fromRGB(35,75,35),
	},
	["Candy"] = {
		Background = Color3.fromRGB(255,182,193),
		Accent = Color3.fromRGB(255,105,180),
		Text = Color3.fromRGB(255,255,255),
		Section = Color3.fromRGB(255,160,182),
		Button = Color3.fromRGB(255,130,158),
	},
	["Fire"] = {
		Background = Color3.fromRGB(50,0,0),
		Accent = Color3.fromRGB(255,69,0),
		Text = Color3.fromRGB(255,210,180),
		Section = Color3.fromRGB(80,0,0),
		Button = Color3.fromRGB(100,20,20),
	},
	["Ice"] = {
		Background = Color3.fromRGB(200,230,255),
		Accent = Color3.fromRGB(100,180,255),
		Text = Color3.fromRGB(20,20,40),
		Section = Color3.fromRGB(180,210,255),
		Button = Color3.fromRGB(160,190,255),
	},
	["Matrix"] = {
		Background = Color3.fromRGB(0,0,0),
		Accent = Color3.fromRGB(0,255,70),
		Text = Color3.fromRGB(0,255,0),
		Section = Color3.fromRGB(10,10,10),
		Button = Color3.fromRGB(20,20,20),
	},
	["Aurora"] = {
		Background = Color3.fromRGB(25,0,40),
		Accent = Color3.fromRGB(100,0,150),
		Text = Color3.fromRGB(230,230,255),
		Section = Color3.fromRGB(40,10,60),
		Button = Color3.fromRGB(60,20,80),
	},
	["Nebula"] = {
		Background = Color3.fromRGB(10,10,20),
		Accent = Color3.fromRGB(150,0,150),
		Text = Color3.fromRGB(200,200,255),
		Section = Color3.fromRGB(20,20,40),
		Button = Color3.fromRGB(30,30,50),
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
				local state = default or false
				toggle.Text = text .. ": " .. (state and "ON" or "OFF")
				toggle.TextColor3 = CurrentTheme.Text
				toggle.Font = Enum.Font.Gotham
				toggle.TextSize = 14
				toggle.Parent = container
				createUICorner(6).Parent = toggle
				toggle.MouseButton1Click:Connect(function()
					state = not state
					toggle.Text = text .. ": " .. (state and "ON" or "OFF")
					callback(state)
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

				local slider = Instance.new("Frame")
				slider.Size = UDim2.new(1, -10, 0, 20)
				slider.BackgroundColor3 = CurrentTheme.Button
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
				slider.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						local rel = math.clamp(input.Position.X - slider.AbsolutePosition.X, 0, slider.AbsoluteSize.X)
						local pct = rel / slider.AbsoluteSize.X
						TweenService:Create(fill, TweenInfo.new(0.1), {Size = UDim2.new(pct, 0, 1, 0)}):Play()
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
							opt.Size = UDim2.new(1, -10, 0, 30)
							opt.BackgroundColor3 = CurrentTheme.Section
							opt.Text = tostring(item)
							opt.TextColor3 = CurrentTheme.Text
							opt.Font = Enum.Font.Gotham
							opt.TextSize = 13
							opt.Parent = container
							opt.LayoutOrder = i + 100
							createUICorner(6).Parent = opt
							opt.MouseButton1Click:Connect(function()
								drop.Text = title .. ": " .. tostring(item)
								callback(item)
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
				boxLabel.Size = UDim2.new(1, -10, 0, 20)
				boxLabel.BackgroundTransparency = 1
				boxLabel.Text = labelText
				boxLabel.TextColor3 = CurrentTheme.Text
				boxLabel.Font = Enum.Font.Gotham
				boxLabel.TextSize = 14
				boxLabel.Parent = container

				local textbox = Instance.new("TextBox")
				textbox.Size = UDim2.new(1, -10, 0, 30)
				textbox.BackgroundColor3 = CurrentTheme.Button
				textbox.PlaceholderText = placeholder
				textbox.TextColor3 = CurrentTheme.Text
				textbox.Font = Enum.Font.Gotham
				textbox.TextSize = 14
				textbox.Parent = container
				createUICorner(6).Parent = textbox

				textbox.FocusLost:Connect(function(enterPressed)
					if enterPressed then
						callback(textbox.Text)
					end
				end)
			end

			function section:CreateKeybind(labelText, defaultKey, callback)
				local bindLabel = Instance.new("TextLabel")
				bindLabel.Size = UDim2.new(1, -10, 0, 20)
				bindLabel.BackgroundTransparency = 1
				bindLabel.Text = labelText .. ": " .. tostring(defaultKey.Name)
				bindLabel.TextColor3 = CurrentTheme.Text
				bindLabel.Font = Enum.Font.Gotham
				bindLabel.TextSize = 14
				bindLabel.Parent = container

				local currentKey = defaultKey
				bindLabel.InputBegan:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.Backspace then
						local connection
						connection = UserInputService.InputBegan:Connect(function(newInput)
							if newInput.UserInputType == Enum.UserInputType.Keyboard then
								currentKey = newInput.KeyCode
								bindLabel.Text = labelText .. ": " .. tostring(currentKey.Name)
								callback(currentKey)
								connection:Disconnect()
							end
						end)
					end
				end)
			end

			function section:CreateColorPicker(labelText, defaultColor, callback)
				local pickerLabel = Instance.new("TextLabel")
				pickerLabel.Size = UDim2.new(1, -10, 0, 20)
				pickerLabel.BackgroundTransparency = 1
				pickerLabel.Text = labelText
				pickerLabel.TextColor3 = CurrentTheme.Text
				pickerLabel.Font = Enum.Font.Gotham
				pickerLabel.TextSize = 14
				pickerLabel.Parent = container

				local colorBtn = Instance.new("TextButton")
				colorBtn.Size = UDim2.new(1, -10, 0, 30)
				colorBtn.BackgroundColor3 = defaultColor
				colorBtn.Text = \"\"
				colorBtn.Parent = container
				createUICorner(6).Parent = colorBtn

				colorBtn.MouseButton1Click:Connect(function()
					callback(colorBtn.BackgroundColor3)
				end)
			end

			function section:CreateLabel(text)
				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(1, -10, 0, 20)
				label.BackgroundTransparency = 1
				label.Text = text
				label.TextColor3 = CurrentTheme.Text
				label.Font = Enum.Font.Gotham
				label.TextSize = 14
				label.Parent = container
			end

			table.insert(tab.Sections, section)
			return section
		end

		table.insert(self.Tabs, tab)
		return tab
	end

	function Library:CreateNotification(title, message, duration)
		local notif = Instance.new("Frame")
		notif.Size = UDim2.new(0, 300, 0, 80)
		notif.Position = UDim2.new(1, -310, 0, 50)
		notif.BackgroundColor3 = CurrentTheme.Button
		notif.Parent = PlayerGui
		createUICorner(8).Parent = notif

		local tLabel = Instance.new("TextLabel")
		tLabel.Size = UDim2.new(1, 0, 0, 30)
		tLabel.BackgroundTransparency = 1
		tLabel.Text = title
		tLabel.TextColor3 = CurrentTheme.Text
		tLabel.Font = Enum.Font.GothamBold
		tLabel.TextSize = 16
		tLabel.Parent = notif

		local mLabel = Instance.new("TextLabel")
		mLabel.Size = UDim2.new(1, 0, 0, 40)
		mLabel.Position = UDim2.new(0, 0, 0, 30)
		mLabel.BackgroundTransparency = 1
		mLabel.Text = message
		mLabel.TextColor3 = CurrentTheme.Text
		mLabel.Font = Enum.Font.Gotham
		mLabel.TextSize = 14
		mLabel.Parent = notif

		TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, -310, 0, 100)}):Play()
		delay(duration, function()
			TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, 310, 0, 100)}):Play()
			wait(0.6)
			notif:Destroy()
		end)
	end

	return self
end

return Library
