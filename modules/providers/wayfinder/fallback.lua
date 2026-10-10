---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

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

---@return WayfinderData?
---@return boolean? removable
---@return boolean? textAvailable
local function ReadFallbackTarget()
    local x, y, mapID = Providers:GetSuperTrackingWaypoint()
    if x == nil or y == nil or mapID == nil then
        return
    end

    local name, description = C_SuperTrack.GetSuperTrackedItemName()
    return {
        mapID = mapID,
        x = x,
        y = y,
        title = name or description or L["Target"],
        description = description,
        texture = "Navigation-Tracked-Icon",
        usesAtlas = true,
    }
end

Wayfinders:RegisterSuperTrackingFallback({
    source = SOURCE,
    getTargetID = GetFallbackTargetID,
    read = ReadFallbackTarget,
    events = { "GROUP_ROSTER_UPDATE", "ZONE_CHANGED_NEW_AREA" },
})
