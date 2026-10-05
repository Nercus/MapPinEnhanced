---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Options = MapPinEnhanced:GetModule("Options")

-- Run after constants and released-save intake, before defaults and XML controls.
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

-- Preserve a button hidden before visibility became an option. The new preference wins thereafter.
local minimapVisibilityKey = "General.Minimap.ShowButton"
if type(MapPinEnhanced:GetVar("options", minimapVisibilityKey)) ~= "boolean" then
    MapPinEnhanced:SetVar("options", minimapVisibilityKey,
        MapPinEnhanced:GetVar("minimapButton", "hide") ~= true)
end

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
