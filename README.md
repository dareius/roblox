
# 🌌 Orion UI (Enhanced Full Version)

A modern, touch-friendly, drag-to-move Roblox UI library.  
Supports tabs, toggles, sliders, dropdowns, color pickers, and more — with animation, `.Set()`, `.Get()`, `.Changed`, `.Disable()`, `.Enable()`, and `.Destroy()`.

---

## 🛠️ How to Use

### 1. Load the Library

```lua
local OrionLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dareius/roblox/refs/heads/main/Test.lua"
))()
```

---

## 🧩 Supported Elements

Each element supports:

- `.Set(value)` – Set the UI value manually
- `.Get()` – Get the current value
- `.Changed.Event:Connect(function(val) ... end)` – Run code when value changes
- `.Disable()` / `.Enable()` – Hide/show the element
- `.Destroy()` – Remove the element completely

---

### 🔘 Toggle

```lua
local toggle = tab:AddToggle({ Name = "Enable", Default = false })
toggle:Set(true)
print(toggle:Get())
toggle.Changed.Event:Connect(function(val) print("Toggled:", val) end)
toggle:Disable()
toggle:Enable()
toggle:Destroy()
```

---

### 🎚️ Slider

```lua
local slider = tab:AddSlider({ Name = "Volume", Min = 0, Max = 100, Default = 50 })
slider:Set(75)
print(slider:Get())
slider.Changed.Event:Connect(function(v) print("Volume:", v) end)
```

---

### 🔽 Dropdown

```lua
local drop = tab:AddDropdown({ Name = "Pet", Options = {"Cat","Dog"}, Default = "Dog" })
drop:Set("Cat")
print(drop:Get())
drop.Changed.Event:Connect(function(opt) print("Picked:", opt) end)
```

---

### 📝 Textbox

```lua
local tb = tab:AddTextbox({ Name = "Say Something", Default = "" })
tb:Set("Hello")
print(tb:Get())
tb.Changed.Event:Connect(function(txt) print("Typed:", txt) end)
```

---

### 🎨 Colorpicker

```lua
local color = tab:AddColorpicker({ Name = "Pick a color", Default = Color3.fromRGB(255, 0, 0) })
color:Set(Color3.fromRGB(0, 255, 0))
print(color:Get())
color.Changed.Event:Connect(function(c) print("Color:", c) end)
```

---

## ✅ Utility Methods (All Elements)

- `:Set(value)`
- `:Get()`
- `:Disable()`
- `:Enable()`
- `:Destroy()`
- `Changed.Event:Connect(...)`

---

📦 Library Features

- Mobile + PC support
- Tab system
- Theme-ready (via library config)
- Animated drag
- Floating reopen pill

---
