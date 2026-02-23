---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Options
local Options = MapPinEnhanced:GetModule("Options")


Options.DEFAULTS = {
    ["test.slider"] = 75,
    ["test.radiogroup"] = "option2",
    ["test.toggle"] = false,
    ["test.input"] = "Default text",
    ["test.colorpicker"] = { r = 1, g = 0, b = 0, a = 1 },
    ["test.checkbox"] = true,
    ["test.checkbox2"] = true,
    ["test.checkbox3"] = false,
    ["test.checkbox4"] = true,
    ["test.checkbox5"] = true,
}


-- config for radiogroups, dropdowns
---@type table<string, MapPinEnhancedRadioGroupOption[]>
Options.OPTIONS_CONFIG = {
    ["test.radiogroup"] = {
        { label = "Option 1", value = "option1" },
        { label = "Option 2", value = "option2" },
        { label = "Option 3", value = "option3" },
    },
}
