---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "quest"
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.Quest
---@type table<number, boolean>
local pendingQuestTitles = {}

---@return string
local function GetQuestTargetID()
    local questID = C_SuperTrack.GetSuperTrackedQuestID()
    if questID == 0 then questID = nil end
    return string.format("quest:%s", tostring(questID))
end

---@type table<Enum.QuestClassification, string>
local questClassificationAtlas = {
    [Enum.QuestClassification.Normal] = "Navigation-Tracked-Icon",
    [Enum.QuestClassification.Questline] = "Navigation-Tracked-Icon",
    [Enum.QuestClassification.Recurring] = "UI-QuestPoiRecurring-QuestBang",
    [Enum.QuestClassification.Meta] = "quest-wrapper-available",
    [Enum.QuestClassification.Calling] = "Quest-DailyCampaign-Available",
    [Enum.QuestClassification.Campaign] = "Quest-Campaign-Available",
    [Enum.QuestClassification.Legendary] = "UI-QuestPoiLegendary-QuestBang",
    [Enum.QuestClassification.Important] = "importantavailablequesticon",
}

---@param questID number
---@param mapID number
---@return number? x
---@return number? y
local function GetQuestWaypointForMap(questID, mapID)
    local x, y = C_QuestLog.GetNextWaypointForMap(questID, mapID)
    if x and y then return x, y end
    -- Blizzard renders objective POIs independently of navigation waypoints.
    for _, info in ipairs(C_QuestLog.GetQuestsOnMap(mapID) or {}) do
        if info.questID == questID then return info.x, info.y end
    end
    for _, info in ipairs(C_TaskQuest.GetQuestsOnMap(mapID) or {}) do
        if info.questID == questID then return info.x, info.y end
    end
end

local function RefreshQuest()
    local questID = C_SuperTrack.GetSuperTrackedQuestID()
    if questID == 0 then questID = nil end
    local targetID = GetQuestTargetID()
    local questMapID = questID and C_TaskQuest.GetQuestZoneID(questID)
    if questID and (not questMapID or questMapID == 0) then questMapID = GetQuestUiMapID(questID) end
    local questTitle = questID and (C_QuestLog.GetTitleForQuestID(questID) or
        C_TaskQuest.GetQuestInfoByQuestID(questID))
    if questID and not questTitle and not pendingQuestTitles[questID] then
        pendingQuestTitles[questID] = true
        C_QuestLog.RequestLoadQuestByID(questID)
    end
    local x, y, mapID = Providers:GetSuperTrackingWaypoint(questID and function(candidateMapID)
        return GetQuestWaypointForMap(questID, candidateMapID)
    end or nil, questMapID)
    if questID and (x == nil or y == nil or mapID == nil) then
        mapID, x, y = C_QuestLog.GetNextWaypoint(questID)
    end
    if questID == nil or x == nil or y == nil or mapID == nil then
        Providers:HandleUnresolvedSuperTrackingTarget(SOURCE, targetID, L["Quest"], {
            hasCoordinates = x ~= nil and y ~= nil,
            questID = questID,
        })
        return
    end
    local superTrackedName = C_SuperTrack.GetSuperTrackedItemName()
    questTitle = questTitle or superTrackedName or L["Quest"]
    local waypointText = C_QuestLog.GetNextWaypointText(questID)
    local title = questTitle
    if C_QuestLog.ReadyForTurnIn(questID) then
        title = string.format(L["Turn in: %s"], questTitle or tostring(questID))
    elseif waypointText and waypointText ~= "" and questTitle and questTitle ~= "" then
        title = string.format(L["%s — %s"], waypointText, questTitle)
    end
    local classification = C_QuestInfoSystem.GetQuestClassification(questID)
    Providers:SetSuperTrackingWayfinderData(SOURCE, targetID, {
        mapID = mapID,
        x = x,
        y = y,
        title = title,
        texture = questClassificationAtlas[classification] or "Navigation-Tracked-Icon",
        usesAtlas = true,
    })
end

---@param questID number
---@param success boolean
local function OnQuestDataLoadResult(questID, success)
    if not pendingQuestTitles[questID] then return end
    pendingQuestTitles[questID] = nil
    if success and questID == C_SuperTrack.GetSuperTrackedQuestID() then
        Providers:RefreshSuperTrackingProvider(SOURCE)
    end
end

Providers:RegisterSuperTrackingProvider({
    source = SOURCE,
    superTrackingType = SUPER_TRACKING_TYPE,
    getTargetID = GetQuestTargetID,
    refresh = RefreshQuest,
    events = { "QUEST_LOG_UPDATE", "QUEST_POI_UPDATE" },
})
MapPinEnhanced:RegisterEvent("QUEST_DATA_LOAD_RESULT", OnQuestDataLoadResult)
