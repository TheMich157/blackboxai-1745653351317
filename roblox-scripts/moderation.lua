-- Roblox Lua script to report moderation actions to the portal API

local ApiModule = require(script.Parent.apiModule)

-- Example token, in practice this should be securely obtained
local apiToken = "YOUR_API_TOKEN_HERE"

local Moderation = {}

-- Report a warning
function Moderation:IssueWarning(targetPlayerId, reason)
    return ApiModule:ReportModerationAction("warn", targetPlayerId, reason, nil, apiToken)
end

-- Report a kick
function Moderation:KickUser(targetPlayerId, reason)
    return ApiModule:ReportModerationAction("kick", targetPlayerId, reason, nil, apiToken)
end

-- Report a ban
function Moderation:BanUser(targetPlayerId, reason, duration)
    return ApiModule:ReportModerationAction("ban", targetPlayerId, reason, duration, apiToken)
end

return Moderation
