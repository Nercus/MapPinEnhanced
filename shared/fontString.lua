---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@param fontString FontString
---@param text string
---@param maxWidth number
---@param ellipsis string
function MapPinEnhanced:SetTruncatedText(fontString, text, maxWidth, ellipsis)
    fontString:SetWidth(0)
    fontString:SetText(text)

    local fullWidth = fontString:GetUnboundedStringWidth()
    if fullWidth <= maxWidth then
        fontString:SetWidth(math.ceil(fullWidth))
        return
    end

    local low = 0
    local high = #text
    local truncatedText = ellipsis
    while low <= high do
        local middle = math.floor((low + high) / 2)
        local candidate = MapPinEnhanced:GetUTF8Prefix(text, middle) .. ellipsis
        fontString:SetText(candidate)
        if fontString:GetUnboundedStringWidth() <= maxWidth then
            truncatedText = candidate
            low = middle + 1
        else
            high = middle - 1
        end
    end

    fontString:SetText(truncatedText)
    fontString:SetWidth(math.min(maxWidth, math.ceil(fontString:GetUnboundedStringWidth())))
end
