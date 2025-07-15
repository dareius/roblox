# Orion UI Library (Deluxe Dark Edition)

This is a mobile-compatible, deluxe-themed version of the Orion UI Library with all borders and dividers removed. This version includes complete support for mobile drag, sliders, and colorpickers.

---

## ðŸªŸ Creating a Window

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/dareius/roblox/refs/heads/main/Test.lua"))()

local Window = OrionLib:MakeWindow({
    Name = "My UI",
    SaveConfig = true,
    ConfigFolder = "MyConfigFolder"
})
```

---

## ðŸ“ Adding a Tab

```lua
local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://7734053494"
})
```

---

## ðŸ”˜ Tab:AddToggle

```lua
local Toggle = Tab:AddToggle({
    Name = "God Mode",
    Default = false,
    Callback = function(Value)
        print("Toggled:", Value)
    end,
    Flag = "GodToggle",
    Save = true
})
```

### Supports:
- `Toggle:Set(boolean)`: Change the toggle state programmatically

---

## ðŸŽšï¸ Tab:AddSlider

```lua
local Slider = Tab:AddSlider({
    Name = "WalkSpeed",
    Min = 0,
    Max = 100,
    Default = 16,
    Increment = 1,
    ValueName = "Speed",
    Callback = function(value)
        print("Speed set to:", value)
    end,
    Flag = "SpeedSlider",
    Save = true
})
```

### Supports:
- `Slider:Set(number)`: Change slider value dynamically

---

## ðŸ”½ Tab:AddDropdown

```lua
local Dropdown = Tab:AddDropdown({
    Name = "Weapon",
    Options = {"Sword", "Gun", "Bow"},
    Default = "Sword",
    Callback = function(selected)
        print("Selected:", selected)
    end,
    Flag = "WeaponDropdown",
    Save = true
})
```

### Supports:
- `Dropdown:Set(optionName)`: Set the selected option
- `Dropdown:Refresh(optionsTable, clearOld)`: Replace dropdown options

---

## âŒ¨ï¸ Tab:AddBind

```lua
local Bind = Tab:AddBind({
    Name = "Dash",
    Default = Enum.KeyCode.Q,
    Hold = false,
    Callback = function()
        print("Key activated!")
    end,
    Flag = "DashBind",
    Save = true
})
```

### Supports:
- `Bind:Set(KeyCode/UserInputType)`: Set or change the keybind

---

## ðŸ“ Tab:AddTextbox

```lua
Tab:AddTextbox({
    Name = "Enter Username",
    Default = "",
    TextDisappear = true,
    Callback = function(text)
        print("User typed:", text)
    end
})
```

---

## ðŸŽ¨ Tab:AddColorpicker

```lua
local Picker = Tab:AddColorpicker({
    Name = "ESP Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        print("Color:", color)
    end,
    Flag = "ESP_Color",
    Save = true
})
```

### Supports:
- `Picker:Set(Color3)`: Change color programmatically

---

## ðŸ“¦ Tab:AddButton

```lua
local Button = Tab:AddButton({
    Name = "Click Me",
    Callback = function()
        print("Button was clicked!")
    end,
    Icon = "rbxassetid://7733960981"
})
```

### Supports:
- `Button:Set("New Text")`: Change button text

---

## ðŸ·ï¸ Tab:AddLabel

```lua
local Label = Tab:AddLabel("Initial label")
Label:Set("Updated label")
```

---

## ðŸ“„ Tab:AddParagraph

```lua
local Paragraph = Tab:AddParagraph("Title", "This is some content.")
Paragraph:Set("Updated content")
```

---

## ðŸ”” Notifications

```lua
OrionLib:MakeNotification({
    Name = "Alert",
    Content = "Something happened!",
    Image = "rbxassetid://7733911829",
    Time = 5
})
```

---

## âš™ï¸ Config

- Use `Flag = "Name"` and `Save = true` to store element values.
- Call `OrionLib:Init()` to manually load config values.

---

## ðŸ“± Mobile Support

- âœ… Drag and drop window
- âœ… Touch-based slider and colorpicker
- âœ… All buttons, toggles, binds and dropdowns work with mobile touch

---

## ðŸ“‚ Tip

Use `Flag` names to retrieve or manipulate values programmatically from `OrionLib.Flags`.

---

Built with â¤ï¸ for modern executors and mobile compatibility.
