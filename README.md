# ðŸŒ‘ DarknessLib UI Documentation

DarknessLib is a modern, minimal, and mobile-friendly Roblox UI library. Rebranded and redesigned from the ground up for clarity and elegance.

---

## ðŸ“¦ Getting Started

Place the script in your executor or require it as a ModuleScript:
```lua
local DarknessLib = loadstring(game:HttpGet("https://your-cdn-link/darkness_lib.lua"))()
```

---

## ðŸªŸ Create a Window

```lua
local Window = DarknessLib:MakeWindow({
    Name = "My Darkness UI",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "DarknessSettings",
    IntroText = "Welcome!",
    IntroIcon = "rbxassetid://0",
    ShowIcon = true,
    Icon = "rbxassetid://0"
})
```

---

## ðŸ“ Tabs

```lua
local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "Home", -- Use Feather icons
    PremiumOnly = false
})
```

---

## ðŸ§© Elements

### ðŸ”˜ Toggle
```lua
Tab:AddToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Toggle:", state)
    end
})
```

### ðŸ”² Button
```lua
Tab:AddButton({
    Name = "Click Me",
    Callback = function()
        print("Button clicked!")
    end
})
```

### ðŸ“‰ Slider
```lua
Tab:AddSlider({
    Name = "Adjust Value",
    Min = 0,
    Max = 100,
    Increment = 5,
    Default = 50,
    ValueName = "%",
    Callback = function(val)
        print("Slider value:", val)
    end
})
```

### ðŸ“‚ Dropdown
```lua
Tab:AddDropdown({
    Name = "Choose Option",
    Default = "Option 1",
    Options = {"Option 1", "Option 2", "Option 3"},
    Callback = function(opt)
        print("Selected:", opt)
    end
})
```

### âŒ¨ï¸ Textbox
```lua
Tab:AddTextbox({
    Name = "Input Something",
    Default = "",
    TextDisappear = false,
    Callback = function(text)
        print("Input:", text)
    end
})
```

### ðŸ•¹ï¸ Keybind
```lua
Tab:AddBind({
    Name = "Hotkey",
    Default = Enum.KeyCode.RightShift,
    Hold = false,
    Callback = function()
        print("Hotkey triggered")
    end
})
```

---

## ðŸ”” Notifications

```lua
DarknessLib:MakeNotification({
    Name = "Alert!",
    Content = "Something happened.",
    Time = 3
})
```

---

## ðŸ’¾ Saving Configs

If `SaveConfig = true` and a `ConfigFolder` name is provided in `MakeWindow`, toggles and values will be remembered across sessions.

---

## ðŸ“± Mobile Support

Touch input is supported for:
- Dragging the window
- Using sliders and buttons
- Tapping dropdowns

---

## â“ Tips

- Use `rbxassetid://` icons for `IntroIcon` and `Icon`
- Feather icon names work for tabs (e.g. `"Home"`, `"Settings"`, `"Terminal"`)
- Keep element names short and readable

---

Created with ðŸ’€??? by DarknessLib Team - voided4356
