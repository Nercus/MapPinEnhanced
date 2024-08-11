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
    if optionType ~= "button" then
        assert(option.default, "Option must have a default value")
    end
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
    if not optionTyped.init then
        optionTyped.init = optionTyped.default
    end
    table.insert(self.options[option.category], option)
end

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

-- C_Timer.After(1, function()
--     Options:RegisterSlider({
--         category = "Floating Pin",
--         label = "Size",
--         description = "Testing the slider",
--         descriptionImage = "interface/icons/achievement_boss_lichking",
--         default = MapPinEnhanced:GetDefault("Floating Pin", "Size") --[[@as number]],
--         init = MapPinEnhanced:GetVar("Floating Pin", "Size") --[[@as number]],
--         onChange = function(value)
--             print("Slider changed", value)
--             MapPinEnhanced:SaveVar("Floating Pin", "Size", value)
--         end,
--         min = 0,
--         max = 100,
--         step = 1
--     })


--     Options:RegisterCheckbox({
--         category = "General",
--         label = "Testcheckbox",
--         description = "Testing the checkbox",
--         descriptionImage = "Interface/AddOns/MapPinEnhanced/assets/maskedDescriptionImageTest.png",
--         default = true,
--         init = true,
--         onChange = function(value)
--             print("Checkbox changed", value)
--         end
--     })

--     Options:RegisterColorpicker({
--         category = "General",
--         label = "Testcolorpicker",
--         description = "Testing the colorpicker",
--         descriptionImage = "interface/talentframe/talentsclassbackgroundwarrior2",
--         default = { r = 1, g = 0, b = 1, a = 1 },
--         init = { r = 1, g = 1, b = 0, a = 1 },
--         onChange = function(value)
--             print("Colorpicker changed", value.r, value.g, value.b, value.a)
--         end
--     })

--     Options:RegisterInput({
--         category = "General",
--         label = "Testinput",
--         description = "Testing the input",
--         descriptionImage = "interface/dressupframe/dressingroommonk",
--         default = "Test",
--         init = "Test",
--         onChange = function(value)
--             print("Input changed", value)
--         end
--     })


--     Options:RegisterSelect({
--         category = "General",
--         label = "Testselect",
--         description = "Testing the select",
--         descriptionImage = "interface/icons/achievement_boss_lichking",
--         default = "OptionValue 1",
--         init = "OptionValue 1",
--         onChange = function(value)
--             print("Select changed", value)
--         end,
--         options = {
--             {
--                 label = "Option 1",
--                 value = "OptionValue 1",
--                 type = "radio"
--             },
--             {
--                 label = "Option 2",
--                 value = "OptionValue 2",
--                 type = "radio"
--             },
--             {
--                 label = "Option 3",
--                 value = "OptionValue 3",
--                 type = "radio"
--             }
--         }
--     })


--     Options:RegisterSlider({
--         category = "General",
--         label = "Testslider",
--         description = "Testing the slider",
--         descriptionImage = "interface/icons/achievement_boss_lichking",
--         default = 50,
--         init = 50,
--         onChange = function(value)
--             print("Slider changed", value)
--         end,
--         min = 0,
--         max = 100,
--         step = 1
--     })
--     Options:RegisterButton({
--         category = "General",
--         label = "Testbutton",
--         description = "Press this button to print the number",
--         buttonLabel = "Press me",
--         onChange = function()
--             print("Button pressed")
--         end
--     })
--     -- MapPinEnhanced:ToggleEditorWindow()
--     -- MapPinEnhanced.editorWindow:SetActiveView("optionView")
-- end)
