-- Template: file://./OptionEditorElement.xml
---@class MapPinEnhancedOptionEditorElementMixin : Frame
---@field label FontString
---@field highlight Texture
---@field option OptionObjectVariants
---@field formElement FormElement
---@field optionHolder Frame
---@field type FormType
MapPinEnhancedOptionEditorElementMixin = {}


---@param formElement FormElement
function MapPinEnhancedOptionEditorElementMixin:SetFormElement(formElement)
    assert(formElement, "formElement must be a valid frame")
    self.formElement = formElement
    formElement:SetParent(self.optionHolder)
    formElement:ClearAllPoints()
    formElement:SetPoint("RIGHT", -10, 0)
    formElement:Show()
end

---@param optionData OptionObjectVariantsTyped
function MapPinEnhancedOptionEditorElementMixin:Setup(optionData)
end
