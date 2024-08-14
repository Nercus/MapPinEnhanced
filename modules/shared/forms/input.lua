-- Template: file://./input.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedInputMixin : EditBox, PropagateMouseMotion
---@field isDecimal boolean
---@onChangeCallback function
MapPinEnhancedInputMixin = {}


---@class InputOptions
---@field onChange fun(value: string)
---@field init? string -- initial value can be nil if option has never been set before
---@field default string



local CONSTANTS = MapPinEnhanced.CONSTANTS
local seperator = CONSTANTS.DECIMAL_SEPARATOR

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
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
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

---@param optionData OptionInputTyped | InputOptions
function MapPinEnhancedInputMixin:Setup(optionData)
    self.onChangeCallback = nil
    local init = optionData.init --[[@as string]]
    self:SetText(init)
    self:SetCursorPosition(0)
    self:SetDisabled(optionData.disabledState)
    self:SetScript("OnTextChanged", function()
        if not self.onChangeCallback then return end
        self.onChangeCallback(self:GetText())
    end)
    -- this is a hack to make sure the callback is set after the input is created
    C_Timer.After(0.1, function()
        self:SetCallback(optionData.onChange)
    end)
end
