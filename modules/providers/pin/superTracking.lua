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

---@param mapID number
---@return Vector2DMixin?
---@return string?
---@return string?
function Providers:GetSuperTrackingInfo(mapID)
    -- TODO: fix this to always use the mapID of the actual map element instead to use the current map

    local pinType, typeID = C_SuperTrack.GetSuperTrackedMapPin()
    ---@type Vector2DMixin?
    local position
    ---@type string?
    local title
    ---@type string?
    local atlasName
    if pinType == Enum.SuperTrackingMapPinType.AreaPOI then
        local areaPOIInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapID, typeID)
        if not areaPOIInfo then return end
        position = areaPOIInfo.position
        title = areaPOIInfo.name
        atlasName = areaPOIInfo.atlasName
    elseif pinType == Enum.SuperTrackingMapPinType.TaxiNode then
        local mapTaxiNodes = C_TaxiMap.GetTaxiNodesForMap(mapID)
        if not mapTaxiNodes then return end
        for _, node in ipairs(mapTaxiNodes) do
            if node.nodeID == typeID then
                position = node.position
                title = node.name
                atlasName = node.atlasName
                break
            end
        end
    elseif pinType == Enum.SuperTrackingMapPinType.QuestOffer then
        local mapQuests = C_QuestLog.GetQuestsOnMap(mapID)
        if not mapQuests then return end
        for _, quest in ipairs(mapQuests) do
            if quest.questID == typeID then
                position = { x = quest.x, y = quest.y }
                title = C_QuestLog.GetTitleForQuestID(quest.questID)
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
        local mapDigsites = C_ResearchInfo.GetDigSitesForMap(mapID)
        if not mapDigsites then return end
        for _, digsite in ipairs(mapDigsites) do
            if digsite.researchSiteID == typeID then
                position = digsite.position
                title = digsite.name
                atlasName = "ArchBlob"
            end
        end
    end
    return position, title, atlasName
end

local function OnSuperTrackingChanged()
    local superTrackingType = C_SuperTrack.GetHighestPrioritySuperTrackingType()
    if superTrackingType == Enum.SuperTrackingType.UserWaypoint then
        return
    end

    ---@type number UiMapID
    local mapID = WorldMapFrame:GetMapID()
    if not mapID then return end

    local position, title, atlasName = Providers:GetSuperTrackingInfo(mapID)

    if not position or not title or not atlasName then
        return
    end

    local uncategorizedGroup = Groups:GetGroupByName(L["Uncategorized Pins"])
    if not uncategorizedGroup then return end
    uncategorizedGroup:AddPin({
        mapID = mapID,
        x = position.x,
        y = position.y,
        title = title,
        texture = atlasName,
        usesAtlas = true,
        setTracked = true
    })
end




MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", OnSuperTrackingChanged)
