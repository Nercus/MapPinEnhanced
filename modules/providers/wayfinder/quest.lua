---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "quest"
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.Quest
---@type table<number, boolean>
local pendingQuestTitles = {}

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

local function RefreshQuest()
    if C_SuperTrack.GetHighestPrioritySuperTrackingType() ~= SUPER_TRACKING_TYPE then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        return
    end
    local questID = C_SuperTrack.GetSuperTrackedQuestID()
    local identity = string.format("quest:%s", tostring(questID))
    local x, y, mapID = Providers:GetSuperTrackingWaypoint()
    if not questID or not x or not y or not mapID then
        Providers:ClearSuperTrackingWayfinderData(SOURCE)
        Providers:ReportUnresolvedSuperTrackingTarget(identity, L["Quest"], { mapID = mapID, questID = questID })
        return
    end
    local questTitle = C_QuestLog.GetTitleForQuestID(questID)
    if not questTitle and not pendingQuestTitles[questID] then
        pendingQuestTitles[questID] = true
        C_QuestLog.RequestLoadQuestByID(questID)
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
    Providers:SetSuperTrackingWayfinderData(SOURCE, identity, {
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
    if success and questID == C_SuperTrack.GetSuperTrackedQuestID() then RefreshQuest() end
end

Providers:RegisterSuperTrackingProvider(SOURCE, SUPER_TRACKING_TYPE)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", RefreshQuest)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_PATH_UPDATED", RefreshQuest)
MapPinEnhanced:RegisterEvent("QUEST_LOG_UPDATE", RefreshQuest)
MapPinEnhanced:RegisterEvent("QUEST_POI_UPDATE", RefreshQuest)
MapPinEnhanced:RegisterEvent("QUEST_DATA_LOAD_RESULT", OnQuestDataLoadResult)
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", RefreshQuest)
