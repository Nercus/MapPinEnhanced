---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@param font FontString
---@param text string?
---@param width number
---@param maxLines number?
---@return boolean truncated
function Wayfinders:ApplyWrappedText(font, text, width, maxLines)
    local _, size = font:GetFont()
    local lineHeight = size + font:GetSpacing()
    -- Each description gets at most a fifth of the screen; titles/instructions
    -- have an additional four-line limit. Width is assigned before measuring.
    local lines = math.max(1, math.min(maxLines or math.huge,
        math.floor(UIParent:GetHeight() * 0.2 / math.max(1, lineHeight))))
    font:SetHeight(0)
    local _, truncated = MapPinEnhanced:BoundDescription(font, text or "", width, lines)
    font:SetWidth(math.max(1, math.min(width, math.ceil(font:GetUnboundedStringWidth()))))
    font:SetHeight(math.max(1, font:GetStringHeight()))
    return truncated
end

---@param owner Frame
---@param title string?
---@param description string?
function Wayfinders:ShowTextTooltip(owner, title, description)
    GameTooltip:SetOwner(owner, "ANCHOR_BOTTOM")
    GameTooltip:ClearLines()
    -- The normal pin tooltip intentionally has a four-line budget. Wayfinder
    -- overflow exposes the complete text, still measured to a bounded width.
    MapPinEnhanced:AddDescriptionToTooltip(title, math.huge)
    MapPinEnhanced:AddDescriptionToTooltip(description, math.huge)
    GameTooltip:Show()
end
