---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Chomp = MapPinEnhanced.Chomp
local PROTOCOL_PREFIX = "MPH";
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



local EVENTS = {
    "set-transmission",

}




function MapPinEnhanced:RegisterTransmission()
    -- register with one of the available events (and the callbacks)
    -- the event is always added to the serialized/string data of the message as a prefix and identifier
    -- then a table with:
    -- 1. onSuccess callback -> returning the received data (param)
    -- 2. onUpdate callback -> returning the progress of the transmission (param)
    -- 3. onError callback -> returning the error message (param)
    -- 4. the prefix (param and returned)
    -- 5. a function to send the data (returned)
end

local function onIncrementalMessageReceived(_, data, _, sender, _, _, _, _, _, _, _, _, sessionID, msgID, msgTotal)

end

local function onChatMessageReceived(_, data, channel, sender)

end

PROTOCOL_SETTINGS.rawCallback = onIncrementalMessageReceived;

Chomp.RegisterAddonPrefix(PROTOCOL_PREFIX, onChatMessageReceived, PROTOCOL_SETTINGS)
