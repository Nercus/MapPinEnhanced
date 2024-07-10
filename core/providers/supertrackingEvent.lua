---@diagnostic disable: no-unknown
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinProvider : Module
local PinProvider = MapPinEnhanced:GetModule("PinProvider")

---@class PinManager : Module
local PinManager = MapPinEnhanced:GetModule("PinManager")


if not Enum.SuperTrackingMapPinType then
    return
end


local GetSuperTrackedMapPin = C_SuperTrack.GetSuperTrackedMapPin
local GetAreaPOIInfo = C_AreaPoiInfo.GetAreaPOIInfo

local WorldMapFrame = WorldMapFrame

local function GetOpenedMapID()
    return WorldMapFrame:GetMapID()
end


---@class MapPinNodeInfo
---@field x number
---@field y number
---@field mapID number
---@field texture string
---@field title string


---@param areaPOIId number
---@param mapID number
---@return MapPinNodeInfo | nil
local function GetAreaPOILocationInfo(areaPOIId, mapID)
    local poiInfo = GetAreaPOIInfo(mapID, areaPOIId)
    if not poiInfo then return end
    return {
        x = poiInfo.position.x,
        y = poiInfo.position.y,
        mapID = mapID,
        texture = poiInfo.atlasName,
        title = poiInfo.name
    }
end



---@param questId number
---@param mapID number
---@return MapPinNodeInfo | nil
local function GetQuestLocationInfo(questId, mapID)
    local questOffersPinPool = WorldMapFrame.pinPools.QuestOfferPinTemplate
    local questOfferPin
    for questPin in questOffersPinPool:EnumerateActive() do
        if questPin.questID == questId and questPin.mapID == mapID then
            questOfferPin = questPin
            break
        end
    end

    if not questOfferPin then return end
    return {
        x = questOfferPin.x,
        y = questOfferPin.y,
        mapID = questOfferPin.mapID,
        texture = questOfferPin.questIcon,
        title = questOfferPin.questName
    }
end

---@param taxiNodeID number
---@param mapID number
---@return MapPinNodeInfo | nil
local function GetTaxiNodeLocationInfo(taxiNodeID, mapID)
    local taxiNodes = C_TaxiMap.GetTaxiNodesForMap(mapID)
    local taxiNode
    for _, node in ipairs(taxiNodes) do
        if node.nodeID == taxiNodeID then
            taxiNode = node
            break
        end
    end
    if not taxiNode then return end
    return {
        x = taxiNode.position.x,
        y = taxiNode.position.y,
        mapID = mapID,
        texture = taxiNode.atlasName,
        title = taxiNode.name
    }
end


---@param digSiteID number
---@param mapID number
---@return MapPinNodeInfo | nil
local function GetDigSiteLocationInfo(digSiteID, mapID)
    local digSites = C_ResearchInfo.GetDigSitesForMap(mapID)
    local digSite
    for _, site in ipairs(digSites) do
        if site.researchSiteID == digSiteID then
            digSite = site
        end
    end
    if not digSite then return end
    return {
        x = digSite.position.x,
        y = digSite.position.y,
        mapID = mapID,
        texture = "ArchBlob", -- always the same atlas
        title = digSite.name
    }
end


local trackedMapPinTypes = {
    [Enum.SuperTrackingMapPinType.AreaPOI] = true,
    [Enum.SuperTrackingMapPinType.QuestOffer] = true,
    [Enum.SuperTrackingMapPinType.TaxiNode] = true,
    [Enum.SuperTrackingMapPinType.DigSite] = true
}


---@param mapPinType Enum.SuperTrackingType
---@param mapPinTypeID number
---@param mapID number
---@return MapPinNodeInfo | nil
local function GetNodeForMapPinType(mapPinType, mapPinTypeID, mapID)
    if mapPinType == Enum.SuperTrackingMapPinType.AreaPOI then
        return GetAreaPOILocationInfo(mapPinTypeID, mapID)
    elseif mapPinType == Enum.SuperTrackingMapPinType.QuestOffer then
        return GetQuestLocationInfo(mapPinTypeID, mapID)
    elseif mapPinType == Enum.SuperTrackingMapPinType.TaxiNode then
        return GetTaxiNodeLocationInfo(mapPinTypeID, mapID)
    elseif mapPinType == Enum.SuperTrackingMapPinType.DigSite then
        return GetDigSiteLocationInfo(mapPinTypeID, mapID)
    end
end


function PinProvider:SupertrackingOnChanged()
    local mapPinType, mapPinTypeID = GetSuperTrackedMapPin()
    if not mapPinType or not mapPinTypeID then return end
    if trackedMapPinTypes[mapPinType] then
        C_SuperTrack.ClearSuperTrackedContent()
    end
    local mapID = GetOpenedMapID()
    if not mapID then return end
    local nodeInfo = GetNodeForMapPinType(mapPinType, mapPinTypeID, mapID)
    if not nodeInfo then return end
    PinManager:AddPin({
        mapID = nodeInfo.mapID,
        x = nodeInfo.x,
        y = nodeInfo.y,
        title = nodeInfo.title,
        texture = nodeInfo.texture,
        usesAtlas = true,
        setTracked = true
    })
end

EventRegistry:RegisterCallback("Supertracking.OnChanged", function()
    PinProvider:SupertrackingOnChanged()
end)
