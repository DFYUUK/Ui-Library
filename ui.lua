local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")

local parentLocation = Players.LocalPlayer:WaitForChild("PlayerGui")

local Library = {}

local LOGO_ASSET = "rbxassetid://100968456165945"
pcall(function()
        ContentProvider:PreloadAsync({LOGO_ASSET})
end)

local function Tween(instance, properties, duration, easingStyle, easingDirection)
        local tweenInfo = TweenInfo.new(duration or 0.3, easingStyle or Enum.EasingStyle.Quart, easingDirection or Enum.EasingDirection.Out)
        local tween = TweenService:Create(instance, tweenInfo, properties)
        tween:Play()
        return tween
end

function Library:CreateWindow(titleText)
        local Window = {}
        
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "EliteGlassUI"
        ScreenGui.Parent = parentLocation
        ScreenGui.ResetOnSpawn = false
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        ScreenGui.DisplayOrder = 999999999
        ScreenGui.IgnoreGuiInset = true

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

        
        UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
                if gameProcessedEvent then return end
                if input.KeyCode == Enum.KeyCode.P then
                        setVisible(not isVisible)
                end
        end)

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
                
                MainFrame.Visible = true
                Tween(MainFrame, {BackgroundTransparency = 0.4})
                Tween(TopBar, {BackgroundTransparency = 0.2})
                Tween(TopBarCover, {BackgroundTransparency = 0.2})
                Tween(MainStroke, {Transparency = 0.5})
                Tween(Title, {TextTransparency = 0})
                
                isVisible = true
                task.wait(0.3)
                MainFrame.ClipsDescendants = false
                
                MobileToggle.Visible = true
                Tween(MobileToggle, {BackgroundTransparency = 0.2}, 0.3)
        end)

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
                                        callback(state)
                                end

                                Button.MouseButton1Click:Connect(function()
                                        state = not state
                                        update()
                                end)

                                update()
                        end

                        function SectionObj:CreateLabel(labelText, labelInfo)
                                local LabelContainer = Instance.new("Frame")
                                LabelContainer.Size = UDim2.new(1, 0, 0, 0)
                                LabelContainer.AutomaticSize = Enum.AutomaticSize.Y
                                LabelContainer.BackgroundTransparency = 1
                                LabelContainer.Parent = Inner

                                local Title = Instance.new("TextLabel")
                                Title.Size = UDim2.new(1, -20, 0, 0)
                                Title.AutomaticSize = Enum.AutomaticSize.Y
                                Title.Position = UDim2.new(0, 10, 0, 2)
                                Title.BackgroundTransparency = 1
                                Title.Text = labelText
                                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Title.Font = Enum.Font.GothamMedium
                                Title.TextSize = 13
                                Title.TextXAlignment = Enum.TextXAlignment.Left
                                Title.TextWrapped = true
                                Title.Parent = LabelContainer

                                local Info = Instance.new("TextLabel")
                                Info.Size = UDim2.new(1, -20, 0, 0)
                                Info.AutomaticSize = Enum.AutomaticSize.Y
                                Info.Position = UDim2.new(0, 10, 0, Title.Position.Y.Offset + Title.AbsoluteSize.Y + 4)
                                Info.BackgroundTransparency = 1
                                Info.Text = labelInfo or ""
                                Info.TextColor3 = Color3.fromRGB(150, 150, 150)
                                Info.Font = Enum.Font.Gotham
                                Info.TextSize = 11
                                Info.TextXAlignment = Enum.TextXAlignment.Left
                                Info.TextWrapped = true
                                Info.Parent = LabelContainer
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

                        function SectionObj:NewSlider(sliderText, sliderInfo, min, max, default, callback)
                                callback = callback or function() end
                                local value = default or min
                                local isDragging = false
                                local isHovering = false
                                
                                local SliderContainer = Instance.new("Frame")
                                SliderContainer.Size = UDim2.new(1, 0, 0, 60)
                                SliderContainer.BackgroundTransparency = 1
                                SliderContainer.Parent = Inner

                                local Title = Instance.new("TextLabel")
                                Title.Size = UDim2.new(1, -60, 0, 16)
                                Title.Position = UDim2.new(0, 10, 0, 2)
                                Title.BackgroundTransparency = 1
                                Title.Text = sliderText
                                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Title.Font = Enum.Font.GothamMedium
                                Title.TextSize = 13
                                Title.TextXAlignment = Enum.TextXAlignment.Left
                                Title.Parent = SliderContainer

                                local Info = Instance.new("TextLabel")
                                Info.Size = UDim2.new(1, -60, 0, 12)
                                Info.Position = UDim2.new(0, 10, 0, 18)
                                Info.BackgroundTransparency = 1
                                Info.Text = sliderInfo or ""
                                Info.TextColor3 = Color3.fromRGB(150, 150, 150)
                                Info.Font = Enum.Font.Gotham
                                Info.TextSize = 11
                                Info.TextXAlignment = Enum.TextXAlignment.Left
                                Info.Parent = SliderContainer

                                -- Value display matching image style
                                local ValueContainer = Instance.new("Frame")
                                ValueContainer.Size = UDim2.new(0, 50, 0, 24)
                                ValueContainer.Position = UDim2.new(1, -60, 0, 2)
                                ValueContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                                ValueContainer.BackgroundTransparency = 0.2
                                ValueContainer.BorderSizePixel = 0
                                ValueContainer.Parent = SliderContainer

                                local ValueCorner = Instance.new("UICorner")
                                ValueCorner.CornerRadius = UDim.new(0, 4)
                                ValueCorner.Parent = ValueContainer

                                local ValueStroke = Instance.new("UIStroke")
                                ValueStroke.Color = Color3.fromRGB(60, 60, 60)
                                ValueStroke.Thickness = 1
                                ValueStroke.Transparency = 0.5
                                ValueStroke.Parent = ValueContainer

                                local ValueLabel = Instance.new("TextLabel")
                                ValueLabel.Size = UDim2.new(1, -8, 1, 0)
                                ValueLabel.Position = UDim2.new(0, 4, 0, 0)
                                ValueLabel.BackgroundTransparency = 1
                                ValueLabel.Text = tostring(math.floor(value))
                                ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                                ValueLabel.Font = Enum.Font.GothamMedium
                                ValueLabel.TextSize = 12
                                ValueLabel.TextXAlignment = Enum.TextXAlignment.Center
                                ValueLabel.Parent = ValueContainer

                                -- Slider track matching image style
                                local SliderTrack = Instance.new("Frame")
                                SliderTrack.Size = UDim2.new(1, -20, 0, 6)
                                SliderTrack.Position = UDim2.new(0, 10, 0, 42)
                                SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                                SliderTrack.BorderSizePixel = 0
                                SliderTrack.Parent = SliderContainer

                                local TrackCorner = Instance.new("UICorner")
                                TrackCorner.CornerRadius = UDim.new(1, 0)
                                TrackCorner.Parent = SliderTrack

                                -- Dark filled portion
                                local SliderFill = Instance.new("Frame")
                                SliderFill.Size = UDim2.new(0, 0, 1, 0)
                                SliderFill.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                                SliderFill.BorderSizePixel = 0
                                SliderFill.Parent = SliderTrack

                                local FillCorner = Instance.new("UICorner")
                                FillCorner.CornerRadius = UDim.new(1, 0)
                                FillCorner.Parent = SliderFill

                                
                                -- Invisible hitbox
                                local SliderButton = Instance.new("TextButton")
                                SliderButton.Size = UDim2.new(1, -20, 0, 20)
                                SliderButton.Position = UDim2.new(0, 10, 0, 35)
                                SliderButton.BackgroundTransparency = 1
                                SliderButton.Text = ""
                                SliderButton.Parent = SliderContainer

                                local function updateSlider(animate)
                                        local percentage = (value - min) / (max - min)
                                        
                                        if animate then
                                                Tween(SliderFill, {Size = UDim2.new(percentage, 0, 1, 0)}, 0.15)
                                        else
                                                SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                                        end
                                        
                                        ValueLabel.Text = tostring(math.floor(value))
                                        
                                        -- Visual feedback for track only
                                        if isDragging then
                                                Tween(SliderTrack, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}, 0.1)
                                        elseif isHovering then
                                                Tween(SliderTrack, {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}, 0.1)
                                        else
                                                Tween(SliderTrack, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.1)
                                        end
                                        
                                        callback(value)
                                end

                                SliderButton.MouseButton1Down:Connect(function()
                                        isDragging = true
                                        updateSlider(false)
                                end)

                                SliderButton.MouseEnter:Connect(function()
                                        isHovering = true
                                        if not isDragging then
                                                updateSlider(false)
                                        end
                                end)

                                SliderButton.MouseLeave:Connect(function()
                                        isHovering = false
                                        if not isDragging then
                                                updateSlider(false)
                                        end
                                end)

                                UserInputService.InputChanged:Connect(function(input)
                                        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                                                local mousePos = input.Position
                                                local sliderPos = SliderTrack.AbsolutePosition
                                                local sliderSize = SliderTrack.AbsoluteSize
                                                local relativeX = mousePos.X - sliderPos.X
                                                local percentage = math.clamp(relativeX / sliderSize.X, 0, 1)
                                                value = min + (max - min) * percentage
                                                updateSlider(false)
                                        end
                                end)

                                UserInputService.InputEnded:Connect(function(input)
                                        if input.UserInputType == Enum.UserInputType.MouseButton1 and isDragging then
                                                isDragging = false
                                                updateSlider(true)
                                        end
                                end)

                                updateSlider(false)
                        end

                        function SectionObj:NewNumberBox(boxText, boxInfo, default, callback)
                                callback = callback or function() end
                                local value = default or 0
                                local isFocused = false
                                
                                local NumberBoxContainer = Instance.new("Frame")
                                NumberBoxContainer.Size = UDim2.new(1, 0, 0, 45)
                                NumberBoxContainer.BackgroundTransparency = 1
                                NumberBoxContainer.Parent = Inner

                                local Title = Instance.new("TextLabel")
                                Title.Size = UDim2.new(1, -140, 0, 16)
                                Title.Position = UDim2.new(0, 10, 0, 2)
                                Title.BackgroundTransparency = 1
                                Title.Text = boxText
                                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Title.Font = Enum.Font.GothamMedium
                                Title.TextSize = 13
                                Title.TextXAlignment = Enum.TextXAlignment.Left
                                Title.Parent = NumberBoxContainer

                                local Info = Instance.new("TextLabel")
                                Info.Size = UDim2.new(1, -140, 0, 12)
                                Info.Position = UDim2.new(0, 10, 0, 18)
                                Info.BackgroundTransparency = 1
                                Info.Text = boxInfo or ""
                                Info.TextColor3 = Color3.fromRGB(150, 150, 150)
                                Info.Font = Enum.Font.Gotham
                                Info.TextSize = 11
                                Info.TextXAlignment = Enum.TextXAlignment.Left
                                Info.Parent = NumberBoxContainer

                                -- Main container matching image style
                                local InputContainer = Instance.new("Frame")
                                InputContainer.Size = UDim2.new(0, 120, 0, 28)
                                InputContainer.Position = UDim2.new(1, -130, 0.5, -14)
                                InputContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                                InputContainer.BackgroundTransparency = 0.2
                                InputContainer.BorderSizePixel = 0
                                InputContainer.Parent = NumberBoxContainer

                                local ContainerCorner = Instance.new("UICorner")
                                ContainerCorner.CornerRadius = UDim.new(0, 4)
                                ContainerCorner.Parent = InputContainer

                                local ContainerStroke = Instance.new("UIStroke")
                                ContainerStroke.Color = Color3.fromRGB(60, 60, 60)
                                ContainerStroke.Thickness = 1
                                ContainerStroke.Transparency = 0.5
                                ContainerStroke.Parent = InputContainer

                                -- Number input field
                                local NumberBox = Instance.new("TextBox")
                                NumberBox.Size = UDim2.new(1, -40, 1, -4)
                                NumberBox.Position = UDim2.new(0, 4, 0, 2)
                                NumberBox.BackgroundTransparency = 1
                                NumberBox.BorderSizePixel = 0
                                NumberBox.Text = tostring(value)
                                NumberBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                                NumberBox.Font = Enum.Font.GothamMedium
                                NumberBox.TextSize = 12
                                NumberBox.PlaceholderText = "0"
                                NumberBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
                                NumberBox.TextTruncate = Enum.TextTruncate.AtEnd
                                NumberBox.ClipsDescendants = true
                                NumberBox.Parent = InputContainer

                                -- Up arrow button
                                local UpButton = Instance.new("TextButton")
                                UpButton.Size = UDim2.new(0, 16, 0, 12)
                                UpButton.Position = UDim2.new(1, -20, 0, 2)
                                UpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                                UpButton.BackgroundTransparency = 0.3
                                UpButton.BorderSizePixel = 0
                                UpButton.Text = "▲"
                                UpButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                                UpButton.Font = Enum.Font.Gotham
                                UpButton.TextSize = 8
                                UpButton.Parent = InputContainer

                                local UpCorner = Instance.new("UICorner")
                                UpCorner.CornerRadius = UDim.new(0, 2)
                                UpCorner.Parent = UpButton

                                -- Down arrow button
                                local DownButton = Instance.new("TextButton")
                                DownButton.Size = UDim2.new(0, 16, 0, 12)
                                DownButton.Position = UDim2.new(1, -20, 0, 14)
                                DownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                                DownButton.BackgroundTransparency = 0.3
                                DownButton.BorderSizePixel = 0
                                DownButton.Text = "▼"
                                DownButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                                DownButton.Font = Enum.Font.Gotham
                                DownButton.TextSize = 8
                                DownButton.Parent = InputContainer

                                local DownCorner = Instance.new("UICorner")
                                DownCorner.CornerRadius = UDim.new(0, 2)
                                DownCorner.Parent = DownButton

                                local function formatNumber(num)
                                        if num >= 1000000 then
                                                return string.format("%.2fM", num / 1000000)
                                        elseif num >= 1000 then
                                                return string.format("%.2fK", num / 1000)
                                        else
                                                return tostring(math.floor(num * 100) / 100)
                                        end
                                end

                                local function updateVisualState(isValid)
                                        if isFocused then
                                                if isValid then
                                                        Tween(InputContainer, {BackgroundColor3 = Color3.fromRGB(40, 45, 50)}, 0.2)
                                                        Tween(ContainerStroke, {Color = Color3.fromRGB(0, 137, 123), Transparency = 0.3}, 0.2)
                                                else
                                                        Tween(InputContainer, {BackgroundColor3 = Color3.fromRGB(50, 40, 40)}, 0.2)
                                                        Tween(ContainerStroke, {Color = Color3.fromRGB(220, 80, 80), Transparency = 0.4}, 0.2)
                                                end
                                        else
                                                if isValid then
                                                        Tween(InputContainer, {BackgroundColor3 = Color3.fromRGB(35, 35, 35), BackgroundTransparency = 0.2}, 0.2)
                                                        Tween(ContainerStroke, {Color = Color3.fromRGB(60, 60, 60), Transparency = 0.5}, 0.2)
                                                else
                                                        Tween(InputContainer, {BackgroundColor3 = Color3.fromRGB(45, 35, 35), BackgroundTransparency = 0.2}, 0.2)
                                                        Tween(ContainerStroke, {Color = Color3.fromRGB(180, 60, 60), Transparency = 0.6}, 0.2)
                                                end
                                        end
                                end

                                local function updateValue()
                                        local numValue = tonumber(NumberBox.Text)
                                        if numValue then
                                                value = numValue
                                                callback(value)
                                                updateVisualState(true)
                                                
                                                if not isFocused and #NumberBox.Text > 8 then
                                                        NumberBox.Text = formatNumber(numValue)
                                                end
                                        else
                                                updateVisualState(false)
                                        end
                                end

                                local function incrementValue(inc)
                                        local newValue = value + inc
                                        local numValue = tonumber(newValue)
                                        if numValue then
                                                value = numValue
                                                NumberBox.Text = tostring(value)
                                                callback(value)
                                                updateVisualState(true)
                                        end
                                end

                                -- Button interactions
                                UpButton.MouseButton1Click:Connect(function()
                                        incrementValue(1)
                                end)

                                DownButton.MouseButton1Click:Connect(function()
                                        incrementValue(-1)
                                end)

                                UpButton.MouseEnter:Connect(function()
                                        Tween(UpButton, {BackgroundColor3 = Color3.fromRGB(70, 70, 70), BackgroundTransparency = 0.2}, 0.1)
                                end)

                                UpButton.MouseLeave:Connect(function()
                                        Tween(UpButton, {BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.3}, 0.1)
                                end)

                                DownButton.MouseEnter:Connect(function()
                                        Tween(DownButton, {BackgroundColor3 = Color3.fromRGB(70, 70, 70), BackgroundTransparency = 0.2}, 0.1)
                                end)

                                DownButton.MouseLeave:Connect(function()
                                        Tween(DownButton, {BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.3}, 0.1)
                                end)

                                NumberBox.Focused:Connect(function()
                                        isFocused = true
                                        NumberBox.Text = tostring(value)
                                        updateVisualState(tonumber(NumberBox.Text) ~= nil)
                                end)

                                NumberBox.FocusLost:Connect(function(enterPressed)
                                        isFocused = false
                                        updateValue()
                                end)

                                NumberBox.MouseEnter:Connect(function()
                                        if not isFocused then
                                                Tween(InputContainer, {BackgroundTransparency = 0}, 0.2)
                                                Tween(ContainerStroke, {Transparency = 0.3}, 0.2)
                                        end
                                end)

                                NumberBox.MouseLeave:Connect(function()
                                        if not isFocused then
                                                Tween(InputContainer, {BackgroundTransparency = 0.2}, 0.2)
                                                updateVisualState(tonumber(NumberBox.Text) ~= nil)
                                        end
                                end)

                                NumberBox.Changed:Connect(function(property)
                                        if property == "Text" and isFocused then
                                                local isValid = tonumber(NumberBox.Text) ~= nil or NumberBox.Text == "" or NumberBox.Text == "-"
                                                updateVisualState(isValid)
                                        end
                                end)

                                NumberBox.Focused:Connect(function()
                                        NumberBox.Text = NumberBox.Text:gsub("[^%d%.%-]", "")
                                end)

                                updateValue()
                        end

                        function SectionObj:NewDropdown(dropdownText, options, callback)
                                callback = callback or function() end
                                local selectedOption = ""
                                local isDropdownOpen = false

                                local DropdownContainer = Instance.new("Frame")
                                DropdownContainer.Size = UDim2.new(1, 0, 0, 35)
                                DropdownContainer.BackgroundTransparency = 1
                                DropdownContainer.Parent = Inner

                                local Title = Instance.new("TextLabel")
                                Title.Size = UDim2.new(1, -140, 0, 16)
                                Title.Position = UDim2.new(0, 10, 0, 2)
                                Title.BackgroundTransparency = 1
                                Title.Text = dropdownText
                                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Title.Font = Enum.Font.GothamMedium
                                Title.TextSize = 13
                                Title.TextXAlignment = Enum.TextXAlignment.Left
                                Title.Parent = DropdownContainer

                                local DropdownButton = Instance.new("TextButton")
                                DropdownButton.Size = UDim2.new(0, 120, 0, 28)
                                DropdownButton.Position = UDim2.new(1, -130, 0.5, -14)
                                DropdownButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                                DropdownButton.BackgroundTransparency = 0.2
                                DropdownButton.BorderSizePixel = 0
                                DropdownButton.Text = "- Select -"
                                DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                                DropdownButton.Font = Enum.Font.GothamMedium
                                DropdownButton.TextSize = 12
                                DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
                                DropdownButton.TextTruncate = Enum.TextTruncate.AtEnd
                                DropdownButton.Parent = DropdownContainer

                                local ButtonCorner = Instance.new("UICorner")
                                ButtonCorner.CornerRadius = UDim.new(0, 4)
                                ButtonCorner.Parent = DropdownButton

                                local ButtonStroke = Instance.new("UIStroke")
                                ButtonStroke.Color = Color3.fromRGB(60, 60, 60)
                                ButtonStroke.Thickness = 1
                                ButtonStroke.Transparency = 0.5
                                ButtonStroke.Parent = DropdownButton

                                local ArrowLabel = Instance.new("TextLabel")
                                ArrowLabel.Size = UDim2.new(0, 20, 1, -4)
                                ArrowLabel.Position = UDim2.new(1, -20, 0, 2)
                                ArrowLabel.BackgroundTransparency = 1
                                ArrowLabel.Text = "▼"
                                ArrowLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                                ArrowLabel.Font = Enum.Font.Gotham
                                ArrowLabel.TextSize = 10
                                ArrowLabel.TextXAlignment = Enum.TextXAlignment.Center
                                ArrowLabel.Parent = DropdownButton

                                -- Options container positioned outside to avoid overlap
                                local OptionsContainer = Instance.new("Frame")
                                OptionsContainer.Size = UDim2.new(0, 120, 0, 0)
                                OptionsContainer.Position = UDim2.new(1, -130, 1, 10) -- Position below with gap
                                OptionsContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                                OptionsContainer.BackgroundTransparency = 0.2
                                OptionsContainer.BorderSizePixel = 0
                                OptionsContainer.Visible = false
                                OptionsContainer.ClipsDescendants = true
                                OptionsContainer.ZIndex = 10 -- Higher ZIndex to appear above other elements
                                OptionsContainer.Parent = DropdownContainer

                                local OptionsCorner = Instance.new("UICorner")
                                OptionsCorner.CornerRadius = UDim.new(0, 4)
                                OptionsCorner.Parent = OptionsContainer

                                local OptionsStroke = Instance.new("UIStroke")
                                OptionsStroke.Color = Color3.fromRGB(60, 60, 60)
                                OptionsStroke.Thickness = 1
                                OptionsStroke.Transparency = 0.5
                                OptionsStroke.Parent = OptionsContainer

                                local OptionsList = Instance.new("UIListLayout")
                                OptionsList.SortOrder = Enum.SortOrder.LayoutOrder
                                OptionsList.Padding = UDim.new(0, 2)
                                OptionsList.Parent = OptionsContainer

                                local optionButtons = {}
                                
                                for i, option in ipairs(options) do
                                        local OptionButton = Instance.new("TextButton")
                                        OptionButton.Size = UDim2.new(1, -8, 0, 24)
                                        OptionButton.Position = UDim2.new(0, 4, 0, 0)
                                        OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                                        OptionButton.BackgroundTransparency = 0.8
                                        OptionButton.BorderSizePixel = 0
                                        OptionButton.Text = option
                                        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                                        OptionButton.Font = Enum.Font.Gotham
                                        OptionButton.TextSize = 11
                                        OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                                        OptionButton.LayoutOrder = i
                                        OptionButton.ZIndex = 11 -- Higher than container
                                        OptionButton.Parent = OptionsContainer
                                        
                                        local OptionCorner = Instance.new("UICorner")
                                        OptionCorner.CornerRadius = UDim.new(0, 2)
                                        OptionCorner.Parent = OptionButton
                                        
                                        OptionButton.MouseEnter:Connect(function()
                                                Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.6}, 0.1)
                                        end)
                                        
                                        OptionButton.MouseLeave:Connect(function()
                                                Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(40, 40, 40), BackgroundTransparency = 0.8}, 0.1)
                                        end)
                                        
                                        OptionButton.MouseButton1Click:Connect(function()
                                                selectedOption = option
                                                DropdownButton.Text = selectedOption
                                                isDropdownOpen = false
                                                OptionsContainer.Visible = false
                                                ArrowLabel.Text = "▼"
                                                callback(selectedOption)
                                        end)
                                        
                                        table.insert(optionButtons, OptionButton)
                                end
                                
                                local function toggleDropdown()
                                        isDropdownOpen = not isDropdownOpen
                                        OptionsContainer.Visible = isDropdownOpen
                                        ArrowLabel.Text = isDropdownOpen and "▲" or "▼"
                                        
                                        if isDropdownOpen then
                                                local totalHeight = #options * 26
                                                Tween(OptionsContainer, {Size = UDim2.new(0, 120, 0, totalHeight)}, 0.2)
                                        else
                                                Tween(OptionsContainer, {Size = UDim2.new(0, 120, 0, 0)}, 0.2)
                                        end
                                end
                                
                                DropdownButton.MouseButton1Click:Connect(toggleDropdown)
                                
                                DropdownButton.MouseEnter:Connect(function()
                                        Tween(DropdownButton, {BackgroundTransparency = 0}, 0.2)
                                        Tween(ButtonStroke, {Transparency = 0.3}, 0.2)
                                end)
                                
                                DropdownButton.MouseLeave:Connect(function()
                                        if not isDropdownOpen then
                                                Tween(DropdownButton, {BackgroundTransparency = 0.2}, 0.2)
                                                Tween(ButtonStroke, {Transparency = 0.5}, 0.2)
                                        end
                                end)
                                
                                local dropdownObj = {}
                                function dropdownObj:Get()
                                        return selectedOption
                                end
                                function dropdownObj:Set(option)
                                        if table.find(options, option) then
                                                selectedOption = option
                                                DropdownButton.Text = selectedOption
                                                callback(selectedOption)
                                        end
                                end
                                
                                return dropdownObj
                        end

                        
                        return SectionObj
                end

                return TabObj
        end

        return Window
end

return Library
