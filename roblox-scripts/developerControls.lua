-- Roblox Lua script for developer server controls via portal API

local ApiModule = require(script.Parent.apiModule)

-- Example token, in practice this should be securely obtained
local apiToken = "YOUR_API_TOKEN_HERE"

local DeveloperControls = {}

-- Shutdown server
function DeveloperControls:ShutdownServer(serverId)
    return ApiModule:ShutdownServer(serverId, apiToken)
end

-- Migrate server
function DeveloperControls:MigrateServer(serverId, targetRegion)
    return ApiModule:MigrateServer(serverId, targetRegion, apiToken)
end

return DeveloperControls
