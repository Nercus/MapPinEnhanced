---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Collections = MapPinEnhanced:GetModule("Collections")
local L = MapPinEnhanced.L

local preFilteredFormatPattern = "%s: %s-%s"
local preFilteredCapturePattern = "%[([%w_]+): ([%w_]+)-([%w_]+)%]"
local logoEscapeSequence = "|TInterface\\Addons\\MapPinEnhanced\\assets\\pins\\PinTrackedYellow.png:12|t" ..
    MapPinEnhanced.name


---@param event WowEvent
---@param msg string
---@param player string
---@param l string language
---@param cs string channel string
---@param t string target
---@param flag any -- "GM", "DEV", or nil
---@param channelId number
---@param ... any
---@return boolean? , string?, string?, string?, string?, string?, any?, number?, any?
local function FilterFunc(_, event, msg, player, l, cs, t, flag, channelId, ...)
    if flag == "GM" or flag == "DEV" or (event == "CHAT_MSG_CHANNEL" and type(channelId) == "number" and channelId > 0) then
        return
    end

    ---@type string?
    local newMsg = ""
    local collectionFound = false
    local anyCollectionFound = false
    local searchedMessage = msg

    repeat
        local start, finish, _, foundCollectionName, foundPlayerName = string.find(searchedMessage,
            preFilteredCapturePattern)
        if foundPlayerName and foundCollectionName then
            local collectionName = tostring(foundCollectionName)
            local playerName = tostring(foundPlayerName)
            local startPos = start or 1
            local finishPos = finish or #searchedMessage
            local displayText = string.format("|cffffd100[%s]|r",
                string.format(preFilteredFormatPattern, logoEscapeSequence, collectionName, playerName))
            local linkData = string.format("%s:%s", collectionName, playerName)
            newMsg = newMsg .. string.sub(searchedMessage, 1, startPos - 1)
            newMsg = newMsg .. LinkUtil.FormatLink("addonMPH", displayText, linkData) --[[@as string]]
            searchedMessage = string.sub(searchedMessage, finishPos + 1);
            collectionFound = true
            anyCollectionFound = true
        else
            newMsg = newMsg .. searchedMessage
            collectionFound = false
        end
    until (not collectionFound)


    if anyCollectionFound then
        return false, newMsg, player, l, cs, t, flag, channelId, ...;
    end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", FilterFunc)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", FilterFunc)


StaticPopupDialogs["MAPPINENHANCED_IMPORT_COLLECTION"] = {
    text = L["Do you want to import the collection '%s' from player '%s'?"],
    button1 = L["Yes"],
    button2 = L["No"],
    ---@param requestInfo { collectionName: string, playerName: string }
    OnAccept = function(_, requestInfo)
        Providers:RequestCollection(requestInfo.collectionName, requestInfo.playerName)
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}


function Providers:RequestCollection(collectionName, targetName)
    assert(collectionName, "Providers:RequestCollection: collectionName is nil")
    assert(targetName, "Providers:RequestCollection: playerName is nil")
    local request = string.format("%s:%s", collectionName, targetName)
    MapPinEnhanced:SendTextAddonMessage("REQUEST_COLLECTION", request, "WHISPER", targetName)
end

EventRegistry:RegisterCallback("SetItemRef", function(_, link)
    ---@type string, string
    local linkType, linkData = LinkUtil.SplitLinkData(link)
    if linkType ~= "addonMPH" then
        return
    end
    local collectionName, playerName = strsplit(":", linkData)
    local dialog = StaticPopup_Show("MAPPINENHANCED_IMPORT_COLLECTION", collectionName, playerName,
        { collectionName = collectionName, playerName = playerName })
    dialog.data = { collectionName = collectionName, playerName = playerName }
end, MapPinEnhanced)

MapPinEnhanced:OnDataAddonMessage("TRANSMIT_COLLECTION", function(data)
    ---@type CollectionInfo
    local collectionData = data
    Collections:RestoreCollection(collectionData)
    MapPinEnhanced:Print(string.format("Received collection '%s' from player '%s'", collectionData.name,
        MapPinEnhanced.me))
end, function(progress, total)
    MapPinEnhanced:Print(string.format("Receiving collection data: %d/%d", progress, total))
end)
