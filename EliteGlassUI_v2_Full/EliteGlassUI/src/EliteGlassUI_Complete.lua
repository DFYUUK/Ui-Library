local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")
local HttpService = game:GetService("HttpService")

local parentLocation = Players.LocalPlayer:WaitForChild("PlayerGui")

local Library = {}

Library.Flags = {}
Library.Theme = {
    Accent = Color3.fromRGB(0, 137, 123),
    Background = Color3.fromRGB(10, 10, 10),
    Secondary = Color3.fromRGB(30, 30, 30),
    Text = Color3.fromRGB(255, 255, 255)
}

Library.ConfigFolder = "EliteGlassUI_Configs"


-- NEW LOGO ASSET
local LOGO_ASSET = "rbxassetid://100968456165945"
pcall(function()
        ContentProvider:PreloadAsync({LOGO_ASSET})
end)

-- Helper function for smooth tweens
local function Tween(instance, properties, duration, easingStyle, easingDirection)
        local tweenInfo = TweenInfo.new(duration or 0.3, easingStyle or Enum.EasingStyle.Quart, easingDirection or Enum.EasingDirection.Out)
        local tween = TweenService:Create(instance, tweenInfo, properties)
        tween:Play()
        return tween
end


-- Notification System
function Library:Notify(title, content, duration)
    duration = duration or 5
    local ScreenGui = parentLocation:FindFirstChild("EliteGlassUI") or Instance.new("ScreenGui", parentLocation)
    ScreenGui.Name = "EliteGlassUI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    
    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.new(0, 280, 0, 70)
    Notif.Position = UDim2.new(1, -300, 0, 20)
    Notif.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Notif.BackgroundTransparency = 0.2
    Notif.BorderSizePixel = 0
    Notif.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner", Notif)
    Corner.CornerRadius = UDim.new(0,8)
    
    local Stroke = Instance.new("UIStroke", Notif)
    Stroke.Color = Library.Theme.Accent
    Stroke.Thickness = 1
    Stroke.Transparency = 0.3
    
    local Title = Instance.new("TextLabel", Notif)
    Title.Size = UDim2.new(1,-20,0,20)
    Title.Position = UDim2.new(0,10,0,8)
    Title.BackgroundTransparency = 1
    Title.Text = title or "Notification"
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    local Content = Instance.new("TextLabel", Notif)
    Content.Size = UDim2.new(1,-20,0,35)
    Content.Position = UDim2.new(0,10,0,28)
    Content.BackgroundTransparency = 1
    Content.Text = content or ""
    Content.TextColor3 = Color3.fromRGB(200,200,200)
    Content.Font = Enum.Font.Gotham
    Content.TextSize = 12
    Content.TextXAlignment = Enum.TextXAlignment.Left
    Content.TextYAlignment = Enum.TextYAlignment.Top
    Content.TextWrapped = true
    
    Notif.Position = UDim2.new(1, 20, 0, 20)
    Tween(Notif, {Position = UDim2.new(1, -300, 0, 20)}, 0.4, Enum.EasingStyle.Back)
    
    task.delay(duration, function()
        Tween(Notif, {Position = UDim2.new(1, 20, 0, 20)}, 0.3)
        task.wait(0.3)
        Notif:Destroy()
    end)
end

-- Config System
function Library:SaveConfig(name)
    if not writefile then 
        Library:Notify("Error", "Executor doesn't support configs", 3)
        return 
    end
    pcall(function()
        if not isfolder(Library.ConfigFolder) then makefolder(Library.ConfigFolder) end
        local data = HttpService:JSONEncode(Library.Flags)
        writefile(Library.ConfigFolder .. "/" .. name .. ".json", data)
        Library:Notify("Config", "Saved as " .. name, 3)
    end)
end

function Library:LoadConfig(name)
    if not readfile then 
        Library:Notify("Error", "Executor doesn't support configs", 3)
        return 
    end
    pcall(function()
        local data = readfile(Library.ConfigFolder .. "/" .. name .. ".json")
        local decoded = HttpService:JSONDecode(data)
        for flag, value in pairs(decoded) do
            Library.Flags[flag] = value
            if Library.FlagCallbacks and Library.FlagCallbacks[flag] then
                Library.FlagCallbacks[flag](value)
            end
        end
        Library:Notify("Config", "Loaded " .. name, 3)
    end)
end

function Library:GetConfigs()
    if not listfiles then return {} end
    local configs = {}
    pcall(function()
        for _, file in ipairs(listfiles(Library.ConfigFolder)) do
            local name = file:match("([^/\]+)%.json$")
            if name then table.insert(configs, name) end
        end
    end)
    return configs
end

Library.FlagCallbacks = {}


