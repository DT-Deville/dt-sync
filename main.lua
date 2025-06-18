-- GardenSync GUI - Safe Local Player Info Display
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "GardenSyncGui"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 400, 0, 250)
main.Position = UDim2.new(0.5, -200, 0.5, -125)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 0
main.BackgroundTransparency = 1

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🌱 GardenSync | Grow Your Garden"
title.TextColor3 = Color3.fromRGB(100, 255, 100)
title.Font = Enum.Font.GothamBold
title.TextSize = 24

local loading = Instance.new("TextLabel", main)
loading.Position = UDim2.new(0, 0, 0, 60)
loading.Size = UDim2.new(1, 0, 0, 30)
loading.TextColor3 = Color3.fromRGB(255, 255, 255)
loading.Font = Enum.Font.Gotham
loading.TextSize = 18
loading.BackgroundTransparency = 1
loading.Text = "Planting seeds..."

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

-- Fade In Animation
for i = 1, 10 do
	main.BackgroundTransparency = 1 - (i * 0.1)
	wait(0.05)
end

-- Loading Animation
for i = 1, 3 do
	loading.Text = "Planting seeds" .. string.rep(".", i)
	wait(0.6)
end
status.Text = "Preparing soil..."
wait(1)
status.Text = "Checking your sprouts..."
wait(1.2)

-- Collect Player and Pet Data
local petList = {}
local gameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
pcall(function()
	local lib = require(ReplicatedStorage:FindFirstChild("Framework") and ReplicatedStorage.Framework:FindFirstChild("Library"))
	local save = lib.Save.Get().Inventory.Pets
	for id, data in pairs(save) do
		table.insert(petList, data.id or "Unknown Seed")
	end
end)

-- Display Data in "Garden"
loading.Text = "Garden fully grown!"
status.Text = "🌼 Ready to view your garden!"
if #petList > 0 then
	gardenDisplay.Text = "🌿 Your Garden:\n" .. table.concat(petList, "\n")
else
	gardenDisplay.Text = "🌿 Your Garden: No seeds planted yet!"
end

-- Keep GUI Open for 10 Seconds
wait(10)

-- Fade Out Animation
for i = 1, 10 do
	main.BackgroundTransparency = i * 0.1
	title.TextTransparency = i * 0.1
	loading.TextTransparency = i * 0.1
	status.TextTransparency = i * 0.1
	gardenDisplay.TextTransparency = i * 0.1
	wait(0.05)
end
gui:Destroy()
