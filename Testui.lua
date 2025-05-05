local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local UILib = {}
local dragging, dragInput, dragStart, startPos

-- Create main screen GUI
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "SmoothUILib"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Core Functions
local function makeDraggable(frame)
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- CreateWindow
function UILib:CreateWindow(titleText)
	local main = Instance.new("Frame")
	main.Size = UDim2.new(0, 500, 0, 300)
	main.Position = UDim2.new(0.5, -250, 0.5, -150)
	main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	main.BorderSizePixel = 0
	main.ClipsDescendants = true
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.Parent = ScreenGui
	main.BackgroundTransparency = 1

	local round = Instance.new("UICorner", main)
	round.CornerRadius = UDim.new(0, 12)

	local shadow = Instance.new("ImageLabel", main)
	shadow.Image = "rbxassetid://1316045217"
	shadow.ImageTransparency = 0.4
	shadow.Size = UDim2.new(1, 60, 1, 60)
	shadow.Position = UDim2.new(0.5, -30, 0.5, -30)
	shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	shadow.BackgroundTransparency = 1
	shadow.ZIndex = 0

	local title = Instance.new("TextLabel", main)
	title.Text = titleText or "Smooth UI"
	title.Font = Enum.Font.GothamBold
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 20
	title.BackgroundTransparency = 1
	title.Position = UDim2.new(0, 10, 0, 10)
	title.Size = UDim2.new(1, -20, 0, 30)
	title.TextXAlignment = Enum.TextXAlignment.Left

	local tabsHolder = Instance.new("Frame", main)
	tabsHolder.Position = UDim2.new(0, 0, 0, 50)
	tabsHolder.Size = UDim2.new(0, 130, 1, -50)
	tabsHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Instance.new("UICorner", tabsHolder).CornerRadius = UDim.new(0, 8)

	local tabList = Instance.new("UIListLayout", tabsHolder)
	tabList.Padding = UDim.new(0, 6)
	tabList.SortOrder = Enum.SortOrder.LayoutOrder

	local contentHolder = Instance.new("Frame", main)
	contentHolder.Position = UDim2.new(0, 140, 0, 50)
	contentHolder.Size = UDim2.new(1, -150, 1, -60)
	contentHolder.BackgroundTransparency = 1

	local function switchToTab(tabFrame)
		for _, v in ipairs(contentHolder:GetChildren()) do
			if v:IsA("Frame") then
				v.Visible = false
			end
		end
		tabFrame.Visible = true
	end

	local windowAPI = {}

	function windowAPI:CreateTab(tabName)
		local tabButton = Instance.new("TextButton", tabsHolder)
		tabButton.Text = tabName
		tabButton.Size = UDim2.new(1, -10, 0, 30)
		tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		tabButton.Font = Enum.Font.Gotham
		tabButton.TextSize = 14
		tabButton.BorderSizePixel = 0
		tabButton.AutoButtonColor = false
		Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 6)

		local tabFrame = Instance.new("Frame", contentHolder)
		tabFrame.Name = tabName .. "_Content"
		tabFrame.Size = UDim2.new(1, 0, 1, 0)
		tabFrame.BackgroundTransparency = 1
		tabFrame.Visible = false

		tabButton.MouseEnter:Connect(function()
			TweenService:Create(tabButton, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(55, 55, 55)
			}):Play()
		end)

		tabButton.MouseLeave:Connect(function()
			TweenService:Create(tabButton, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			}):Play()
		end)

		tabButton.MouseButton1Click:Connect(function()
			switchToTab(tabFrame)
		end)

		if #contentHolder:GetChildren() == 1 then
			switchToTab(tabFrame)
		end

		local tabAPI = {}

		function tabAPI:GetFrame()
			return tabFrame
		end

		return tabAPI
	end

	-- Opening animation
	main.Position = UDim2.new(0.5, -250, 0.5, -400)
	main.BackgroundTransparency = 1
	TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
		Position = UDim2.new(0.5, -250, 0.5, -150),
		BackgroundTransparency = 0
	}):Play()

	makeDraggable(main)
	return windowAPI
end

return UILib
