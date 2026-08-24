---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "content"
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.Content

---@return string
local function GetContentTargetID()
    local trackableType, trackableID = C_SuperTrack.GetSuperTrackedContent()
    return string.format("content:%s:%s", tostring(trackableType), tostring(trackableID))
end

---@param trackableType Enum.ContentTrackingType
---@param trackableID number
---@return string|number? texture
---@return boolean? usesAtlas
local function GetContentIcon(trackableType, trackableID)
    if trackableType == Enum.ContentTrackingType.Appearance and C_TransmogCollection then
        return C_TransmogCollection.GetSourceIcon(trackableID), false
    elseif trackableType == Enum.ContentTrackingType.Mount and C_MountJournal then
        return select(3, C_MountJournal.GetMountInfoByID(trackableID)), false
    elseif trackableType == Enum.ContentTrackingType.Achievement then
        return select(10, GetAchievementInfo(trackableID)), false
    elseif trackableType == Enum.ContentTrackingType.Decor and C_HousingCatalog and Enum.HousingCatalogEntryType then
        local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(Enum.HousingCatalogEntryType.Decor,
            trackableID, false)
        if info then return info.iconAtlas or info.iconTexture, info.iconAtlas ~= nil end
    end
end

---@param _ string
---@param targetID string
---@param changeNumber integer
local function ClearContent(_, targetID, changeNumber)
    if not Providers:ClearSuperTrackingWayfinderData(SOURCE, targetID, changeNumber) then return end
    C_SuperTrack.ClearSuperTrackedContent()
end

---@param trackableType Enum.ContentTrackingType
---@param trackableID number
---@param mapID number
---@return number? x
---@return number? y
---@return string? waypointText
local function GetContentWaypointForMap(trackableType, trackableID, mapID)
    if not C_ContentTracking or not C_ContentTracking.GetNextWaypointForTrackable then return end
    local _, mapInfo = C_ContentTracking.GetNextWaypointForTrackable(trackableType, trackableID, mapID)
    if not mapInfo then return end
    return mapInfo.x, mapInfo.y, mapInfo.waypointText
end

local function RefreshContent()
    local trackableType, trackableID = C_SuperTrack.GetSuperTrackedContent()
    local targetID = GetContentTargetID()
    local hasTrackable = trackableType ~= nil and trackableID ~= nil
    local x, y, mapID = Providers:GetSuperTrackingWaypoint(hasTrackable and function(candidateMapID)
        return GetContentWaypointForMap(trackableType, trackableID, candidateMapID)
    end or nil)
    if hasTrackable and (x == nil or y == nil or mapID == nil) and
        C_ContentTracking and C_ContentTracking.GetBestMapForTrackable then
        local _, bestMapID = C_ContentTracking.GetBestMapForTrackable(trackableType, trackableID)
        if bestMapID then
            x, y = GetContentWaypointForMap(trackableType, trackableID, bestMapID)
            mapID = x ~= nil and y ~= nil and bestMapID or nil
        end
    end
    if trackableType == nil or trackableID == nil or x == nil or y == nil or mapID == nil then
        Providers:HandleUnresolvedSuperTrackingTarget(SOURCE, targetID, L["Content"], {
            hasCoordinates = x ~= nil and y ~= nil,
            trackableID = trackableID,
            trackableType = trackableType,
        })
        return
    end
    local title, description = C_SuperTrack.GetSuperTrackedItemName()
    title = title or description
    if not title and C_ContentTracking then title = C_ContentTracking.GetTitle(trackableType, trackableID) end
    local texture, usesAtlas = GetContentIcon(trackableType, trackableID)
    Providers:SetSuperTrackingWayfinderData(SOURCE, targetID, {
        mapID = mapID, x = x, y = y, title = title, texture = texture, usesAtlas = usesAtlas,
    }, ClearContent)
end

Providers:RegisterSuperTrackingProvider({
    source = SOURCE,
    superTrackingType = SUPER_TRACKING_TYPE,
    getTargetID = GetContentTargetID,
    refresh = RefreshContent,
    events = { "CONTENT_TRACKING_UPDATE", "TRACKABLE_INFO_UPDATE", "TRACKING_TARGET_INFO_UPDATE" },
})
