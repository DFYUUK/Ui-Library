# EliteGlassUI v2

A complete, Fluent-inspired UI library for Roblox with configs, notifications, color pickers, and more.

**Made by Markdetet**

## ✨ Features

* 🚀 Animated loader with custom logo
* 📱 Auto-scaling for all resolutions
* 🔔 Built-in notification system
* 💾 Config save/load system (JSON)
* 🎨 Color picker
* ⌨️ Keybind system
* 🌓 Theme support
* All Fluent-like elements

## 📦 Components

|Component|Description|
|-|-|
|Toggle|On/off switch with callback|
|Slider|Range slider with percentage|
|Dropdown|Multi-option selector|
|Textbox|Text input field|
|NumberBox|Numeric input|
|Button|Clickable action|
|ColorPicker|8-color quick picker|
|Keybind|Keyboard shortcut binder|

## 🚀 Installation

```lua
local Library = loadstring(game:HttpGet("..."))()
```

## 📖 Quick Start

```lua
local Library = loadstring(game:HttpGet(...))()
local Window = Library:CreateWindow("My Hub")

local Tab = Window:CreateTab("Home")
local Section = Tab:CreateSection("Main")


Section:NewToggle("Auto Farm", "Farms automatically", false, function(state)
    print(state)
end)



Section:NewSlider("Speed", "", 16, 200, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)


Section:NewColorPicker("ESP Color", "", Color3.fromRGB(0,255,0), function(color)
    print(color)
end)


Section:NewKeybind("Toggle", "", Enum.KeyCode.F, function()
    print("Pressed!")
end)


Library:Notify("Hello", "This is a notification", 3)


Library:SaveConfig("myconfig")
Library:LoadConfig("myconfig")
```

## 💾 Config System

Configs are saved to `EliteGlassUI\_Configs/` folder (executor only).

```lua

Library:SaveConfig("default")


Library:LoadConfig("default")


local configs = Library:GetConfigs()
```

All flags are automatically stored in `Library.Flags\["Element Name"]`

## 🔔 Notifications

```lua
Library:Notify("Title", "Content text", 3) -- 3 second duration
```

## 🎨 API Reference

### Library

```lua
Library:CreateWindow(title)
Library:Notify(title, content, duration)
Library:SaveConfig(name)
Library:LoadConfig(name)
Library:GetConfigs()
Library.Flags -- table of all values
```

### Window

```lua
Window:CreateTab(name, iconId)
```

### Tab

```lua
Tab:CreateSection(name)
```

### Section

```lua
Section:NewToggle(text, info, default, callback)
Section:NewSlider(text, info, min, max, default, callback)
Section:NewDropdown(text, info, options, default, callback)
Section:NewTextbox(text, info, default, callback)
Section:NewNumberBox(text, info, default, callback)
Section:NewButton(text, info, callback)
Section:NewColorPicker(text, info, defaultColor, callback)
Section:NewKeybind(text, info, defaultKey, callback)
```



```

## 🎯 Example Features in example.lua

* Auto Farm toggle with notification
* WalkSpeed slider
* Farm Mode dropdown
* ESP Color picker
* UI Toggle keybind (RightShift)
* Config save/load system
* Theme selector
* FOV number box
* Teleport, Rejoin buttons

## ⚙️ Customization

Edit in EliteGlassUI.lua:

* Line 12: `LOGO\_ASSET` - change loader logo
* Line 13: Preload assets
* `Color3.fromRGB(0, 137, 123)`
* Loader title: "E - Zero"
* Credit: "Made by Markdetet"

## 📝 License

MIT - Free to use, credit appreciated.

\---

**EliteGlassUI** 

