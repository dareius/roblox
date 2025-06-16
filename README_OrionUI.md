
# 🌌 Orion UI (Custom Enhanced Version)

A modern, touch-friendly, drag-to-move, Roblox UI library.  
Supports tabs, toggles, sliders, dropdowns, color pickers, and more — all with animation, theming, and programmatic `.Set()` control.

---

## 🛠️ How to Use

### 1. Load the Library

Paste this into a **LocalScript** (e.g. `StarterPlayerScripts`):

```lua
local OrionLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dareius/roblox/refs/heads/main/Test.lua"
))()
```

> Replace the URL with your own GitHub if you host the library elsewhere.

---

### 2. Create the Main UI Window

```lua
Window = OrionLib:MakeWindow({
    Name = "My Cool UI",
    IntroText = "Welcome!",
    Icon = "rbxassetid://6034287515",
    ShowIcon = true
})
```

---

### 3. Create Tabs

```lua
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://6031280882"
})

local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://6035078884"
})
```

---

## 🧩 Supported Elements

Each element returns a control object with a `.Set()` function for programmatic changes.

### 🔘 Toggle

```lua
local Toggle = MainTab:AddToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Toggle is:", state)
    end
})

Toggle:Set(true)
```

### 🎚️ Slider

```lua
local Slider = MainTab:AddSlider({
    Name = "Volume",
    Min = 0,
    Max = 100,
    Default = 50,
    ValueName = "%",
    Callback = function(val)
        print("Volume:", val)
    end
})

Slider:Set(75)
```

### 🔽 Dropdown

```lua
local Dropdown = MainTab:AddDropdown({
    Name = "Favorite Animal",
    Options = {"Cat", "Dog", "Axolotl"},
    Default = "Cat",
    Callback = function(choice)
        print("You picked:", choice)
    end
})

Dropdown:Set("Axolotl")
```

### 📝 Textbox

```lua
local Textbox = MainTab:AddTextbox({
    Name = "Say Something",
    Default = "",
    Callback = function(text)
        print("You typed:", text)
    end
})

Textbox:Set("Hello World")
```

### 🎨 Color Picker

```lua
local Picker = MainTab:AddColorpicker({
    Name = "Pick a Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        print("Selected color:", color)
    end
})

Picker:Set(Color3.fromRGB(0, 255, 0))
```

### 🖱️ Bind

```lua
MainTab:AddBind({
    Name = "Do Something",
    Default = Enum.KeyCode.F,
    Callback = function()
        print("F key pressed!")
    end
})
```

### 📌 Label

```lua
local Label = MainTab:AddLabel("This is a label")
Label:Set("Updated text")
```

### 📎 Paragraph

```lua
MainTab:AddParagraph("Instructions", [[
Use this paragraph to show longer formatted text.
Great for instructions, help, or lore!
]])
```

### 🔔 Notification

```lua
OrionLib:MakeNotification({
    Name = "Notice",
    Content = "Something happened!",
    Time = 3
})
```

---

## 🪟 UX Features

- ✅ Minimizes to top-center bar
- ✅ Touch + mouse compatible
- ✅ Mobile-friendly drag
- ✅ Floating reopen button on close
- ✅ Smooth transitions

---

## 🧪 Debug Tips

- Sliders + color pickers are now locked to:
  - Current visible tab
  - UI not minimized
  - Active drag input

---

## 📁 Optional Features Coming Soon

| Feature         | Status   |
|----------------|----------|
| `.Get()` method | 🔜 Planned |
| `.Changed` signals | 🔜 Planned |
| Custom themes   | ✅ Supported manually |
| Save/load config | Optional |
