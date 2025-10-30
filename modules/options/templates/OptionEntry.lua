---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionsEntryTemplate : Frame
---@field form AnyFormElement?
---@field formSlot Frame
---@field label FontString
MapPinEnhancedOptionsEntryMixin = {}

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

---@param node TreeNodeMixin
function MapPinEnhancedOptionsEntryMixin:Init(node)
    local data = node:GetData() --[[@as MapPinEnhancedOptionMixin]]
    local optionType = data.optionType
    self.optionData = data.optionData
    self.label:SetText(data.optionData.label)
    self.form = GetFormByType(optionType)
    self.form:Setup(data.optionData)
    self.form:SetParent(self.formSlot)
    self.form:SetPoint("LEFT", self.formSlot, "LEFT", -2, 0)
    self.form:Show()
end

function MapPinEnhancedOptionsEntryMixin:Reset()
    if self.form then
        framePool:Release(self.form)
        self.form = nil
    end
end

function MapPinEnhancedOptionsEntryMixin:SetEnabled()
end

function MapPinEnhancedOptionsEntryMixin:SetDisabled()
end

local Options = MapPinEnhanced:GetModule("Options")

function MapPinEnhancedOptionsEntryMixin:OnEnter()
    Options.optionsFrame:SetDescription({
        image = self.optionData.descriptionImage,
        text = self.optionData.description,
    })
end

function MapPinEnhancedOptionsEntryMixin:OnLeave()
    Options.optionsFrame:SetDescription(nil)
end
