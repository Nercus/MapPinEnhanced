-- Template: file://./input.xml
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

---@param disabled boolean
function MapPinEnhancedInputMixin:SetDisabled(disabled)
    if disabled then
        self:Disable()
        self:SetAlpha(0.5)
    else
        self:Enable()
        self:SetAlpha(1)
    end
end

---@param optionData OptionObjectVariantsTyped
function MapPinEnhancedInputMixin:Setup(optionData)
    self.onChangeCallback = nil
    local init = optionData.init --[[@as string]]
    self:SetText(init)
    self:SetDisabled(optionData.disabledState)
    if optionData.disabledState then return end -- dont set up click handler if disabled
    self:SetScript("OnTextChanged", function()
        if not self.onChangeCallback then return end
        self.onChangeCallback(self:GetText())
    end)
    -- this is a hack to make sure the callback is set after the input is created
    C_Timer.After(0.1, function()
        self:SetCallback(optionData.onChange)
    end)
end
