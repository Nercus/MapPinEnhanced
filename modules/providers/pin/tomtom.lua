---@diagnostic disable: no-unknown
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Groups = MapPinEnhanced:GetModule("Groups")

---@return MapPinEnhancedGroupMixin
local function EnsureTomTomGroup()
    local group = Groups:GetGroupByName(L["TomTom Pins"])
    if group then return group end

    group = Groups:RegisterGroup({
        name = L["TomTom Pins"],
        source = MapPinEnhanced.name,
        icon = "Interface\\Icons\\INV_Misc_Map_01",
        order = GetTime()
    })
    assert(group, "EnsureTomTomGroup: failed to register the TomTom group")
    return group
end

function Providers:CheckForTomTom()
    self.isTomTomLoaded = C_AddOns.IsAddOnLoaded("TomTom")
    if not self.isTomTomLoaded then
        ---@diagnostic disable-next-line: global-element slash command definition has to be global
        SLASH_MapPinEnhanced2 = "/way"
        return
    end
    EnsureTomTomGroup()
    MapPinEnhanced:Print(L["TomTom Is Loaded! You may experience some unexpected behavior."])
end

local isHooked = false
--- Hook TomTom's AddWaypoint function to add pins to the map when a use has TomTom installed and adds a waypoint to the map.
local function HookTomTomAddWaypoint()
    if isHooked then return end
    if not TomTom then return end
    if not TomTom.AddWaypoint then return end
    local group = EnsureTomTomGroup()
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
    isHooked = true
end

MapPinEnhanced:RegisterEvent("ADDON_LOADED", function(addon)
    if addon == "TomTom" then
        MapPinEnhanced.isTomTomLoaded = true
        EnsureTomTomGroup()
        HookTomTomAddWaypoint()
    end
end)


MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    Providers:CheckForTomTom()
    if Providers.isTomTomLoaded then
        HookTomTomAddWaypoint()
    end
end)
