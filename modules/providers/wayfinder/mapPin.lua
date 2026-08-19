---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "mapPin"
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.MapPin

---@type table<Enum.SuperTrackingMapPinType, boolean>
local supportedPinTypes = {
    [Enum.SuperTrackingMapPinType.AreaPOI] = true,
    [Enum.SuperTrackingMapPinType.QuestOffer] = true,
    [Enum.SuperTrackingMapPinType.TaxiNode] = true,
    [Enum.SuperTrackingMapPinType.DigSite] = true,
    [Enum.SuperTrackingMapPinType.HousingPlot] = true,
}

---@type table<Enum.QuestClassification, string>
local questClassificationAtlas = {
    [Enum.QuestClassification.Normal] = "QuestNormal",
    [Enum.QuestClassification.Questline] = "QuestNormal",
    [Enum.QuestClassification.Recurring] = "UI-QuestPoiRecurring-QuestBang",
    [Enum.QuestClassification.Meta] = "quest-wrapper-available",
    [Enum.QuestClassification.Calling] = "Quest-DailyCampaign-Available",
    [Enum.QuestClassification.Campaign] = "Quest-Campaign-Available",
    [Enum.QuestClassification.Legendary] = "UI-QuestPoiLegendary-QuestBang",
    [Enum.QuestClassification.Important] = "importantavailablequesticon",
}

---@type table<Enum.HousingPlotOwnerType, string>
local housingOwnerAtlas = {
    [Enum.HousingPlotOwnerType.None] = "housing-map-plot-unoccupied",
    [Enum.HousingPlotOwnerType.Self] = "housing-map-plot-player-house",
    [Enum.HousingPlotOwnerType.Friend] = "housing-map-plot-occupied-friend",
    [Enum.HousingPlotOwnerType.Stranger] = "housing-map-plot-occupied",
}

---@param plotDataID number
---@return NeighborhoodPlotMapInfo?
local function GetHousingPlotInfo(plotDataID)
    if not C_HousingNeighborhood or not C_HousingNeighborhood.GetNeighborhoodMapData then return nil end
    for _, plotInfo in ipairs(C_HousingNeighborhood.GetNeighborhoodMapData()) do
        if plotInfo.plotDataID == plotDataID then return plotInfo end
    end
end

---@param pinType Enum.SuperTrackingMapPinType
---@param typeID number
---@param mapID number
---@return string? title
---@return string|number? texture
---@return boolean? usesAtlas
local function GetMapPinDisplayInfo(pinType, typeID, mapID)
    if pinType == Enum.SuperTrackingMapPinType.AreaPOI then
        local info = C_AreaPoiInfo.GetAreaPOIInfo(mapID, typeID) or C_AreaPoiInfo.GetAreaPOIInfo(nil, typeID)
        return info and info.name, info and info.atlasName, true
    elseif pinType == Enum.SuperTrackingMapPinType.TaxiNode then
        for _, node in ipairs(C_TaxiMap.GetTaxiNodesForMap(mapID) or {}) do
            if node.nodeID == typeID then return node.name, node.atlasName, true end
        end
    elseif pinType == Enum.SuperTrackingMapPinType.QuestOffer then
        local title = C_QuestLog.GetTitleForQuestID(typeID)
        local classification = C_QuestInfoSystem.GetQuestClassification(typeID)
        local atlas = questClassificationAtlas[classification] or "QuestLog-tab-icon-quest"
        return title and string.format(L["Accept: %s"], title), atlas, true
    elseif pinType == Enum.SuperTrackingMapPinType.DigSite then
        for _, digSite in ipairs(C_ResearchInfo.GetDigSitesForMap(mapID) or {}) do
            if digSite.researchSiteID == typeID then return digSite.name, "ArchBlob", true end
        end
    elseif pinType == Enum.SuperTrackingMapPinType.HousingPlot then
        local plotInfo = GetHousingPlotInfo(typeID)
        if not plotInfo then return L["House"] end
        ---@type string?
        local title
        if plotInfo.ownerName and plotInfo.ownerName ~= "" then
            title = string.format(L["%s's House"], plotInfo.ownerName)
        elseif C_HousingNeighborhood.GetNeighborhoodPlotName then
            title = C_HousingNeighborhood.GetNeighborhoodPlotName(plotInfo.plotID)
        end
        return title or L["House"], housingOwnerAtlas[plotInfo.ownerType], true
    end
end

local function ClearMapPin()
    Providers:ClearSuperTrackingWayfinderData(SOURCE)
    C_SuperTrack.ClearSuperTrackedMapPin()
end

local function RefreshMapPin()
    if C_SuperTrack.GetHighestPrioritySuperTrackingType() ~= SUPER_TRACKING_TYPE then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        return
    end
    local pinType, typeID = C_SuperTrack.GetSuperTrackedMapPin()
    local identity = string.format("mapPin:%s:%s", tostring(pinType), tostring(typeID))
    if pinType and not supportedPinTypes[pinType] then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        Providers:ReportUnsupportedSuperTrackingTarget(identity, { pinType = pinType, typeID = typeID })
        return
    end
    local x, y, mapID, waypointDescription = Providers:GetSuperTrackingWaypoint()
    if not pinType or not typeID or not x or not y or not mapID then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        Providers:ReportUnresolvedSuperTrackingTarget(identity, L["Map Pin"], {
            mapID = mapID, pinType = pinType, typeID = typeID,
        })
        return
    end
    local title, texture, usesAtlas = GetMapPinDisplayInfo(pinType, typeID, mapID)
    local superTrackedName = C_SuperTrack.GetSuperTrackedItemName()
    Providers:SetSuperTrackingWayfinderData(SOURCE, identity, {
        mapID = mapID,
        x = x,
        y = y,
        title = title or superTrackedName or waypointDescription,
        texture = texture,
        usesAtlas = usesAtlas,
    }, ClearMapPin)
end

Providers:RegisterSuperTrackingProvider(SOURCE, SUPER_TRACKING_TYPE)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", RefreshMapPin)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_PATH_UPDATED", RefreshMapPin)
MapPinEnhanced:RegisterEvent("NEIGHBORHOOD_MAP_DATA_UPDATED", RefreshMapPin)
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", RefreshMapPin)
