---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "content"
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.Content

---@type table<Enum.ContentTrackingType, boolean>
local supportedContentTypes = {
    [Enum.ContentTrackingType.Appearance] = true,
    [Enum.ContentTrackingType.Mount] = true,
    [Enum.ContentTrackingType.Achievement] = true,
    [Enum.ContentTrackingType.Decor] = true,
}

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

local function ClearContent()
    Providers:ClearSuperTrackingWayfinderData(SOURCE)
    C_SuperTrack.ClearSuperTrackedContent()
end

local function RefreshContent()
    if C_SuperTrack.GetHighestPrioritySuperTrackingType() ~= SUPER_TRACKING_TYPE then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        return
    end
    local trackableType, trackableID = C_SuperTrack.GetSuperTrackedContent()
    local identity = string.format("content:%s:%s", tostring(trackableType), tostring(trackableID))
    if trackableType ~= nil and not supportedContentTypes[trackableType] then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        Providers:ReportUnsupportedSuperTrackingTarget(identity, {
            trackableID = trackableID, trackableType = trackableType,
        })
        return
    end
    local x, y, mapID = Providers:GetSuperTrackingWaypoint()
    if trackableType == nil or not trackableID or not x or not y or not mapID then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        Providers:ReportUnresolvedSuperTrackingTarget(identity, L["Content"], {
            mapID = mapID, trackableID = trackableID, trackableType = trackableType,
        })
        return
    end
    local title, description = C_SuperTrack.GetSuperTrackedItemName()
    title = title or description
    if not title and C_ContentTracking then title = C_ContentTracking.GetTitle(trackableType, trackableID) end
    local texture, usesAtlas = GetContentIcon(trackableType, trackableID)
    Providers:SetSuperTrackingWayfinderData(SOURCE, identity, {
        mapID = mapID, x = x, y = y, title = title, texture = texture, usesAtlas = usesAtlas,
    }, ClearContent)
end

Providers:RegisterSuperTrackingProvider(SOURCE, SUPER_TRACKING_TYPE)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", RefreshContent)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_PATH_UPDATED", RefreshContent)
MapPinEnhanced:RegisterEvent("CONTENT_TRACKING_UPDATE", RefreshContent)
MapPinEnhanced:RegisterEvent("TRACKABLE_INFO_UPDATE", RefreshContent)
MapPinEnhanced:RegisterEvent("TRACKING_TARGET_INFO_UPDATE", RefreshContent)
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", RefreshContent)
