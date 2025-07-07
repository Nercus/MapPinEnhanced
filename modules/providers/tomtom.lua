---@diagnostic disable: no-unknown
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Groups = MapPinEnhanced:GetModule("Groups")

function Providers:CheckForTomTom()
    self.isTomTomLoaded = C_AddOns.IsAddOnLoaded("TomTom")
    if not self.isTomTomLoaded then
        ---@diagnostic disable-next-line: global-element slash command definition has to be global
        SLASH_MapPinEnhanced3 = "/way"
        return
    end
    MapPinEnhanced:Print(L["TomTom Is Loaded! You may experience some unexpected behavior."])
end

local isHooked = false
--- Hook TomTom's AddWaypoint function to add pins to the map when a use has TomTom installed and adds a waypoint to the map.
local function HookTomTomAddWaypoint()
    if isHooked then return end
    if not TomTom then return end
    if not TomTom.AddWaypoint then return end
    local group = Groups:GetGroupByName(L["TomTom Pins"])
    assert(group, "TomTom group not found. Register the TomTom group before hooking.")
    hooksecurefunc(TomTom, "AddWaypoint", function(_, ...)
        local mapID, x, y, info = ...
        ---@cast info TomTomWaypointOptions
        if not mapID or not x or not y then return end
        group:AddPin({
            mapID = mapID,
            x = x,
            y = y,
            title = info.title or L["TomTom Waypoint"],
            texture = info.minimap_icon or "Interface\\Icons\\INV_Misc_Map_01",
        })
    end)
end

MapPinEnhanced:RegisterEvent("ADDON_LOADED", function(_, addon)
    if addon == "TomTom" then
        MapPinEnhanced.isTomTomLoaded = true
        Groups:RegisterPinGroup({
            name = L["TomTom Pins"],
            source = MapPinEnhanced.name,
            icon = "Interface\\Icons\\INV_Misc_Map_01",
        })
        HookTomTomAddWaypoint()
    end
end)


MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    Providers:CheckForTomTom()
end)
