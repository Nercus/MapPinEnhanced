---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local CONSTANTS = MapPinEnhanced.CONSTANTS
local PREFIX = CONSTANTS.PREFIX
local LibSerialize = MapPinEnhanced.LibSerialize
local LibDeflate = MapPinEnhanced.LibDeflate

---@class PinProvider
local PinProvider = MapPinEnhanced:GetModule("PinProvider")


---serialize a table for transmission through addon messages
---@param data table
---@return string
function PinProvider:SerializeTransmit(data)
    local serialized = LibSerialize:Serialize(data) --[[@as string]]
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed)
    return PREFIX .. encoded
end

---deserialize a table from a string received through addon messages
---@param data string
---@return table | nil
function PinProvider:DeserializeTransmit(data)
    local dataWithoutPrefix = string.sub(data, #PREFIX + 1)
    local decoded = LibDeflate:DecodeForWoWAddonChannel(dataWithoutPrefix) --[[@as string]]
    if not decoded then return end
    local decompressed = LibDeflate:DecompressDeflate(decoded)
    if not decompressed then return end
    local success, deserialized = LibSerialize:Deserialize(decompressed) --[[@as table]]
    if not success then return end
    return deserialized
end

---serialize a table for import/export
---@param data table
---@return string
function PinProvider:SerializeImport(data)
    local serialized = LibSerialize:Serialize(data) --[[@as string]]
    local compressed = LibDeflate:CompressDeflate(serialized)
    local encoded = LibDeflate:EncodeForPrint(compressed)
    return PREFIX .. encoded
end

---deserialize a table from a string received through import/export
---@param data string
---@return table | nil
function PinProvider:DeserializeImport(data)
    local dataWithoutPrefix = string.sub(data, #PREFIX + 1)
    local decoded = LibDeflate:DecodeForPrint(dataWithoutPrefix) --[[@as string]]
    if not decoded then return end
    local decompressed = LibDeflate:DecompressDeflate(decoded)
    if not decompressed then return end
    local success, deserialized = LibSerialize:Deserialize(decompressed) --[[@as table]]
    if not success then return end
    return deserialized
end
