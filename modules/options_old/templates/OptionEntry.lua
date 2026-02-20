---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionsEntryTemplate : Frame
---@field form AnyFormElement?
---@field formSlot Frame
---@field label FontString
MapPinEnhancedOptionsEntryMixin = {}

---@alias AnyFormElement MapPinEnhancedButtonTemplate | MapPinEnhancedCheckboxTemplate | MapPinEnhancedColorpickerTemplate | MapPinEnhancedInputTemplate | MapPinEnhancedRadioGroupTemplate | MapPinEnhancedSliderTemplate | MapPinEnhancedTextareaTemplate | MapPinEnhancedCheckboxGroupTemplate

local framePool = CreateFramePoolCollection()
framePool:CreatePool("Button", nil, "MapPinEnhancedButtonTemplate")
framePool:CreatePool("CheckButton", nil, "MapPinEnhancedCheckboxTemplate")
framePool:CreatePool("Button", nil, "MapPinEnhancedColorpickerTemplate")
framePool:CreatePool("EditBox", nil, "MapPinEnhancedInputTemplate")
framePool:CreatePool("Frame", nil, "MapPinEnhancedRadioGroupTemplate")
framePool:CreatePool("Frame", nil, "MapPinEnhancedCheckboxGroupTemplate")
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
    elseif optionType == "checkboxgroup" then
        return framePool:Acquire("MapPinEnhancedCheckboxGroupTemplate")
    elseif optionType == "slider" then
        return framePool:Acquire("MapPinEnhancedSliderTemplate")
    elseif optionType == "textarea" then
        return framePool:Acquire("MapPinEnhancedTextareaTemplate")
    else
        error("Unknown option type: " .. tostring(optionType))
    end
end

local WIDTH_PER_ELEMENT = {
    button = 100,
    checkbox = 26,
    colorpicker = 26,
    input = 100,
    radiogroup = 200,
    checkboxgroup = 200,
    slider = 200,
    textarea = 200,
}

-- TODO: check for variable entry height based on content size i.e radiogroup, checkboxgroups being vertically aligned
-- FIXME: change to height and width per element type. adjust so it doesn't look too cramped
-- FIXME: form state is lost when collapsing/expanding categories

---@param node TreeNodeMixin
function MapPinEnhancedOptionsEntryMixin:Init(node)
    local data = node:GetData() --[[@as MapPinEnhancedOptionMixin]]
    local optionType = data.optionType
    data:SetFrame(self)
    self.optionData = data.optionData
    self.label:SetText(data.optionData.label)
    self.form = GetFormByType(optionType)
    self.form:SetWidth(WIDTH_PER_ELEMENT[optionType])
    self.form:SetPropagateMouseMotion(true)
    self.form:Setup(data.optionData)
    self.form:SetParent(self.formSlot)
    self.form:ClearAllPoints()
    self.form:SetPoint("RIGHT", self.formSlot, "RIGHT", -30, 0)
    self.form:Show()

    if self:IsMouseOver() then
        self:SetAlpha(1)
    else
        self:SetAlpha(0.7)
    end
end

function MapPinEnhancedOptionsEntryMixin:Reset()
    if self.form then
        framePool:Release(self.form)
        self.form = nil
    end
end

function MapPinEnhancedOptionsEntryMixin:SetEnabled()
    if self.form and self.form.SetEnabled then
        self.form:SetEnabled(true)
    end
end

function MapPinEnhancedOptionsEntryMixin:SetDisabled()
    if self.form and self.form.SetEnabled then
        self.form:SetEnabled(false)
    end
end

local Options = MapPinEnhanced:GetModule("Options")

function MapPinEnhancedOptionsEntryMixin:OnEnter()
    Options.optionsFrame:SetDescription({
        image = self.optionData.descriptionImage,
        text = self.optionData.description,
    })
    self:SetAlpha(1)
end

function MapPinEnhancedOptionsEntryMixin:OnLeave()
    Options.optionsFrame:SetDescription(nil)
    self:SetAlpha(0.7)
end
