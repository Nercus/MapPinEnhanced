---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L


local questClassificationAtlas = {
    [Enum.QuestClassification.Normal] = "QuestNormal",
    [Enum.QuestClassification.Questline] = "QuestNormal",
    [Enum.QuestClassification.Recurring] = "UI-QuestPoiRecurring-QuestBang",
    [Enum.QuestClassification.Meta] = "quest-wrapper-available",
    [Enum.QuestClassification.Calling] = "Quest-DailyCampaign-Available",
    [Enum.QuestClassification.Campaign] = "Quest-Campaign-Available",
    [Enum.QuestClassification.Legendary] = "UI-QuestPoiLegendary-QuestBang",
    [Enum.QuestClassification.Important] = "importantavailablequesticon",
};



--- cache areaPOIs, taxi nodes and digsites for faster lookup
---@type table<number, number>
local areaPOICache = {}
---@type table<number, number>
local taxiNodeCache = {}
---@type table<number, number>
local digsiteNodeCache = {}


local function BuildCaches()
    for _, map in ipairs(C_Map.GetMapChildrenInfo(947, 3, true)) do
        local areaPOIs = C_AreaPoiInfo.GetAreaPOIForMap(map.mapID)
        local dungeonEntrances = C_EncounterJournal.GetDungeonEntrancesForMap(map.mapID)
        local delves = C_AreaPoiInfo.GetDelvesForMap(map.mapID)
        local dragonridingRaces = C_AreaPoiInfo.GetDragonridingRacesForMap(map.mapID)
        local events = C_AreaPoiInfo.GetEventsForMap(map.mapID)
        local questHubs = C_AreaPoiInfo.GetQuestHubsForMap(map.mapID)
        for _, areaPoiID in ipairs(areaPOIs or {}) do
            areaPOICache[areaPoiID] = map.mapID
        end
        for _, node in ipairs(dungeonEntrances or {}) do
            areaPOICache[node.areaPoiID] = map.mapID
        end
        for _, areaPoiID in ipairs(delves or {}) do
            areaPOICache[areaPoiID] = map.mapID
        end
        for _, areaPoiID in ipairs(dragonridingRaces or {}) do
            areaPOICache[areaPoiID] = map.mapID
        end
        for _, areaPoiID in ipairs(events or {}) do
            areaPOICache[areaPoiID] = map.mapID
        end
        for _, areaPoiID in ipairs(questHubs or {}) do
            areaPOICache[areaPoiID] = map.mapID
        end

        --- cache taxi nodes for faster lookup
        for _, node in ipairs(C_TaxiMap.GetTaxiNodesForMap(map.mapID) or {}) do
            taxiNodeCache[node.nodeID] = map.mapID
        end

        for _, node in ipairs(C_ResearchInfo.GetDigSitesForMap(map.mapID) or {}) do
            digsiteNodeCache[node.researchSiteID] = map.mapID
        end
    end
end

---@return number? x
---@return number? y
---@return number? mapID
---@return string?
---@return string?
---@return Enum.SuperTrackingMapPinType? pinType
---@return number? typeID
function Providers:GetSuperTrackingInfo()
    local pinType, typeID = C_SuperTrack.GetSuperTrackedMapPin()
    ---@type string
    local title
    ---@type string
    local atlasName
    ---@type number
    local mapID
    ---@type number
    local x
    ---@type number
    local y
    if pinType == Enum.SuperTrackingMapPinType.AreaPOI then
        mapID = areaPOICache[typeID]
        if not mapID then return end
        local areaPOIInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapID, typeID)
        if not areaPOIInfo then return end
        x = areaPOIInfo.position.x
        y = areaPOIInfo.position.y
        title = areaPOIInfo.name
        atlasName = areaPOIInfo.atlasName
    elseif pinType == Enum.SuperTrackingMapPinType.TaxiNode then
        mapID = taxiNodeCache[typeID]
        if not mapID then return end

        local mapTaxiNodes = C_TaxiMap.GetTaxiNodesForMap(mapID)
        if not mapTaxiNodes then return end
        for _, node in ipairs(mapTaxiNodes) do
            if node.nodeID == typeID then
                title = node.name
                atlasName = node.atlasName
                x = node.position.x
                y = node.position.y
                -- FIXME: taxi nodes can break and sometimes return coords higher than 1
                break
            end
        end
    elseif pinType == Enum.SuperTrackingMapPinType.QuestOffer then
        ---@type number?
        mapID = GetQuestUiMapID(typeID);
        if not mapID then return end

        local mapQuests = C_QuestLog.GetQuestsOnMap(mapID)
        if not mapQuests then return end
        for _, quest in ipairs(mapQuests) do
            if quest.questID == typeID then
                title = C_QuestLog.GetTitleForQuestID(quest.questID)
                x = quest.x
                y = quest.y
                local questClassification = C_QuestInfoSystem.GetQuestClassification(quest.questID);
                local questAtlas = questClassificationAtlas[questClassification]
                if questAtlas then
                    atlasName = questAtlas
                else
                    atlasName = "QuestLog-tab-icon-quest"
                end
                break
            end
        end
    elseif pinType == Enum.SuperTrackingMapPinType.DigSite then
        mapID = digsiteNodeCache[typeID]
        if not mapID then return end

        local mapDigsites = C_ResearchInfo.GetDigSitesForMap(mapID)
        if not mapDigsites then return end
        for _, digsite in ipairs(mapDigsites) do
            if digsite.researchSiteID == typeID then
                title = digsite.name
                atlasName = "ArchBlob"
                x = digsite.position.x
                y = digsite.position.y
            end
        end
    end
    return x, y, mapID, title, atlasName, pinType, typeID
end

local function OnSuperTrackingChanged()
    local superTrackingType = C_SuperTrack.GetHighestPrioritySuperTrackingType()
    if superTrackingType == Enum.SuperTrackingType.UserWaypoint then
        return
    end
    local x, y, mapID, title, atlasName, pinType, typeID = Providers:GetSuperTrackingInfo()

    if not x or not y or not mapID then
        return
    end

    local uncategorizedGroup = Groups:GetGroupByName(L["Uncategorized Pins"])
    if not uncategorizedGroup then return end
    local pinExists = false
    for _, pin in pairs(uncategorizedGroup.pins) do
        if pin.pinData.mapID == mapID and pin.pinData.x == x and pin.pinData.y == y and pin.pinData.pinType == pinType and
            pin.pinData.typeID == typeID then
            pinExists = true
            break
        end
    end
    if pinExists then return end
    uncategorizedGroup:AddPin({
        mapID = mapID,
        typeID = typeID,
        pinType = pinType,
        x = x,
        y = y,
        title = title,
        texture = atlasName,
        usesAtlas = true,
        setTracked = true
    })
end




MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", OnSuperTrackingChanged)
MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", BuildCaches)
