---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Forms : Module
local Forms = MapPinEnhanced:CreateModule("Forms")



function Forms:Init()
    self.buttons = CreateFramePool("Button", nil, "MapPinEnhancedButtonTemplate")
    self.checkboxes = CreateFramePool("CheckButton", nil, "MapPinEnhancedCheckboxTemplate")
    self.colorpickers = CreateFramePool("ColorSelect", nil, "MapPinEnhancedColorpickerTemplate")
    self.inputs = CreateFramePool("EditBox", nil, "MapPinEnhancedInputTemplate")
    self.selects = CreateFramePool("Frame", nil, "MapPinEnhancedSelectTemplate")
    self.sliders = CreateFramePool("Slider", nil, "MapPinEnhancedSliderTemplate")
    self.textareas = CreateFramePool("Frame", nil, "MapPinEnhancedTextareaTemplate")
    self.init = true
end

---@alias FormType "button" | "checkbox" | "colorpicker" | "input" | "select" | "slider" | "textarea"
---@alias FormElement MapPinEnhancedButtonMixin | MapPinEnhancedCheckboxMixin | MapPinEnhancedColorpickerMixin | MapPinEnhancedInputMixin | MapPinEnhancedSelectMixin | MapPinEnhancedSliderMixin | MapPinEnhancedTextareaMixin

---@class FormData
---@field type FormType


---@param formType FormType
---@return FormElement | nil
function Forms:GetFormElement(formType)
    if not self.init then
        self:Init()
    end
    assert(type(formType) == "string", "formType must be a string")
    if formType == "button" then
        return self.buttons:Acquire() --[[@as MapPinEnhancedButtonMixin]]
    elseif formType == "checkbox" then
        return self.checkboxes:Acquire() --[[@as MapPinEnhancedCheckboxMixin]]
    elseif formType == "colorpicker" then
        return self.colorpickers:Acquire() --[[@as MapPinEnhancedColorpickerMixin]]
    elseif formType == "input" then
        return self.inputs:Acquire() --[[@as MapPinEnhancedInputMixin]]
    elseif formType == "select" then
        return self.selects:Acquire() --[[@as MapPinEnhancedSelectMixin]]
    elseif formType == "slider" then
        return self.sliders:Acquire() --[[@as MapPinEnhancedSliderMixin]]
    elseif formType == "textarea" then
        return self.textareas:Acquire() --[[@as MapPinEnhancedTextareaMixin]]
    end
    error("Invalid form formType: " .. formType)
    return nil
end
