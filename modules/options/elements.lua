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

---@class OptionButton : PlainOptionObject
---@field buttonLabel string
---@field onChange fun(value: mouseButton, down: boolean)

---@class OptionCheckbox : PlainOptionObject
---@field onChange fun(value: boolean)
---@field init? boolean -- initial value can be nil if option has never been set before
---@field default boolean

---@class OptionColorpicker : PlainOptionObject
---@field onChange fun(value: Color)
---@field init? Color -- initial value can be nil if option has never been set before
---@field default Color

---@class OptionInput : PlainOptionObject
---@field onChange fun(value: string)
---@field init? string -- initial value can be nil if option has never been set before
---@field default string


---@class SelectOptionEntry
---@field label string
---@field value string | number | ColorPickerInfo
---@field type "button" | "title" | "checkbox" | "radio" | "divider" | "spacer"

---@class OptionSelect : PlainOptionObject
---@field onChange fun(value: string)
---@field init? string | number -- initial value can be nil if option has never been set before
---@field default string | number
---@field options SelectOptionEntry[]

---@class OptionSlider : PlainOptionObject
---@field onChange fun(value: number)
---@field init? number -- initial value can be nil if option has never been set before
---@field default number
---@field min number
---@field max number
---@field step number

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
