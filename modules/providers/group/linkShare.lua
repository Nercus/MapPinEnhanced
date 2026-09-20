---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Transfer = MapPinEnhanced:GetModule("Transfer")
local Notifications = MapPinEnhanced:GetModule("Notifications")

local L = MapPinEnhanced.L
local Chomp = MapPinEnhanced.Chomp
local LINK_TYPE = "mappinenhanced"
local TOKEN_PATTERN = "%[MPH:1:([^:%s%[%]|]+):([%x%-]+):([^%[%]|\r\n]+)%]"
local LINK_PATTERN = "|Hmappinenhanced:1:([^:%s%[%]|]+):([%x%-]+)|h%[MPH: ([^%[%]|\r\n]+)%]|h"
local SHARE_LIFETIME = 1800
local REQUEST_TIMEOUT = 60

---@type table<string, {data: SerializedExport, expires: number}>
local offers = {}
---@type {sender: string, token: string, requestID: string, timer: FunctionContainer}?
local pending

local function MakeToken(sender, token, name)
    return string.format("[MPH:1:%s:%s:%s]", sender, token, name)
end

local function MakeLink(sender, token, name)
    return string.format("|cffEBCB8B|H%s:1:%s:%s|h[MPH: %s]|h|r", LINK_TYPE, sender, token, name)
end

local function InsertGroupLink(sender, token, name)
    local overhead = math.max(#MakeToken(sender, token, ""), #MakeLink(sender, token, ""))
    name = MapPinEnhanced:GetUTF8Prefix(name, 240 - overhead)
    local link = MakeLink(sender, token, name)
    if not ChatEdit_InsertLink(link) then
        ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
        ChatEdit_InsertLink(link)
    end
end

-- This session-long callback runs before Blizzard reads the outgoing text.
-- Replace only our links, including their color wrapper; chat carries the
-- existing plain token while the editbox can display a compact label.
EventRegistry:RegisterCallback("ChatFrame.OnEditBoxPreSendText", function(_, editBox)
    ---@cast editBox EditBox
    local text = editBox:GetText()
    if MapPinEnhanced:IsSecretValue(text) then return end
    local outgoing = text:gsub("|c%x%x%x%x%x%x%x%x" .. LINK_PATTERN .. "|r", MakeToken)
    outgoing = outgoing:gsub(LINK_PATTERN, MakeToken)
    if outgoing ~= text then editBox:SetText(outgoing) end
end, Providers)

---@param group MapPinEnhancedGroupMixin
function Providers:ShareGroupToChat(group)
    if not group or group:GetTotalPinCount() == 0 then return end
    local now = GetTime()
    local count = 0
    ---@type string?, number?
    local oldestToken, oldestTime
    for token, offer in pairs(offers) do
        if offer.expires <= now then
            offers[token] = nil
        else
            count = count + 1
            if not oldestTime or offer.expires < oldestTime then
                oldestToken, oldestTime = token, offer.expires
            end
        end
    end
    if count >= 20 and oldestToken then offers[oldestToken] = nil end
    local token = MapPinEnhanced:GenerateUUID()
    offers[token] = { data = Transfer:GetSerializedTarget(group), expires = now + SHARE_LIFETIME }
    -- Only the presentation name is sanitized. Identity comes from the private
    -- offer token, so renaming/deleting/releasing the source cannot change it.
    local name = group:GetName():gsub("[|%[%]\r\n]", " ")
    local sender = Chomp.NameMergedRealm(UnitFullName("player"))
    InsertGroupLink(sender, token, name)
end

local function IsWhisper(kind)
    return kind == "WHISPER" or kind == "WHISPER:LOGGED" or kind == "WHISPER:BATTLENET"
end

local function ClearPending()
    if pending then pending.timer:Cancel() end
    pending = nil
end

local function RequestGroup(sender, token)
    sender = Chomp.NameMergedRealm(sender)
    ClearPending()
    local requestID = MapPinEnhanced:GenerateUUID()
    pending = {
        sender = sender,
        token = token,
        requestID = requestID,
        timer = C_Timer.NewTimer(REQUEST_TIMEOUT, function()
            pending = nil
            MapPinEnhanced:Notify(
                L["Group sharing timed out. The sender must be online and the link must still be available."], "ERROR")
        end),
    }
    MapPinEnhanced:Notify(L["Requesting shared group..."])
    MapPinEnhanced:SendTextAddonMessage("GROUP_REQUEST", token .. ":" .. requestID, "WHISPER", sender)
end

MapPinEnhanced:OnTextAddonMessage("GROUP_REQUEST", function(text, sender, kind)
    if not IsWhisper(kind) then return end
    local token, requestID = text:match("^([%x%-]+):([%x%-]+)$")
    if not token or not requestID or #token > 64 or #requestID > 64 then return end
    ---@type {data: SerializedExport, expires: number}?
    local offer = offers[token]
    if offer and offer.expires <= GetTime() then
        offers[token] = nil
        offer = nil
    end
    MapPinEnhanced:SendDataAddonMessage("GROUP_RESPONSE", {
        token = token,
        requestID = requestID,
        export = offer and offer.data or nil,
    }, "WHISPER", sender)
end)

MapPinEnhanced:OnDataAddonMessage("GROUP_RESPONSE", function(data, sender, kind)
    if not IsWhisper(kind) or not pending or sender ~= pending.sender or
        data.token ~= pending.token or data.requestID ~= pending.requestID then
        return
    end
    ClearPending()
    if type(data.export) ~= "table" then
        MapPinEnhanced:Notify(L["This shared group is no longer available. Ask the sender for a new link."], "ERROR")
        return
    end
    Transfer:ShowImportWindow(MapPinEnhanced:SerializeData(data.export))
    Notifications:ShowNotification("GROUP_RECEIVED", data.export.group.name)
end)

-- Render incoming plain tokens using the same compact link as the editbox.
local function FilterChat(_, _, message, ...)
    ---@cast message string
    if MapPinEnhanced:IsSecretValue(message) or type(message) ~= "string" then return end
    local changed, count = message:gsub(TOKEN_PATTERN, function(sender, token, name)
        if #sender > 100 or #token > 64 then return end
        return MakeLink(sender, token, name)
    end)
    if count > 0 then return false, changed, ... end
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

LinkUtil.RegisterLinkHandler(LINK_TYPE, function(link, text)
    ---@cast link string
    ---@cast text string
    local sender, token = link:match("^mappinenhanced:1:([^:%s%[%]|]+):([%x%-]+)$")
    if not sender or not token or #sender > 100 or #token > 64 then return end
    if IsShiftKeyDown() then
        local name = text:match("%[MPH: ([^%[%]|]+)%]") or "MPH"
        InsertGroupLink(sender, token, name)
    else
        RequestGroup(sender, token)
    end
end)
