---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "vignette"
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.Vignette

local function RefreshVignette()
    if C_SuperTrack.GetHighestPrioritySuperTrackingType() ~= SUPER_TRACKING_TYPE then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        return
    end
    local vignetteGUID = C_SuperTrack.GetSuperTrackedVignette()
    local identity = string.format("vignette:%s", tostring(vignetteGUID))
    local vignetteInfo = vignetteGUID and C_VignetteInfo.GetVignetteInfo(vignetteGUID)
    local x, y, mapID = Providers:GetSuperTrackingWaypoint()
    if not vignetteGUID or not vignetteInfo or not x or not y or not mapID then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        Providers:ReportUnresolvedSuperTrackingTarget(identity, L["Vignette"], {
            mapID = mapID,
            vignetteGUID = vignetteGUID,
            vignetteID = vignetteInfo and vignetteInfo.vignetteID,
        })
        return
    end
    Providers:SetSuperTrackingWayfinderData(SOURCE, identity, {
        mapID = mapID,
        x = x,
        y = y,
        title = vignetteInfo.name,
        texture = vignetteInfo.atlasName,
        usesAtlas = true,
    })
end

Providers:RegisterSuperTrackingProvider(SOURCE, SUPER_TRACKING_TYPE)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", RefreshVignette)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_PATH_UPDATED", RefreshVignette)
MapPinEnhanced:RegisterEvent("VIGNETTES_UPDATED", RefreshVignette)
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", RefreshVignette)
