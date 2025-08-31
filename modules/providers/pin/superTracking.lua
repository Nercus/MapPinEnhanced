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



---@return number? x
---@return number? y
---@return number? mapID
---@return string?
---@return string?
---@return Enum.SuperTrackingMapPinType? pinType
---@return number? typeID
function Providers:GetSuperTrackingInfo()
    -- TODO: make generic
    -- TODO: support more supertrackable types: check https://warcraft.wiki.gg/wiki/API_C_SuperTrack.GetHighestPrioritySuperTrackingType
    -- TODO: generically get title, icon, coords for supertracked types
    -- TODO: check if detecting silverdragon and handynotes is possible


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

    local mouseFoci = GetMouseFoci();
    for _, focus in ipairs(mouseFoci) do
        if focus.lastOwningMapID then
            mapID = focus.lastOwningMapID
            break
        end
    end
    if not mapID then
        return
    end

    if pinType == Enum.SuperTrackingMapPinType.AreaPOI then
        local areaPOIInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapID, typeID)
        if not areaPOIInfo then return end
        x = areaPOIInfo.position.x
        y = areaPOIInfo.position.y
        title = areaPOIInfo.name
        atlasName = areaPOIInfo.atlasName
    elseif pinType == Enum.SuperTrackingMapPinType.TaxiNode then
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
        if pin.pinData.pinType == pinType and pin.pinData.typeID == typeID then
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
