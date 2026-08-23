---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@alias PinArrivalMode "dynamic"|"static"

---@class Options
---@field ARRIVAL_MODE_DYNAMIC PinArrivalMode
---@field ARRIVAL_MODE_STATIC PinArrivalMode
local Options = MapPinEnhanced:GetModule("Options")

Options.TRACKING_MODE_NEAREST = "nearest"
Options.TRACKING_MODE_ORDERED = "ordered"
Options.ARRIVAL_MODE_DYNAMIC = "dynamic"
Options.ARRIVAL_MODE_STATIC = "static"

Options.TRACKING_MODE_OPTIONS = {
    { label = L["Track by Distance"], value = Options.TRACKING_MODE_NEAREST },
    { label = L["Track by Order"],    value = Options.TRACKING_MODE_ORDERED },
}

Options.DEFAULTS = {
    ["General.Distance.ShowUnit"] = true,
    ["General.Tracking.DefaultMode"] = Options.TRACKING_MODE_NEAREST --[[@as GroupTrackingMode]],
    ["General.Tracking.ArrivalMode"] = Options.ARRIVAL_MODE_DYNAMIC,
    ["Pins.Miscellaneous.ScaleOnHover"] = false,
    ["Miscellaneous.Coords.Enable"] = true,
    ["Miscellaneous.Coords.Lock"] = false,
    ["Miscellaneous.Coords.Visibility"] = {},
    ["Miscellaneous.Tracker.Visibility"] = {},
    ["Wayfinder.General.HideBlizzardFloatingDiamond"] = false,
    ["Wayfinder.Floating.Enable"] = false,
    ["Wayfinder.Floating.Style"] = "modern",
    ["Wayfinder.Arrow.Enable"] = true,
    ["Wayfinder.Arrow.RotatePin"] = false,
}


-- config for radiogroups, dropdowns
---@type table<string, MapPinEnhancedRadioGroupOption[]>
Options.OPTIONS_CONFIG = {
    ["General.Tracking.DefaultMode"] = Options.TRACKING_MODE_OPTIONS,
    ["General.Tracking.ArrivalMode"] = {
        { label = L["Dynamic"], value = Options.ARRIVAL_MODE_DYNAMIC },
        { label = L["Static"],  value = Options.ARRIVAL_MODE_STATIC },
    },
    ["Wayfinder.Floating.Style"] = {
        { label = L["Enhanced"], value = "modern" },
        { label = L["Basic"],    value = "simple" },
    },
    ["Miscellaneous.Coords.Visibility"] = {
        { label = L["Dungeon"],                  value = "dungeon" },
        { label = L["Raid"],                     value = "raid" },
        { label = L["Scenario"],                 value = "scenario" },
        { label = L["Battleground"],             value = "battleground" },
        { label = L["Arena"],                    value = "arena" },
        { label = L["No coordinates available"], value = "noCoordinates" },
    },
    ["Miscellaneous.Tracker.Visibility"] = {
        { label = L["Dungeon"],        value = "dungeon" },
        { label = L["Raid"],           value = "raid" },
        { label = L["Scenario"],       value = "scenario" },
        { label = L["Battleground"],   value = "battleground" },
        { label = L["Arena"],          value = "arena" },
        { label = L["No active pins"], value = "noActivePins" },
    },
}
