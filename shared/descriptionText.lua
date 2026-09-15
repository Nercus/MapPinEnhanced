---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@param font FontString
---@param text string
---@param width number
---@param lines number
---@return string text
---@return boolean truncated
function MapPinEnhanced:BoundDescription(font, text, width, lines)
    font:SetWidth(width)
    font:SetWordWrap(true)
    font:SetNonSpaceWrap(true)
    font:SetMaxLines(0)
    local function Fits(candidate)
        font:SetText(self:EscapeMarkup(candidate))
        return font:GetNumLines() <= lines and font:GetUnboundedStringWidth() <= width * lines
    end
    if Fits(text) then return self:EscapeMarkup(text), false end
    local low, high = 0, #text
    local result = "..."
    while low <= high do
        local middle = math.floor((low + high) / 2)
        local candidate = self:GetUTF8Prefix(text, middle) .. "..."
        if Fits(candidate) then
            result = candidate
            low = middle + 1
        else
            high = middle - 1
        end
    end
    result = self:EscapeMarkup(result)
    font:SetText(result)
    return result, true
end

---@type FontString?
local tooltipMeasure

---@param description string?
function MapPinEnhanced:AddDescriptionToTooltip(description)
    if not description then return end
    if not tooltipMeasure then
        tooltipMeasure = UIParent:CreateFontString(nil, "ARTWORK", "GameTooltipText")
        tooltipMeasure:Hide()
    end
    -- Wrap privately, then supply non-wrapping lines. GameTooltip can grow to
    -- their measured width without narrowing the four-line budget afterward.
    tooltipMeasure:SetFontObject(GameTooltipText)
    tooltipMeasure:SetWidth(0)
    tooltipMeasure:SetWordWrap(false)
    ---@type string
    local remaining = description
    for line = 1, 4 do
        local newline = remaining:find("\n", 1, true)
        local paragraph = newline and remaining:sub(1, newline - 1) or remaining
        local low, high, accepted = 0, #paragraph, 0
        while low <= high do
            local middle = math.floor((low + high) / 2)
            local candidate = self:GetUTF8Prefix(paragraph, middle)
            local more = #candidate < #remaining
            tooltipMeasure:SetText(self:EscapeMarkup(candidate .. (line == 4 and more and "..." or "")))
            if tooltipMeasure:GetUnboundedStringWidth() <= 300 then
                accepted = #candidate
                low = middle + 1
            else
                high = middle - 1
            end
        end
        local text = paragraph:sub(1, accepted)
        if accepted < #paragraph and line < 4 then
            local wordBoundary = tonumber(text:match("^.*()%s+"))
            if wordBoundary and wordBoundary > 1 then
                accepted = wordBoundary - 1
                text = paragraph:sub(1, accepted)
            end
        end
        local consumed = accepted
        if accepted == #paragraph and newline then consumed = consumed + 1 end
        local more = consumed < #remaining
        if line == 4 and more then text = text .. "..." end
        GameTooltip:AddLine(self:EscapeMarkup(text ~= "" and text or " "), 0.85, 0.85, 0.85, false)
        if not more then break end
        remaining = remaining:sub(consumed + 1)
        if accepted < #paragraph then remaining = remaining:gsub("^ +", "") end
    end
end