function Library:CreateWindow(titleText)
        local Window = {}
        
        -- Main GUI
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "EliteGlassUI"
        ScreenGui.Parent = parentLocation
        ScreenGui.ResetOnSpawn = false
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        ScreenGui.DisplayOrder = 999999999
        ScreenGui.IgnoreGuiInset = true

        -- [[ AUTOFIT SCALING - PURE SCREEN SIZE ]] --
        local UIScale = Instance.new("UIScale")
        UIScale.Parent = ScreenGui
        
        local function updateScale()
                local viewport = workspace.CurrentCamera.ViewportSize
                local scaleY = viewport.Y / 1080
                local scaleX = viewport.X / 1920
                local scale = math.min(scaleX, scaleY)
                UIScale.Scale = math.clamp(scale, 0.5, 1)
        end
        
        updateScale()
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)

        -- [[ LOADER ]] --
        local LoaderFrame = Instance.new("Frame")
        LoaderFrame.Name = "Loader"
        LoaderFrame.Size = UDim2.new(0, 0, 0, 0)
        LoaderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        LoaderFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        LoaderFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        LoaderFrame.BackgroundTransparency = 0.4
        LoaderFrame.BorderSizePixel = 0
        LoaderFrame.ClipsDescendants = true
        LoaderFrame.Parent = ScreenGui

        local LoaderCorner = Instance.new("UICorner")
        LoaderCorner.CornerRadius = UDim.new(0, 12)
        LoaderCorner.Parent = LoaderFrame

        local LoaderStroke = Instance.new("UIStroke")
        LoaderStroke.Color = Color3.fromRGB(255, 255, 255)
        LoaderStroke.Thickness = 1
        LoaderStroke.Transparency = 0.7
        LoaderStroke.Parent = LoaderFrame

        -- Logo (rounded square)
        local Logo = Instance.new("ImageLabel")
        Logo.Name = "Logo"
        Logo.Size = UDim2.new(0, 56, 0, 56)
        Logo.Position = UDim2.new(0.5, 0, 0, 12)
        Logo.AnchorPoint = Vector2.new(0.5, 0)
        Logo.BackgroundTransparency = 1
        Logo.Image = LOGO_ASSET
        Logo.ImageTransparency = 1
        Logo.ScaleType = Enum.ScaleType.Crop
        Logo.Parent = LoaderFrame

        local LogoCorner = Instance.new("UICorner")
        LogoCorner.CornerRadius = UDim.new(0, 12)
        LogoCorner.Parent = Logo

        local LogoStroke = Instance.new("UIStroke")
        LogoStroke.Color = Color3.fromRGB(255, 255, 255)
        LogoStroke.Thickness = 1
        LogoStroke.Transparency = 1
        LogoStroke.Parent = Logo

        local LoaderTitle = Instance.new("TextLabel")
        LoaderTitle.Size = UDim2.new(1, 0, 0, 30)
        LoaderTitle.Position = UDim2.new(0, 0, 0, 72)
        LoaderTitle.BackgroundTransparency = 1
        LoaderTitle.Text = "E - Zero"
        LoaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        LoaderTitle.Font = Enum.Font.GothamBold
        LoaderTitle.TextSize = 24
        LoaderTitle.TextTransparency = 1
        LoaderTitle.Parent = LoaderFrame

        local Percentage = Instance.new("TextLabel")
        Percentage.Name = "Percentage"
        Percentage.Size = UDim2.new(1, 0, 0, 20)
        Percentage.Position = UDim2.new(0, 0, 0, 100)
        Percentage.BackgroundTransparency = 1
        Percentage.Text = "0%"
        Percentage.TextColor3 = Color3.fromRGB(200, 200, 200)
        Percentage.Font = Enum.Font.GothamMedium
        Percentage.TextSize = 14
        Percentage.TextTransparency = 1
        Percentage.Parent = LoaderFrame

        local BarBG = Instance.new("Frame")
        BarBG.Name = "BarBG"
        BarBG.Size = UDim2.new(1, -40, 0, 8)
        BarBG.Position = UDim2.new(0, 20, 0, 124)
        BarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        BarBG.BorderSizePixel = 0
        BarBG.Parent = LoaderFrame

        local BarBGCorner = Instance.new("UICorner")
        BarBGCorner.CornerRadius = UDim.new(1, 0)
        BarBGCorner.Parent = BarBG

        local BarFill = Instance.new("Frame")
        BarFill.Name = "BarFill"
        BarFill.Size = UDim2.new(0, 0, 1, 0)
        BarFill.BackgroundColor3 = Color3.fromRGB(0, 137, 123)
        BarFill.BorderSizePixel = 0
        BarFill.Parent = BarBG

        local BarFillCorner = Instance.new("UICorner")
        BarFillCorner.CornerRadius = UDim.new(1, 0)
        BarFillCorner.Parent = BarFill

        local Subtitle = Instance.new("TextLabel")
        Subtitle.Size = UDim2.new(1, 0, 0, 20)
        Subtitle.Position = UDim2.new(0, 0, 0, 142)
        Subtitle.BackgroundTransparency = 1
        Subtitle.Text = "Made by Markdetet"
        Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
        Subtitle.Font = Enum.Font.Gotham
        Subtitle.TextSize = 13
        Subtitle.TextTransparency = 1
        Subtitle.Parent = LoaderFrame

        -- [[ MAIN WINDOW ]] --
        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Size = UDim2.new(0, 550, 0, 380)
        MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        MainFrame.BackgroundTransparency = 1
        MainFrame.BorderSizePixel = 0
        MainFrame.Visible = false
        MainFrame.Active = true
        MainFrame.ClipsDescendants = true
        MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        MainFrame.Parent = ScreenGui

        local MainCorner = Instance.new("UICorner")
        MainCorner.CornerRadius = UDim.new(0, 8)
        MainCorner.Parent = MainFrame

        local MainStroke = Instance.new("UIStroke")
        MainStroke.Color = Color3.fromRGB(255, 255, 255)
        MainStroke.Thickness = 1
        MainStroke.Transparency = 1
        MainStroke.Parent = MainFrame

        -- [[ TOP BAR ]] --
        local TopBar = Instance.new("Frame")
        TopBar.Size = UDim2.new(1, 0, 0, 30)
        TopBar.BackgroundColor3 = Color3.fromRGB(0, 137, 123)
        TopBar.BackgroundTransparency = 1
        TopBar.BorderSizePixel = 0
        TopBar.Parent = MainFrame
        
        local TopBarCorner = Instance.new("UICorner")
        TopBarCorner.CornerRadius = UDim.new(0, 8)
        TopBarCorner.Parent = TopBar
        
        local TopBarCover = Instance.new("Frame")
        TopBarCover.Size = UDim2.new(1, 0, 0, 8)
        TopBarCover.Position = UDim2.new(0, 0, 1, -8)
        TopBarCover.BackgroundColor3 = Color3.fromRGB(0, 137, 123)
        TopBarCover.BackgroundTransparency = 1
        TopBarCover.BorderSizePixel = 0
        TopBarCover.Parent = TopBar

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, -15, 1, 0)
        Title.Position = UDim2.new(0, 15, 0, 0)
        Title.BackgroundTransparency = 1
        Title.Text = titleText or "UI Library"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.GothamSemibold
        Title.TextSize = 14
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.TextTransparency = 1
        Title.Parent = TopBar
        
        -- Window State
        local isVisible = false
        local originalSize = UDim2.new(0, 550, 0, 380)
        local originalPosition = UDim2.new(0.5, 0, 0.5, 0)
        
        MainFrame.Size = originalSize
        
        local function setVisible(visible)
                if isVisible == visible then return end
                isVisible = visible
                
                if isVisible then
                        MainFrame.Visible = true
                        Tween(MainFrame, {Size = originalSize, Position = originalPosition, BackgroundTransparency = 0.4}, 0.4, Enum.EasingStyle.Back)
                        Tween(MainStroke, {Transparency = 0.5}, 0.4)
                        Tween(TopBar, {BackgroundTransparency = 0.2}, 0.4)
                        Tween(TopBarCover, {BackgroundTransparency = 0.2}, 0.4)
                        Tween(Title, {TextTransparency = 0}, 0.4)
                else
                        Tween(MainFrame, {Size = UDim2.new(0, originalSize.X.Offset * 0.8, 0, originalSize.Y.Offset * 0.8), BackgroundTransparency = 1}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                        Tween(MainStroke, {Transparency = 1}, 0.3)
                        Tween(TopBar, {BackgroundTransparency = 1}, 0.3)
                        Tween(TopBarCover, {BackgroundTransparency = 1}, 0.3)
                        Tween(Title, {TextTransparency = 1}, 0.3)
                        task.wait(0.3)
                        MainFrame.Visible = false
                end
        end

        -- [[ MOBILE TOGGLE BUTTON WITH LOGO ]] --
        local MobileToggle = Instance.new("ImageButton")
        MobileToggle.Name = "MobileToggle"
        MobileToggle.Size = UDim2.new(0, 50, 0, 50)
        MobileToggle.Position = UDim2.new(0, 15, 0, 85)
        MobileToggle.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        MobileToggle.BackgroundTransparency = 0.2
        MobileToggle.Image = LOGO_ASSET
        MobileToggle.ScaleType = Enum.ScaleType.Crop
        MobileToggle.AutoButtonColor = true
        MobileToggle.Parent = ScreenGui
        MobileToggle.ZIndex = 999999
        MobileToggle.Visible = false

        local MobileCorner = Instance.new("UICorner")
        MobileCorner.CornerRadius = UDim.new(0, 12)
        MobileCorner.Parent = MobileToggle

        local MobileStroke = Instance.new("UIStroke")
        MobileStroke.Color = Color3.fromRGB(0, 137, 123)
        MobileStroke.Thickness = 2
        MobileStroke.Transparency = 0.3
        MobileStroke.Parent = MobileToggle

        MobileToggle.MouseButton1Click:Connect(function()
                setVisible(not isVisible)
        end)

        -- [[ DRAGGING LOGIC REMOVED - GUI NOT DRAGGABLE ]] --
        
        -- [[ KEYBIND P ]] --
        UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
                if gameProcessedEvent then return end
                if input.KeyCode == Enum.KeyCode.P then
                        setVisible(not isVisible)
                end
        end)

        -- [[ LOADING ANIMATION - FINISH BEFORE UI LOADS ]] --
        task.spawn(function()
                task.wait(0.5)
                Tween(LoaderFrame, {Size = UDim2.new(0, 260, 0, 175)})
                LoaderCorner.CornerRadius = UDim.new(0, 16)
                task.wait(0.4)
                Tween(Logo, {ImageTransparency = 0})
                Tween(LogoStroke, {Transparency = 0.7})
                Tween(LoaderTitle, {TextTransparency = 0})
                Tween(Subtitle, {TextTransparency = 0})
                Tween(Percentage, {TextTransparency = 0})
                for i = 0, 100 do
                        BarFill.Size = UDim2.new(i/100, 0, 1, 0)
                        Percentage.Text = i .. "%"
                        task.wait(0.02)
                end
                task.wait(0.3)
                -- Fade out loader completely
                Tween(LoaderTitle, {TextTransparency = 1})
                Tween(Subtitle, {TextTransparency = 1})
                Tween(Percentage, {TextTransparency = 1})
                Tween(Logo, {ImageTransparency = 1})
                Tween(LogoStroke, {Transparency = 1})
                Tween(BarBG, {BackgroundTransparency = 1})
                Tween(BarFill, {BackgroundTransparency = 1})
                Tween(LoaderStroke, {Transparency = 1})
                Tween(LoaderFrame, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, 0.4)
                task.wait(0.5)
                
                LoaderFrame:Destroy()
                
                -- NOW load the main UI after loader finishes
                MainFrame.Visible = true
                Tween(MainFrame, {BackgroundTransparency = 0.4})
                Tween(TopBar, {BackgroundTransparency = 0.2})
                Tween(TopBarCover, {BackgroundTransparency = 0.2})
                Tween(MainStroke, {Transparency = 0.5})
                Tween(Title, {TextTransparency = 0})
                
                isVisible = true
                task.wait(0.3)
                MainFrame.ClipsDescendants = false
                
                -- Show mobile toggle AFTER loader finishes
                MobileToggle.Visible = true
                Tween(MobileToggle, {BackgroundTransparency = 0.2}, 0.3)
        end)

        -- [[ TABS & CONTENT ]] --
        local TabContainer = Instance.new("Frame")
        TabContainer.Size = UDim2.new(0, 130, 1, -30)
        TabContainer.Position = UDim2.new(0, 0, 0, 30)
        TabContainer.BackgroundTransparency = 1
        TabContainer.Parent = MainFrame

        local TabList = Instance.new("UIListLayout")
        TabList.SortOrder = Enum.SortOrder.LayoutOrder
        TabList.Padding = UDim.new(0, 5)
        TabList.Parent = TabContainer

        local TabPadding = Instance.new("UIPadding")
        TabPadding.PaddingTop = UDim.new(0, 10)
        TabPadding.PaddingLeft = UDim.new(0, 10)
        TabPadding.Parent = TabContainer

        local ContentContainer = Instance.new("Frame")
        ContentContainer.Size = UDim2.new(1, -140, 1, -40)
        ContentContainer.Position = UDim2.new(0, 135, 0, 35)
        ContentContainer.BackgroundTransparency = 1
        ContentContainer.Parent = MainFrame

        local tabsData = {}

        function Window:NewTab(tabName)
                local TabObj = {}
                
                local TabBtn = Instance.new("TextButton")
                TabBtn.Name = tabName.."_Tab"
                TabBtn.Size = UDim2.new(1, -10, 0, 30)
                TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TabBtn.BackgroundTransparency = 0.95
                TabBtn.Text = "  " .. tabName
                TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
                TabBtn.Font = Enum.Font.GothamMedium
                TabBtn.TextSize = 13
                TabBtn.TextXAlignment = Enum.TextXAlignment.Left
                TabBtn.Parent = TabContainer

                local TabBtnCorner = Instance.new("UICorner")
                TabBtnCorner.CornerRadius = UDim.new(0, 6)
                TabBtnCorner.Parent = TabBtn

                local ContentScroll = Instance.new("ScrollingFrame")
                ContentScroll.Name = tabName.."_Content"
                ContentScroll.Size = UDim2.new(1, 0, 1, 0)
                ContentScroll.BackgroundTransparency = 1
                ContentScroll.ScrollBarThickness = 2
                ContentScroll.Visible = false
                ContentScroll.Parent = ContentContainer
                ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
                ContentScroll.CanvasSize = UDim2.new(0,0,0,0)
                ContentScroll.ScrollBarImageTransparency = 0.5

                local ContentLayout = Instance.new("UIListLayout")
                ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
                ContentLayout.Padding = UDim.new(0, 8)
                ContentLayout.Parent = ContentScroll

                table.insert(tabsData, {Btn = TabBtn, Content = ContentScroll})

                TabBtn.MouseEnter:Connect(function()
                        if not ContentScroll.Visible then
                                Tween(TabBtn, {BackgroundTransparency = 0.85})
                        end
                end)
                
                TabBtn.MouseLeave:Connect(function()
                        if not ContentScroll.Visible then
                                Tween(TabBtn, {BackgroundTransparency = 0.95})
                        end
                end)
                
                TabBtn.MouseButton1Click:Connect(function()
                        for _, data in ipairs(tabsData) do
                                data.Content.Visible = false
                                Tween(data.Btn, {BackgroundTransparency = 0.95, TextColor3 = Color3.fromRGB(180, 180, 180)})
                        end
                        ContentScroll.Visible = true
                        Tween(TabBtn, {BackgroundTransparency = 0.8, TextColor3 = Color3.fromRGB(255, 255, 255)})
                end)

                if #tabsData == 1 then
                        ContentScroll.Visible = true
                        TabBtn.BackgroundTransparency = 0.8
                        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                end

                function TabObj:NewSection(sectionName)
                        local SectionObj = {}

                        local SectionFrame = Instance.new("Frame")
                        SectionFrame.Name = sectionName
                        SectionFrame.Size = UDim2.new(1, -10, 0, 0)
                        SectionFrame.AutomaticSize = Enum.AutomaticSize.Y
                        SectionFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
                        SectionFrame.BackgroundTransparency = 0.55
                        SectionFrame.BorderSizePixel = 0
                        SectionFrame.Parent = ContentScroll

                        local SectionCorner = Instance.new("UICorner")
                        SectionCorner.CornerRadius = UDim.new(0, 8)
                        SectionCorner.Parent = SectionFrame

                        local SectionStroke = Instance.new("UIStroke")
                        SectionStroke.Color = Color3.fromRGB(255, 255, 255)
                        SectionStroke.Thickness = 1
                        SectionStroke.Transparency = 0.88
                        SectionStroke.Parent = SectionFrame

                        local Header = Instance.new("Frame")
                        Header.Size = UDim2.new(1, 0, 0, 26)
                        Header.BackgroundColor3 = Color3.fromRGB(0, 137, 123)
                        Header.BackgroundTransparency = 0.75
                        Header.BorderSizePixel = 0
                        Header.Parent = SectionFrame

                        local HeaderCorner = Instance.new("UICorner")
                        HeaderCorner.CornerRadius = UDim.new(0, 8)
                        HeaderCorner.Parent = Header

                        local HeaderFix = Instance.new("Frame")
                        HeaderFix.Size = UDim2.new(1, 0, 0, 8)
                        HeaderFix.Position = UDim2.new(0, 0, 1, -8)
                        HeaderFix.BackgroundColor3 = Color3.fromRGB(0, 137, 123)
                        HeaderFix.BackgroundTransparency = 0.75
                        HeaderFix.BorderSizePixel = 0
                        HeaderFix.Parent = Header

                        local SectionLabel = Instance.new("TextLabel")
                        SectionLabel.Size = UDim2.new(1, -20, 1, 0)
                        SectionLabel.Position = UDim2.new(0, 10, 0, 0)
                        SectionLabel.BackgroundTransparency = 1
                        SectionLabel.Text = sectionName
                        SectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        SectionLabel.Font = Enum.Font.GothamSemibold
                        SectionLabel.TextSize = 14
                        SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
                        SectionLabel.Parent = Header

                        local Inner = Instance.new("Frame")
                        Inner.Name = "Inner"
                        Inner.Size = UDim2.new(1, 0, 0, 0)
                        Inner.AutomaticSize = Enum.AutomaticSize.Y
                        Inner.Position = UDim2.new(0, 0, 0, 26)
                        Inner.BackgroundTransparency = 1
                        Inner.Parent = SectionFrame

                        local Padding = Instance.new("UIPadding")
                        Padding.PaddingTop = UDim.new(0, 8)
                        Padding.PaddingBottom = UDim.new(0, 8)
                        Padding.PaddingLeft = UDim.new(0, 8)
                        Padding.PaddingRight = UDim.new(0, 8)
                        Padding.Parent = Inner

                        local Layout = Instance.new("UIListLayout")
                        Layout.SortOrder = Enum.SortOrder.LayoutOrder
                        Layout.Padding = UDim.new(0, 6)
                        Layout.Parent = Inner

                        function SectionObj:NewToggle(toggleText, toggleInfo, callback)
                                callback = callback or function() end
                                local state = false
                                local ToggleContainer = Instance.new("Frame")
                                ToggleContainer.Size = UDim2.new(1, 0, 0, 40)
                                ToggleContainer.BackgroundTransparency = 1
                                ToggleContainer.Parent = Inner

                                local Title = Instance.new("TextLabel")
                                Title.Size = UDim2.new(1, -60, 0, 18)
                                Title.Position = UDim2.new(0, 10, 0, 2)
                                Title.BackgroundTransparency = 1
                                Title.Text = toggleText
                                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Title.Font = Enum.Font.GothamMedium
                                Title.TextSize = 13
                                Title.TextXAlignment = Enum.TextXAlignment.Left
                                Title.Parent = ToggleContainer

                                local Info = Instance.new("TextLabel")
                                Info.Size = UDim2.new(1, -60, 0, 14)
                                Info.Position = UDim2.new(0, 10, 0, 20)
                                Info.BackgroundTransparency = 1
                                Info.Text = toggleInfo or ""
                                Info.TextColor3 = Color3.fromRGB(150, 150, 150)
                                Info.Font = Enum.Font.Gotham
                                Info.TextSize = 11
                                Info.TextXAlignment = Enum.TextXAlignment.Left
                                Info.Parent = ToggleContainer

                                local Switch = Instance.new("Frame")
                                Switch.Size = UDim2.new(0, 36, 0, 20)
                                Switch.Position = UDim2.new(1, -46, 0, 10)
                                Switch.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                                Switch.Parent = ToggleContainer

                                local SwitchCorner = Instance.new("UICorner")
                                SwitchCorner.CornerRadius = UDim.new(1, 0)
                                SwitchCorner.Parent = Switch

                                local Knob = Instance.new("Frame")
                                Knob.Size = UDim2.new(0, 16, 0, 16)
                                Knob.Position = UDim2.new(0, 2, 0.5, -8)
                                Knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                                Knob.Parent = Switch

                                local KnobCorner = Instance.new("UICorner")
                                KnobCorner.CornerRadius = UDim.new(1, 0)
                                KnobCorner.Parent = Knob

                                local Button = Instance.new("TextButton")
                                Button.Size = UDim2.new(1, 0, 1, 0)
                                Button.BackgroundTransparency = 1
                                Button.Text = ""
                                Button.Parent = ToggleContainer

                                local function update()
                                        if state then
                                                Tween(Switch, {BackgroundColor3 = Color3.fromRGB(0, 137, 123)})
                                                Tween(Knob, {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                                        else
                                                Tween(Switch, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)})
                                                Tween(Knob, {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Color3.fromRGB(200, 200, 200)})
                                        end
                                        if flag then Library.Flags[flag] = state end
                                        callback(state)
                                end

                                Button.MouseButton1Click:Connect(function()
                                        state = not state
                                        update()
                                end)

                                update()
                        end

                        
                        function SectionObj:NewParagraph(paragraphText, paragraphInfo)
                                local ParagraphContainer = Instance.new("Frame")
                                ParagraphContainer.Size = UDim2.new(1, 0, 0, 0)
                                ParagraphContainer.AutomaticSize = Enum.AutomaticSize.Y
                                ParagraphContainer.BackgroundTransparency = 1
                                ParagraphContainer.Parent = Inner

                                local Title = Instance.new("TextLabel")
                                Title.Size = UDim2.new(1, -20, 0, 18)
                                Title.Position = UDim2.new(0, 10, 0, 2)
                                Title.BackgroundTransparency = 1
                                Title.Text = paragraphText or ""
                                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Title.Font = Enum.Font.GothamMedium
                                Title.TextSize = 13
                                Title.TextXAlignment = Enum.TextXAlignment.Left
                                Title.TextWrapped = true
                                Title.AutomaticSize = Enum.AutomaticSize.Y
                                Title.Parent = ParagraphContainer

                                if paragraphInfo and paragraphInfo ~= "" then
                                    local Info = Instance.new("TextLabel")
                                    Info.Size = UDim2.new(1, -20, 0, 0)
                                    Info.Position = UDim2.new(0, 10, 0, 22)
                                    Info.BackgroundTransparency = 1
                                    Info.Text = paragraphInfo
                                    Info.TextColor3 = Color3.fromRGB(150, 150, 150)
                                    Info.Font = Enum.Font.Gotham
                                    Info.TextSize = 12
                                    Info.TextXAlignment = Enum.TextXAlignment.Left
                                    Info.TextWrapped = true
                                    Info.AutomaticSize = Enum.AutomaticSize.Y
                                    Info.Parent = ParagraphContainer
                                end
                        end

                        function SectionObj:NewSlider(sliderText, sliderInfo, min, max, default, callback, flag)
                                callback = callback or function() end
                                min = min or 0
                                max = max or 100
                                default = default or min
                                local value = default
                                if flag then Library.Flags[flag] = default; Library.FlagCallbacks[flag] = callback end

                                local SliderContainer = Instance.new("Frame")
                                SliderContainer.Size = UDim2.new(1, 0, 0, 50)
                                SliderContainer.BackgroundTransparency = 1
                                SliderContainer.Parent = Inner

                                local Title = Instance.new("TextLabel")
                                Title.Size = UDim2.new(1, -80, 0, 18)
                                Title.Position = UDim2.new(0, 10, 0, 2)
                                Title.BackgroundTransparency = 1
                                Title.Text = sliderText
                                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Title.Font = Enum.Font.GothamMedium
                                Title.TextSize = 13
                                Title.TextXAlignment = Enum.TextXAlignment.Left
                                Title.Parent = SliderContainer

                                local Info = Instance.new("TextLabel")
                                Info.Size = UDim2.new(1, -80, 0, 14)
                                Info.Position = UDim2.new(0, 10, 0, 20)
                                Info.BackgroundTransparency = 1
                                Info.Text = sliderInfo or ""
                                Info.TextColor3 = Color3.fromRGB(150, 150, 150)
                                Info.Font = Enum.Font.Gotham
                                Info.TextSize = 11
                                Info.TextXAlignment = Enum.TextXAlignment.Left
                                Info.Parent = SliderContainer

                                local ValueLabel = Instance.new("TextLabel")
                                ValueLabel.Size = UDim2.new(0, 70, 0, 18)
                                ValueLabel.Position = UDim2.new(1, -80, 0, 2)
                                ValueLabel.BackgroundTransparency = 1
                                ValueLabel.Text = tostring(value) .. " (0%)"
                                ValueLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                                ValueLabel.Font = Enum.Font.GothamBold
                                ValueLabel.TextSize = 13
                                ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
                                ValueLabel.Parent = SliderContainer

                                local Track = Instance.new("Frame")
                                Track.Size = UDim2.new(1, -20, 0, 6)
                                Track.Position = UDim2.new(0, 10, 0, 38)
                                Track.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                                Track.BorderSizePixel = 0
                                Track.Parent = SliderContainer

                                local TrackCorner = Instance.new("UICorner")
                                TrackCorner.CornerRadius = UDim.new(1, 0)
                                TrackCorner.Parent = Track

                                local Fill = Instance.new("Frame")
                                Fill.Size = UDim2.new(0, 0, 1, 0)
                                Fill.BackgroundColor3 = Color3.fromRGB(0, 137, 123)
                                Fill.BorderSizePixel = 0
                                Fill.Parent = Track

                                local FillCorner = Instance.new("UICorner")
                                FillCorner.CornerRadius = UDim.new(1, 0)
                                FillCorner.Parent = Fill

                                local Knob = Instance.new("Frame")
                                Knob.Size = UDim2.new(0, 14, 0, 14)
                                Knob.Position = UDim2.new(0, -7, 0.5, -7)
                                Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                Knob.Parent = Track

                                local KnobCorner = Instance.new("UICorner")
                                KnobCorner.CornerRadius = UDim.new(1, 0)
                                KnobCorner.Parent = Knob

                                local dragging = false

                                local function update(val)
                                    value = math.clamp(math.floor(val + 0.5), min, max)
                                    local alpha = (max == min) and 0 or (value - min) / (max - min)
                                    local percent = math.floor(alpha * 100 + 0.5)
                                    ValueLabel.Text = tostring(value) .. " (" .. percent .. "%)"
                                    Tween(Fill, {Size = UDim2.new(alpha, 0, 1, 0)})
                                    Tween(Knob, {Position = UDim2.new(alpha, -7, 0.5, -7)})
                                    if flag then Library.Flags[flag] = value end
                                    callback(value)
                                end

                                Track.InputBegan:Connect(function(input)
                                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                        dragging = true
                                    end
                                end)

                                UserInputService.InputEnded:Connect(function(input)
                                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                        dragging = false
                                    end
                                end)

                                UserInputService.InputChanged:Connect(function(input)
                                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                                        local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                                        update(min + (max - min) * pos)
                                    end
                                end)

                                update(default)
                        end

                        function SectionObj:NewNumberBox(numberText, numberInfo, default, callback)
                                callback = callback or function() end
                                default = default or 0

                                local NumberContainer = Instance.new("Frame")
                                NumberContainer.Size = UDim2.new(1, 0, 0, 40)
                                NumberContainer.BackgroundTransparency = 1
                                NumberContainer.Parent = Inner

                                local Title = Instance.new("TextLabel")
                                Title.Size = UDim2.new(1, -100, 0, 18)
                                Title.Position = UDim2.new(0, 10, 0, 2)
                                Title.BackgroundTransparency = 1
                                Title.Text = numberText or "Number"
                                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Title.Font = Enum.Font.GothamMedium
                                Title.TextSize = 13
                                Title.TextXAlignment = Enum.TextXAlignment.Left
                                Title.Parent = NumberContainer

                                local Info = Instance.new("TextLabel")
                                Info.Size = UDim2.new(1, -100, 0, 14)
                                Info.Position = UDim2.new(0, 10, 0, 20)
                                Info.BackgroundTransparency = 1
                                Info.Text = numberInfo or "Type any number"
                                Info.TextColor3 = Color3.fromRGB(150, 150, 150)
                                Info.Font = Enum.Font.Gotham
                                Info.TextSize = 11
                                Info.TextXAlignment = Enum.TextXAlignment.Left
                                Info.Parent = NumberContainer

                                local Box = Instance.new("Frame")
                                Box.Size = UDim2.new(0, 80, 0, 28)
                                Box.Position = UDim2.new(1, -90, 0.5, -14)
                                Box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                                Box.BorderSizePixel = 0
                                Box.Parent = NumberContainer

                                local BoxCorner = Instance.new("UICorner")
                                BoxCorner.CornerRadius = UDim.new(0, 6)
                                BoxCorner.Parent = Box

                                local TextBox = Instance.new("TextBox")
                                TextBox.Size = UDim2.new(1, -10, 1, 0)
                                TextBox.Position = UDim2.new(0, 5, 0, 0)
                                TextBox.BackgroundTransparency = 1
                                TextBox.Text = tostring(default)
                                TextBox.PlaceholderText = "0"
                                TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
                                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                                TextBox.Font = Enum.Font.GothamMedium
                                TextBox.TextSize = 13
                                TextBox.TextXAlignment = Enum.TextXAlignment.Center
                                TextBox.ClearTextOnFocus = false
                                TextBox.Parent = Box

                                TextBox.FocusLost:Connect(function()
                                    local num = tonumber(TextBox.Text)
                                    if num then
                                        callback(num)
                                        TextBox.Text = tostring(num)
                                    else
                                        TextBox.Text = tostring(default)
                                    end
                                end)
                        end

