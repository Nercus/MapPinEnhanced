---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "quest"
local OBJECTIVE_DIRECTION_DISTANCE = 40
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.Quest
---@type table<number, boolean>
local pendingQuestTitles = {}

---@type table<Enum.QuestClassification, string>
local questProgressAtlas = {
    [Enum.QuestClassification.Recurring] = "QuestProgressRecurring",
    [Enum.QuestClassification.Campaign] = "QuestProgressCampaign",
    [Enum.QuestClassification.Legendary] = "QuestProgressLegendary",
    [Enum.QuestClassification.Important] = "QuestProgressImportant",
}

---@type table<Enum.QuestClassification, string>
local questTurnInAtlas = {
    [Enum.QuestClassification.Recurring] = "quest-recurring-turnin",
    [Enum.QuestClassification.Meta] = "quest-wrapper-turnin",
    [Enum.QuestClassification.Calling] = "Quest-DailyCampaign-TurnIn",
    [Enum.QuestClassification.Campaign] = "Quest-Campaign-TurnIn",
    [Enum.QuestClassification.Legendary] = "quest-legendary-turnin",
    [Enum.QuestClassification.Important] = "quest-important-turnin",
}

---@param questID number
---@param ready boolean?
---@return string?
local function GetQuestAtlas(questID, ready)
    local isWorldQuest = C_QuestLog.IsWorldQuest(questID)
    if issecretvalue(isWorldQuest) or type(isWorldQuest) ~= "boolean" then return nil end
    if isWorldQuest then
        local tagInfo = C_QuestLog.GetQuestTagInfo(questID)
        if not MapPinEnhanced:IsReadableTable(tagInfo) or not QuestUtil or
            not QuestUtil.GetWorldQuestAtlasInfo then
            return nil
        end
        ---@cast tagInfo QuestTagInfo
        if issecretvalue(tagInfo.worldQuestType) or issecretvalue(tagInfo.isElite) or
            issecretvalue(tagInfo.quality) or issecretvalue(tagInfo.tradeskillLineID) then
            return nil
        end
        -- World quests retain Blizzard's objective-type icon while in progress.
        local atlas = QuestUtil.GetWorldQuestAtlasInfo(questID, tagInfo, false)
        if not issecretvalue(atlas) and type(atlas) == "string" and atlas ~= "" then return atlas end
        return nil
    end
    if issecretvalue(ready) or type(ready) ~= "boolean" then return nil end
    if ready then
        local classification = C_QuestInfoSystem.GetQuestClassification(questID)
        if issecretvalue(classification) then return nil end
        return questTurnInAtlas[classification] or "UI-QuestPoi-QuestBangTurnIn"
    end
    local isTask = C_QuestLog.IsQuestTask(questID)
    if issecretvalue(isTask) or type(isTask) ~= "boolean" then return nil end
    if isTask then return "Bonus-Objective-Star" end
    local classification = C_QuestInfoSystem.GetQuestClassification(questID)
    if issecretvalue(classification) then return nil end
    return questProgressAtlas[classification] or "QuestProgressStandard"
end

---@param questID number
---@return number?
local function GetObjectiveDirectionDistance(questID)
    local objectives = C_QuestLog.GetQuestObjectives(questID)
    if not MapPinEnhanced:IsReadableTable(objectives) then return nil end
    local maximumRequired = 0
    for _, objective in ipairs(objectives) do
        if not MapPinEnhanced:IsReadableTable(objective) then return nil end
        local required = objective.numRequired
        if not MapPinEnhanced:IsReadableNumber(required) or required < 0 or
            required > 1 or required % 1 ~= 0 then
            return nil
        end
        -- Completed objectives still classify the quest, including higher counts.
        maximumRequired = math.max(maximumRequired, required)
    end
    return maximumRequired == 1 and OBJECTIVE_DIRECTION_DISTANCE or nil
end

---@param questID number
---@param inside boolean?
---@return string? atlas
---@return boolean? active nil when membership or unfinished readiness is unavailable
---@return boolean? ready
---@return number? directionDistance
function Providers:ReadQuestState(questID, inside)
    local ready = C_QuestLog.ReadyForTurnIn and C_QuestLog.ReadyForTurnIn(questID)
    if not issecretvalue(inside) and inside == nil and C_Minimap and C_Minimap.IsInsideQuestBlob then
        inside = C_Minimap.IsInsideQuestBlob(questID)
    end
    local active ---@type boolean?
    if not issecretvalue(inside) and type(inside) == "boolean" and
        not issecretvalue(ready) and ready == false then
        active = inside
    end
    return GetQuestAtlas(questID, ready), active, ready,
        active == true and GetObjectiveDirectionDistance(questID) or nil
