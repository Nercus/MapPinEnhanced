---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class Options : Module
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

local function CheckForDuplicateOption(label, category, options)
    if not options then return end
    if not options[category] then return end
    ---@type OptionObjectVariants[]
    local categoryOptions = options[category]
    for _, option in ipairs(categoryOptions) do
        if option.label == label then
            error(("Option with label %s already exists in category %s"):format(label, category))
        end
    end
end

---@param optionType FormType
---@param option OptionObjectVariants
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
    CheckForDuplicateOption(option.label, option.category, self.options)
    local optionTyped = option --[[@as OptionObjectVariantsTyped]]
    optionTyped.type = optionType
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
