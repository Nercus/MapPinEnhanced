---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "fallback"

---@return string
local function GetFallbackTargetID()
    local superTrackingType = C_SuperTrack.GetHighestPrioritySuperTrackingType()
    local pinType, pinTypeID = C_SuperTrack.GetSuperTrackedMapPin()
    local contentType, contentID = C_SuperTrack.GetSuperTrackedContent()
    local questID = C_SuperTrack.GetSuperTrackedQuestID()
    local vignetteGUID = C_SuperTrack.GetSuperTrackedVignette()
    return string.format("fallback:%s:%s:%s:%s:%s:%s:%s",
        tostring(superTrackingType), tostring(pinType), tostring(pinTypeID), tostring(contentType),
        tostring(contentID), tostring(questID), tostring(vignetteGUID))
end

local function RefreshFallbackTarget()
    local superTrackingType = C_SuperTrack.GetHighestPrioritySuperTrackingType()
    local pinType, pinTypeID = C_SuperTrack.GetSuperTrackedMapPin()
    local contentType, contentID = C_SuperTrack.GetSuperTrackedContent()
    local questID = C_SuperTrack.GetSuperTrackedQuestID()
    local vignetteGUID = C_SuperTrack.GetSuperTrackedVignette()
    local targetID = GetFallbackTargetID()

    local x, y, mapID = Providers:GetSuperTrackingWaypoint()
    if x == nil or y == nil or mapID == nil then
        Providers:HandleUnresolvedSuperTrackingTarget(SOURCE, targetID, L["Target"], {
            contentID = contentID,
            contentType = contentType,
            hasCoordinates = x ~= nil and y ~= nil,
            mapPinID = pinTypeID,
            mapPinType = pinType,
            questID = questID,
            superTrackingType = superTrackingType,
            vignetteGUID = vignetteGUID,
        })
        return
    end

    local name, description = C_SuperTrack.GetSuperTrackedItemName()
    Providers:SetSuperTrackingWayfinderData(SOURCE, targetID, {
        mapID = mapID,
        x = x,
        y = y,
        title = name or description or L["Target"],
        texture = "Navigation-Tracked-Icon",
        usesAtlas = true,
    })
end

Providers:RegisterSuperTrackingFallback({
    source = SOURCE,
    getTargetID = GetFallbackTargetID,
    refresh = RefreshFallbackTarget,
    events = { "GROUP_ROSTER_UPDATE", "ZONE_CHANGED_NEW_AREA" },
})
