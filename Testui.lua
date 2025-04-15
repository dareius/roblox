--[[ 
  Custom Roblox UI Library - Enhanced Version with ColorPicker, MultiDropdown
  Features: Theme Selection, UI Scaling, Animations, MultiDropdown, ColorPicker, Notify, Paragraphs, Dropdowns
  Compatible with most Executors (Synapse, Fluxus, KRNL, etc.)
]]

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Library = {}
Library.__index = Library

local Themes = {
  Default = {
    Background = Color3.fromRGB(30, 30, 30),
    TopBar = Color3.fromRGB(40, 40, 40),
    Text = Color3.fromRGB(255, 255, 255),
    Button = Color3.fromRGB(60, 60, 60),
    ButtonHover = Color3.fromRGB(80, 80, 80),
    Accent = Color3.fromRGB(0, 120, 255)
  },
  Dark = {
    Background = Color3.fromRGB(20, 20, 20),
    TopBar = Color3.fromRGB(35, 35, 35),
    Text = Color3.fromRGB(255, 255, 255),
    Button = Color3.fromRGB(45, 45, 45),
    ButtonHover = Color3.fromRGB(65, 65, 65),
    Accent = Color3.fromRGB(255, 105, 180)
  },
  Light = {
    Background = Color3.fromRGB(240, 240, 240),
    TopBar = Color3.fromRGB(200, 200, 200),
    Text = Color3.fromRGB(10, 10, 10),
    Button = Color3.fromRGB(210, 210, 210),
    ButtonHover = Color3.fromRGB(180, 180, 180),
    Accent = Color3.fromRGB(0, 140, 255)
  }
}

