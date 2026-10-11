---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

-- Keys are addon folder names, not localized titles.
---@type table<string, string>
local conflictingAddons = {
    WaypointUI = "Waypoint UI",
}

local hasEnteredWorld = false
local warningShown = false

local function ShowAddonConflicts()
    if not hasEnteredWorld or warningShown then return end

    local loaded = {} ---@type string[]
    for addonName, title in pairs(conflictingAddons) do
        if C_AddOns.IsAddOnLoaded(addonName) then
            loaded[#loaded + 1] = title
        end
    end
    if #loaded == 0 then return end
    table.sort(loaded)
    warningShown = MapPinEnhanced:ShowAddonConflictsDialog(loaded) ~= nil
end

-- Wait for the world so normal addons finish loading; also cover load-on-demand addons.
MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    hasEnteredWorld = true
    ShowAddonConflicts()
end)

MapPinEnhanced:RegisterEvent("ADDON_LOADED", function(addonName)
    if conflictingAddons[addonName] then
        ShowAddonConflicts()
    end
end)
