---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinSetMixin
MapPinEnhancedPinSetShareMixin = {}

--- [AddonName: Setname-PlayerName]
local preFilteredFormatPattern = "[%s: %s-%s]"
local preFilteredCapturePattern = "([%w_]+): ([%w_]+)-([%w_]+)"
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
        local _, finish, _, setName, playerName = searchedMessage:find(preFilteredCapturePattern);
        if playerName and setName then
            local displayText = string.format("|cffffd100" .. preFilteredFormatPattern .. "|r", logoEscapeSequence,
                setName, playerName)
            ---@type string
            newMsg = newMsg .. LinkUtil.FormatLink("addonMPH", displayText, setName, playerName)
            ---@type string
            searchedMessage = searchedMessage:sub(finish + 1);
            setFound = true
            anySetFound = true
        else
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
        MapPinEnhanced:SendAddonMessage(
            string.format("request-set-%s", requestInfo.setName),
            string.format("%s:%s", requestInfo.setName, requestInfo.playerName),
            "WHISPER",
            requestInfo.playerName
        )
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}


function MapPinEnhancedPinSetShareMixin:OnShareUpdate(progress, total)
    print(string.format("Sharing set '%s': %d/%d", self.name, progress, total))
end

function MapPinEnhancedPinSetShareMixin:OnShareComplete()
    print(string.format("Set '%s' shared successfully!", self.name))
end

function MapPinEnhancedPinSetShareMixin:OnRequestReceived(setName, playerName)
    if self.name ~= setName then
        return
    end
    self.transmission(self:GetSaveableData(), "WHISPER", playerName)
end

function MapPinEnhancedPinSetShareMixin:LinkToChat()
    assert(self.name, "MapPinEnhancedPinSetShareMixin:LinkToChat: name is nil")
    self.transmission = MapPinEnhanced:RegisterTransmission({
        event = string.format("transmit:set:%s", self.name),
        onUpdate = function(progress, total)
            self:OnShareUpdate(progress, total)
        end,
        onComplete = function()
            self:OnShareComplete()
        end,
    })

    MapPinEnhanced:RegisterAddonMessage(string.format("request-set-%s", self.name), function(data)
        local setName, playerName = strsplit(":", data)
        self:OnRequestReceived(setName, playerName)
    end)

    local setName = self.name
    local link = string.format(preFilteredFormatPattern, MapPinEnhanced.name, setName, MapPinEnhanced.me)
    ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
    ChatEdit_InsertLink(link)
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
