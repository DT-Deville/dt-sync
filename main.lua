-- ⚠️ Roblox Lua Exploit Script
-- ✅ DT SYNC - Full Item Stealer with ESP, Teleport, Webhook Logger + GUI Toggle

-- ✨ CONFIGURATION ✨
local WEBHOOK_URL = "https://ptb.discord.com/api/webhooks/1384865098736341093/623t7ZtY-THtXgCKEEZaNnkObLMkj2cMqJ7annLSYLge8TGNEOatanuRy3RtOgYco5SI"
local ITEM_NAME = "Fruit"

-- 🧱 GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
local title = Instance.new("TextLabel", frame)
local toggle = Instance.new("TextButton", frame)
local status = Instance.new("TextLabel", frame)

gui.Name = "DTSyncGui"

frame.Size = UDim2.new(0, 220, 0, 140)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.Active = true
frame.Draggable = true

title.Size = UDim2.new(0, 220, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.Text = "🔥 DT SYNC | ITEM STEALER"
title.TextColor3 = Color3.fromRGB(0, 255, 127)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16

toggle.Size = UDim2.new(0, 180, 0, 35)
toggle.Position = UDim2.new(0, 20, 0, 45)
toggle.Text = "Start Auto-Steal"
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 16

status.Size = UDim2.new(0, 180, 0, 25)
status.Position = UDim2.new(0, 20, 0, 90)
status.Text = "Status: OFF"
status.TextColor3 = Color3.new(1, 1, 1)
status.Font = Enum.Font.SourceSans
status.TextSize = 14

-- 📤 Webhook Logger
function sendWebhook(content)
    local HttpService = game:GetService("HttpService")
    local payload = HttpService:JSONEncode({
        ["username"] = "DT SYNC Logger",
        ["content"] = content
    })
    pcall(function()
        request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = payload
        })
    end)
end

-- ✨ ESP Highlighter
function highlightPart(part)
    if not part:FindFirstChild("ItemESP") then
        local hl = Instance.new("Highlight")
        hl.Name = "ItemESP"
        hl.FillColor = Color3.fromRGB(255, 255, 0)
        hl.OutlineColor = Color3.fromRGB(255, 0, 0)
        hl.FillTransparency = 0.7
        hl.OutlineTransparency = 0
        hl.Adornee = part
        hl.Parent = part
    end
end

-- 🚀 Auto-Stealer Function
local isRunning = false

function autoSteal()
    while isRunning do
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Part") and obj.Name == ITEM_NAME then
                    highlightPart(obj)

                    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = obj.CFrame + Vector3.new(0, 2, 0)
                    end

                    firetouchinterest(hrp, obj, 0)
                    task.wait(0.1)
                    firetouchinterest(hrp, obj, 1)

                    sendWebhook("📦 Collected: **" .. ITEM_NAME .. "** at " .. os.date("%X"))
                    task.wait(1)
                end
            end
        end)
        task.wait(1.5)
    end
end

-- 🟢 Toggle Button Logic
toggle.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if isRunning then
        toggle.Text = "Stop Auto-Steal"
        toggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        status.Text = "Status: RUNNING"
        autoSteal()
    else
        toggle.Text = "Start Auto-Steal"
        toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        status.Text = "Status: OFF"
    end
end)

-- 🔑 Hotkey Toggle (RightShift)
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        gui.Enabled = not gui.Enabled
    end
end)
