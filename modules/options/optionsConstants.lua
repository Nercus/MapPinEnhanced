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

Options.TRACKING_MODE_NEAREST = "nearest"
Options.TRACKING_MODE_ORDERED = "ordered"
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

Options.TRACKING_MODE_OPTIONS = {
    { label = MapPinEnhanced:Iconize("arrowleftright", L["Track by Distance"]), value = Options.TRACKING_MODE_NEAREST },
    { label = MapPinEnhanced:Iconize("list", L["Track by Order"]),              value = Options.TRACKING_MODE_ORDERED },
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
    ["Wayfinder.General.Selection"] = Options.WAYFINDER_SELECTION_ARROW,
    ["Wayfinder.General.ShowETA"] = true,
    ["Wayfinder.Navigation.Enable"] = true,
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
    ["Wayfinder.Arrow.RotatePin"] = false,
}


-- config for radiogroups, dropdowns
---@type table<string, MapPinEnhancedRadioGroupOption[]>
Options.OPTIONS_CONFIG = {
    ["Wayfinder.Navigation.TransportationGroups"] = {
        { label = L["Navigation Transportation Portals"],             value = "portals" },
        { label = L["Navigation Transportation Flight paths"],        value = "flightPaths" },
        { label = L["Navigation Transportation Scheduled transport"], value = "scheduledTransport" },
        { label = L["Navigation Transportation NPC travel"],          value = "npcTravel" },
        { label = L["Navigation Transportation Phase changes"],       value = "phaseChanges" },
        { label = L["Navigation Transportation Personal teleports"],  value = "personalTeleports" },
        { label = L["Navigation Transportation Dungeon teleports"],   value = "dungeonTeleports" },
    },
    ["General.Tracking.DefaultMode"] = Options.TRACKING_MODE_OPTIONS,
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
