---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local random = math.random
local defaultColor = ConsoleGetColorFromType(1)

---Print a formatted message to the chat
---@param ... string
function MapPinEnhanced:Print(...)
    local str = select(1, ...)
    local args = select(2, ...)
    if args then
        str = string.format(str, args) ---@type string
    end
    assert(type(str) == "string", "Print must be passed a string")
    local prefix = self:WrapTextInColor(self.name .. ": ", defaultColor)
    ---@diagnostic disable-next-line: undefined-global, no-unknown
    DEFAULT_CHAT_FRAME:AddMessage(prefix .. str)
end

---Print a message to the chat without formatting
---@param ... string
function MapPinEnhanced:PrintUnformatted(...)
    local str = select(1, ...)
    local args = select(2, ...)
    if args then
        str = string.format(str, args) ---@type string
    end
    assert(type(str) == "string", "PrintUnformatted must be passed a string")
    ---@diagnostic disable-next-line: undefined-global, no-unknown
    DEFAULT_CHAT_FRAME:AddMessage(str)
end

---Wrap text in a color
---@param text string
---@param color ColorMixin
---@return string
function MapPinEnhanced:WrapTextInColor(text, color)
    assert(type(text) == "string", "Text not provided or incorrect type")
    assert(type(color) == "table", "Color not provided or incorrect type")
    local colorEscape = string.format("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
    return colorEscape .. text .. "|r"
end

---Generate a UUID in the format of 'xxxxxxxx-xxxx'
---@param prefix? string optional prefix to add to the UUID
---@return string UUID a UUID in the format of 'xxxxxxxx-xxxx' or 'prefix-xxxxxxxx-xxxx'
function MapPinEnhanced:GenerateUUID(prefix)
    assert(type(prefix) == "string" or prefix == nil, "Prefix must be a string or nil")
    local template = 'xxxxxxxx-yxxx'
    local ans = string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
    return prefix and prefix .. '-' .. ans or ans
end
