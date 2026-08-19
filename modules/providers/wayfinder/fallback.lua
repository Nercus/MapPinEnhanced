---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")

local function RefreshUnsupportedTarget()
    local superTrackingType = C_SuperTrack.GetHighestPrioritySuperTrackingType()
    if superTrackingType == Enum.SuperTrackingType.UserWaypoint then
        Providers:ClearActiveSuperTrackingWayfinderData()
        return
    end
    if superTrackingType and Providers.superTrackingProviderTypes[superTrackingType] then return end

    Providers:ClearActiveSuperTrackingWayfinderData()
    if not superTrackingType then return end

    local pinType, pinTypeID = C_SuperTrack.GetSuperTrackedMapPin()
    local contentType, contentID = C_SuperTrack.GetSuperTrackedContent()
    local questID = C_SuperTrack.GetSuperTrackedQuestID()
    local vignetteGUID = C_SuperTrack.GetSuperTrackedVignette()
    local identity = string.format("unsupported:%s:%s:%s:%s:%s:%s:%s",
        tostring(superTrackingType), tostring(pinType), tostring(pinTypeID), tostring(contentType),
        tostring(contentID), tostring(questID), tostring(vignetteGUID))
    Providers:ReportUnsupportedSuperTrackingTarget(identity, {
        contentID = contentID,
        contentType = contentType,
        mapPinID = pinTypeID,
        mapPinType = pinType,
        questID = questID,
        superTrackingType = superTrackingType,
        vignetteGUID = vignetteGUID,
    })
end

MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", RefreshUnsupportedTarget)
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", RefreshUnsupportedTarget)