function Library:CreateWindow(options)
  options = options or {}
  local theme = Themes[options.Theme or "Default"]
  local scale = options.Scale or 1
  local title = options.Title or "UI Library"

  local ScreenGui = Instance.new("ScreenGui")
  ScreenGui.Name = "CustomUILib"
  ScreenGui.ResetOnSpawn = false
  ScreenGui.Parent = game:GetService("CoreGui")

  local Main = Instance.new("Frame")
  Main.Size = UDim2.new(0, 400 * scale, 0, 300 * scale)
  Main.Position = UDim2.new(0.5, -200 * scale, 0.5, -150 * scale)
  Main.BackgroundColor3 = theme.Background
  Main.BorderSizePixel = 0
  Main.ClipsDescendants = true
  Main.AnchorPoint = Vector2.new(0.5, 0.5)
  Main.Parent = ScreenGui

  local Corner = Instance.new("UICorner", Main)
  Corner.CornerRadius = UDim.new(0, 12)

  local TopBar = Instance.new("TextLabel")
  TopBar.Size = UDim2.new(1, 0, 0, 40 * scale)
  TopBar.BackgroundColor3 = theme.TopBar
  TopBar.Text = title
  TopBar.TextColor3 = theme.Text
  TopBar.Font = Enum.Font.GothamBold
  TopBar.TextSize = 20 * scale
  TopBar.Name = "TopBar"
  TopBar.Parent = Main
  Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

  local UIListLayout = Instance.new("UIListLayout")
  UIListLayout.Parent = Main
  UIListLayout.Padding = UDim.new(0, 6 * scale)
  UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
  UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
  UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

  -- Open animation
  Main.Size = UDim2.new(0, 0, 0, 0)
  TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 400 * scale, 0, 300 * scale)
  }):Play()

  local Window = {}

  function Window:CreateTab(name)
    local TabFrame = Instance.new("Frame")
    TabFrame.Name = name .. "Tab"
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1, -12 * scale, 1, -60 * scale)
    TabFrame.LayoutOrder = 2
    TabFrame.Parent = Main

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = TabFrame
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 6 * scale)

    local Tab = {}

    function Tab:CreateButton(data)
      local Btn = Instance.new("TextButton")
      Btn.Size = UDim2.new(1, 0, 0, 30 * scale)
      Btn.BackgroundColor3 = theme.Button
      Btn.Text = data.Name
      Btn.Font = Enum.Font.Gotham
      Btn.TextSize = 14 * scale
      Btn.TextColor3 = theme.Text
      Btn.Parent = TabFrame
      Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

      Btn.MouseEnter:Connect(function()
        Btn.BackgroundColor3 = theme.ButtonHover
      end)
      Btn.MouseLeave:Connect(function()
        Btn.BackgroundColor3 = theme.Button
      end)
      Btn.MouseButton1Click:Connect(function()
        data.Callback()
      end)
    end

    function Tab:CreateDropdown(data)
      local Drop = Instance.new("TextButton")
      Drop.Size = UDim2.new(1, 0, 0, 30 * scale)
      Drop.BackgroundColor3 = theme.Button
      Drop.Text = data.Name .. " ▼"
      Drop.Font = Enum.Font.Gotham
      Drop.TextSize = 14 * scale
      Drop.TextColor3 = theme.Text
      Drop.Parent = TabFrame
      Instance.new("UICorner", Drop).CornerRadius = UDim.new(0, 8)

      local Opened = false

      local List = Instance.new("Frame")
      List.Size = UDim2.new(1, 0, 0, #data.Options * 25 * scale)
      List.BackgroundColor3 = theme.Button
      List.Visible = false
      List.Parent = TabFrame

      local Layout = Instance.new("UIListLayout")
      Layout.Parent = List
      Layout.SortOrder = Enum.SortOrder.LayoutOrder

      for _, opt in ipairs(data.Options) do
        local Btn = Instance.new("TextButton")
        Btn.Text = opt
        Btn.Size = UDim2.new(1, 0, 0, 25 * scale)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 12 * scale
        Btn.TextColor3 = theme.Text
        Btn.BackgroundColor3 = theme.ButtonHover
        Btn.Parent = List
        Btn.MouseButton1Click:Connect(function()
          data.Callback(opt)
        end)
      end

      Drop.MouseButton1Click:Connect(function()
        Opened = not Opened
        List.Visible = Opened
      end)
    end

    function Tab:CreateMultiDropdown(data)
      local Drop = Instance.new("TextButton")
      Drop.Size = UDim2.new(1, 0, 0, 30 * scale)
      Drop.BackgroundColor3 = theme.Button
      Drop.Text = data.Name .. " ▼"
      Drop.Font = Enum.Font.Gotham
      Drop.TextSize = 14 * scale
      Drop.TextColor3 = theme.Text
      Drop.Parent = TabFrame
      Instance.new("UICorner", Drop).CornerRadius = UDim.new(0, 8)

      local Opened = false

      local List = Instance.new("Frame")
      List.Size = UDim2.new(1, 0, 0, #data.Options * 25 * scale)
      List.BackgroundColor3 = theme.Button
      List.Visible = false
      List.Parent = TabFrame

      local Layout = Instance.new("UIListLayout")
      Layout.Parent = List
      Layout.SortOrder = Enum.SortOrder.LayoutOrder

      local selectedOptions = {}

      for _, opt in ipairs(data.Options) do
        local Btn = Instance.new("TextButton")
        Btn.Text = opt
        Btn.Size = UDim2.new(1, 0, 0, 25 * scale)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 12 * scale
        Btn.TextColor3 = theme.Text
        Btn.BackgroundColor3 = theme.ButtonHover
        Btn.Parent = List
        Btn.MouseButton1Click:Connect(function()
          selectedOptions[opt] = not selectedOptions[opt]
          Btn.BackgroundColor3 = selectedOptions[opt] and theme.Accent or theme.ButtonHover
          data.Callback(opt, selectedOptions[opt])
        end)
      end

      Drop.MouseButton1Click:Connect(function()
        Opened = not Opened
        List.Visible = Opened
      end)
    end

    function Tab:CreateColorPicker(data)
      local ColorPicker = Instance.new("TextButton")
      ColorPicker.Size = UDim2.new(1, 0, 0, 30 * scale)
      ColorPicker.BackgroundColor3 = theme.Button
      ColorPicker.Text = data.Name
      ColorPicker.Font = Enum.Font.Gotham
      ColorPicker.TextSize = 14 * scale
      ColorPicker.TextColor3 = theme.Text
      ColorPicker.Parent = TabFrame
      Instance.new("UICorner", ColorPicker).CornerRadius = UDim.new(0, 8)

      local colorButton = Instance.new("TextButton")
      colorButton.Size = UDim2.new(0, 40 * scale, 0, 25 * scale)
      colorButton.BackgroundColor3 = data.Color or theme.Accent
      colorButton.Text = ""
      colorButton.Font = Enum.Font.Gotham
      colorButton.TextSize = 14 * scale
      colorButton.Parent = ColorPicker
      Instance.new("UICorner", colorButton).CornerRadius = UDim.new(0, 8)

      colorButton.MouseButton1Click:Connect(function()
        local colorPickerFrame = Instance.new("Frame")
        colorPickerFrame.Size = UDim2.new(0, 200 * scale, 0, 200 * scale)
        colorPickerFrame.Position = UDim2.new(0.5, -100 * scale, 0.5, -100 * scale)
        colorPickerFrame.BackgroundColor3 = theme.Background
        colorPickerFrame.BorderSizePixel = 0
        colorPickerFrame.Parent = ScreenGui
        Instance.new("UICorner", colorPickerFrame).CornerRadius = UDim.new(0, 12)

        local closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0, 30 * scale, 0, 30 * scale)
        closeButton.Position = UDim2.new(1, -40 * scale, 0, 10 * scale)
        closeButton.Text = "X"
        closeButton.Font = Enum.Font.GothamBold
        closeButton.TextSize = 18 * scale
        closeButton.TextColor3 = theme.Text
        closeButton.BackgroundColor3 = theme.Button
        closeButton.BorderSizePixel = 0
        closeButton.Parent = colorPickerFrame
        closeButton.MouseButton1Click:Connect(function()
          colorPickerFrame:Destroy()
        end)

        local colorBox = Instance.new("Frame")
        colorBox.Size = UDim2.new(0, 180 * scale, 0, 120 * scale)
        colorBox.Position = UDim2.new(0, 10 * scale, 0, 40 * scale)
        colorBox.BackgroundColor3 = theme.Background
        colorBox.Parent = colorPickerFrame
        Instance.new("UICorner", colorBox).CornerRadius = UDim.new(0, 6)

        -- Color Selection Logic
        local hueSlider = Instance.new("Frame")
        hueSlider.Size = UDim2.new(0, 180 * scale, 0, 10 * scale)
        hueSlider.Position = UDim2.new(0, 10 * scale, 0, 10 * scale)
        hueSlider.BackgroundColor3 = theme.Accent
        hueSlider.Parent = colorBox

        local selectedColor = Instance.new("Frame")
        selectedColor.Size = UDim2.new(0, 10 * scale, 0, 10 * scale)
        selectedColor.Position = UDim2.new(0, 0, 0, 0)
        selectedColor.BackgroundColor3 = data.Color or theme.Accent
        selectedColor.Parent = hueSlider

        local dragging = false
        hueSlider.InputBegan:Connect(function(input)
          if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
          end
        end)

        hueSlider.InputChanged:Connect(function(input)
          if dragging then
            local newPos = math.clamp(input.Position.X - hueSlider.Position.X.Offset, 0, hueSlider.Size.X.Offset)
            selectedColor.Position = UDim2.new(0, newPos, 0, 0)
            local hue = newPos / hueSlider.Size.X.Offset
            local newColor = Color3.fromHSV(hue, 1, 1)
            colorButton.BackgroundColor3 = newColor
            data.Color = newColor
          end
        end)

        hueSlider.InputEnded:Connect(function(input)
          if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
          end
        end)
      end)
    end

    function Tab:CreateNotify(message, duration)
      duration = duration or 3
      local notificationFrame = Instance.new("Frame")
      notificationFrame.Size = UDim2.new(0, 200 * scale, 0, 50 * scale)
      notificationFrame.Position = UDim2.new(0.5, -100 * scale, 0, 10 * scale)
      notificationFrame.BackgroundColor3 = theme.Accent
      notificationFrame.BorderSizePixel = 0
      notificationFrame.Parent = ScreenGui
      Instance.new("UICorner", notificationFrame).CornerRadius = UDim.new(0, 8)

      local notifyLabel = Instance.new("TextLabel")
      notifyLabel.Size = UDim2.new(1, 0, 1, 0)
      notifyLabel.Text = message
      notifyLabel.Font = Enum.Font.Gotham
      notifyLabel.TextSize = 14 * scale
      notifyLabel.TextColor3 = theme.Text
      notifyLabel.BackgroundTransparency = 1
      notifyLabel.Parent = notificationFrame

      local fadeOutTween = TweenService:Create(notificationFrame, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -100 * scale, 0, -60 * scale)
      })
      fadeOutTween:Play()

      fadeOutTween.Completed:Connect(function()
        notificationFrame:Destroy()
      end)
    end

    return Tab
  end

  return Window
end
