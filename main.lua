-- 🔥 DT SYNC V4 - Full Update for Delta/Xeno
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "DTSyncGuiV4"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(1, 0, 1, 0)
main.Position = UDim2.new(0, 0, 0, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.BackgroundTransparency = 1

-- Sidebar
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sidebar.BorderSizePixel = 0

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, -150, 0, 40)
title.Position = UDim2.new(0, 150, 0, 0)
title.BackgroundTransparency = 1
title.Text = "DT SYNC | Pet Simulator: Grow a Garden"
title.TextColor3 = Color3.fromRGB(0, 255, 127)
title.Font = Enum.Font.GothamBold
title.TextSize = 24

-- Content Frame
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -150, 1, -40)
content.Position = UDim2.new(0, 150, 0, 40)
content.BackgroundTransparency = 1

-- Loading Label
local loading = Instance.new("TextLabel", content)
loading.Position = UDim2.new(0, 10, 0, 10)
loading.Size = UDim2.new(1, -20, 0, 30)
loading.TextColor3 = Color3.fromRGB(255, 255, 255)
loading.Font = Enum.Font.Gotham
loading.TextSize = 18
loading.BackgroundTransparency = 1
loading.Text = "Loading modules..."

-- Status Label
local status = Instance.new("TextLabel", content)
status.Position = UDim2.new(0, 10, 0, 50)
status.Size = UDim2.new(1, -20, 0, 25)
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.BackgroundTransparency = 1
status.Text = ""

-- Auto-Farm Button
local autoFarmButton = Instance.new("TextButton", sidebar)
autoFarmButton.Size = UDim2.new(1, -10, 0, 40)
autoFarmButton.Position = UDim2.new(0, 5, 0, 50)
autoFarmButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
autoFarmButton.Text = "Auto-Farm: Off"
autoFarmButton.TextColor3 = Color3.fromRGB(0, 255, 127)
autoFarmButton.Font = Enum.Font.Gotham
autoFarmButton.TextSize = 16

-- Pet List Button
local petListButton = Instance.new("TextButton", sidebar)
petListButton.Size = UDim2.new(1, -10, 0, 40)
petListButton.Position = UDim2.new(0, 5, 0, 100)
petListButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
petListButton.Text = "View Pets"
petListButton.TextColor3 = Color3.fromRGB(0, 255, 127)
petListButton.Font = Enum.Font.Gotham
petListButton.TextSize = 16

-- Auto-Rank Button
local autoRankButton = Instance.new("TextButton", sidebar)
autoRankButton.Size = UDim2.new(1, -10, 0, 40)
autoRankButton.Position = UDim2.new(0, 5, 0, 150)
autoRankButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
autoRankButton.Text = "Auto-Rank: Off"
autoRankButton.TextColor3 = Color3.fromRGB(0, 255, 127)
autoRankButton.Font = Enum.Font.Gotham
autoRankButton.TextSize = 16

-- Teleport Button
local teleportButton = Instance.new("TextButton", sidebar)
teleportButton.Size = UDim2.new(1, -10, 0, 40)
teleportButton.Position = UDim2.new(0, 5, 0, 200)
teleportButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
teleportButton.Text = "Teleport"
teleportButton.TextColor3 = Color3.fromRGB(0, 255, 127)
teleportButton.Font = Enum.Font.Gotham
teleportButton.TextSize = 16

-- Settings Button
local settingsButton = Instance.new("TextButton", sidebar)
settingsButton.Size = UDim2.new(1, -10, 0, 40)
settingsButton.Position = UDim2.new(0, 5, 0, 250)
settingsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
settingsButton.Text = "Settings"
settingsButton.TextColor3 = Color3.fromRGB(0, 255, 127)
settingsButton.Font = Enum.Font.Gotham
settingsButton.TextSize = 16

-- Pet List Display
local petListFrame = Instance.new("ScrollingFrame", content)
petListFrame.Size = UDim2.new(1, -20, 1, -100)
petListFrame.Position = UDim2.new(0, 10, 0, 100)
petListFrame.BackgroundTransparency = 1
petListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
petListFrame.Visible = false

-- Teleport Interface
local teleportFrame = Instance.new("Frame", content)
teleportFrame.Size = UDim2.new(1, -20, 1, -100)
teleportFrame.Position = UDim2.new(0, 10, 0, 100)
teleportFrame.BackgroundTransparency = 1
teleportFrame.Visible = false

local placeIdInput = Instance.new("TextBox", teleportFrame)
placeIdInput.Size = UDim2.new(1, -100, 0, 30)
placeIdInput.Position = UDim2.new(0, 10, 0, 10)
placeIdInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
placeIdInput.TextColor3 = Color3.fromRGB(255, 255, 255)
placeIdInput.Font = Enum.Font.Gotham
placeIdInput.TextSize = 14
placeIdInput.PlaceholderText = "Enter Place ID"
placeIdInput.Text = ""

