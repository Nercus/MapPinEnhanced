---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local PREFIX = "MPEVersion"
local SEND_THROTTLE = 10
local channels = { GUILD = true, PARTY = true, RAID = true, INSTANCE_CHAT = true }

---@param text any
---@return number[]?
local function ParseVersion(text)
    if MapPinEnhanced:IsSecretValue(text) or type(text) ~= "string" or #text > 16 then return end
    ---@type string, string, string
    local major, minor, patch = text:match("^(%d+)%.(%d+)%.(%d+)$")
    if not major then return end
    local parts = { tonumber(major), tonumber(minor), tonumber(patch) }
    for index = 1, 3 do
        if parts[index] > 999999 then return end
    end
    return parts
end

---@param candidate number[]
---@param current number[]
---@return boolean
local function IsNewer(candidate, current)
    for index = 1, 3 do
        if candidate[index] ~= current[index] then
            return candidate[index] > current[index]
        end
    end
    return false
end

local version = MapPinEnhanced.version
local installedVersion = ParseVersion(version)
-- Only packaged stable releases participate; development/beta builds stay quiet.
if not installedVersion or not C_ChatInfo or not C_ChatInfo.RegisterAddonMessagePrefix
    or not C_ChatInfo.SendAddonMessage then
    return
end
local registered = pcall(C_ChatInfo.RegisterAddonMessagePrefix, PREFIX)
if not registered or not C_ChatInfo.IsAddonMessagePrefixRegistered(PREFIX) then return end

local notified = false
local lastSent = {} ---@type table<string, number>
local pendingReply = {} ---@type table<string, FunctionContainer>

---@param channel string
local function Send(channel)
    local now = GetTime()
    if now - (lastSent[channel] or -math.huge) < SEND_THROTTLE then return end
    lastSent[channel] = now
    if C_ChatInfo.InChatMessagingLockdown and C_ChatInfo.InChatMessagingLockdown() then return end
    -- A failed/throttled send is disposable. Never surface transport errors or retry in a loop.
    pcall(C_ChatInfo.SendAddonMessage, PREFIX, version, channel)
end

local function Broadcast()
    if IsInGuild() then Send("GUILD") end
    if IsInGroup(Enum.PartyCategory.Instance) then Send("INSTANCE_CHAT") end
    if IsInGroup(Enum.PartyCategory.Home) then
        Send(IsInRaid(Enum.PartyCategory.Home) and "RAID" or "PARTY")
    end
end

MapPinEnhanced:RegisterEvent("CHAT_MSG_ADDON", function(prefix, text, channel)
    if MapPinEnhanced:IsSecretValue(prefix) or prefix ~= PREFIX then return end
    if MapPinEnhanced:IsSecretValue(channel) or not channels[channel] then return end
    local receivedVersion = ParseVersion(text)
    if not receivedVersion then return end
    if IsNewer(installedVersion, receivedVersion) then
        if pendingReply[channel] or GetTime() - (lastSent[channel] or -math.huge) < SEND_THROTTLE then return end
        -- Spread replies across the channel; hearing an equal/newer release cancels ours.
        pendingReply[channel] = C_Timer.NewTimer(1 + math.random() * 4, function()
            pendingReply[channel] = nil
            Send(channel)
        end)
        return
    end
    if pendingReply[channel] then
        pendingReply[channel]:Cancel()
        pendingReply[channel] = nil
    end
    if not notified and IsNewer(receivedVersion, installedVersion) then
        notified = true
        MapPinEnhanced:Print(string.format(MapPinEnhanced.L[
        "A new version (%s) for Map Pin Enhanced is available. You are on (%s)."], text, version))
    end
end)

-- Only short, event-triggered timers: no ticker, unit scanning or saved peer history.
MapPinEnhanced:RegisterEventBucket({ "PLAYER_LOGIN", "PLAYER_GUILD_UPDATE" }, Broadcast, 8)
local lastHomeSize, lastInstanceSize = 0, 0
local wasRaid = false
MapPinEnhanced:RegisterEvent("GROUP_ROSTER_UPDATE", function()
    local homeSize = GetNumGroupMembers(Enum.PartyCategory.Home)
    local instanceSize = GetNumGroupMembers(Enum.PartyCategory.Instance)
    local isRaid = IsInRaid(Enum.PartyCategory.Home)
    if homeSize > lastHomeSize or instanceSize > lastInstanceSize or isRaid ~= wasRaid then
        Broadcast()
    end
    lastHomeSize, lastInstanceSize, wasRaid = homeSize, instanceSize, isRaid
end)
