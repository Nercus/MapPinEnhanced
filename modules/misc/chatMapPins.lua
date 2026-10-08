---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Misc = MapPinEnhanced:GetModule("Misc")
local LINK_PATTERN = "(|Hworldmap:(%d+):(%d+):(%d+)|h)%[.-%]|h"
local NATIVE_LABEL = "|A:Waypoint-MapPin-ChatIcon:13:13:0:0|a Map Pin Location"

local function ReplaceMapPin(prefix, mapToken, xToken, yToken)
    local mapID, x, y = tonumber(mapToken), tonumber(xToken), tonumber(yToken)
    if not MapPinEnhanced:IsReadablePositiveInteger(mapID) or not x or not y or
        not MapPinEnhanced:IsCoordinate(x / 10000) or not MapPinEnhanced:IsCoordinate(y / 10000) then return end
    local info = C_Map.GetMapInfo(mapID)
    if not info then return end
    return string.format("%s[|A:Waypoint-MapPin-ChatIcon:13:13:0:0|a %s (%.2f, %.2f)]|h",
        prefix, info.name, x / 100, y / 100)
end

local function FilterChat(_, _, message, ...)
    ---@cast message string
    if MapPinEnhanced:IsSecretValue(message) or type(message) ~= "string" then return end
    if not message:find("|Hworldmap:", 1, true) then return end
    local changed = message:gsub(LINK_PATTERN, ReplaceMapPin)
    if changed ~= message then return false, changed, ... end
end

for _, event in ipairs({
    "CHAT_MSG_SAY", "CHAT_MSG_YELL", "CHAT_MSG_GUILD", "CHAT_MSG_OFFICER",
    "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER", "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER",
    "CHAT_MSG_RAID_WARNING", "CHAT_MSG_INSTANCE_CHAT", "CHAT_MSG_INSTANCE_CHAT_LEADER",
    "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER_INFORM", "CHAT_MSG_BN_WHISPER",
    "CHAT_MSG_BN_WHISPER_INFORM", "CHAT_MSG_CHANNEL",
}) do
    ChatFrame_AddMessageEventFilter(event, FilterChat)
end

-- Native clicks read only the payload. Outgoing chat validates the label too,
-- so restore Blizzard's canonical text when a displayed link is forwarded.
EventRegistry:RegisterCallback("ChatFrame.OnEditBoxPreSendText", function(_, editBox)
    ---@cast editBox EditBox
    local text = editBox:GetText()
    if MapPinEnhanced:IsSecretValue(text) then return end
    if not text:find("|Hworldmap:", 1, true) then return end
    local outgoing = text:gsub(LINK_PATTERN, function(prefix)
        return prefix .. "[" .. NATIVE_LABEL .. "]|h"
    end)
    if outgoing ~= text then editBox:SetText(outgoing) end
end, Misc)
