---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")

local PREFIX = "!MPH!"

---serialize a table for import/export
---@param data table
---@return string
function Providers:SerializeImport(data)
    local serialized = C_EncodingUtil.SerializeCBOR(data)
    local compressed = C_EncodingUtil.CompressString(serialized)
    local encoded = C_EncodingUtil.EncodeBase64(compressed)
    return PREFIX .. encoded
end

---deserialize a table from a string received through import/export
---@param data string
---@return table | nil
function Providers:DeserializeImport(data)
    local dataWithoutPrefix = string.sub(data, #PREFIX + 1)
    local decoded = C_EncodingUtil.DecodeBase64(dataWithoutPrefix)
    if not decoded then return end
    local decompressed = C_EncodingUtil.DecompressString(decoded)
    if not decompressed then return end
    local deserialized = C_EncodingUtil.DeserializeCBOR(decompressed)
    return deserialized
end
