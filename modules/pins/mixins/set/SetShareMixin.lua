---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinSetMixin
MapPinEnhancedPinSetShareMixin = {}

local PROTOCOL_PREFIX = "MPH3";
--- [AddonName: Setname-PlayerName]
local preFilteredFormatPattern = "[%s: %s-%s]"
local preFilteredCapturePattern = "([%w_]+): ([%w_]+)-([%w_]+)"
local logoEscapeSequence = "|TInterface\\Addons\\MapPinEnhanced\\assets\\pins\\PinTrackedYellow.png:12|t" ..
    MapPinEnhanced.name



-- add test statusbar to middle of the screen
local statusBar = CreateFrame("StatusBar", nil, UIParent, "MapPinEnhancedStatusbarTemplate")
statusBar:SetPoint("CENTER", 0, 100)
statusBar:SetSize(400, 40)
statusBar:SetMinMaxValues(0, 100)
statusBar:SetValue(0)
statusBar:Hide()


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

local Chomp = MapPinEnhanced.Chomp



-- Popup dialog for importing a set
StaticPopupDialogs["MAPPINENHANCED_IMPORT_SET"] = {
    text = "Do you want to import the set '%s' from player '%s'?",
    button1 = YES,
    button2 = NO,
    OnAccept = function(self, data)
        if not data or not data.setName or not data.playerName then
            return
        end

        -- Example: Create a big table with a lot of data
        local bigTable = {}
        for i = 1, 1000 do
            bigTable[i] = {
                id = i,
                name = "Entry_" .. i,
                value = math.random(1, 10000),
                flags = { a = true, b = false, c = i % 2 == 0 },
                nested = {
                    subid = i * 10,
                    description = "Nested data for entry " .. i,
                }
            }
        end

        -- You can use bigTable as needed here
        -- For demonstration, just print the size
        print("Created bigTable with entries:", #bigTable)

        -- Chomp.SmartAddonMessage(PROTOCOL_PREFIX, "request:" .. data.setName .. ":" .. data.playerName, "WHISPER",
        --     data.playerName)


        MapPinEnhanced:Debug({
            "SENT_DATA",
            data = bigTable
        })
        local serializedTable = C_EncodingUtil.SerializeCBOR(bigTable)
        local compressedTable = C_EncodingUtil.CompressString(serializedTable)
        Chomp.SmartAddonMessage(PROTOCOL_PREFIX, compressedTable, "WHISPER", data.playerName, {
            serialize = true,
            binaryBlob = true
        })
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Show popup when set link is clicked
EventRegistry:RegisterCallback("SetItemRef", function(_, link)
    local linkType, linkData = LinkUtil.SplitLinkData(link)
    if linkType ~= "addonMPH" then
        return
    end
    local setName, playerName = strsplit(":", linkData)
    StaticPopup_Show("MAPPINENHANCED_IMPORT_SET", setName, playerName, { setName = setName, playerName = playerName })
end, MapPinEnhanced)



function MapPinEnhancedPinSetShareMixin:LinkToChat()
    assert(self.name, "MapPinEnhancedPinSetShareMixin:LinkToChat: name is nil")

    local setName = self.name

    local link = string.format(preFilteredFormatPattern, MapPinEnhanced.name, setName, MapPinEnhanced.me)
    ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
    ChatEdit_InsertLink(link)
end

local PROTOCOL_SETTINGS = {
    permitUnlogged = true,
    permitLogged = true,
    permitBattleNet = true,
    fullMsgOnly = true,
    validTypes = {
        ["string"] = true,
        ["table"] = true,
    },
    broadcastPrefix = PROTOCOL_PREFIX,
}

local function onIncrementalMessageReceived(_, data, _, sender, _, _, _, _, _, _, _, _, sessionID, msgID, msgTotal)
    local progress = msgID / msgTotal
    if not statusBar:IsShown() then
        statusBar:Show()
    end
    statusBar:SetValueSmooth(progress * 100)
    print(string.format("Received incremental message from %s: %d%% complete", sender, progress * 100))
end
PROTOCOL_SETTINGS.rawCallback = onIncrementalMessageReceived;

local function onChatMessageReceived(_, data, channel, sender)
    local decompressedData = C_EncodingUtil.DecompressString(data)
    local deserializedData = C_EncodingUtil.DeserializeCBOR(decompressedData)
    MapPinEnhanced:Debug({
        "onChatMessageReceived",
        data = deserializedData,
        channel = channel,
        sender = sender,
    })
end

Chomp.RegisterAddonPrefix(PROTOCOL_PREFIX, onChatMessageReceived, PROTOCOL_SETTINGS)
