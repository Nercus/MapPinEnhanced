---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@alias WayfinderSelection "arrow"|"floating"

---@class Options
---@field WAYFINDER_SELECTION_ARROW WayfinderSelection
---@field WAYFINDER_SELECTION_FLOATING WayfinderSelection
local Options = MapPinEnhanced:GetModule("Options")

Options.WAYFINDER_SELECTION_ARROW = "arrow"
Options.WAYFINDER_SELECTION_FLOATING = "floating"

Options.SCALE_PRESETS = {
    { label = L["Small (90%)"],    value = 0.9 },
    { label = L["Default (100%)"], value = 1 },
    { label = L["Large (125%)"],   value = 1.25 },
    { label = L["Huge (150%)"],    value = 1.5 },
}

---@type MapPinEnhancedMultiselectValue
local lexiconDataTypes = {}

Options.DEFAULTS = {
    ["General.TooltipHelper"] = true,
    ["General.Lexicon.Enable"] = true,
    ["General.Lexicon.DataTypes"] = lexiconDataTypes,
    ["General.FlightTimer.Enable"] = true,
    ["General.FlightTimer.Lock"] = false,
    ["General.FlightTimer.Scale"] = 1,
    ["General.FlightTimer.Gradient"] = {
        startColor = { r = 0.55, g = 0.40, b = 0.02, a = 1 },
        endColor = { r = 0.28, g = 0.20, b = 0.01, a = 1 },
    },
    ["Miscellaneous.Coords.ShowZone"] = false,
    ["Miscellaneous.Coords.ShowDecimals"] = true,
    ["Pins.Appearance.AlwaysPingTracked"] = false,
    ["Pins.Appearance.MinimapScale"] = 1,
    ["Pins.Appearance.WorldMapScale"] = 1,
    ["Pins.Appearance.DefaultColor"] = "Yellow",
    ["Pins.Appearance.FadeUntracked"] = false,
    ["Pins.Appearance.ShowMinimapPins"] = true,
    ["Pins.Miscellaneous.EnableLockedPins"] = false,
    ["Pins.Tracking.ArrivalNotification"] = "disabled",
    ["Pins.Tracking.AutoUntrack"] = false,
    ["Pins.Integrations.TomTom"] = C_AddOns.IsAddOnLoaded("TomTom") and true or false,
    ["Miscellaneous.Tracker.AutoShow"] = true,
    ["Miscellaneous.Tracker.CloseAction"] = false,
    ["Miscellaneous.Tracker.ShowCoordinates"] = true,
    ["Miscellaneous.Tracker.MaximumRows"] = 7,
    ["Miscellaneous.Tracker.BackgroundOpacity"] = 0,
    ["Miscellaneous.Tracker.Scale"] = 1,
    ["General.Minimap.ShowButton"] = true,
    ["General.Minimap.CustomButton"] = false,
    ["General.Distance.ShowUnit"] = false,
    ["Pins.Miscellaneous.ScaleOnHover"] = false,
    ["Miscellaneous.Coords.Enable"] = false,
    ["Miscellaneous.Coords.Lock"] = false,
    ["Miscellaneous.Coords.Visibility"] = { noCoordinates = true },
    ["Miscellaneous.Tracker.Visibility"] = { noActivePins = true },
    ["Wayfinder.General.HideBlizzardFloatingDiamond"] = true,
    ["Wayfinder.General.Selection"] = Options.WAYFINDER_SELECTION_FLOATING,
    ["Wayfinder.General.ShowETA"] = true,
    ["Wayfinder.General.ShowObjectiveFrame"] = true,
    ["Wayfinder.Navigation.Enable"] = true,
    ["Wayfinder.Navigation.AutomaticTravelSelection"] = true,
    ["Wayfinder.Navigation.RestoreEquipment"] = true,
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
    ["Wayfinder.Floating.ScaleWithDistance"] = false,
    ["Wayfinder.Floating.ShowBeam"] = true,
    ["Wayfinder.Floating.ShowTextOutline"] = false,
}


