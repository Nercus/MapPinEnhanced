-- Template: file://./input.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedInputMixin : EditBox, PropagateMouseMotion
---@field isDecimal boolean
---@onChangeCallback function
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

function MapPinEnhancedInputMixin:SetCallback(callback)
    assert(type(callback) == "function")
    self.onChangeCallback = callback
end

---@param optionData OptionObjectVariantsTyped
function MapPinEnhancedInputMixin:Setup(optionData)
    self.onChangeCallback = nil
    self:SetScript("OnTextChanged", function()
        if not self.onChangeCallback then return end
        self.onChangeCallback(self:GetText())
    end)
    self:SetCallback(optionData.onChange)
end
