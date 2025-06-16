# 🌌 Orion Deluxe UI Library

A beautiful, dark, mobile-friendly and script-ready UI library for Roblox, inspired by the Orion UI framework — re-themed for a deluxe experience.

## ✨ Features

- Dark & sleek deluxe theme
- Fully mobile-compatible
- Drag-to-move window
- Customizable window title, icon, and tabs
- Supports buttons, toggles, sliders, dropdowns, keybinds, and more
- Settings autosave (optional)

---

## 📦 How to Use

### 1. Load the Library

```lua
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/orion_deluxe_full.txt"))()
```

---

2. Create a Window
```lua
local Window = OrionLib:MakeWindow({
    Name = "My Script UI",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "MyScript" -- folder name for config files
})
```

---

3. Create Tabs
```lua
local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "cpu", -- Doesn't support lol btw just put a random value
    PremiumOnly = false
})
```

---

4. Add UI Elements

➕ Label
```lua
Tab:AddLabel("Welcome to my script!")
```
🔘 Button
```lua
Tab:AddButton({
    Name = "Click Me",
    Callback = function()
        print("Button clicked!")
    end
})
```
✅ Toggle
```lua
Tab:AddToggle({
    Name = "Enable Mode",
    Default = false,
    Callback = function(Value)
        print("Toggle is now:", Value)
    end
})
```
🎚️ Slider
```lua
Tab:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})
```
⌨️ Keybind
```lua
Tab:AddBind({
    Name = "Quick Action",
    Default = Enum.KeyCode.K,
    Hold = false,
    Callback = function()
        print("Keybind triggered")
    end
})
```
🧾 Textbox
```lua
Tab:AddTextbox({
    Name = "Set Nickname",
    Default = "",
    TextDisappear = false,
    Callback = function(Text)
        print("You entered:", Text)
    end
})
```
🎨 Color Picker
```lua
Tab:AddColorpicker({
    Name = "Pick a Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Color)
        print("Chosen color:", Color)
    end
})
```
⬇️ Dropdown
```lua
Tab:AddDropdown({
    Name = "Select Team",
    Options = { "Red", "Blue", "Green" },
    Default = "Red",
    Callback = function(Option)
        print("You picked:", Option)
    end
})
```

---

5. Initialize the UI (optional but recommended)
```lua
OrionLib:Init()
```

---

📁 File Saving (Config)
```lua
--- just set save file thingy to true in window lol
```
Useful for saving toggle states, slider values, etc.



---

💬 Need Help?

Open an issue or join our Discord (if you have one). Contributions welcome!


---

🧠 Credits

Based on the original Orion UI Library

Theme and UX redesign by YOUR_NAME
