---@diagnostic disable: no-unknown
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local PinManager = MapPinEnhanced:GetModule("PinManager")

---------------------------------------------------------------------------

local isHooked = false
--- Hook TomTom's AddWaypoint function to add pins to the map when a use has TomTom installed and adds a waypoint to the map.
local function HookTomTomAddWaypoint()
    if isHooked then return end
    if not MapPinEnhanced.isTomTomLoaded then return end -- only hook if TomTom is loaded
    if not TomTom then return end
    if not TomTom.AddWaypoint then return end
    hooksecurefunc(TomTom, "AddWaypoint", function(_, ...)
        local mapID, x, y, info = ...
        if not info then
            info = {}
            info.title = "TomTom Waypoint"
        end
        if not mapID or not x or not y then return end
        PinManager:AddPin({
            mapID = mapID,
            x = x,
            y = y,
            title = info.title,
            setTracked = true,
        })
    end)
end

MapPinEnhanced:RegisterEvent("ADDON_LOADED", function(_, addonName)
    if addonName == "TomTom" then
        HookTomTomAddWaypoint()
    end
end)

local function AddTomTomShim()
    if TomTom then return end
    if MapPinEnhanced.isTomTomLoaded then return end -- only shim if TomTom is not loaded
    local TomTom = {}
    TomTom.AddWaypoint = function(_, ...)
        local mapID, x, y, info = ...
        if not info then
            info = {}
            info.title = "TomTom Waypoint"
        end
        if not mapID or not x or not y then return end
        PinManager:AddPin({
            mapID = mapID,
            x = x,
            y = y,
            title = info.title,
            setTracked = true,
        })
    end
    _G.TomTom = TomTom
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", AddTomTomShim)
