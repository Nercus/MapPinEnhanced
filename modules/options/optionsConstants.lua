---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@alias PinArrivalMode "dynamic"|"static"
---@alias WayfinderSelection "arrow"|"floating"

---@class Options
---@field ARRIVAL_MODE_DYNAMIC PinArrivalMode
---@field ARRIVAL_MODE_STATIC PinArrivalMode
---@field WAYFINDER_SELECTION_ARROW WayfinderSelection
---@field WAYFINDER_SELECTION_FLOATING WayfinderSelection
local Options = MapPinEnhanced:GetModule("Options")

Options.ARRIVAL_MODE_DYNAMIC = "dynamic"
Options.ARRIVAL_MODE_STATIC = "static"
Options.WAYFINDER_SELECTION_ARROW = "arrow"
Options.WAYFINDER_SELECTION_FLOATING = "floating"

Options.SCALE_PRESETS = {
    { label = L["Small (90%)"],    value = 0.9 },
    { label = L["Default (100%)"], value = 1 },
    { label = L["Large (125%)"],   value = 1.25 },
    { label = L["Huge (150%)"],    value = 1.5 },
}

Options.DEFAULTS = {
    ["Miscellaneous.Coords.ShowZone"] = false,
    ["Miscellaneous.Coords.ShowDecimals"] = true,
    ["Pins.Appearance.AlwaysPingTracked"] = false,
    ["Pins.Appearance.MinimapScale"] = 1,
    ["Pins.Appearance.WorldMapScale"] = 1,
    ["Pins.Appearance.DefaultColor"] = "Yellow",
    ["Pins.Appearance.FadeUntracked"] = false,
    ["Pins.Appearance.ShowMinimapPins"] = true,
    ["Pins.Miscellaneous.EnableLockedPins"] = true,
    ["Pins.Tracking.ArrivalNotification"] = "locked",
    ["Pins.Tracking.AutoUntrack"] = false,
    ["Miscellaneous.Tracker.AutoShow"] = true,
    ["Miscellaneous.Tracker.ShowBlizzardEntry"] = true,
    ["Miscellaneous.Tracker.CloseAction"] = false,
    ["Miscellaneous.Tracker.MaximumRows"] = 7,
    ["Miscellaneous.Tracker.BackgroundOpacity"] = 0,
    ["Miscellaneous.Tracker.Scale"] = 1,
    ["General.Minimap.ShowButton"] = true,
    ["General.Minimap.CustomButton"] = true,
    ["General.Distance.ShowUnit"] = true,
    ["General.Tracking.ArrivalMode"] = Options.ARRIVAL_MODE_DYNAMIC,
    ["Pins.Miscellaneous.ScaleOnHover"] = false,
    ["Miscellaneous.Coords.Enable"] = true,
    ["Miscellaneous.Coords.Lock"] = false,
    ["Miscellaneous.Coords.Visibility"] = { noCoordinates = true },
    ["Miscellaneous.Tracker.Visibility"] = { noActivePins = true },
    ["Wayfinder.General.HideBlizzardFloatingDiamond"] = false,
    ["Wayfinder.General.Selection"] = Options.WAYFINDER_SELECTION_ARROW,
    ["Wayfinder.General.ShowETA"] = true,
    ["Wayfinder.Navigation.Enable"] = true,
    ["Wayfinder.Navigation.BackgroundSearch"] = false,
    ["Wayfinder.Navigation.AutomaticTravelSelection"] = false,
    ["Wayfinder.Navigation.WorldMap"] = true,
    ["Wayfinder.Navigation.Minimap"] = true,
    ["Wayfinder.Navigation.TransportationGroups"] = {
        portals = true,
        flightPaths = true,
        scheduledTransport = true,
        npcTravel = true,
        phaseChanges = true,
        personalTeleports = true,
        dungeonTeleports = false,
    },
    ["Wayfinder.Floating.ShowBeam"] = true,
}


-- config for radiogroups, dropdowns
---@type table<string, MapPinEnhancedRadioGroupOption[]>
Options.OPTIONS_CONFIG = {
    ["Pins.Appearance.MinimapScale"] = Options.SCALE_PRESETS,
    ["Pins.Appearance.WorldMapScale"] = Options.SCALE_PRESETS,
    ["Miscellaneous.Tracker.Scale"] = Options.SCALE_PRESETS,
    ["Pins.Appearance.DefaultColor"] = {
        { label = L["Red"],       value = "Red" },
        { label = L["Orange"],    value = "Orange" },
        { label = L["Pale"],      value = "Pale" },
        { label = L["Yellow"],    value = "Yellow" },
        { label = L["Green"],     value = "Green" },
        { label = L["LightBlue"], value = "LightBlue" },
        { label = L["DarkBlue"],  value = "DarkBlue" },
        { label = L["Purple"],    value = "Purple" },
        { label = L["Pink"],      value = "Pink" },
    },
    ["Pins.Tracking.ArrivalNotification"] = {
        { label = L["Only locked pins"], value = "locked" },
        { label = L["All pins"],         value = "all" },
        { label = L["Disabled"],         value = "disabled" },
    },
    ["Wayfinder.Navigation.TransportationGroups"] = {
        { label = L["Navigation Transportation Portals"],             value = "portals" },
        { label = L["Navigation Transportation Flight paths"],        value = "flightPaths" },
        { label = L["Navigation Transportation Scheduled transport"], value = "scheduledTransport" },
        { label = L["Navigation Transportation NPC travel"],          value = "npcTravel" },
        { label = L["Navigation Transportation Phase changes"],       value = "phaseChanges" },
        { label = L["Navigation Transportation Personal teleports"],  value = "personalTeleports" },
        { label = L["Navigation Transportation Dungeon teleports"],   value = "dungeonTeleports" },
    },
    ["General.Tracking.ArrivalMode"] = {
        { label = L["Dynamic"], value = Options.ARRIVAL_MODE_DYNAMIC },
        { label = L["Static"],  value = Options.ARRIVAL_MODE_STATIC },
    },
    ["Wayfinder.General.Selection"] = {
        { label = L["Arrow"],    value = Options.WAYFINDER_SELECTION_ARROW },
        { label = L["Floating"], value = Options.WAYFINDER_SELECTION_FLOATING },
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

-- Options loads before Pins. Fill the swatches from its palette once that owner
-- is ready, retaining the selected color and the normal dropdown change callback.
MapPinEnhanced:OnLoad(function()
    local Pins = MapPinEnhanced:GetModule("Pins")
    local key = "Pins.Appearance.DefaultColor"
    for _, option in ipairs(Options.OPTIONS_CONFIG[key]) do
        option.label = Pins:GetColorMenuLabel(option.value)
    end
    Options.options[key]:Setup(Options:GetOptionValue(key))
end)
