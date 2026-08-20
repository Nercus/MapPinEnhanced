---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "vignette"
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.Vignette

---@param vignetteGUID WOWGUID
---@param mapID number
---@return number? x
---@return number? y
local function GetVignettePositionForMap(vignetteGUID, mapID)
    local position = C_VignetteInfo.GetVignettePosition(vignetteGUID, mapID)
    if not position then return end
    return position.x, position.y
end

local function RefreshVignette()
    if C_SuperTrack.GetHighestPrioritySuperTrackingType() ~= SUPER_TRACKING_TYPE then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        return
    end
    local vignetteGUID = C_SuperTrack.GetSuperTrackedVignette()
    local identity = string.format("vignette:%s", tostring(vignetteGUID))
    local vignetteInfo = vignetteGUID and C_VignetteInfo.GetVignetteInfo(vignetteGUID)
    local x, y, mapID = Providers:GetSuperTrackingWaypoint(vignetteGUID and function(candidateMapID)
        return GetVignettePositionForMap(vignetteGUID, candidateMapID)
    end or nil)
    if not vignetteGUID or not vignetteInfo or x == nil or y == nil or mapID == nil then
        Providers:HandleUnresolvedSuperTrackingTarget(SOURCE, identity, L["Vignette"], {
            hasCoordinates = x ~= nil and y ~= nil,
            hasVignetteInfo = vignetteInfo ~= nil,
            vignetteGUID = vignetteGUID,
            vignetteID = vignetteInfo and vignetteInfo.vignetteID,
        }, RefreshVignette)
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
