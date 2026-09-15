---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@param value number
---@param step number?
---@return string
function MapPinEnhanced:FormatValueToPrecision(value, step)
    if not step or step == 1 then
        return tostring(math.floor(value))
    end
    local precision = math.max(0, -math.floor(math.log10(step)))
    return string.format("%." .. precision .. "f", value)
end

---@param text string
---@param length integer Maximum byte length; incomplete UTF-8 characters are omitted.
---@return string
function MapPinEnhanced:GetUTF8Prefix(text, length)
    while length > 0 do
        local byte = text:byte(length + 1)
        if not byte or byte < 128 or byte >= 192 then break end
        length = length - 1
    end
    return text:sub(1, length)
end

---@param text string?
---@return string?
function MapPinEnhanced:NormalizeText(text)
    if issecretvalue(text) or type(text) ~= "string" then return nil end
    text = strtrim(text:gsub("\r\n", "\n"):gsub("\r", "\n"))
    return text ~= "" and text or nil
end

---@param text string
---@return string
function MapPinEnhanced:EscapeMarkup(text)
    return (text:gsub("|", "||"))
end

---@param text string?
---@return string?
function MapPinEnhanced:ToPlainText(text)
    text = self:NormalizeText(text)
    if not text then return nil end
    text = text:gsub("|H.-|h(.-)|h", "%1"):gsub("|c%x%x%x%x%x%x%x%x", "")
        :gsub("|r", ""):gsub("|T.-|t", ""):gsub("|A.-|a", ""):gsub("||", "|")
    text = self:NormalizeText(text)
    return text
end
