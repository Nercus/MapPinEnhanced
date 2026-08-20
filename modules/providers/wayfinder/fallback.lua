---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "fallback"

local function RefreshFallbackTarget()
    local superTrackingType = C_SuperTrack.GetHighestPrioritySuperTrackingType()
    if superTrackingType == Enum.SuperTrackingType.UserWaypoint then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        return
    end
    if superTrackingType and Providers.superTrackingProviderTypes[superTrackingType] then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        return
    end

    if superTrackingType == nil then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        return
    end

    local pinType, pinTypeID = C_SuperTrack.GetSuperTrackedMapPin()
    local contentType, contentID = C_SuperTrack.GetSuperTrackedContent()
    local questID = C_SuperTrack.GetSuperTrackedQuestID()
    local vignetteGUID = C_SuperTrack.GetSuperTrackedVignette()
    local identity = string.format("fallback:%s:%s:%s:%s:%s:%s:%s",
        tostring(superTrackingType), tostring(pinType), tostring(pinTypeID), tostring(contentType),
        tostring(contentID), tostring(questID), tostring(vignetteGUID))

    local x, y, mapID = Providers:GetSuperTrackingWaypoint()
    if x == nil or y == nil or mapID == nil then
        Providers:HandleUnresolvedSuperTrackingTarget(SOURCE, identity, L["Target"], {
            contentID = contentID,
            contentType = contentType,
            hasCoordinates = x ~= nil and y ~= nil,
            mapPinID = pinTypeID,
            mapPinType = pinType,
            questID = questID,
            superTrackingType = superTrackingType,
            vignetteGUID = vignetteGUID,
        }, RefreshFallbackTarget)
        return
    end

    local name, description = C_SuperTrack.GetSuperTrackedItemName()
    Providers:SetSuperTrackingWayfinderData(SOURCE, identity, {
        mapID = mapID,
        x = x,
        y = y,
        title = name or description or L["Target"],
        texture = "Navigation-Tracked-Icon",
        usesAtlas = true,
    })
end

MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", RefreshFallbackTarget)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_PATH_UPDATED", RefreshFallbackTarget)
MapPinEnhanced:RegisterEvent("GROUP_ROSTER_UPDATE", RefreshFallbackTarget)
MapPinEnhanced:RegisterEvent("ZONE_CHANGED_NEW_AREA", RefreshFallbackTarget)
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", RefreshFallbackTarget)
