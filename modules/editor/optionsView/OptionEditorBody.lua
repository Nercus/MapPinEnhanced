-- Template: file://./OptionEditorBody.xml
---@class MapPinEnhancedOptionEditorViewBodyMixin : Frame
---@field optionElements FramePool
---@field buttons FramePool
---@field checkboxes FramePool
---@field colorpickers FramePool
---@field inputs FramePool
---@field selects FramePool
---@field sliders FramePool
---@field init boolean
MapPinEnhancedOptionEditorViewBodyMixin = {}


function MapPinEnhancedOptionEditorViewBodyMixin:OnLoad()
    if self.init then return end
    self.optionElements = CreateFramePool("Frame", nil, "MapPinEnhancedOptionEditorElementTemplate")
    self.buttons = CreateFramePool("Button", nil, "MapPinEnhancedButtonTemplate")
    self.checkboxes = CreateFramePool("CheckButton", nil, "MapPinEnhancedCheckboxTemplate")
    self.colorpickers = CreateFramePool("ColorSelect", nil, "MapPinEnhancedColorpickerTemplate")
    self.inputs = CreateFramePool("EditBox", nil, "MapPinEnhancedInputTemplate")
    self.selects = CreateFramePool("Frame", nil, "MapPinEnhancedSelectTemplate")
    self.sliders = CreateFramePool("Slider", nil, "MapPinEnhancedSliderTemplate")
    self.init = true
end

---@alias FormType "button" | "checkbox" | "colorpicker" | "input" | "select" | "slider"
---@alias FormElement MapPinEnhancedButtonMixin | MapPinEnhancedCheckboxMixin | MapPinEnhancedColorpickerMixin | MapPinEnhancedInputMixin | MapPinEnhancedSelectMixin | MapPinEnhancedSliderMixin

---@class FormData
---@field type FormType


---@param formType FormType
---@return MapPinEnhancedOptionEditorElementMixin
function MapPinEnhancedOptionEditorViewBodyMixin:GetFormElement(formType)
    if not self.init then
        self:OnLoad()
    end
    assert(type(formType) == "string", "formType must be a string")
    local optionElement = self.optionElements:Acquire() --[[@as MapPinEnhancedOptionEditorElementMixin]]
    if formType == "button" then
        local buttons = self.buttons:Acquire() --[[@as MapPinEnhancedButtonMixin]]
        optionElement:SetFormElement(buttons)
    elseif formType == "checkbox" then
        local checkboxes = self.checkboxes:Acquire() --[[@as MapPinEnhancedCheckboxMixin]]
        optionElement:SetFormElement(checkboxes)
    elseif formType == "colorpicker" then
        local colorpickers = self.colorpickers:Acquire() --[[@as MapPinEnhancedColorpickerMixin]]
        optionElement:SetFormElement(colorpickers)
    elseif formType == "input" then
        local inputs = self.inputs:Acquire() --[[@as MapPinEnhancedInputMixin]]
        optionElement:SetFormElement(inputs)
    elseif formType == "select" then
        local selects = self.selects:Acquire() --[[@as MapPinEnhancedSelectMixin]]
        optionElement:SetFormElement(selects)
    elseif formType == "slider" then
        local sliders = self.sliders:Acquire() --[[@as MapPinEnhancedSliderMixin]]
        optionElement:SetFormElement(sliders)
    end
    error("Invalid form formType: " .. formType)
    return optionElement
end
