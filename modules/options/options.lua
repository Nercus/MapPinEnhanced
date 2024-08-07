-- TODO: wrapper for settings are here: might want to use a similiar debounce method like https://gist.github.com/Meorawr/c8b09f8a0ffc0b9f3fc32494c8208194

---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Options : Module
---@field options table<OPTIONCATEGORY, OptionObjectVariantsTyped[]> | nil#
---@field OptionBody MapPinEnhancedOptionEditorViewBodyMixin | nil#
local Options = MapPinEnhanced:CreateModule("Options")
Options.options = {}

---@enum OPTIONCATEGORY
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


---get a list of all used categories in the correct order
---@return string[]
function Options:GetCategories()
    -- dont return empty categories
    local categories = {}
    for _, category in ipairs(CATEGORY_ORDER) do
        if self.options[category] then
            table.insert(categories, category)
        end
    end
    return categories
end

function Options:GetOptionsForCategory(category)
    return self.options[category]
end

---@param category OPTIONCATEGORY
---@param label string
---@return OptionObjectVariantsTyped | nil
function Options:GetOptionElement(category, label)
    local categoryOptions = self.options[category]
    for _, option in ipairs(categoryOptions) do
        if option and option.label == label then
            return option
        end
    end
    return nil
end

---@param category OPTIONCATEGORY
---@param label string
---@param disabledState boolean
function Options:SetOptionDisabledState(category, label, disabledState)
    local option = self:GetOptionElement(category, label)
    if option then
        option.disabledState = disabledState
        if self.OptionBody then
            self.OptionBody:Update(category, label)
        end
        return
    end
    error(("Option with label %s does not exist in category %s"):format(label, category))
end
