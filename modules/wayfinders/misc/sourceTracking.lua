---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Providers = MapPinEnhanced:GetModule("Providers")

---@class SuperTrackingControl
---@field captureTracking fun(data: WayfinderData): SuperTrackingRestore?
---@field untrack fun()

---@type table<string, SuperTrackingControl>
local controls = {
    quest = {
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
    },
    mapPin = {
        captureTracking = function(data)
            local pinType, typeID = C_SuperTrack.GetSuperTrackedMapPin()
            local mapID = data.mapID
            if pinType == nil or typeID == nil or not mapID then return nil end
            return function()
                if pinType == Enum.SuperTrackingMapPinType.HousingPlot then
                    if not Providers:GetHousingPlotInfo(typeID) then return false end
                elseif Providers:GetMapPinInfo(pinType, typeID, mapID) == nil then
                    return false
                end
                C_SuperTrack.SetSuperTrackedMapPin(pinType, typeID)
                return true
            end
        end,
        untrack = function() C_SuperTrack.ClearSuperTrackedMapPin() end,
    },
    content = {
        captureTracking = function()
            local trackableType, trackableID = C_SuperTrack.GetSuperTrackedContent()
            if trackableType == nil or trackableID == nil then return nil end
            return function()
                if not C_ContentTracking or not C_ContentTracking.IsTrackable(trackableType, trackableID) then
                    return false
                end
                C_SuperTrack.SetSuperTrackedContent(trackableType, trackableID)
                return true
            end
        end,
        untrack = function() C_SuperTrack.ClearSuperTrackedContent() end,
    },
    vignette = {
        captureTracking = function()
            local guid = C_SuperTrack.GetSuperTrackedVignette()
            if not guid then return nil end
            return function()
                if not C_VignetteInfo.GetVignetteInfo(guid) then return false end
                C_SuperTrack.SetSuperTrackedVignette(guid)
                return true
            end
        end,
        -- Retail exposes no vignette-specific clear operation.
        untrack = function() C_SuperTrack.ClearAllSuperTracked() end,
    },
}

---@param source string
---@param data WayfinderData
---@return SuperTrackingRestore?
---@return fun()?
function Wayfinders:CaptureSourceTracking(source, data)
    local control = controls[source]
    if not control then return end
    return control.captureTracking(data), control.untrack
end

---@param source string
---@param targetID string
---@param changeNumber integer
function Wayfinders:RemoveSuperTrackingDestination(source, targetID, changeNumber)
    if not self:ClearSuperTrackingWayfinderData(source, targetID, changeNumber) then return end
    local control = controls[source]
    if control then control.untrack() end
end

-- Stage identity is independent of Blizzard's temporary UserWaypoint selection.
-- Replacing a stage is a destination change, not a text refresh for the old route.
MapPinEnhanced:RegisterEvent("SCENARIO_UPDATE", function()
    if Wayfinders:IsChangingSuperTrackingEntry() then return end
    local Navigation = MapPinEnhanced:GetModule("Navigation")
    local scenario = C_ScenarioInfo.GetScenarioInfo()
    local step = C_ScenarioInfo.GetScenarioStepInfo()
    local owner, targetID = Navigation:GetActiveDestinationState()
    if scenario and step and owner == "scenario" and Wayfinders:IsStepSuperTracking() and
        targetID ~= Providers:GetScenarioTargetID(scenario, step) then
        Wayfinders:ClearStepSuperTracking()
    end
    Wayfinders:RefreshSuperTrackingProvider("scenario")
end)
