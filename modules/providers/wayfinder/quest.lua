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
---@param questTitle string
---@return string? description
---@return boolean available
local function GetQuestDescription(questID, questTitle)
    local ready = C_QuestLog.ReadyForTurnIn(questID)
    if issecretvalue(ready) then return nil, false end
    if ready then return string.format(L["Turn in: %s"], questTitle), true end
    local objectives = C_QuestLog.GetQuestObjectives(questID)
    if not objectives then return nil, false end
    ---@type string?
    local completedText
    -- Objective text already includes localized progress. Advance in quest-log
    -- order when an objective finishes instead of retaining its completed counter.
    for _, objective in ipairs(objectives) do
        if issecretvalue(objective.text) or issecretvalue(objective.finished) then return nil, false end
        local text = Providers:PlainDescription(objective.text, questTitle)
        if text then
            if not objective.finished then return text, true end
            completedText = completedText or text
        end
    end
    if completedText then return completedText, true end
    local waypointText = C_QuestLog.GetNextWaypointText(questID)
    if issecretvalue(waypointText) then return nil, false end
    return Providers:PlainDescription(waypointText, questTitle), true
end

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
        Providers:HandleUnresolvedSuperTrackingTarget(SOURCE, targetID)
        return
    end
    local superTrackedName = C_SuperTrack.GetSuperTrackedItemName()
    questTitle = Providers:PlainDescription(questTitle) or Providers:PlainDescription(superTrackedName) or L["Quest"]
    local classification = C_QuestInfoSystem.GetQuestClassification(questID)
    Providers:SetSuperTrackingWayfinderData(SOURCE, targetID, {
        mapID = mapID,
        x = x,
        y = y,
        title = questTitle,
        description = GetQuestDescription(questID, questTitle),
        texture = questClassificationAtlas[classification] or "Navigation-Tracked-Icon",
        usesAtlas = true,
    })
end

local function OnQuestProgress()
    Providers:RefreshSuperTrackingProvider(SOURCE)
end

---@param targetID string
---@param data WayfinderData
---@return string?, string?, boolean?
local function ReadQuestText(targetID, data)
    local questID = tonumber(targetID:match("^quest:(%d+)$"))
    if not questID then return end
    local title = Providers:PlainDescription(C_QuestLog.GetTitleForQuestID(questID)) or
        Providers:PlainDescription(C_TaskQuest.GetQuestInfoByQuestID(questID))
    if not title then return end
    local description, available = GetQuestDescription(questID, title)
    return title, description, available
end

---@param questID number
---@param success boolean
local function OnQuestDataLoadResult(questID, success)
    if not pendingQuestTitles[questID] then return end
    pendingQuestTitles[questID] = nil
    if success then
        Providers:RefreshSuperTrackingProvider(SOURCE)
    end
end

Providers:RegisterSuperTrackingProvider({
    source = SOURCE,
    superTrackingType = SUPER_TRACKING_TYPE,
    getTargetID = GetQuestTargetID,
    refresh = RefreshQuest,
    readText = ReadQuestText,
    captureTracking = function()
        local questID = C_SuperTrack.GetSuperTrackedQuestID()
        if not questID or questID == 0 then return nil end
        return function()
            if not C_QuestLog.IsOnQuest(questID) and not C_TaskQuest.IsActive(questID) then return false end
            C_SuperTrack.SetSuperTrackedQuestID(questID)
            return true
        end
    end,
    untrack = function() C_SuperTrack.SetSuperTrackedQuestID(0) end,
    events = { "QUEST_POI_UPDATE" },
})
MapPinEnhanced:RegisterEvent("QUEST_LOG_UPDATE", OnQuestProgress)
MapPinEnhanced:RegisterEvent("QUEST_WATCH_UPDATE", OnQuestProgress)
MapPinEnhanced:RegisterEvent("QUEST_DATA_LOAD_RESULT", OnQuestDataLoadResult)
