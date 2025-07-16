-- Void UI Library Module
local Void = {}

-- Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Create a window
function Void:CreateWin(settings)
	-- Validate settings
	if not settings or type(settings) ~= "table" then
		error("Void:CreateWin requires a settings table")
	end

	-- Default settings
	local defaultSettings = {
		Title = "Void UI",
		Version = "1.0.0",
		Size = UDim2.new(0.6, 0, 0.7, 0),
	}

	-- Merge defaults
	for key, value in pairs(defaultSettings) do
		if settings[key] == nil then
			settings[key] = value
		end
	end

	-- ScreenGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "VoidUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui", 5)

	-- Main Window
	local window = Instance.new("Frame")
	window.Name = "Window"
	window.Size = settings.Size
	window.Position = UDim2.new(0.2, 0, 0.15, 0)
	window.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	window.BorderSizePixel = 0
	window.Parent = screenGui

	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 8)
	uiCorner.Parent = window

	-- Title
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Size = UDim2.new(0, 200, 0, 24)
	titleLabel.Position = UDim2.new(0, 10, 0, 10)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = settings.Title
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 18
	titleLabel.Font = Enum.Font.SourceSansBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = window

	-- Version
	local versionLabel = Instance.new("TextLabel")
	versionLabel.Name = "Version"
	versionLabel.Size = UDim2.new(0, 200, 0, 16)
	versionLabel.Position = UDim2.new(0, 10, 0, 34)
	versionLabel.BackgroundTransparency = 1
	versionLabel.Text = "v" .. settings.Version
	versionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
	versionLabel.TextSize = 14
	versionLabel.Font = Enum.Font.SourceSans
	versionLabel.TextXAlignment = Enum.TextXAlignment.Left
	versionLabel.Parent = window

	-- Divider
	local divider = Instance.new("Frame")
	divider.Name = "Divider"
	divider.Size = UDim2.new(1, 0, 0, 1)
	divider.Position = UDim2.new(0, 0, 0, 60)
	divider.BackgroundTransparency = 1
	divider.BorderSizePixel = 0
	divider.Parent = window

	-- Tab Container
	local tabContainer = Instance.new("Frame")
	tabContainer.Name = "TabContainer"
	tabContainer.Size = UDim2.new(0, 150, 1, -70)
	tabContainer.Position = UDim2.new(0, 10, 0, 70)
	tabContainer.BackgroundTransparency = 1
	tabContainer.Parent = window

	local tabLayout = Instance.new("UIListLayout")
	tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabLayout.Padding = UDim.new(0, 5)
	tabLayout.Parent = tabContainer

	-- Draggable
	local dragging, dragInput, dragStart, startPos
	local function updateInput(input)
		local delta = input.Position - dragStart
		window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	window.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = window.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	window.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			updateInput(input)
		end
	end)

	-- Tab Handling
	local tabs = {}
	local currentTab = nil

	-- AddTab function
	local function AddTab(tabName)
		local tabButton = Instance.new("TextButton")
		tabButton.Name = tabName
		tabButton.Size = UDim2.new(1, 0, 0, 30)
		tabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		tabButton.Text = tabName
		tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		tabButton.TextSize = 16
		tabButton.Font = Enum.Font.SourceSans
		tabButton.Parent = tabContainer

		local tabCorner = Instance.new("UICorner")
		tabCorner.CornerRadius = UDim.new(0, 4)
		tabCorner.Parent = tabButton

		local tabContent = Instance.new("Frame")
		tabContent.Name = tabName .. "Content"
		tabContent.Size = UDim2.new(1, -170, 1, -70)
		tabContent.Position = UDim2.new(0, 160, 0, 70)
		tabContent.BackgroundTransparency = 1
		tabContent.Visible = false
		tabContent.Parent = window

		local tabLayout = Instance.new("UIListLayout")
		tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
		tabLayout.Padding = UDim.new(0, 5)
		tabLayout.Parent = tabContent

		tabs[tabName] = {
			Button = tabButton,
			Content = tabContent,
		}

		tabButton.MouseButton1Click:Connect(function()
			if currentTab ~= tabName then
				if currentTab then
					tabs[currentTab].Content.Visible = false
					tabs[currentTab].Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				end
				tabContent.Visible = true
				tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				currentTab = tabName
			end
		end)

		if not currentTab then
			currentTab = tabName
			tabContent.Visible = true
			tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		end

		return tabContent
	end

	-- Return API
	return {
		Window = window,
		ScreenGui = screenGui,
		AddTab = AddTab
	}
end

return Void
