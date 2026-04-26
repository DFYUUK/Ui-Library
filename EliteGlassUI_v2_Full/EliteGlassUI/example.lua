local Library = loadstring(game:HttpGet("..."))()

local Window = Library:CreateWindow("E - Zero Hub")
Library:Notify("Welcome", "EliteGlassUI loaded successfully!", 3)


local HomeTab = Window:CreateTab("Home", "rbxassetid://3926305904")
local VisualsTab = Window:CreateTab("Visuals")
local SettingsTab = Window:CreateTab("Settings")


local Main = HomeTab:CreateSection("Main Features")

Main:NewToggle("Auto Farm", "Automatically farms resources", false, function(state)
    Library.Flags["Auto Farm"] = state
    Library:Notify("Auto Farm", state and "Enabled" or "Disabled", 2)
end)

Main:NewSlider("WalkSpeed", "Player movement speed", 16, 200, 16, function(value)
    Library.Flags["WalkSpeed"] = value
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

Main:NewDropdown("Farm Mode", "Select farming method", {"Normal", "Fast", "Legit", "Stealth"}, "Normal", function(option)
    Library.Flags["Farm Mode"] = option
    print("Mode:", option)
end)

Main:NewButton("Teleport Spawn", "Go to spawn location", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
    Library:Notify("Teleport", "Teleported to spawn", 2)
end)


local ESP = VisualsTab:CreateSection("ESP Settings")

ESP:NewToggle("Player ESP", "See players through walls", true, function(v)
    Library.Flags["Player ESP"] = v
end)

ESP:NewColorPicker("ESP Color", "Color of ESP boxes", Color3.fromRGB(0, 137, 123), function(color)
    Library.Flags["ESP Color"] = {color.R, color.G, color.B}
    Library:Notify("Color", "ESP color updated", 1.5)
end)

ESP:NewSlider("ESP Distance", "Max render distance", 100, 5000, 1000, function(v)
    Library.Flags["ESP Distance"] = v
end)

local World = VisualsTab:CreateSection("World")

World:NewColorPicker("Ambient Color", "World ambient lighting", Color3.fromRGB(100, 100, 100), function(c)
    game.Lighting.Ambient = c
end)

World:NewToggle("Fullbright", "Brighten the map", false, function(state)
    if state then
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 14
    else
        game.Lighting.Brightness = 1
    end
end)


local Config = SettingsTab:CreateSection("Configuration")

Config:NewKeybind("Toggle UI", "Hide/show the UI", Enum.KeyCode.RightShift, function(key)
    -- Keybind is automatically handled
    Library:Notify("Keybind", "UI toggle set to " .. key.Name, 2)
end)

Config:NewKeybind("Panic Key", "Quick disable all", Enum.KeyCode.P, function()
    Library:Notify("Panic", "All features disabled!", 2)
end)

Config:NewTextbox("Config Name", "Name for save file", "default", function(text)
    Library.Flags["Config Name"] = text
end)

Config:NewButton("Save Config", "Save current settings", function()
    local name = Library.Flags["Config Name"] or "default"
    Library:SaveConfig(name)
end)

Config:NewButton("Load Config", "Load saved settings", function()
    local name = Library.Flags["Config Name"] or "default"
    Library:LoadConfig(name)
end)

local Misc = SettingsTab:CreateSection("Misc")

Misc:NewDropdown("Theme", "UI color theme", {"Teal", "Purple", "Red", "Blue"}, "Teal", function(theme)
    local colors = {
        Teal = Color3.fromRGB(0, 137, 123),
        Purple = Color3.fromRGB(137, 0, 123),
        Red = Color3.fromRGB(137, 0, 0),
        Blue = Color3.fromRGB(0, 80, 137)
    }
    Library:Notify("Theme", "Theme set to " .. theme, 2)
end)

Misc:NewNumberBox("FOV", "Camera field of view", 70, function(num)
    workspace.CurrentCamera.FieldOfView = num
    Library.Flags["FOV"] = num
end)

Misc:NewButton("Rejoin Game", "", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end)

Misc:NewButton("Copy Discord", "Join our server", function()
    setclipboard("https://discord.gg/yourserver")
    Library:Notify("Discord", "Copied to clipboard!", 2)
end)


task.wait(1)
Library:LoadConfig("default")

print("EliteGlassUI v2 - All features loaded!")
