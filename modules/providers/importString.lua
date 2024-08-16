---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local CONSTANTS = MapPinEnhanced.CONSTANTS
local PREFIX = CONSTANTS.PREFIX

---------------------------------------------------------------------------

---serialize a table for transmission through addon messages
---@param data table
---@return string
function MapPinEnhanced:SerializeTransmit(data)
    local serialized = self.LibSerialize:Serialize(data) --[[@as string]]
    local compressed = self.LibDeflate:CompressDeflate(serialized)
    local encoded = self.LibDeflate:EncodeForWoWAddonChannel(compressed)
    return PREFIX .. encoded
end

---deserialize a table from a string received through addon messages
---@param data string
---@return table | nil
function MapPinEnhanced:DeserializeTransmit(data)
    local dataWithoutPrefix = string.sub(data, #PREFIX + 1)
    local decoded = self.LibDeflate:DecodeForWoWAddonChannel(dataWithoutPrefix) --[[@as string]]
    if not decoded then return end
    local decompressed = self.LibDeflate:DecompressDeflate(decoded)
    if not decompressed then return end
    local success, deserialized = self.LibSerialize:Deserialize(decompressed) --[[@as table]]
    if not success then return end
    return deserialized
end

---serialize a table for import/export
---@param data table
---@return string
function MapPinEnhanced:SerializeImport(data)
    local serialized = self.LibSerialize:Serialize(data) --[[@as string]]
    local compressed = self.LibDeflate:CompressDeflate(serialized)
    local encoded = self.LibDeflate:EncodeForPrint(compressed)
    return PREFIX .. encoded
end

---deserialize a table from a string received through import/export
---@param data string
---@return table | nil
function MapPinEnhanced:DeserializeImport(data)
    local dataWithoutPrefix = string.sub(data, #PREFIX + 1)
    local decoded = self.LibDeflate:DecodeForPrint(dataWithoutPrefix) --[[@as string]]
    if not decoded then return end
    local decompressed = self.LibDeflate:DecompressDeflate(decoded)
    if not decompressed then return end
    local success, deserialized = self.LibSerialize:Deserialize(decompressed) --[[@as table]]
    if not success then return end
    return deserialized
end
