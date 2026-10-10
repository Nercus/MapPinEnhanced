---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Providers = MapPinEnhanced:GetModule("Providers")
local SOURCE = "quest"
local OBJECTIVE_EXIT_GRACE_SECONDS = 3

---@param questID number
---@param atlas string?
---@param active boolean?
---@param directionDistance number?
local function ApplyQuestState(questID, atlas, active, directionDistance)
    if Wayfinders:IsChangingSuperTrackingEntry() then return end
    local owner, targetID, changeNumber = Navigation:GetActiveDestinationState()
    if owner ~= SOURCE or targetID ~= string.format("quest:%s", questID) then return end
    if atlas then
        Navigation:UpdateDestinationIcon(owner, targetID, changeNumber, atlas, true)
        Wayfinders:UpdateSuperTrackingEntryIcon(owner, targetID, atlas, true)
    end
    Navigation:UpdateDestinationAreaState(owner, targetID, changeNumber, active == true,
        active == false and OBJECTIVE_EXIT_GRACE_SECONDS or nil, directionDistance)
end

---@param eventQuestID number?
---@param inside boolean?
function Wayfinders:RefreshQuestState(eventQuestID, inside)
    if Wayfinders:IsChangingSuperTrackingEntry() then return end
    -- The original quest still owns area state during temporary Step supertracking.
    local owner, targetID = Navigation:GetActiveDestinationState()
    if owner ~= SOURCE or not targetID then return end
    local questID = tonumber(targetID:match("^quest:(%d+)$"))
    if not questID or issecretvalue(eventQuestID) or eventQuestID and eventQuestID ~= questID then return end
    local atlas, active, _, directionDistance = Providers:ReadQuestState(questID, inside)
    ApplyQuestState(questID, atlas, active, directionDistance)
end

MapPinEnhanced:RegisterEvent("PLAYER_INSIDE_QUEST_BLOB_STATE_CHANGED", function(questID, inside)
    Wayfinders:RefreshQuestState(questID, inside)
end)
MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    Wayfinders:RefreshSuperTrackingProvider(SOURCE)
end)