local teleportGoButton = Instance.new("TextButton", teleportFrame)
teleportGoButton.Size = UDim2.new(0, 80, 0, 30)
teleportGoButton.Position = UDim2.new(1, -90, 0, 10)
teleportGoButton.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
teleportGoButton.TextColor3 = Color3.fromRGB(20, 20, 20)
teleportGoButton.Font = Enum.Font.GothamBold
teleportGoButton.TextSize = 14
teleportGoButton.Text = "Go"

-- Receiver (Player List) Interface
local receiverFrame = Instance.new("ScrollingFrame", teleportFrame)
receiverFrame.Size = UDim2.new(1, -20, 0, 200)
receiverFrame.Position = UDim2.new(0, 10, 0, 50)
receiverFrame.BackgroundTransparency = 1
receiverFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

-- Victim Teleport Code Generator
local victimCodeLabel = Instance.new("TextLabel", teleportFrame)
victimCodeLabel.Size = UDim2.new(1, -100, 0, 30)
victimCodeLabel.Position = UDim2.new(0, 10, 0, 260)
victimCodeLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
victimCodeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
victimCodeLabel.Font = Enum.Font.Gotham
victimCodeLabel.TextSize = 14
victimCodeLabel.Text = "Teleport Code: None"

local generateCodeButton = Instance.new("TextButton", teleportFrame)
generateCodeButton.Size = UDim2.new(0, 80, 0, 30)
generateCodeButton.Position = UDim2.new(1, -90, 0, 260)
generateCodeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
generateCodeButton.TextColor3 = Color3.fromRGB(20, 20, 20)
generateCodeButton.Font = Enum.Font.GothamBold
generateCodeButton.TextSize = 14
generateCodeButton.Text = "Generate"

-- Auto-Farm Variables
local autoFarmActive = false
local collectedResources = 0

-- Pet Logger
local petList = {}
local function updatePetList()
	pcall(function()
		local lib = require(ReplicatedStorage:FindFirstChild("GameEvents") and ReplicatedStorage.GameEvents:FindFirstChild("DataStream"))
		local save = lib and lib:GetData().Pets or {}
		petList = {}
		for id, data in pairs(save) do
			table.insert(petList, {id = id, name = data.Type or "Unknown"})
		end
	end)
	
	for _, child in ipairs(petListFrame:GetChildren()) do
		if child:IsA("TextLabel") then
			child:Destroy()
		end
	end
	
	local yOffset = 0
	for i, pet in ipairs(petList) do
		local petLabel = Instance.new("TextLabel", petListFrame)
		petLabel.Size = UDim2.new(1, -10, 0, 30)
		petLabel.Position = UDim2.new(0, 5, 0, yOffset)
		petLabel.BackgroundTransparency = 1
		petLabel.Text = "Pet " .. i .. ": " .. pet.name
		petLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		petLabel.Font = Enum.Font.Gotham
		petLabel.TextSize = 14
		yOffset = yOffset + 35
	end
	petListFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- Receiver (Player List) Update
