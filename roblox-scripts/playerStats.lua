-- Roblox Lua script to track player stats and report to portal API

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local ApiModule = require(script.Parent.apiModule)

local playerStats = {}

-- Example token, in practice this should be securely obtained
local apiToken = "YOUR_API_TOKEN_HERE"

local function reportStats(player)
    local stats = playerStats[player.UserId]
    if stats then
        ApiModule:ReportPlayerStats(player.UserId, stats.deaths, stats.playtime, apiToken)
    end
end

local function onPlayerAdded(player)
    playerStats[player.UserId] = {
        deaths = 0,
        playtime = 0
    }

    -- Track playtime
    local startTime = os.time()

    -- Example: Listen for death event (customize as per your game)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            playerStats[player.UserId].deaths = playerStats[player.UserId].deaths + 1
            reportStats(player)
        end)
    end)

    -- Update playtime every minute
    while player.Parent do
        wait(60)
        local currentTime = os.time()
        playerStats[player.UserId].playtime = playerStats[player.UserId].playtime + (currentTime - startTime) / 60
        startTime = currentTime
        reportStats(player)
    end
end

local function onPlayerRemoving(player)
    reportStats(player)
    playerStats[player.UserId] = nil
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)
