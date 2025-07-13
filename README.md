
# Orion UI Library (Deluxe Dark Edition)

This is a mobile-compatible, deluxe-themed version of the Orion UI Library with all borders and dividers removed. This version includes complete support for mobile drag, sliders, and colorpickers.

---

## ðŸªŸ Creating a Window

```lua
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dareius/roblox/refs/heads/main/Test.lua"))()

local Window = OrionLib:MakeWindow({
    Name = "My UI",
    SaveConfig = true,
    ConfigFolder = "MyConfigFolder"
})
```

### Window Options:
- `Name` (string): UI window title
- `SaveConfig` (boolean): Enables auto-saving of toggles/sliders/etc.
- `ConfigFolder` (string): Folder name for config files

---

## ðŸ“ Adding a Tab

```lua
local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://7734053494"
})
```

### Tab Options:
- `Name` (string): Tab name
- `Icon` (string): Optional Roblox asset ID

---

## ðŸ”˜ Tab:AddToggle

```lua
local Toggle = Tab:AddToggle({
    Name = "Enable ESP",
    Default = false,
    Callback = function(Value)
        print("Toggle State:", Value)
    end,
    Flag = "ESP_Toggle",
    Save = true
})
```

### Toggle Supports:
- `Set(value: boolean)`: Change toggle state programmatically

---

## ðŸŽšï¸ Tab:AddSlider

```lua
local Slider = Tab:AddSlider({
    Name = "Walkspeed",
    Min = 10,
    Max = 100,
    Default = 16,
    Increment = 1,
    ValueName = "WS",
    Callback = function(value)
        print("Slider changed to:", value)
    end,
    Flag = "WalkspeedSlider",
    Save = true
})
```

### Slider Supports:
- `Set(value: number)`: Set slider value programmatically

---

## ðŸ”½ Tab:AddDropdown

```lua
local Dropdown = Tab:AddDropdown({
    Name = "Select Weapon",
    Options = {"Sword", "Gun", "Bow"},
    Default = "Sword",
    Callback = function(option)
        print("Selected:", option)
    end,
    Flag = "WeaponDropdown",
    Save = true
})
```

### Dropdown Supports:
- `Set(option: string)`: Set selected option
- `Refresh(options: table, clear: boolean)`: Refresh dropdown options

---

## âŒ¨ï¸ Tab:AddBind

```lua
local Bind = Tab:AddBind({
    Name = "Activate Ability",
    Default = Enum.KeyCode.Q,
    Hold = false,
    Callback = function()
        print("Key pressed!")
    end,
    Flag = "AbilityBind",
    Save = true
})
```

### Bind Supports:
- `Set(Enum.KeyCode or Enum.UserInputType)`

---

## ðŸ“ Tab:AddTextbox

```lua
Tab:AddTextbox({
    Name = "Enter Name",
    Default = "",
    TextDisappear = true,
    Callback = function(text)
        print("Text:", text)
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

### Colorpicker Supports:
- `Set(Color3)`

---

## ðŸ·ï¸ Tab:AddLabel

```lua
local Label = Tab:AddLabel("This is a label")
Label:Set("New text")
```

---

## ðŸ“„ Tab:AddParagraph

```lua
local Paragraph = Tab:AddParagraph("Title", "This is paragraph content.")
Paragraph:Set("Updated content.")
```

---

## ðŸ”” Notifications

```lua
OrionLib:MakeNotification({
    Name = "Success",
    Content = "Loaded successfully!",
    Image = "rbxassetid://7733911829",
    Time = 5
})
```

---

## ðŸ§  Notes

- All elements with `Flag` + `Save = true` will auto-save and load across sessions.
- You can call `OrionLib:Init()` to trigger config loading manually.

---

## ðŸ–±ï¸ Mobile Support

- âœ… Dragging
- âœ… Slider dragging
- âœ… Colorpicker are actually broken
- âœ… Tap toggles/buttons

---

Enjoy your smooth, modern UI with mobile-friendly controls.
