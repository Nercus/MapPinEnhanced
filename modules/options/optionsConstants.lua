---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class Options
local Options = MapPinEnhanced:GetModule("Options")


Options.DEFAULTS = {
    ["Miscellaneous.Coords.Enable"] = true,
    ["Miscellaneous.Coords.Lock"] = false,
    ["Wayfinder.Floating.Enable"] = false,
    ["Wayfinder.Floating.Style"] = "modern" --[[@as WayfinderFloatingFrameType]],
    ["Wayfinder.Arrow.Enable"] = true,
}


-- config for radiogroups, dropdowns
---@type table<string, MapPinEnhancedRadioGroupOption[]>
Options.OPTIONS_CONFIG = {
    ["Wayfinder.Floating.Style"] = {
        { label = L["Modern"], value = "modern" },
        { label = L["Simple"], value = "simple" },
    },
}
