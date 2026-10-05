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

local WAYFINDER_SELECTION_OPTION = "Wayfinder.General.Selection"
local LEGACY_FLOATING_ENABLE_OPTION = "Wayfinder.Floating.Enable"
local LEGACY_ARROW_ENABLE_OPTION = "Wayfinder.Arrow.Enable"

local savedWayfinderSelection = MapPinEnhanced:GetVar("options", WAYFINDER_SELECTION_OPTION)
if savedWayfinderSelection ~= Options.WAYFINDER_SELECTION_ARROW and
    savedWayfinderSelection ~= Options.WAYFINDER_SELECTION_FLOATING then
    local floatingEnabled = MapPinEnhanced:GetVar("options", LEGACY_FLOATING_ENABLE_OPTION)
    local arrowEnabled = MapPinEnhanced:GetVar("options", LEGACY_ARROW_ENABLE_OPTION)
    if floatingEnabled ~= nil or arrowEnabled ~= nil then
        local selection = floatingEnabled == true and Options.WAYFINDER_SELECTION_FLOATING or
            Options.WAYFINDER_SELECTION_ARROW
        MapPinEnhanced:SetVar("options", WAYFINDER_SELECTION_OPTION, selection)
        MapPinEnhanced:DeleteVar("options", LEGACY_FLOATING_ENABLE_OPTION)
        MapPinEnhanced:DeleteVar("options", LEGACY_ARROW_ENABLE_OPTION)
    elseif savedWayfinderSelection ~= nil then
        MapPinEnhanced:DeleteVar("options", WAYFINDER_SELECTION_OPTION)
    end
end

-- Tracking mode belongs to each group; the retired global default no longer applies.
MapPinEnhanced:DeleteVar("options", "General.Tracking.DefaultMode")

Options.SCALE_PRESETS = {
    { label = L["Small (90%)"],    value = 0.9 },
    { label = L["Default (100%)"], value = 1 },
    { label = L["Large (125%)"],   value = 1.25 },
    { label = L["Huge (150%)"],    value = 1.5 },
}

-- Move retired Tiny selections to the smallest available preset before controls load.
for _, key in ipairs({ "Pins.Appearance.MinimapScale", "Pins.Appearance.WorldMapScale", "Miscellaneous.Tracker.Scale" }) do
    if MapPinEnhanced:GetVar("options", key) == 0.75 then
        MapPinEnhanced:SetVar("options", key, 0.9)
    end
end

-- The option becomes authoritative after importing the old frame scale once.
local trackerScaleKey = "Miscellaneous.Tracker.Scale"
local savedScale = MapPinEnhanced:GetVar("options", trackerScaleKey)
local validScale = false
for _, preset in ipairs(Options.SCALE_PRESETS) do
    if savedScale == preset.value then validScale = true end
end
if not validScale then
    local oldScale = MapPinEnhanced:GetVar("frames", "tracker", "scale")
    if not MapPinEnhanced:IsReadableNumber(oldScale) or oldScale ~= oldScale then oldScale = 1 end
    local nearest = Options.SCALE_PRESETS[1].value
    for _, preset in ipairs(Options.SCALE_PRESETS) do
        if math.abs(preset.value - oldScale) < math.abs(nearest - oldScale) - 0.000001 then
            nearest = preset.value
        end
    end
    MapPinEnhanced:SetVar("options", trackerScaleKey, nearest)
end

-- Retain the saved Close/Minimize choice when replacing the radio group with a checkbox.
local trackerCloseActionKey = "Miscellaneous.Tracker.CloseAction"
local savedCloseAction = MapPinEnhanced:GetVar("options", trackerCloseActionKey)
if type(savedCloseAction) ~= "boolean" then
    MapPinEnhanced:SetVar("options", trackerCloseActionKey, savedCloseAction == "minimize")
end

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


-- Preserve a button hidden before visibility became an option. The new preference wins thereafter.
local minimapVisibilityKey = "General.Minimap.ShowButton"
if type(MapPinEnhanced:GetVar("options", minimapVisibilityKey)) ~= "boolean" then
    MapPinEnhanced:SetVar("options", minimapVisibilityKey,
        MapPinEnhanced:GetVar("minimapButton", "hide") ~= true)
end

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

-- Normalize the replaced preferences before XML registers their controls. New
-- values win on every later login, including false and an empty selection.
local beamKey = "Wayfinder.Floating.ShowBeam"
if type(MapPinEnhanced:GetVar("options", beamKey)) ~= "boolean" then
    MapPinEnhanced:SetVar("options", beamKey,
        MapPinEnhanced:GetVar("options", "Wayfinder.Floating.Style") ~= "simple")
end
MapPinEnhanced:DeleteVar("options", "Wayfinder.Floating.Style")

local etaKey = "Wayfinder.General.ShowETA"
if type(MapPinEnhanced:GetVar("options", etaKey)) ~= "boolean" then
    MapPinEnhanced:SetVar("options", etaKey,
        MapPinEnhanced:GetVar("options", "Wayfinder.General.ReadoutMode") ~= "distance")
end
MapPinEnhanced:DeleteVar("options", "Wayfinder.General.ReadoutMode")

local groupKey = "Wayfinder.Navigation.TransportationGroups"
-- Retain removed method names here only to preserve legacy saved preferences.
local oldGroupMembers = {
    portals = { "portal" },
    flightPaths = { "flighttaxi" },
    scheduledTransport = { "ship", "zeppelin", "tram", "transport" },
    npcTravel = { "gossip" },
    phaseChanges = { "phaseswitch" },
    personalTeleports = { "spell", "item", "toy", "dhearth", "unboundteleport" },
    dungeonTeleports = { "dungeonteleport" },
}
---@param value any
---@return table<string, boolean>?
local function CopyTransportationGroups(value)
    if type(value) ~= "table" then return nil end
    local copy = {} ---@type table<string, boolean>
    for group in pairs(oldGroupMembers) do
        if value[group] ~= nil and type(value[group]) ~= "boolean" then return nil end
        copy[group] = value[group] == true
    end
    return copy
end

local savedGroups = CopyTransportationGroups(MapPinEnhanced:GetVar("options", groupKey))
local oldMethods = MapPinEnhanced:GetVar("options", "Wayfinder.Navigation.TransportationMethods")
local groups = {} ---@type table<string, boolean>
for group, members in pairs(oldGroupMembers) do
    if savedGroups then
        groups[group] = savedGroups[group] == true
    elseif type(oldMethods) == "table" then
        -- A merged preference must not silently re-enable an excluded method.
        local enabled = true
        for _, member in ipairs(members) do
            if oldMethods[member] ~= true then enabled = false end
        end
        groups[group] = enabled
    else
        groups[group] = Options.DEFAULTS[groupKey][group]
    end
end
MapPinEnhanced:SetVar("options", groupKey, groups)
MapPinEnhanced:DeleteVar("options", "Wayfinder.Navigation.TransportationMethods")

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
