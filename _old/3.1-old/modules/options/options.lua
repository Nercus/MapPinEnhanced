---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Options
local Options = MapPinEnhanced:GetModule("Options")
local CONSTANTS = MapPinEnhanced.CONSTANTS



---check if an option with the same label already exists in the category
---@param label string
---@param category OPTIONCATEGORY
---@param options table<OPTIONCATEGORY, OptionObjectVariants[]>
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

---@param optionType FormType
---@param option OptionObjectVariants
function Options:RegisterOption(optionType, option)
    assert(option.category, "Option must have a category")
    assert(option.label, "Option must have a label")
    assert(optionType ~= "button" and option.default ~= nil, "Option must have a default value")
    assert(optionType, "Option must have a type")

    if not self.options then
        ---@type table<OPTIONCATEGORY, OptionObjectVariantsTyped[]>
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
---@return OPTIONCATEGORY[] usedCategories - the ideal scenario would be that this always returns OPTIONCATEGORY[], it's a failsafe if we have a category that is not in the order
function Options:GetCategories()
    -- dont return empty categories
    local categories = {}
    for _, category in ipairs(CONSTANTS.CATEGORY_ORDER) do
        if self.options[category] then
            table.insert(categories, category)
        end
    end
    return categories
end

---get a list of all options for a category
---@param category OPTIONCATEGORY
---@return OptionObjectVariantsTyped[]
function Options:GetOptionsForCategory(category)
    return self.options[category]
end

---get the option data for a specific option
---@param category OPTIONCATEGORY
---@param label string
---@return OptionObjectVariantsTyped | nil
function Options:GetOptionElementData(category, label)
    local categoryOptions = self.options[category]
    for _, option in ipairs(categoryOptions) do
        if option and option.label == label then
            return option
        end
    end
    return nil
end
