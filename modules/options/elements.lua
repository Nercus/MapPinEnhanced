---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class Options : Module
local Options = MapPinEnhanced:GetModule("Options")

---@class PlainOptionObject
---@field category OPTIONCATEGORY
---@field label string
---@field description string?
---@field descriptionImage string? reference to an image
---@field disabledState boolean?
---@field blockOnCreationInit boolean?

---@class OptionButton : PlainOptionObject,ButtonOptions
---@class OptionCheckbox : PlainOptionObject,CheckboxOptions
---@class OptionColorpicker : PlainOptionObject,ColorPickerOptions
---@class OptionInput : PlainOptionObject,InputOptions
---@class OptionSelect : PlainOptionObject,SelectOptions
---@class OptionSlider : PlainOptionObject,SliderOptions

---@alias OptionObjectVariants OptionButton | OptionCheckbox | OptionColorpicker | OptionInput | OptionSelect | OptionSlider

---@class OptionButtonTyped : OptionButton
---@field type "button"
---@class OptionCheckboxTyped : OptionCheckbox
---@field type "checkbox"
---@class OptionColorpickerTyped : OptionColorpicker
---@field type "colorpicker"
---@class OptionInputTyped : OptionInput
---@field type "input"
---@class OptionSelectTyped : OptionSelect
---@field type "select"
---@class OptionSliderTyped : OptionSlider
---@field type "slider"

---@alias OptionObjectVariantsTyped OptionButtonTyped | OptionCheckboxTyped | OptionColorpickerTyped | OptionInputTyped | OptionSelectTyped | OptionSliderTyped


---@param option OptionButton
function Options:RegisterButton(option)
    self:RegisterOption("button", option)
end

---@param option OptionCheckbox
function Options:RegisterCheckbox(option)
    self:RegisterOption("checkbox", option)
end

---@param option OptionColorpicker
function Options:RegisterColorpicker(option)
    self:RegisterOption("colorpicker", option)
end

---@param option OptionInput
function Options:RegisterInput(option)
    self:RegisterOption("input", option)
end

---@param option OptionSelect
function Options:RegisterSelect(option)
    self:RegisterOption("select", option)
end

---@param option OptionSlider
function Options:RegisterSlider(option)
    self:RegisterOption("slider", option)
end
