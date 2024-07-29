-- TODO: wrapper for settings are here: might want to use a similiar debounce method like https://gist.github.com/Meorawr/c8b09f8a0ffc0b9f3fc32494c8208194


---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Options : Module
---@field CATEGORY table<CATEGORY, string>
---@field options table<CATEGORY, OptionObject[]> | nil
local Options = MapPinEnhanced:CreateModule("Options")

---@enum CATEGORY
local OptionCategories = {
    General = "General",
    Tracker = "Tracker",
    FloatingPin = "Floating Pin"
}

local CATEGORY_ORDER = {
    OptionCategories.General,
    OptionCategories.Tracker,
    OptionCategories.FloatingPin
}

Options.CATEGORY = OptionCategories

---@class OptionObject
---@field category CATEGORY
---@field label string
---@field description string
---@field descriptionImage string reference to an image
---@field type FormType

---@class OptionButton : OptionObject
---@field onChange fun(value: MouseButton, down: boolean)

---@class OptionCheckbox : OptionObject
---@field onChange fun(value: boolean)
---@field init boolean
---@field default boolean

---@class OptionColorpicker : OptionObject
---@field onChange fun(value: Color)
---@field init Color
---@field default Color

---@class OptionInput : OptionObject
---@field onChange fun(value: string)
---@field init string
---@field default string

---@class OptionSelect : OptionObject
---@field onChange fun(value: string)
---@field init number index of the selected option
---@field default number index of the selected option
---@field options (string | number | boolean)[]

---@class OptionSlider : OptionObject
---@field onChange fun(value: number)
---@field init number
---@field default number
---@field min number
---@field max number
---@field step number

---@class OptionObjectTypes : OptionButton | OptionCheckbox | OptionColorpicker | OptionInput | OptionSelect | OptionSlider

-- TODO: add proper typing for the options

---@param option OptionObjectTypes
function Options:RegisterOption(option)
    assert(option.category, "Option must have a category")
    assert(option.label, "Option must have a label")
    assert(option.type, "Option must have a type")

    if not self.options then
        self.options = {}
    end
    if not self.options[option.category] then
        self.options[option.category] = {}
    end
    table.insert(self.options[option.category], option)
end

function Options:SetOptionDisabledState()
end