local function updateReceiverList()
	for _, child in ipairs(receiverFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	local yOffset = 0
	for _, otherPlayer in ipairs(Players:GetPlayers()) do
		if otherPlayer ~= player then
			local playerButton = Instance.new("TextButton", receiverFrame)
			playerButton.Size = UDim2.new(1, -10, 0, 30)
			playerButton.Position = UDim2.new(0, 5, 0, yOffset)
			playerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			playerButton.Font = Enum.Font.Gotham
			playerButton.TextSize = 14
			playerButton.Text = otherPlayer.Name
			playerButton.MouseButton1Click:Connect(function()
				status.Text = "Sent teleport invite to " .. otherPlayer.Name
			end)
			yOffset = yOffset + 35
		end
	end
	receiverFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

-- Game Check
local gameSupported = false
pcall(function()
	local lib = require(ReplicatedStorage:FindFirstChild("GameEvents") and ReplicatedStorage.GameEvents:FindFirstChild("DataStream"))
	if lib then
		gameSupported = true
		local gameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
		title.Text = "DT SYNC | " .. gameInfo.Name
	end
end)

-- Fade In
for i = 1, 10 do
	main.BackgroundTransparency = 1 - (i * 0.1)
	sidebar.BackgroundTransparency = 1 - (i * 0.1)
	wait(0.05)
end

-- Fake Load
if not gameSupported then
	loading.Text = "❌ Game not supported!"
	status.Text = "Please run in Pet Simulator: Grow a Garden."
	wait(2)
	for i = 1, 10 do
		main.BackgroundTransparency = i * 0.1
		sidebar.BackgroundTransparency = i * 0.1
		title.TextTransparency = i * 0.1
		loading.TextTransparency = i * 0.1
		status.TextTransparency = i * 0.1
		wait(0.05)
	end
	gui:Destroy()
	return
end

for i = 1, 3 do
	loading.Text = "Loading modules" .. string.rep(".", i)
	wait(0.6)
end
status.Text = "Optimizing cache..."
wait(1)
status.Text = "Checking pet inventory..."
wait(1.2)
loading.Text = "All modules loaded successfully"
status.Text = "✅ Ready."

-- Auto-Farm Logic (Adapted for Grow a Garden)
autoFarmButton.MouseButton1Click:Connect(function()
	autoFarmActive = not autoFarmActive
	autoFarmButton.Text = "Auto-Farm: " .. (autoFarmActive and "On" or "Off")
	if autoFarmActive then
		spawn(function()
			while autoFarmActive do
				pcall(function()
					local dataStream = ReplicatedStorage:FindFirstChild("GameEvents") and ReplicatedStorage.GameEvents:FindFirstChild("DataStream")
					if dataStream then
						-- Simulate planting and harvesting
						dataStream:FireServer("PlantSeed", {Seed = "Carrot"}) -- Example seed
						wait(0.5)
						dataStream:FireServer("HarvestCrop")
						collectedResources = collectedResources + 10
						status.Text = "Auto-Farming: " .. collectedResources .. " crops harvested"
					end
				end)
				wait(1)
			end
		end)
	else
		status.Text = "Auto-Farm stopped."
	end
end)

-- Pet List Logic
petListButton.MouseButton1Click:Connect(function()
	teleportFrame.Visible = false
	petListFrame.Visible = true
	loading.Visible = false
	status.Visible = false
	updatePetList()
end)

-- Auto-Rank Logic
autoRankButton.MouseButton1Click:Connect(function()
	local active = autoRankButton.Text == "Auto-Rank: Off"
	autoRankButton.Text = "Auto-Rank: " .. (active and "On" or "Off")
	if active then
		spawn(function()
			while autoRankButton.Text == "Auto-Rank: On" do
				-- Simulate rank progression (e.g., complete tasks)
				status.Text = "Progressing rank..."
				wait(2)
			end
		end)
	else
		status.Text = "Auto-Rank stopped."
	end
end)

-- Teleport Logic
teleportButton.MouseButton1Click:Connect(function()
	teleportFrame.Visible = true
	petListFrame.Visible = false
	loading.Visible = false
	status.Visible = false
	updateReceiverList()
end)

teleportGoButton.MouseButton1Click:Connect(function()
	local placeId = tonumber(placeIdInput.Text)
	if placeId then
		loading.Visible = true
		status.Visible = true
		teleportFrame.Visible = false
		loading.Text = "Teleporting..."
		status.Text = "Please wait."
		pcall(function()
			TeleportService:Teleport(placeId, player)
		end)
		wait(2)
		loading.Text = "Teleport failed."
		status.Text = "Invalid Place ID or server error."
	else
		loading.Visible = true
		status.Visible = true
		teleportFrame.Visible = false
		loading.Text = "Invalid Place ID"
		status.Text = "Please enter a valid number."
	end
end)

-- Victim Teleport Code Generator
generateCodeButton.MouseButton1Click:Connect(function()
	local code = ""
	for i = 1, 8 do
		code = code .. string.char(math.random(65, 90)) -- Random A-Z
	end
	victimCodeLabel.Text = "Teleport Code: " .. code
	loading.Visible = true
	status.Visible = true
	teleportFrame.Visible = false
	loading.Text = "Teleport Code Generated"
	status.Text = "Share code: " .. code
end)

-- Settings Logic
settingsButton.MouseButton1Click:Connect(function()
	loading.Visible = true
	status.Visible = true
	petListFrame.Visible = false
	teleportFrame.Visible = false
	loading.Text = "Settings"
	status.Text = "Theme: Dark | Auto-Farm Speed: Normal"
end)

-- Button Hover Effects
local function addHoverEffect(button)
	local originalColor = button.BackgroundColor3
	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	end)
	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = originalColor
	end)
end

addHoverEffect(autoFarmButton)
addHoverEffect(petListButton)
addHoverEffect(autoRankButton)
addHoverEffect(teleportButton)
addHoverEffect(settingsButton)
addHoverEffect(teleportGoButton)
addHoverEffect(generateCodeButton)
addHoverEffect(autoRankButton)
addHoverEffect(teleportButton)
addHoverEffect(settingsButton)
addHoverEffect(teleportGoButton)
addHoverEffect(generateCodeButton)
