---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "mapPin"
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.MapPin
---@type table<number, boolean>
local requestedQuestMaps = {}
---@type table<number, boolean>
local pendingQuestTitles = {}

---@param questID number
---@param mapID number
---@return number? x
---@return number? y
---@return string? title
local function GetQuestOfferInfo(questID, mapID)
    -- Quest offers are quest-line or task records, not accepted quest-log POIs.
    local info = C_QuestLine.GetQuestLineInfo(questID, mapID)
    if info and not info.inProgress then return info.x, info.y, info.questName end
    if not requestedQuestMaps[mapID] then
        requestedQuestMaps[mapID] = true
        C_QuestLine.RequestQuestLinesForMap(mapID)
    end
    for _, task in ipairs(C_TaskQuest.GetQuestsOnMap(mapID) or {}) do
        if task.questID == questID and task.isQuestStart and not task.inProgress then
            return task.x, task.y, C_TaskQuest.GetQuestInfoByQuestID(questID)
        end
    end
end

---@return string
local function GetMapPinTargetID()
    local pinType, typeID = C_SuperTrack.GetSuperTrackedMapPin()
    return string.format("mapPin:%s:%s", tostring(pinType), tostring(typeID))
end

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
    for _, plotInfo in ipairs(C_HousingNeighborhood.GetNeighborhoodMapData() or {}) do
        if plotInfo.plotDataID == plotDataID then return plotInfo end
    end
end

---@param pinType Enum.SuperTrackingMapPinType
---@param typeID number
---@param mapID number
---@return number? x
---@return number? y
---@return string? title
---@return string|number? texture
---@return boolean? usesAtlas
---@return string? description
local function GetMapPinInfo(pinType, typeID, mapID)
    if pinType == Enum.SuperTrackingMapPinType.AreaPOI then
        local info = C_AreaPoiInfo.GetAreaPOIInfo(mapID, typeID)
        local display = info or C_AreaPoiInfo.GetAreaPOIInfo(nil, typeID)
        return info and info.position.x, info and info.position.y,
            display and display.name, display and display.atlasName, true, display and display.description
    elseif pinType == Enum.SuperTrackingMapPinType.TaxiNode then
        for _, node in ipairs(C_TaxiMap.GetTaxiNodesForMap(mapID) or {}) do
            if node.nodeID == typeID then
                return node.position.x, node.position.y, node.name, node.atlasName, true
            end
        end
    elseif pinType == Enum.SuperTrackingMapPinType.QuestOffer then
        local x, y, title = GetQuestOfferInfo(typeID, mapID)
        title = title or C_QuestLog.GetTitleForQuestID(typeID)
        if not title and not pendingQuestTitles[typeID] then
            pendingQuestTitles[typeID] = true
            C_QuestLog.RequestLoadQuestByID(typeID)
        end
        local classification = C_QuestInfoSystem.GetQuestClassification(typeID)
        return x, y, title, questClassificationAtlas[classification] or "QuestLog-tab-icon-quest", true
    elseif pinType == Enum.SuperTrackingMapPinType.DigSite then
        for _, digSite in ipairs(C_ResearchInfo.GetDigSitesForMap(mapID) or {}) do
            if digSite.researchSiteID == typeID then
                return digSite.position.x, digSite.position.y, digSite.name, "ArchBlob", true
            end
        end
    elseif pinType == Enum.SuperTrackingMapPinType.HousingPlot then
        local plotInfo = GetHousingPlotInfo(typeID)
        if not plotInfo then return nil, nil, L["House"] end
        local title ---@type string?
        if plotInfo.ownerName and plotInfo.ownerName ~= "" then
            title = string.format(L["%s's House"], plotInfo.ownerName)
        elseif C_HousingNeighborhood.GetNeighborhoodPlotName then
            title = C_HousingNeighborhood.GetNeighborhoodPlotName(plotInfo.plotID)
        end
        return nil, nil, title or L["House"], housingOwnerAtlas[plotInfo.ownerType], true
    end
end

---@param _ string
---@param targetID string
---@param changeNumber integer
local function ClearMapPin(_, targetID, changeNumber)
    if not Providers:ClearSuperTrackingWayfinderData(SOURCE, targetID, changeNumber) then return end
    C_SuperTrack.ClearSuperTrackedMapPin()
end