function SectionObj:NewButton(buttonText, buttonInfo, callback)
                                callback = callback or function() end
                                local ButtonContainer = Instance.new("Frame")
                                ButtonContainer.Size = UDim2.new(1, 0, 0, 40)
                                ButtonContainer.BackgroundTransparency = 1
                                ButtonContainer.Parent = Inner

                                local Title = Instance.new("TextLabel")
                                Title.Size = UDim2.new(1, -60, 0, 18)
                                Title.Position = UDim2.new(0, 10, 0, 2)
                                Title.BackgroundTransparency = 1
                                Title.Text = buttonText
                                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Title.Font = Enum.Font.GothamMedium
                                Title.TextSize = 13
                                Title.TextXAlignment = Enum.TextXAlignment.Left
                                Title.Parent = ButtonContainer

                                local Info = Instance.new("TextLabel")
                                Info.Size = UDim2.new(1, -60, 0, 14)
                                Info.Position = UDim2.new(0, 10, 0, 20)
                                Info.BackgroundTransparency = 1
                                Info.Text = buttonInfo or ""
                                Info.TextColor3 = Color3.fromRGB(150, 150, 200)
                                Info.Font = Enum.Font.Gotham
                                Info.TextSize = 11
                                Info.TextXAlignment = Enum.TextXAlignment.Left
                                Info.Parent = ButtonContainer

                                local Btn = Instance.new("TextButton")
                                Btn.Size = UDim2.new(0, 50, 0, 24)
                                Btn.Position = UDim2.new(1, -60, 0.5, -12)
                                Btn.BackgroundColor3 = Color3.fromRGB(0, 137, 123)
                                Btn.Text = "Run"
                                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Btn.Font = Enum.Font.GothamMedium
                                Btn.TextSize = 12
                                Btn.Parent = ButtonContainer

                                local BtnCorner = Instance.new("UICorner")
                                BtnCorner.CornerRadius = UDim.new(0, 6)
                                BtnCorner.Parent = Btn

                                Btn.MouseButton1Click:Connect(callback)
                        end


                        function SectionObj:NewColorPicker(colorText, colorInfo, default, callback)
                                callback = callback or function() end
                                default = default or Color3.fromRGB(0,137,123)
                                
                                local ColorContainer = Instance.new("Frame")
                                ColorContainer.Size = UDim2.new(1, 0, 0, 40)
                                ColorContainer.BackgroundTransparency = 1
                                ColorContainer.Parent = Inner
                                
                                local Title = Instance.new("TextLabel")
                                Title.Size = UDim2.new(1, -60, 0, 18)
                                Title.Position = UDim2.new(0, 10, 0, 2)
                                Title.BackgroundTransparency = 1
                                Title.Text = colorText or "Color"
                                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Title.Font = Enum.Font.GothamMedium
                                Title.TextSize = 13
                                Title.TextXAlignment = Enum.TextXAlignment.Left
                                Title.Parent = ColorContainer
                                
                                local Info = Instance.new("TextLabel")
                                Info.Size = UDim2.new(1, -60, 0, 14)
                                Info.Position = UDim2.new(0, 10, 0, 20)
                                Info.BackgroundTransparency = 1
                                Info.Text = colorInfo or ""
                                Info.TextColor3 = Color3.fromRGB(150, 150, 150)
                                Info.Font = Enum.Font.Gotham
                                Info.TextSize = 11
                                Info.TextXAlignment = Enum.TextXAlignment.Left
                                Info.Parent = ColorContainer
                                
                                local ColorBtn = Instance.new("TextButton")
                                ColorBtn.Size = UDim2.new(0, 40, 0, 24)
                                ColorBtn.Position = UDim2.new(1, -50, 0.5, -12)
                                ColorBtn.BackgroundColor3 = default
                                ColorBtn.Text = ""
                                ColorBtn.Parent = ColorContainer
                                
                                local BtnCorner = Instance.new("UICorner")
                                BtnCorner.CornerRadius = UDim.new(0, 6)
                                BtnCorner.Parent = ColorBtn
                                
                                local colors = {
                                    Color3.fromRGB(0,137,123), Color3.fromRGB(211,47,47),
                                    Color3.fromRGB(25,118,210), Color3.fromRGB(123,31,162),
                                    Color3.fromRGB(255,143,0), Color3.fromRGB(56,142,60)
                                }
                                local idx = 1
                                
                                ColorBtn.MouseButton1Click:Connect(function()
                                    idx = idx % #colors + 1
                                    local col = colors[idx]
                                    ColorBtn.BackgroundColor3 = col
                                    callback(col)
                                end)
                                callback(default)
                        end

                        function SectionObj:NewKeybind(keyText, keyInfo, default, callback)
                                callback = callback or function() end
                                default = default or Enum.KeyCode.RightShift
                                
                                local KeyContainer = Instance.new("Frame")
                                KeyContainer.Size = UDim2.new(1, 0, 0, 40)
                                KeyContainer.BackgroundTransparency = 1
                                KeyContainer.Parent = Inner
                                
                                local Title = Instance.new("TextLabel")
                                Title.Size = UDim2.new(1, -80, 0, 18)
                                Title.Position = UDim2.new(0, 10, 0, 2)
                                Title.BackgroundTransparency = 1
                                Title.Text = keyText or "Keybind"
                                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Title.Font = Enum.Font.GothamMedium
                                Title.TextSize = 13
                                Title.TextXAlignment = Enum.TextXAlignment.Left
                                Title.Parent = KeyContainer
                                
                                local Info = Instance.new("TextLabel")
                                Info.Size = UDim2.new(1, -80, 0, 14)
                                Info.Position = UDim2.new(0, 10, 0, 20)
                                Info.BackgroundTransparency = 1
                                Info.Text = keyInfo or ""
                                Info.TextColor3 = Color3.fromRGB(150, 150, 150)
                                Info.Font = Enum.Font.Gotham
                                Info.TextSize = 11
                                Info.TextXAlignment = Enum.TextXAlignment.Left
                                Info.Parent = KeyContainer
                                
                                local KeyBtn = Instance.new("TextButton")
                                KeyBtn.Size = UDim2.new(0, 60, 0, 24)
                                KeyBtn.Position = UDim2.new(1, -70, 0.5, -12)
                                KeyBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
                                KeyBtn.Text = default.Name
                                KeyBtn.TextColor3 = Color3.fromRGB(255,255,255)
                                KeyBtn.Font = Enum.Font.GothamMedium
                                KeyBtn.TextSize = 12
                                KeyBtn.Parent = KeyContainer
                                
                                local BtnCorner = Instance.new("UICorner")
                                BtnCorner.CornerRadius = UDim.new(0, 6)
                                BtnCorner.Parent = KeyBtn
                                
                                local listening = false
                                KeyBtn.MouseButton1Click:Connect(function()
                                    listening = true
                                    KeyBtn.Text = "..."
                                end)
                                
                                UserInputService.InputBegan:Connect(function(input, gp)
                                    if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                                        listening = false
                                        default = input.KeyCode
                                        KeyBtn.Text = default.Name
                                        callback(default)
                                    elseif not gp and input.KeyCode == default then
                                        callback(default)
                                    end
                                end)
                        end

                        function SectionObj:NewLabel(text)
                                local Label = Instance.new("TextLabel")
                                Label.Size = UDim2.new(1, -20, 0, 20)
                                Label.Position = UDim2.new(0, 10, 0, 0)
                                Label.BackgroundTransparency = 1
                                Label.Text = text or ""
                                Label.TextColor3 = Color3.fromRGB(180,180,180)
                                Label.Font = Enum.Font.Gotham
                                Label.TextSize = 12
                                Label.TextXAlignment = Enum.TextXAlignment.Left
                                Label.Parent = Inner
                                Label.Size = UDim2.new(1, -20, 0, Label.TextBounds.Y + 4)
                        end


                        return SectionObj
                end

                return TabObj
        end

        return Window
end

return Library