-- config for radiogroups, dropdowns
---@type table<string, MapPinEnhancedRadioGroupOption[]>
Options.OPTIONS_CONFIG = {
    ["General.Lexicon.DataTypes"] = {
        { label = L["Point of interest"],          value = "poi" },
        { label = L["City"],                       value = "city" },
        { label = L["Town"],                       value = "town" },
        { label = L["Dungeon"],                    value = "dungeon" },
        { label = L["Raid"],                       value = "raid" },
        { label = L["Delve"],                      value = "delve" },
        { label = L["Vault"],                      value = "great-vault" },
        { label = L["Raid Finder"],                value = "lfr-npc" },
        { label = L["Auction House"],              value = "auctioneer" },
        { label = L["Bank"],                       value = "banker" },
        { label = L["Inn"],                        value = "innkeeper" },
        { label = L["Mailbox"],                    value = "mailbox" },
        { label = L["Stable Master"],              value = "stable" },
        { label = L["Trainer"],                    value = "trainer" },
        { label = L["Class Trainer"],              value = "class" },
        { label = L["Profession Trainer"],         value = "profession" },
        { label = L["Vendor"],                     value = "vendor" },
        { label = L["Repair"],                     value = "vendor-repair" },
        { label = L["Ammunition Vendor"],          value = "vendor-ammo" },
        { label = L["Armor Vendor"],               value = "vendor-armor" },
        { label = L["Bag Vendor"],                 value = "vendor-bags" },
        { label = L["Fishing Vendor"],             value = "vendor-fishing" },
        { label = L["Food Vendor"],                value = "vendor-food" },
        { label = L["General Goods Vendor"],       value = "vendor-general" },
        { label = L["Poison Vendor"],              value = "vendor-poisons" },
        { label = L["Profession Supplies Vendor"], value = "vendor-profsupplies" },
        { label = L["Reagent Vendor"],             value = "vendor-reagents" },
        { label = L["Trade Goods Vendor"],         value = "vendor-trade" },
        { label = L["Weapon Vendor"],              value = "vendor-weapons" },
    },
    ["General.FlightTimer.Scale"] = Options.SCALE_PRESETS,
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

for _, option in ipairs(Options.OPTIONS_CONFIG["General.Lexicon.DataTypes"]) do
    lexiconDataTypes[option.value] = true
end

---@param key string
---@param available table<string, boolean>
local function FilterAvailableOptions(key, available)
    local options = {} ---@type MapPinEnhancedRadioGroupOption[]
    for _, option in ipairs(Options.OPTIONS_CONFIG[key]) do
        if available[option.value] then options[#options + 1] = option end
    end
    Options.OPTIONS_CONFIG[key] = options
    Options.options[key]:Setup(Options:GetOptionValue(key))
end

-- Options loads before feature data and palettes. Refresh menus once their owners
-- are ready, retaining selected values and the normal change callbacks.
MapPinEnhanced:OnLoad(function()
    -- Flavor catalogs are registered by now. Filter choices without changing
    -- saved selections or hiding methods that are only temporarily unusable.
    local Navigation = MapPinEnhanced:GetModule("Navigation")
    local Providers = MapPinEnhanced:GetModule("Providers")
    FilterAvailableOptions("Wayfinder.Navigation.TransportationGroups", Navigation:GetAvailableTransportationGroups())
    FilterAvailableOptions("General.Lexicon.DataTypes", Providers:GetAvailableLocationTypes())

    local Pins = MapPinEnhanced:GetModule("Pins")
    local key = "Pins.Appearance.DefaultColor"
    for _, option in ipairs(Options.OPTIONS_CONFIG[key]) do
        option.label = Pins:GetColorMenuLabel(option.value)
    end
    Options.options[key]:Setup(Options:GetOptionValue(key))
end)
