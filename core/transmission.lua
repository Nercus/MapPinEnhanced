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

---@class TransmissionOptions
---@field event string
---@field onComplete fun(data: table)
---@field onUpdate fun(progress: number, total: number)

---@type table<string, TransmissionOptions[]>
local registeredTransmissions = {}

---@type table<number, string>
local sessionIDToTransmission = {}

---@type table<string, fun(data: string)[]>
local registeredAddonMessages = {}

local function EncodeTableForTransmission(data, event)
    local serializedTable = C_EncodingUtil.SerializeCBOR(data)
    serializedTable = string.format("%s:%s", event, serializedTable)
    return C_EncodingUtil.CompressString(serializedTable)
end

local function DecodeTableFromTransmission(data)
    local decompressedData = C_EncodingUtil.DecompressString(data)
    local event, serializedTable = decompressedData:match("^(.-):(.*)$")
    if not event or not serializedTable then
        error("Failed to decode table from transmission data")
        return nil
    end
    return C_EncodingUtil.DeserializeCBOR(serializedTable), event
end

---@param event string
---@param text string
---@param kind string
---@param target string
function MapPinEnhanced:SendAddonMessage(event, text, kind, target)
    local textData = string.format("%s:%s", event, text)
    Chomp.SmartAddonMessage(PROTOCOL_PREFIX, textData, kind, target, {
        serialize = true,
        binaryBlob = false
    })
end

function MapPinEnhanced:RegisterAddonMessage(event, callback)
    if not event or not callback then
        error("Event and callback must be provided for registering addon message")
    end
    if not registeredAddonMessages[event] then
        registeredAddonMessages[event] = {}
    end
    table.insert(registeredAddonMessages[event], callback)
end

---@param transmissionOptions TransmissionOptions
---@return fun(data: table, kind: string, target: string)
function MapPinEnhanced:RegisterTransmission(transmissionOptions)
    if not transmissionOptions or not transmissionOptions.event then
        error("Transmission options must include an 'event' field")
    end
    if not registeredTransmissions[transmissionOptions.event] then
        registeredTransmissions[transmissionOptions.event] = {}
    end
    table.insert(registeredTransmissions[transmissionOptions.event], transmissionOptions)
    return function(data, kind, target)
        local compressedTable = EncodeTableForTransmission(data, transmissionOptions.event)
        Chomp.SmartAddonMessage(PROTOCOL_PREFIX, compressedTable, kind, target, {
            serialize = true,
            binaryBlob = true
        })
    end
end

local function onDataMessageIncrementalReceived(data, sessionID, msgID, msgTotal)
    if msgID == 1 then
        local _, event = DecodeTableFromTransmission(data)
        if not event or not registeredTransmissions[event] then
            error("Received transmission for unknown event: " .. tostring(event))
            return
        end
        sessionIDToTransmission[sessionID] = event
    end

    local event = sessionIDToTransmission[sessionID]
    local transmissionInfo = registeredTransmissions[event]
    if not transmissionInfo then
        error("No registered transmission for event: " .. tostring(event))
        return
    end
    for _, transmission in ipairs(transmissionInfo) do
        if transmission.onUpdate then
            transmission.onUpdate(msgID, msgTotal)
        end
    end
end


local function onIncrementalMessageReceived(_, data, _, _, _, _, _, _, _, _, _, _, sessionID, msgID, msgTotal)
    local dataType = type(data)
    if dataType == "string" then
        return -- we don't handle incremental updates of strings. if data is big enough to be split, it should be a table
    elseif dataType == "table" then
        onDataMessageIncrementalReceived(data, sessionID, msgID, msgTotal)
    else
        error("Unsupported data type received: " .. tostring(dataType))
    end
end

local function onTextMessageReceived(data)
    ---@type string, string
    local event, msg = data:match("([^:]+):(.*)")
    if not registeredAddonMessages[event] then
        error("No registered addon message for event: " .. tostring(event))
        return
    end
    for _, callback in ipairs(registeredAddonMessages[event]) do
        callback(msg)
    end
end


local function onDataMessageReceived(data, sessionID)
    local event = sessionIDToTransmission[sessionID]
    local transmissionInfo = registeredTransmissions[event]
    if not transmissionInfo then
        error("No registered transmission for event: " .. tostring(event))
        return
    end
    local decodedData, eventType = DecodeTableFromTransmission(data)
    if not decodedData or eventType ~= event then
        error("Failed to decode data or event mismatch: " .. tostring(eventType))
        return
    end
    for _, transmission in ipairs(transmissionInfo) do
        if transmission.onComplete then
            transmission.onComplete(decodedData)
        end
    end
end


local function onChatMessageReceived(_, data, _, _, _, _, _, _, _, _, _, _, sessionID)
    local dataType = type(data)
    if dataType == "string" then
        onTextMessageReceived(data)
    elseif dataType == "table" then
        onDataMessageReceived(data, sessionID)
    end
end

PROTOCOL_SETTINGS.rawCallback = onIncrementalMessageReceived;
Chomp.RegisterAddonPrefix(PROTOCOL_PREFIX, onChatMessageReceived, PROTOCOL_SETTINGS)
