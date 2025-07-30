---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Chomp = MapPinEnhanced.Chomp
local PROTOCOL_PREFIX_DATA = "MPHData";
local PROTOCOL_PREFIX_TEXT = "MPHText";

local PROTOCOL_SETTINGS_DATA = {
    permitUnlogged = true,
    permitLogged = true,
    permitBattleNet = true,
    fullMsgOnly = true,
    validTypes = {
        ["string"] = true,
    },
    broadcastPrefix = PROTOCOL_PREFIX_DATA,
}

local PROTOCOL_SETTINGS_TEXT = {
    permitUnlogged = true,
    permitLogged = true,
    permitBattleNet = true,
    fullMsgOnly = true,
    validTypes = {
        ["string"] = true,
    },
    broadcastPrefix = PROTOCOL_PREFIX_TEXT,
}



---@type table<string, {onSuccess: fun(data: table), onUpdate: fun(progress: number, total: number)}[]>
local registeredDataCallbacks = {}
---@type table<number, string>
local sessionIDToDataEvent = {}
---@type table<string, fun(text: string)[]>
local registeredTextCallbacks = {}


---@enum (key) ADDON_MESSAGE_EVENT
local ALLOWED_EVENTS = {
    TRANSMIT_SET = "TRANSMIT_SET",
    REQUEST_SET = "REQUEST_SET",
}


---@param event ADDON_MESSAGE_EVENT
---@param text string
---@param kind string
---@param target string
function MapPinEnhanced:SendTextAddonMessage(event, text, kind, target)
    assert(ALLOWED_EVENTS[event], "Invalid event: " .. tostring(event))
    local textData = string.format("%s:%s", event, text)
    Chomp.SmartAddonMessage(PROTOCOL_PREFIX_TEXT, textData, kind, target, {
        serialize = true,
        binaryBlob = false
    })
end

---@param event ADDON_MESSAGE_EVENT
---@param callback fun(text: string)
function MapPinEnhanced:OnTextAddonMessage(event, callback)
    assert(ALLOWED_EVENTS[event], "Invalid event: " .. tostring(event))
    if not registeredTextCallbacks[event] then
        registeredTextCallbacks[event] = {}
    end
    table.insert(registeredTextCallbacks[event], callback)
end

local function onTextMessageReceived(_, text)
    local event, msg = strsplit(":", text, 2)
    if not event or not msg then
        return
    end
    if registeredTextCallbacks[event] then
        for _, callback in ipairs(registeredTextCallbacks[event]) do
            if type(callback) == "function" then
                callback(msg)
            end
        end
    end
end

local encodeReplacements = { ["\000"] = "\001\001", ["\001"] = "\001\002" };
local decodeReplacements = { ["\001\001"] = "\000", ["\001\002"] = "\001" };

---@param data table
---@param event ADDON_MESSAGE_EVENT
---@return string
local function EncodeTableForTransmission(data, event)
    local serializedTable = C_EncodingUtil.SerializeCBOR(data)
    local compressedString = C_EncodingUtil.CompressString(serializedTable)
    compressedString = (string.gsub(compressedString, "[%z\001]", encodeReplacements));
    return string.format("%s:%s", event, compressedString)
end

---@param data string
---@return table?, string?
local function DecodeTableFromTransmission(data)
    local event, compressedData = strsplit(":", data, 2)
    compressedData = (string.gsub(compressedData, "\001.", decodeReplacements))
    local decompressedData = C_EncodingUtil.DecompressString(compressedData)
    if not event or not decompressedData then
        error("Failed to decode table from transmission data")
        return nil
    end
    return C_EncodingUtil.DeserializeCBOR(decompressedData), event
end

---@param event ADDON_MESSAGE_EVENT
---@param data table
---@param kind string
---@param target string
function MapPinEnhanced:SendDataAddonMessage(event, data, kind, target)
    assert(type(data) == "table", "Data must be a table")
    assert(ALLOWED_EVENTS[event], "Invalid event: " .. tostring(event))

    local encodedData = EncodeTableForTransmission(data, event)
    Chomp.SmartAddonMessage(PROTOCOL_PREFIX_DATA, encodedData, kind, target, {
        serialize = true,
        binaryBlob = true
    })
end

---@param event ADDON_MESSAGE_EVENT
---@param onSuccessCallback fun(data: table)
---@param onUpdateCallback fun(progress: number, total: number)
function MapPinEnhanced:OnDataAddonMessage(event, onSuccessCallback, onUpdateCallback)
    assert(ALLOWED_EVENTS[event], "Invalid event: " .. tostring(event))
    if not registeredDataCallbacks[event] then
        registeredDataCallbacks[event] = {}
    end
    table.insert(registeredDataCallbacks[event], {
        onSuccess = onSuccessCallback,
        onUpdate = onUpdateCallback
    })
end

---@param _ any
---@param data string
---@param ... unknown
local function onDataMessageReceived(_, data, ...)
    local sessionID = select(11, ...)
    if not sessionID or not sessionIDToDataEvent[sessionID] then
        error("Received transmission for unknown session ID: " .. tostring(sessionID))
        return
    end
    local decodedData, event = DecodeTableFromTransmission(data)
    if not event or not decodedData then
        error("Failed to decode data from transmission")
        return
    end
    if not registeredDataCallbacks[event] then
        error("Received transmission for unknown event: " .. tostring(event))
        return
    end
    local callbackList = registeredDataCallbacks[event]
    for _, callback in ipairs(callbackList) do
        if type(callback.onSuccess) == "function" then
            callback.onSuccess(decodedData)
        end
    end
end


---@param _ any
---@param data string
---@param ... unknown
local function onDataMessageIncrementalReceived(_, data, ...)
    ---@type number, number?, number?
    local sessionID, msgID, msgTotal = select(11, ...)
    if msgID == 1 then
        local event = data:match('^"([^"]+):')
        if not event or not registeredDataCallbacks[event] then
            error("Received transmission for unknown event: " .. tostring(event))
            return
        end
        sessionIDToDataEvent[sessionID] = event
    end
    local event = sessionIDToDataEvent[sessionID]
    if not event or not registeredDataCallbacks[event] then
        error("Received transmission for unknown event: " .. tostring(event))
        return
    end
    local callbackList = registeredDataCallbacks[event]
    for _, callback in ipairs(callbackList) do
        if type(callback.onUpdate) == "function" then
            callback.onUpdate(msgID, msgTotal)
        end
    end
end

PROTOCOL_SETTINGS_DATA.rawCallback = onDataMessageIncrementalReceived
Chomp.RegisterAddonPrefix(PROTOCOL_PREFIX_DATA, onDataMessageReceived, PROTOCOL_SETTINGS_DATA)
Chomp.RegisterAddonPrefix(PROTOCOL_PREFIX_TEXT, onTextMessageReceived, PROTOCOL_SETTINGS_TEXT)
