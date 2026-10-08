---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")
local Tracker = MapPinEnhanced:GetModule("Tracker")
local LINK_TYPE = "mappinenhancedpin"
local COORDINATE_PATTERNS = {
    "(%d+%.?%d*)[ \t]*,+[ \t]*(%d+%.?%d*)",
    "(%d+%.?%d*)[ \t]+(%d+%.?%d*)",
}

---@param value number?
---@return boolean
local function IsChatCoordinate(value)
    return MapPinEnhanced:IsReadableNumber(value) and value > 0 and value < 100
end

---@param text string
---@param pattern string
---@param mapID number
---@return string
local function ReplaceCoordinates(text, pattern, mapID)
    local result = {} ---@type string[]
    local position, searchFrom = 1, 1
    while true do
        local first, last, xToken, yToken = text:find(pattern, searchFrom)
        if not first then break end
        ---@cast xToken string
        ---@cast yToken string
        local x, y = tonumber(xToken), tonumber(yToken)
        local before = first > 1 and text:sub(first - 1, first - 1) or ""
        local after = text:sub(last + 1, last + 1)
        if IsChatCoordinate(x) and IsChatCoordinate(y) and
            not before:find("[%w_.%-]") and not after:find("[%w_%%]") and
            not text:sub(last + 1):match("^%.%d") then
            result[#result + 1] = text:sub(position, first - 1)
            result[#result + 1] = string.format("|cffEBCB8B|H%s:%d:%s:%s|h[%s]|h|r",
                LINK_TYPE, mapID, xToken, yToken, text:sub(first, last))
            position = last + 1
            searchFrom = position
        else
            -- Retry after the first number so an invalid pair cannot hide the next valid pair.
            searchFrom = first + #xToken
        end
    end
    result[#result + 1] = text:sub(position)
    return table.concat(result)
end

---@param message string
---@param pattern string
---@param mapID number
---@return string
local function ReplacePlainText(message, pattern, mapID)
    local result = {} ---@type string[]
    local position = 1
    while position <= #message do
        local first = message:find("|", position, true)
        result[#result + 1] = ReplaceCoordinates(message:sub(position, first and first - 1 or #message), pattern, mapID)
        if not first then break end
        -- Links (including labels), textures, atlases and colors are opaque. This also
        -- protects links made by the comma pass when the space pass runs afterward.
        local kind = message:sub(first + 1, first + 1)
        local finish ---@type number?
        if kind == "H" then
            local label = message:find("|h", first + 2, true)
            local close = label and message:find("|h", label + 2, true)
            finish = close and close + 1
        elseif kind == "T" or kind == "A" then
            local close = message:find(kind == "T" and "|t" or "|a", first + 2, true)
            finish = close and close + 1
        elseif kind == "c" then
            local _, last = message:find("^|c%x%x%x%x%x%x%x%x", first)
            finish = last
        elseif kind == "r" or kind == "|" then
            finish = first + 1
        end
        -- Leave unknown or incomplete markup intact rather than parsing its contents.
        result[#result + 1] = message:sub(first, finish or #message)
        if not finish then break end
        position = finish + 1
    end
    return table.concat(result)
end

local function FilterChat(_, _, message, ...)
    ---@cast message string
    if MapPinEnhanced:IsSecretValue(message) or type(message) ~= "string" then return end
    if not message:find("%d") then return end
    local mapID = C_Map.GetBestMapForUnit("player")
    if not MapPinEnhanced:IsReadablePositiveInteger(mapID) or not C_Map.GetMapInfo(mapID) then return end
    local changed = message
    -- Prefer explicit comma pairs before considering space-separated numbers, as in TomPoints.
    for _, pattern in ipairs(COORDINATE_PATTERNS) do
        changed = ReplacePlainText(changed, pattern, mapID)
    end
    if changed ~= message then return false, changed, ... end
end

for _, event in ipairs({
    "CHAT_MSG_SAY", "CHAT_MSG_YELL", "CHAT_MSG_GUILD", "CHAT_MSG_OFFICER",
    "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER", "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER",
    "CHAT_MSG_RAID_WARNING", "CHAT_MSG_INSTANCE_CHAT", "CHAT_MSG_INSTANCE_CHAT_LEADER",
    "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER_INFORM", "CHAT_MSG_BN_WHISPER",
    "CHAT_MSG_BN_WHISPER_INFORM", "CHAT_MSG_CHANNEL", "CHAT_MSG_COMMUNITIES_CHANNEL",
}) do
    ChatFrame_AddMessageEventFilter(event, FilterChat)
end

LinkUtil.RegisterLinkHandler(LINK_TYPE, function(link)
    ---@cast link string
    if MapPinEnhanced:IsSecretValue(link) or type(link) ~= "string" then return end
    local mapToken, xToken, yToken = link:match("^mappinenhancedpin:(%d+):(%d+%.?%d*):(%d+%.?%d*)$")
    local mapID, x, y = tonumber(mapToken), tonumber(xToken), tonumber(yToken)
    if not MapPinEnhanced:IsReadablePositiveInteger(mapID) or not IsChatCoordinate(x) or
        not IsChatCoordinate(y) or not C_Map.GetMapInfo(mapID) then return end
    -- The link retains the map at receipt, even if the player changes zones before clicking.
    local data = { mapID = mapID, x = x / 100, y = y / 100 }
    if IsModifiedClick("CHATLINK") then
        ChatEdit_InsertLink(MapPinEnhanced:GetModule("Providers"):GetMapPinChatLink(data.x, data.y, mapID))
        return
    end
    local group = Groups:GetUngroupedGroup()
    if not group then return end
    local _, pinID = group:AddPin(data)
    if pinID then Tracker:OnUserPinsAdded() end
end)
