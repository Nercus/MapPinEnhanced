---@diagnostic disable: no-unknown
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local PinSections = MapPinEnhanced:GetModule("PinSections")
local L = MapPinEnhanced.L

---@class PinProvider
local PinProvider = MapPinEnhanced:GetModule("PinProvider")
local Utils = MapPinEnhanced:GetModule("Utils")
local Events = MapPinEnhanced:GetModule("Events")

function PinProvider:CheckForTomTom()
    self.isTomTomLoaded = C_AddOns.IsAddOnLoaded("TomTom")
    if not self.isTomTomLoaded then
        ---@diagnostic disable-next-line: global-element slash command definition has to be global
        SLASH_MapPinEnhanced3 = "/way"
        return
    end
    Utils:Print(L["TomTom Is Loaded! You may experience some unexpected behavior."])
end

local isHooked = false
--- Hook TomTom's AddWaypoint function to add pins to the map when a use has TomTom installed and adds a waypoint to the map.
local function HookTomTomAddWaypoint()
    if isHooked then return end
    if not TomTom then return end
    if not TomTom.AddWaypoint then return end
    hooksecurefunc(TomTom, "AddWaypoint", function(_, ...)
        local mapID, x, y, info = ...
        if not mapID or not x or not y then return end
        local uncategorizedSection = PinSections:GetSectionByName(L["Uncategorized Pins"])
        if not uncategorizedSection then return end
        uncategorizedSection:AddPin({
            mapID = mapID,
            x = x,
            y = y,
            title = info.title,
            setTracked = true,
        })
    end)
end

Events:RegisterEvent("ADDON_LOADED", function(_, addon)
    if addon == "TomTom" then
        MapPinEnhanced.isTomTomLoaded = true
        HookTomTomAddWaypoint()
    end
end)


Events:RegisterEvent("PLAYER_LOGIN", function()
    PinProvider:CheckForTomTom()
end)
