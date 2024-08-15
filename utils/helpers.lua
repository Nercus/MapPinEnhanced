---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


local random = math.random

---@alias UUID string

---generate a UUID in the format of 'xxxxxxxx-xxxx'
---@param prefix string optional prefix to add to the UUID
---@return UUID
function MapPinEnhanced:GenerateUUID(prefix)
    local template = 'xxxxxxxx-yxxx'
    local ans = string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
    return prefix and prefix .. '-' .. ans or ans
end

function MapPinEnhanced:DebounceChange(func, delay)
    ---@type FunctionContainer?
    local timer
    return function(...)
        local args = { ... }
        if timer then
            timer:Cancel()
        end
        timer = C_Timer.NewTimer(delay, function()
            func(unpack(args))
        end)
    end
end

--- TODO: move that to providers
local PREFIX = "!MPH!"
---@param data table
---@return string
function MapPinEnhanced:SerializeTransmit(data)
    local serialized = self.LibSerialize:Serialize(data) --[[@as string]]
    local compressed = self.LibDeflate:CompressDeflate(serialized)
    local encoded = self.LibDeflate:EncodeForWoWAddonChannel(compressed)
    return PREFIX .. encoded
end

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

---@param data table
---@return string
function MapPinEnhanced:SerializeImport(data)
    local serialized = self.LibSerialize:Serialize(data) --[[@as string]]
    local compressed = self.LibDeflate:CompressDeflate(serialized)
    local encoded = self.LibDeflate:EncodeForPrint(compressed)
    return PREFIX .. encoded
end

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
