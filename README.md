
# ðŸŒŸ OrionLib UI â€“ Full Documentation (Enhanced Version)

A modern, mobile-ready Roblox UI library with tabs, animations, full method support, and divider utilities.

---

## ðŸš€ How to Get Started

### ðŸ”— Load the Library


```lua
local OrionLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dareius/roblox/refs/heads/main/Test.lua"
))()
```

---

## ðŸªŸ Create the Main Window

```lua
Window = OrionLib:MakeWindow({
    Name = "My Game UI",
    IntroText = "Welcome!",
    Icon = "rbxassetid://6034287515",
    ShowIcon = true
})
```

---

## ðŸ“‚ Create Tabs

```lua
local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://6031280882"
})
```

You can create as many tabs as you'd like.

---

## ðŸ§± Tab Dividers (Sidebar)

Insert visual breaks between tabs:

```lua
OrionLib:AddTabDivider()
```

---

## ðŸ“ Element Dividers (Inside Tabs)

Add a line between UI sections in a tab:

```lua
Tab:AddDivider()
```

---

## ðŸ”˜ Supported UI Elements

Each element supports `.Set(value)`, `.Get()`, `.Changed`, `.Disable()`, `.Enable()`, `.Destroy()`.

---

### Toggle

```lua
local t = Tab:AddToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(val)
        print("Toggle:", val)
    end
})

t:Set(true)
print(t:Get())

t.Changed.Event:Connect(function(val) print("Changed:", val) end)
```

---

### Slider

```lua
local s = Tab:AddSlider({
    Name = "Volume",
    Min = 0,
    Max = 100,
    Default = 50,
    ValueName = "%",
    Callback = function(v) print("Slider:", v) end
})

s:Set(75)
print(s:Get())
s.Changed.Event:Connect(function(v) print("Changed:", v) end)
```

---

### Dropdown

```lua
local d = Tab:AddDropdown({
    Name = "Choose Option",
    Options = {"One", "Two", "Three"},
    Default = "Two",
    Callback = function(v) print("Dropdown:", v) end
})

d:Set("One")
print(d:Get())
d.Changed.Event:Connect(function(v) print("Changed:", v) end)
```

---

### Textbox

```lua
local txt = Tab:AddTextbox({
    Name = "Enter Text",
    Default = "",
    Callback = function(v) print("Typed:", v) end
})

txt:Set("Hello")
print(txt:Get())
txt.Changed.Event:Connect(function(v) print("Changed:", v) end)
```

---

### Color Picker

```lua
local cp = Tab:AddColorpicker({
    Name = "Pick Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(c) print("Color:", c) end
})

cp:Set(Color3.fromRGB(0, 255, 0))
print(cp:Get())
cp.Changed.Event:Connect(function(c) print("Changed:", c) end)
```

---

### Bind

```lua
Tab:AddBind({
    Name = "Activate",
    Default = Enum.KeyCode.F,
    Callback = function()
        print("F pressed")
    end
})
```

---

### Button

```lua
Tab:AddButton({
    Name = "Click Me",
    Callback = function()
        print("Button clicked")
    end
})
```

---

### Label

```lua
local label = Tab:AddLabel("Info Text")
label:Set("Updated Text")
```

---

### Paragraph

```lua
Tab:AddParagraph("Instructions", [[
This is a longer text block for instructions, notes, or story.
]])
```

---

### Notifications

```lua
OrionLib:MakeNotification({
    Name = "Notice",
    Content = "Something happened!",
    Time = 4
})
```

---

## ðŸ§© Utility Methods (All Elements)

| Method        | Description                       |
|---------------|-----------------------------------|
| `:Set(value)` | Change the current value          |
| `:Get()`      | Get the current value             |
| `:Disable()`  | Hide the element                  |
| `:Enable()`   | Show the element again            |
| `:Destroy()`  | Remove the element from the UI    |
| `Changed.Event` | Signal for when value changes |

---

## ðŸ“¦ UX Features

- Responsive layout for PC + Mobile
- Animated drag with Touch + Mouse
- Reopen via pill UI or button
- Animated transitions
- Custom theming support (manual)

---

## ðŸ“ Coming Soon

- Config saving
- Themes UI switcher
- Dynamic tab ordering

---
