---@class MapPinEnhancedOptionEntryTemplate : Frame
---@field form AnyFormElement?
MapPinEnhancedOptionEntryMixin = {}

---@alias AnyFormElement MapPinEnhancedButtonTemplate | MapPinEnhancedCheckboxTemplate | MapPinEnhancedColorpickerTemplate | MapPinEnhancedInputTemplate | MapPinEnhancedRadioGroupTemplate | MapPinEnhancedSliderTemplate | MapPinEnhancedTextareaTemplate

local framePool = CreateFramePoolCollection()
framePool:CreatePool("Button", nil, "MapPinEnhancedButtonTemplate")
framePool:CreatePool("CheckButton", nil, "MapPinEnhancedCheckboxTemplate")
framePool:CreatePool("Button", nil, "MapPinEnhancedColorpickerTemplate")
framePool:CreatePool("EditBox", nil, "MapPinEnhancedInputTemplate")
framePool:CreatePool("Frame", nil, "MapPinEnhancedRadioGroupTemplate")
framePool:CreatePool("Slider", nil, "MapPinEnhancedSliderTemplate")
framePool:CreatePool("ScrollFrame", nil, "MapPinEnhancedTextareaTemplate")

---@param optionType OptionType
---@return AnyFormElement
local function GetFormByType(optionType)
    if optionType == "button" then
        return framePool:Acquire("MapPinEnhancedButtonTemplate")
    elseif optionType == "checkbox" then
        return framePool:Acquire("MapPinEnhancedCheckboxTemplate")
    elseif optionType == "colorpicker" then
        return framePool:Acquire("MapPinEnhancedColorpickerTemplate")
    elseif optionType == "input" then
        return framePool:Acquire("MapPinEnhancedInputTemplate")
    elseif optionType == "radiogroup" then
        return framePool:Acquire("MapPinEnhancedRadioGroupTemplate")
    elseif optionType == "slider" then
        return framePool:Acquire("MapPinEnhancedSliderTemplate")
    elseif optionType == "textarea" then
        return framePool:Acquire("MapPinEnhancedTextareaTemplate")
    else
        error("Unknown option type: " .. tostring(optionType))
    end
end

---@param node MapPinEnhancedOptionMixin
function MapPinEnhancedOptionEntryMixin:Init(node)
    node:SetFrame(self)
    local optionType = node.optionType
    self.form = GetFormByType(optionType)
    self.form:Setup(node.optionData)
end

function MapPinEnhancedOptionEntryMixin:Reset()
    if self.form then
        framePool:Release(self.form)
        self.form = nil
    end
end

function MapPinEnhancedOptionEntryMixin:SetEnabled()
end

function MapPinEnhancedOptionEntryMixin:SetDisabled()
end
