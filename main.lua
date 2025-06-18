-- DT SYNC TOOL v1 by Bossing
-- GUI + Script Loader + Webhook + Full Collect

-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("DT SYNC TOOL v1", "DarkTheme")

-- Tabs
local MainTab = Window:NewTab("Main")
local Scripts = MainTab:NewSection("Script Hub")
local Logs = MainTab:NewSection("Webhook Logger")

-- Script Loader Section
Scripts:NewButton("Auto Fruit Grab", "Grabs all fruits", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YOURUSER/YOURREPO/main/fruit.lua"))()
end)

Scripts:NewButton("Auto Coin Grab", "Collects coins fast", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YOURUSER/YOURREPO/main/coin.lua"))()
end)

Scripts:NewButton("ESP Items", "ESP for all items", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YOURUSER/YOURREPO/main/esp.lua"))()
end)

Scripts:NewButton("Auto Collect All (Fruits, Coins, Pets)", "Ultimate Grab", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YOURUSER/YOURREPO/main/autocollect.lua"))()
end)

-- Webhook Logger Section
Logs:NewTextbox("Webhook URL", "Paste your Discord Webhook", function(value)
    getgenv().webhook = value
end)

Logs:NewButton("Send Log Now", "Sends test log to webhook", function()
    if getgenv().webhook then
        local http = game:GetService("HttpService")
        local payload = http:JSONEncode({
            content = "**DT SYNC TOOL Log**",
            embeds = {{
                title = "User Log",
                description = "✅ Player: "..game.Players.LocalPlayer.Name.."\n🕒 "..os.date("%c"),
                color = 65280
            }}
        })
        syn.request({
            Url = getgenv().webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = payload
        })
    end
end)
