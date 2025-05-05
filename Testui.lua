--[[
	UILib v2 - Sleek, glowing, animated UI library
	By ChatGPT for user with perfect visuals in mind
--]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local UILib = {}
local dragging, dragInput, dragStart, startPos

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

function UILib:CreateWindow(titleText)
	local ScreenGui = Instance.new("ScreenGui", PlayerGui)
	ScreenGui.Name = "SmoothUILib"
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false

	local Main = Instance.new("Frame")
	Main.Name = "MainWindow"
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 550, 0, 350)
	Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Main.BackgroundTransparency = 0.1
	Main.ClipsDescendants = true
	Main.Parent = ScreenGui

	local Corner = Instance.new("UICorner", Main)
	Corner.CornerRadius = UDim.new(0, 12)

	local Shadow = Instance.new("ImageLabel", Main)
	Shadow.Name = "Shadow"
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Size = UDim2.new(1, 60, 1, 60)
	Shadow.ZIndex = 0
	Shadow.Image = "rbxassetid://1316045217"
	Shadow.ImageTransparency = 0.55
	Shadow.BackgroundTransparency = 1

	local Title = Instance.new("TextLabel", Main)
	Title.Text = titleText or "Perfect UI"
	Title.Size = UDim2.new(1, -20, 0, 40)
	Title.Position = UDim2.new(0, 10, 0, 0)
	Title.BackgroundTransparency = 1
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 20
	Title.Font = Enum.Font.GothamBold
	Title.TextXAlignment = Enum.TextXAlignment.Left

	local Tabs = Instance.new("Frame", Main)
	Tabs.Position = UDim2.new(0, 0, 0, 45)
	Tabs.Size = UDim2.new(0, 140, 1, -45)
	Tabs.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Tabs.BackgroundTransparency = 0.05
	Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0, 8)

	local TabList = Instance.new("UIListLayout", Tabs)
	TabList.SortOrder = Enum.SortOrder.LayoutOrder
	TabList.Padding = UDim.new(0, 6)

	local Content = Instance.new("Frame", Main)
	Content.Position = UDim2.new(0, 150, 0, 45)
	Content.Size = UDim2.new(1, -160, 1, -55)
	Content.BackgroundTransparency = 1

	local function switchTab(toFrame)
		for _, v in ipairs(Content:GetChildren()) do
			if v:IsA("Frame") then
				v.Visible = false
			end
		end
		toFrame.Visible = true
	end

	local windowAPI = {}

	function windowAPI:CreateTab(name)
		local tabBtn = Instance.new("TextButton", Tabs)
		tabBtn.Text = name
		tabBtn.Size = UDim2.new(1, -10, 0, 30)
		tabBtn.Position = UDim2.new(0, 5, 0, 0)
		tabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		tabBtn.Font = Enum.Font.Gotham
		tabBtn.TextSize = 14
		tabBtn.BorderSizePixel = 0
		tabBtn.AutoButtonColor = false
		Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)

		local tabFrame = Instance.new("Frame", Content)
		tabFrame.Size = UDim2.new(1, 0, 1, 0)
		tabFrame.BackgroundTransparency = 1
		tabFrame.Visible = false

		local tabList = Instance.new("UIListLayout", tabFrame)
		tabList.Padding = UDim.new(0, 6)
		tabList.SortOrder = Enum.SortOrder.LayoutOrder

		tabBtn.MouseButton1Click:Connect(function()
			switchTab(tabFrame)
		end)

		if #Content:GetChildren() == 1 then
			switchTab(tabFrame)
		end

		local tabAPI = {}

		function tabAPI:AddButton(text, callback)
			local button = Instance.new("TextButton", tabFrame)
			button.Text = text
			button.Size = UDim2.new(1, 0, 0, 30)
			button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			button.TextColor3 = Color3.fromRGB(255, 255, 255)
			button.Font = Enum.Font.Gotham
			button.TextSize = 14
			button.AutoButtonColor = true
			Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

			button.MouseButton1Click:Connect(function()
				pcall(callback)
			end)
		end

		function tabAPI:AddToggle(text, callback)
			local toggle = Instance.new("TextButton", tabFrame)
			toggle.Text = "OFF - " .. text
			toggle.Size = UDim2.new(1, 0, 0, 30)
			toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
			toggle.Font = Enum.Font.Gotham
			toggle.TextSize = 14
			toggle.AutoButtonColor = false
			Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 6)

			local state = false
			toggle.MouseButton1Click:Connect(function()
				state = not state
				toggle.Text = (state and "ON" or "OFF") .. " - " .. text
				pcall(callback, state)
			end)
		end

		return tabAPI
	end

	-- Opening animation
	Main.Position = UDim2.new(0.5, 0, 0.5, -400)
	Main.BackgroundTransparency = 1
	TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
		Position = UDim2.new(0.5, 0, 0.5, 0),
		BackgroundTransparency = 0.1
	}):Play()

	makeDraggable(Main)
	return windowAPI
end

return UILib
