---@class NercLibPrivate : NercLib
local NercLib = _G.NercLib

---@class PlainOptionObject
---@field category string
---@field label string
---@field description string?
---@field descriptionImage string? reference to an image
---@field disabledState boolean?
---@field blockOnCreationInit boolean?

---@class ButtonOptions
---@field buttonLabel string
---@field onChange fun(value: mouseButton, down: boolean)

---@class CheckboxOptions
---@field onChange fun(value: boolean)
---@field init? fun(): boolean -- initial value can be nil if option has never been set before
---@field default boolean

---@class Color
---@field r number
---@field g number
---@field b number
---@field a number?

---@class ColorPickerOptions
---@field onChange fun(value: Color)
---@field init? fun(): Color -- initial value can be nil if option has never been set before
---@field default Color

---@class InputOptions
---@field onChange fun(value: string)
---@field init? fun(): string -- initial value can be nil if option has never been set before
---@field default string

---@class SelectOptions
---@field onChange fun(value: string | number | table<string,boolean>)
---@field init? fun(): string | number | table<string,boolean> -- initial value can be nil if option has never been set before
---@field default string | number | table<string,boolean>
---@field options SelectOptionEntry[]

---@class SelectOptionEntry
---@field label string
---@field value string | number
---@field type "button" | "title" | "checkbox" | "radio" | "divider" | "spacer"

---@class SliderOptions
---@field updateOnRelease boolean?
---@field onChange fun(value: number)
---@field init? fun(): number -- initial value can be nil if option has never been set before
---@field default number
---@field min number
---@field max number
---@field step number

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

---@alias FormType "button" | "checkbox" | "colorpicker" | "input" | "select" | "slider"
---@alias OptionObjectVariantsTyped OptionButtonTyped | OptionCheckboxTyped | OptionColorpickerTyped | OptionInputTyped | OptionSelectTyped | OptionSliderTyped

---@param addon NercLibAddon
function NercLib:AddOptionModule(addon)
    ---@class Options
    local Options = addon:GetModule("Options")

    ---@type table<string, number>
    Options.categories = {}

    ---check if an option with the same label already exists in the category
    ---@param label string
    ---@param category string
    ---@param options table<string, OptionObjectVariants[]>
    local function CheckForDuplicateOption(label, category, options)
        assert(label, "Option must have a label")
        assert(category, "Option must have a category")
        assert(options, "Options must be a table")
        assert(options[category], "Category must exist")
        ---@type OptionObjectVariants[]
        local categoryOptions = options[category]
        for _, option in ipairs(categoryOptions) do
            if option.label == label then
                error(("Option with label %s already exists in category %s"):format(label, category))
            end
        end
    end

    ---register a category
    ---@param category string
    ---@param order number
    function Options:RegisterCategory(category, order)
        assert(category, "Category must have a name")
        assert(order, "Category must have an order")
        self.categories[category] = order
    end

    ---@param optionType FormType
    ---@param option OptionObjectVariants
    function Options:RegisterOption(optionType, option)
        assert(option.category, "Option must have a category")
        assert(self.categories[option.category], "Category must be registered")
        assert(option.label, "Option must have a label")
        assert(optionType ~= "button" and option.default ~= nil, "Option must have a default value")
        assert(optionType, "Option must have a type")

        if not self.options then
            ---@type table<string, OptionObjectVariantsTyped[]>
            self.options = {}
        end
        if not self.options[option.category] then
            self.options[option.category] = {}
        end
        CheckForDuplicateOption(option.label, option.category, self.options)

        local optionTyped = option --[[@as OptionObjectVariantsTyped]]
        optionTyped.type = optionType
        table.insert(self.options[option.category], option)

        if not optionTyped.onChange then return end
        assert(type(optionTyped.onChange) == "function", "onChange must be a function")
        assert(type(optionTyped.init) == "function", "init must be a function")

        if optionTyped.init() == nil then
            optionTyped.onChange(optionTyped.default) -- set default value
        end
        if not optionTyped.blockOnCreationInit then
            optionTyped.onChange(optionTyped.init()) -- set initial value
        end
    end

    ---get a list of all used categories in the correct order
    ---@return string[] usedCategories - the ideal scenario would be that this always returns string[], it's a failsafe if we have a category that is not in the order
    function Options:GetCategories()
        local usedCategories = {}
        for category, _ in pairs(self.categories) do
            table.insert(usedCategories, category)
        end
        table.sort(usedCategories, function(a, b)
            return self.categories[a] < self.categories[b]
        end)
        return usedCategories
    end

    ---get a list of all options for a category
    ---@param category string
    ---@return OptionObjectVariantsTyped[]
    function Options:GetOptionsForCategory(category)
        assert(self.categories[category], "Category must be registered")
        return self.options[category]
    end

    ---get the option data for a specific option
    ---@param category string
    ---@param label string
    ---@return OptionObjectVariantsTyped | nil
    function Options:GetOptionElementData(category, label)
        assert(self.categories[category], "Category must be registered")
        assert(self.options[category], "Category must have options")
        assert(label, "Option must have a label")
        local categoryOptions = self.options[category]
        for _, option in ipairs(categoryOptions) do
            if option and option.label == label then
                return option
            end
        end
        return nil
    end
end
