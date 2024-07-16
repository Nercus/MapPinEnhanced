---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedInputMixin : EditBox
---@field isDecimal boolean
MapPinEnhancedInputMixin = {}

local seperator = GetLocale() == "deDE" and "," or "."

function MapPinEnhancedInputMixin:OnChar()
    if not self.isDecimal then return end
    -- only allow the following patterns for decimal
    -- XX or XX.XX or XX.X or X
    local text = self:GetText()
    if text == "" then return end

    if text:match("%d%d" .. seperator .. "%d%d") then return end
    if text:match("%d" .. seperator .. "%d%d") then return end
    if tonumber(text) and tonumber(text) < 100 then return end

    self:SetText(text:sub(1, #text - 1))
end
