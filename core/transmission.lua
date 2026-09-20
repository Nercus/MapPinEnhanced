---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Chomp = MapPinEnhanced.Chomp
local DATA_PREFIX = "MPHData"
local TEXT_PREFIX = "MPHText"

---@enum (key) ADDON_MESSAGE_EVENT
local ALLOWED_EVENTS = {
    GROUP_REQUEST = true,
    GROUP_RESPONSE = true,
}

---@type table<string, fun(data: table, sender: string, kind: string)[]>
local dataCallbacks = {}
---@type table<string, fun(text: string, sender: string, kind: string)[]>
local textCallbacks = {}

---@param event ADDON_MESSAGE_EVENT
---@param text string
---@param kind string
---@param target string
function MapPinEnhanced:SendTextAddonMessage(event, text, kind, target)
    assert(ALLOWED_EVENTS[event], "MapPinEnhanced:SendTextAddonMessage: invalid event")
    Chomp.SmartAddonMessage(TEXT_PREFIX, event .. ":" .. text, kind, target, {
        serialize = true,
        binaryBlob = false,
    })
end

---@param event ADDON_MESSAGE_EVENT
---@param callback fun(text: string, sender: string, kind: string)
function MapPinEnhanced:OnTextAddonMessage(event, callback)
    assert(ALLOWED_EVENTS[event], "MapPinEnhanced:OnTextAddonMessage: invalid event")
    textCallbacks[event] = textCallbacks[event] or {}
    table.insert(textCallbacks[event], callback)
end

local encodeReplacements = { ["\000"] = "\001\001", ["\001"] = "\001\002" }
local decodeReplacements = { ["\001\001"] = "\000", ["\001\002"] = "\001" }

---@param event ADDON_MESSAGE_EVENT
---@param data table
---@param kind string
---@param target string
function MapPinEnhanced:SendDataAddonMessage(event, data, kind, target)
    assert(ALLOWED_EVENTS[event], "MapPinEnhanced:SendDataAddonMessage: invalid event")
    assert(type(data) == "table", "MapPinEnhanced:SendDataAddonMessage: data must be a table")
    local compressed = C_EncodingUtil.CompressString(C_EncodingUtil.SerializeCBOR(data))
    local encoded = compressed:gsub("[%z\001]", encodeReplacements)
    Chomp.SmartAddonMessage(DATA_PREFIX, event .. ":" .. encoded, kind, target, {
        serialize = true,
        binaryBlob = true,
    })
end

---@param event ADDON_MESSAGE_EVENT
---@param callback fun(data: table, sender: string, kind: string)
function MapPinEnhanced:OnDataAddonMessage(event, callback)
    assert(ALLOWED_EVENTS[event], "MapPinEnhanced:OnDataAddonMessage: invalid event")
    dataCallbacks[event] = dataCallbacks[event] or {}
    table.insert(dataCallbacks[event], callback)
end

---@param encoded string
---@return any
local function DecodeData(encoded)
    local compressed = encoded:gsub("\001.", decodeReplacements)
    local decompressed = C_EncodingUtil.DecompressString(compressed)
    if not decompressed then return nil end
    return C_EncodingUtil.DeserializeCBOR(decompressed)
end

-- Chomp owns fragmentation and sender/session isolation. Dispatch only complete
-- messages; a raw first-fragment callback is not a prerequisite for decoding.
Chomp.RegisterAddonPrefix(DATA_PREFIX, function(_, message, kind, sender)
    if type(message) ~= "string" or #message > 1048576 then return end
    local event, encoded = strsplit(":", message, 2)
    local callbacks = event and dataCallbacks[event]
    if not callbacks or not encoded then return end
    local ok, data = pcall(DecodeData, encoded)
    if not ok or type(data) ~= "table" then return end
    for _, callback in ipairs(callbacks) do callback(data, sender, kind) end
end, {
    permitUnlogged = true,
    permitLogged = true,
    permitBattleNet = true,
    fullMsgOnly = true,
    validTypes = { string = true },
})

Chomp.RegisterAddonPrefix(TEXT_PREFIX, function(_, message, kind, sender)
    if type(message) ~= "string" or #message > 1024 then return end
    local event, text = strsplit(":", message, 2)
    local callbacks = event and textCallbacks[event]
    if not callbacks or not text then return end
    for _, callback in ipairs(callbacks) do callback(text, sender, kind) end
end, {
    permitUnlogged = true,
    permitLogged = true,
    permitBattleNet = true,
    fullMsgOnly = true,
    validTypes = { string = true },
})