end

---@return string
local function GetQuestTargetID()
    local questID = C_SuperTrack.GetSuperTrackedQuestID()
    if questID == 0 then questID = nil end
    return string.format("quest:%s", tostring(questID))
end

---@param questID number
---@param questTitle string
---@param ready boolean?
---@return string? description
---@return boolean available
local function GetQuestDescription(questID, questTitle, ready)
    if issecretvalue(ready) then return nil, false end
    if ready then
        local index = C_QuestLog.GetLogIndexForQuestID(questID)
        local text = index and GetQuestLogCompletionText(index)
        if issecretvalue(text) then return nil, false end
        return Providers:PlainDescription(text, questTitle) or string.format(L["Turn in: %s"], questTitle), true
    end
    local objectives = C_QuestLog.GetQuestObjectives(questID)
    if not objectives then return nil, false end
    ---@type string[]
    local lines = {}
    -- Blizzard owns localized counters. Keep unfinished objectives in quest-log
    -- order and preserve their line breaks through the existing description path.
    for _, objective in ipairs(objectives) do
        if issecretvalue(objective.text) or issecretvalue(objective.finished) then return nil, false end
        local text = Providers:PlainDescription(objective.text, questTitle)
        if text and not objective.finished then lines[#lines + 1] = text end
    end
    if #lines > 0 then return table.concat(lines, "\n"), true end
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

---@param previous WayfinderData?
---@return WayfinderData?
---@return boolean? removable
---@return boolean? textAvailable
local function ReadQuest(previous)
    local questID = C_SuperTrack.GetSuperTrackedQuestID()
    if questID == 0 then questID = nil end
    local atlas, active, ready, directionDistance ---@type string?, boolean?, boolean?, number?
    if questID then
        atlas, active, ready, directionDistance = Providers:ReadQuestState(questID)
    end
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
    end or nil, questMapID, questID and function() return C_QuestLog.GetNextWaypoint(questID) end or nil)
    if questID == nil or x == nil or y == nil or mapID == nil then
        return
    end
    local titleAvailable = Providers:PlainDescription(questTitle) ~= nil
    local superTrackedName = C_SuperTrack.GetSuperTrackedItemName()
    questTitle = Providers:PlainDescription(questTitle) or Providers:PlainDescription(superTrackedName) or L["Quest"]
    local description, textAvailable = GetQuestDescription(questID, questTitle, ready)
    return {
        mapID = mapID,
        x = x,
        y = y,
        title = questTitle,
        description = description,
        texture = atlas or previous and previous.texture or "Navigation-Tracked-Icon",
        usesAtlas = true,
    }, false, titleAvailable and textAvailable
end

local function OnQuestProgress()
    Wayfinders:RefreshSuperTrackingProvider(SOURCE)
end

---@param targetID string
---@param data WayfinderData
---@return string?, string?, boolean?
local function ReadQuestText(targetID, data)
    local questID = tonumber(targetID:match("^quest:(%d+)$"))
    if not questID then return end
    local atlas, active, ready, directionDistance = Providers:ReadQuestState(questID)
    local title = Providers:PlainDescription(C_QuestLog.GetTitleForQuestID(questID)) or
        Providers:PlainDescription(C_TaskQuest.GetQuestInfoByQuestID(questID))
    if not title then return end
    local description, available = GetQuestDescription(questID, title, ready)
    return title, description, available
end

---@param questID number
---@param success boolean
local function OnQuestDataLoadResult(questID, success)
    if not pendingQuestTitles[questID] then return end
    pendingQuestTitles[questID] = nil
    if success then
        OnQuestProgress()
    end
end

Wayfinders:RegisterSuperTrackingProvider({
    source = SOURCE,
    superTrackingType = SUPER_TRACKING_TYPE,
    getTargetID = GetQuestTargetID,
    read = ReadQuest,
    events = { "QUEST_POI_UPDATE", "QUEST_LOG_UPDATE", "QUEST_WATCH_UPDATE" },
    readText = ReadQuestText,
})
MapPinEnhanced:RegisterEvent("QUEST_DATA_LOAD_RESULT", OnQuestDataLoadResult)
