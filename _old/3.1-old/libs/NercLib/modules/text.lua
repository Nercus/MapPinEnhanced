---@class NercLibPrivate : NercLib
local NercLib = _G.NercLib



---@param addon NercLibAddon
function NercLib:AddTextModule(addon)
    ---@class Text
    local Text = addon:GetModule("Text")

    ---Abbreviate a number to a more readable format
    ---@param number number
    ---@return string
    function Text:AbbreviateNumber(number)
        assert(type(number) == "number", "Number not provided or incorrect type")
        if number >= 1e12 then
            return string.format("%.1fT", number / 1e12)
        elseif number >= 1e9 then
            return string.format("%.1fB", number / 1e9)
        elseif number >= 1e6 then
            return string.format("%.2fM", number / 1e6)
        elseif number >= 1e3 then
            return string.format("%.1fK", number / 1e3)
        else
            return string.format("%d", number)
        end
    end

    ---Wrap text in a color
    ---@param text string
    ---@param color ColorMixin
    ---@return string
    function Text:WrapTextInColor(text, color)
        assert(type(text) == "string", "Text not provided or incorrect type")
        assert(type(color) == "table", "Color not provided or incorrect type")
        local colorEscape = string.format("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
        return colorEscape .. text .. "|r"
    end

    local random = math.random

    ---@alias UUID string a UUID in the format of 'xxxxxxxx-xxxx' or 'prefix-xxxxxxxx-xxxx'

    ---generate a UUID in the format of 'xxxxxxxx-xxxx'
    ---@param prefix? string optional prefix to add to the UUID
    ---@return UUID
    function Text:GenerateUUID(prefix)
        assert(type(prefix) == "string" or prefix == nil, "Prefix must be a string or nil")
        local template = 'xxxxxxxx-yxxx'
        local ans = string.gsub(template, '[xy]', function(c)
            local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
            return string.format('%x', v)
        end)
        return prefix and prefix .. '-' .. ans or ans
    end

    local defaultColor = ConsoleGetColorFromType(1)
    local prefix = Text:WrapTextInColor(addon.name .. ": ", defaultColor)

    ---Print a styled message to the chat
    ---@param ... string
    function Text:Print(...)
        local str = select(1, ...)
        local args = select(2, ...)
        if args then
            str = string.format(str, args) ---@type string
        end
        assert(type(str) == "string", "Print must be passed a string")
        ---@diagnostic disable-next-line: undefined-global, no-unknown
        DEFAULT_CHAT_FRAME:AddMessage(prefix .. str)
    end

    function Text:PrintUnformatted(...)
        local str = select(1, ...)
        local args = select(2, ...)
        if args then
            str = string.format(str, args) ---@type string
        end
        assert(type(str) == "string", "PrintUnformatted must be passed a string")
        ---@diagnostic disable-next-line: undefined-global, no-unknown
        DEFAULT_CHAT_FRAME:AddMessage(str)
    end
end
