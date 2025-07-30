---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Sets = MapPinEnhanced:GetModule("Sets")

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
    local setFound = false
    local anySetFound = false
    local searchedMessage = msg

    repeat
        local start, finish, _, setName, playerName = string.find(searchedMessage, preFilteredCapturePattern)
        if playerName and setName then
            local displayText = string.format("|cffffd100[%s]|r",
                string.format(preFilteredFormatPattern, logoEscapeSequence, setName, playerName))
            newMsg = newMsg .. string.sub(searchedMessage, 1, start - 1)
            newMsg = newMsg .. LinkUtil.FormatLink("addonMPH", displayText, setName, playerName)
            searchedMessage = string.sub(searchedMessage, finish + 1);
            setFound = true
            anySetFound = true
        else
            newMsg = newMsg .. searchedMessage
            setFound = false
        end
    until (not setFound)


    if anySetFound then
        -- filter CHAT_MSG_WHISPER to not allow random players
        return false, newMsg, player, l, cs, t, flag, channelId, ...; -- No set found, do not filter
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


-- Popup dialog for importing a set
StaticPopupDialogs["MAPPINENHANCED_IMPORT_SET"] = {
    text = "Do you want to import the set '%s' from player '%s'?",
    button1 = "Yes",
    button2 = "No",
    ---@param requestInfo { setName: string, playerName: string }
    OnAccept = function(_, requestInfo)
        -- request first then the sender sends the message
        Providers:RequestSet(requestInfo.setName, requestInfo.playerName)
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}


function Providers:RequestSet(setName, targetName)
    assert(setName, "Providers:RequestSet: setName is nil")
    assert(targetName, "Providers:RequestSet: playerName is nil")
    local request = string.format("%s:%s", setName, targetName)
    MapPinEnhanced:SendTextAddonMessage("REQUEST_SET", request, "WHISPER", targetName)
end

-- Show popup when set link is clicked
EventRegistry:RegisterCallback("SetItemRef", function(_, link)
    ---@type string, string
    local linkType, linkData = LinkUtil.SplitLinkData(link)
    if linkType ~= "addonMPH" then
        return
    end
    local setName, playerName = strsplit(":", linkData)
    local dialog = StaticPopup_Show("MAPPINENHANCED_IMPORT_SET", setName, playerName,
        { setName = setName, playerName = playerName })
    dialog.data = { setName = setName, playerName = playerName }
end, MapPinEnhanced)

MapPinEnhanced:OnDataAddonMessage("TRANSMIT_SET", function(data)
    ---@type SetInfo
    local setData = data
    Sets:RestoreSet(setData)
    MapPinEnhanced:Print(string.format("Received set '%s' from player '%s'", setData.name, MapPinEnhanced.me))
end, function(progress, total)
    MapPinEnhanced:Print(string.format("Receiving set data: %d/%d", progress, total))
end)
