---@class MapPinEnhanced : NercUtilsAddon
local MapPinEnhanced = LibStub("NercUtils"):GetAddon(...)

local version = C_AddOns.GetAddOnMetadata("MapPinEnhanced", "Version")
local numericVersion = tonumber((version:gsub("%.", ""))) or 0
---version number in the format of 100 for 1.0.0 or 302 for 3.0.2
MapPinEnhanced.version = numericVersion
MapPinEnhanced.nameVersionString = MapPinEnhanced.name .. " v" .. version

MapPinEnhanced.isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
MapPinEnhanced.isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC -- Note: Classic is not supported yet

MapPinEnhanced.HBD = LibStub("HereBeDragons-2.0")
MapPinEnhanced.HBDP = LibStub("HereBeDragons-Pins-2.0")
MapPinEnhanced.LDBIcon = LibStub("LibDBIcon-1.0")

MapPinEnhanced:SetSlashTrigger("/mph", 1)
MapPinEnhanced:SetSlashTrigger("/mpe", 2)

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    local isTomTomLoaded = C_AddOns.IsAddOnLoaded("TomTom")

    if not isTomTomLoaded then
        MapPinEnhanced:SetSlashTrigger("/way", 3)
    end
    MapPinEnhanced.isTomTomLoaded = isTomTomLoaded
end)