---@param targetID string
---@param data WayfinderData
---@return string?, string?, boolean?
local function ReadMapPinText(targetID, data)
    local typeText, idText = targetID:match("^mapPin:(%d+):(%d+)$")
    local pinType, typeID = tonumber(typeText), tonumber(idText)
    if not pinType or not typeID then return end
    local _, _, title, _, _, description = GetMapPinInfo(pinType, typeID, data.mapID)
    title = Providers:PlainDescription(title)
    if not title or issecretvalue(description) then return end
    if pinType ~= Enum.SuperTrackingMapPinType.AreaPOI then
        -- A temporary Step has no original-source supertracking text. Keep its
        -- last attributable detail while independently refreshing the name.
        if Providers:IsStepSuperTracking() then
            description = data.description
        else
            local _, sourceText = C_SuperTrack.GetSuperTrackedItemName()
            description = Providers:PlainDescription(sourceText, title) or data.description
        end
    end
    return title, description, true
end

local function RefreshMapPin()
    local pinType, typeID = C_SuperTrack.GetSuperTrackedMapPin()
    local targetID = GetMapPinTargetID()
    local hasPin = pinType ~= nil and typeID ~= nil
    local questOffer = pinType == Enum.SuperTrackingMapPinType.QuestOffer and
        C_QuestLine.GetQuestLineInfo(typeID)
    local questMapID = questOffer and questOffer.startMapID or nil
    if hasPin and pinType == Enum.SuperTrackingMapPinType.QuestOffer and
        (not questMapID or questMapID == 0) then
        questMapID = C_TaskQuest.GetQuestZoneID(typeID)
    end
    ---@type number?, string?, string|number?, boolean?, string?
    local resolvedMapID, title, texture, usesAtlas, description
    local x, y, mapID, waypointDescription, traversalOnly = Providers:GetSuperTrackingWaypoint(
        hasPin and function(candidateMapID)
            local x, y
            x, y, title, texture, usesAtlas, description = GetMapPinInfo(pinType, typeID, candidateMapID)
            resolvedMapID = candidateMapID
            return x, y
        end or nil, questMapID)
    if pinType == nil or typeID == nil or x == nil or y == nil or mapID == nil then
        Providers:HandleUnresolvedSuperTrackingTarget(SOURCE, targetID)
        return
    end
    if resolvedMapID ~= mapID then
        local x, y
        x, y, title, texture, usesAtlas, description = GetMapPinInfo(pinType, typeID, mapID)
    end
    local textAvailable = Providers:PlainDescription(title) ~= nil and not issecretvalue(description)
    local superTrackedName, superTrackedDescription = C_SuperTrack.GetSuperTrackedItemName()
    local displayTitle = title or superTrackedName or waypointDescription
    local displayDescription = description or superTrackedDescription or waypointDescription
    if textAvailable then
        displayTitle = Providers:PlainDescription(title)
        if pinType == Enum.SuperTrackingMapPinType.AreaPOI then
            displayDescription = description
        else
            displayDescription = Providers:PlainDescription(superTrackedDescription, displayTitle) or displayDescription
        end
    end
    Providers:SetSuperTrackingWayfinderData(SOURCE, targetID, {
        mapID = mapID,
        x = x,
        y = y,
        title = displayTitle,
        description = displayDescription,
        texture = texture,
        usesAtlas = usesAtlas,
    }, not traversalOnly and ClearMapPin or nil, textAvailable)
end

Providers:RegisterSuperTrackingProvider({
    source = SOURCE,
    superTrackingType = SUPER_TRACKING_TYPE,
    getTargetID = GetMapPinTargetID,
    refresh = RefreshMapPin,
    readText = ReadMapPinText,
    captureTracking = function(data)
        local pinType, typeID = C_SuperTrack.GetSuperTrackedMapPin()
        local mapID = data.mapID
        if pinType == nil or typeID == nil or not mapID then return nil end
        return function()
            if pinType == Enum.SuperTrackingMapPinType.HousingPlot then
                if not GetHousingPlotInfo(typeID) then return false end
            elseif GetMapPinInfo(pinType, typeID, mapID) == nil then
                return false
            end
            C_SuperTrack.SetSuperTrackedMapPin(pinType, typeID)
            return true
        end
    end,
    untrack = function() C_SuperTrack.ClearSuperTrackedMapPin() end,
    events = { "AREA_POIS_UPDATED", "NEIGHBORHOOD_MAP_DATA_UPDATED", "QUEST_POI_UPDATE", "QUEST_LOG_UPDATE" },
})

MapPinEnhanced:RegisterEvent("QUESTLINE_UPDATE", function(requestRequired)
    if requestRequired then wipe(requestedQuestMaps) end
    Providers:RefreshSuperTrackingProvider(SOURCE)
end)

MapPinEnhanced:RegisterEvent("QUEST_DATA_LOAD_RESULT", function(questID, success)
    if not pendingQuestTitles[questID] then return end
    pendingQuestTitles[questID] = nil
    if success then Providers:RefreshSuperTrackingProvider(SOURCE) end
end)
