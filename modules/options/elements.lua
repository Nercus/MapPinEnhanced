---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class Options : Module
---@field options table<OPTIONCATEGORY, OptionObjectTypes[]> | nil
local Options = MapPinEnhanced:GetModule("Options")

---@class PlainOptionObject
---@field category OPTIONCATEGORY
---@field label string
---@field description string
---@field descriptionImage string reference to an image

---@class OptionButton : PlainOptionObject
---@field onChange fun(value: MouseButton, down: boolean)

---@class OptionCheckbox : PlainOptionObject
---@field onChange fun(value: boolean)
---@field init boolean
---@field default boolean

---@class OptionColorpicker : PlainOptionObject
---@field onChange fun(value: Color)
---@field init Color
---@field default Color

---@class OptionInput : PlainOptionObject
---@field onChange fun(value: string)
---@field init string
---@field default string

---@class OptionSelect : PlainOptionObject
---@field onChange fun(value: string)
---@field init number index of the selected option
---@field default number index of the selected option
---@field options (string | number | boolean)[]

---@class OptionSlider : PlainOptionObject
---@field onChange fun(value: number)
---@field init number
---@field default number
---@field min number
---@field max number
---@field step number

---@alias OptionObjectTypes OptionButton | OptionCheckbox | OptionColorpicker | OptionInput | OptionSelect | OptionSlider


---@param optionType FormType
---@param option OptionObjectTypes
function Options:RegisterOption(optionType, option)
    assert(option.category, "Option must have a category")
    assert(option.label, "Option must have a label")
    assert(option.description, "Option must have a description")
    assert(option.descriptionImage, "Option must have a descriptionImage")
    assert(optionType, "Option must have a type")
    if not self.options then
        self.options = {}
    end
    if not self.options[option.category] then
        self.options[option.category] = {}
    end
    table.insert(self.options[option.category], option)
end

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
