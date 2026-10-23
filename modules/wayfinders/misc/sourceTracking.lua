---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Providers = MapPinEnhanced:GetModule("Providers")
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Pins = MapPinEnhanced:GetModule("Pins")

---@class CorpseTrackingRestore
---@field owner string
---@field targetID string
---@field changeNumber integer
---@field restore SuperTrackingRestore
---@field waypoint UiMapPoint?

---@type CorpseTrackingRestore?
local corpseTrackingRestore
local trackingCorpse = false
local loadingScreen = false

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

function Wayfinders:CancelCorpseTrackingRestore()
    corpseTrackingRestore = nil
end

-- Capture before the corpse replaces the entry or releases an owned Step. The
-- saved command restores source identity; routes are recalculated after revival.
---@param source string?
---@param targetID string?
function Wayfinders:UpdateCorpseTracking(source, targetID)
    if source == "corpse" then
        if trackingCorpse then return end
        trackingCorpse = true
        local owner, destinationID, changeNumber = Navigation:GetActiveDestinationState()
        local restore = self:CaptureSuperTrackingEntryRestore()
        local pin = Pins:GetTrackedPin()
        if pin then
            MapPinEnhanced:GetModule("Groups"):CancelNextPinPrediction()
        end
        self:ClearStepSuperTracking(false)
        if owner and destinationID and restore then
            corpseTrackingRestore = {
                owner = owner,
                targetID = destinationID,
                changeNumber = changeNumber,
                restore = restore,
                waypoint = C_Map.GetUserWaypoint(),
            }
        end
        return
    end
    if not trackingCorpse or loadingScreen or UnitIsDeadOrGhost("player") then return end
    trackingCorpse = false
    local previous = corpseTrackingRestore
    corpseTrackingRestore = nil
    local owner, destinationID, changeNumber = Navigation:GetActiveDestinationState()
    local pin = Pins:GetTrackedPin()
    -- Pins remains the source of current intent, including selection/removal
    -- while dead. Rebuild its adapter without retracking a captured old ID.
    if pin and (owner == "corpse" or owner == "addonPins" and destinationID == pin.pinID) then
        if source or C_SuperTrack.IsSuperTrackingAnything() and
            not C_SuperTrack.IsSuperTrackingUserWaypoint() then
            Pins:UntrackTrackedPin()
        else
            self:ClearStepSuperTracking(false)
            self:RestoreTrackedPinWayfinder()
        end
        return
    end
    if not previous then return end
    if owner ~= "corpse" and not (owner == previous.owner and destinationID == previous.targetID and
        changeNumber == previous.changeNumber) then return end
    -- A corpse route may itself own a temporary waypoint. Release that copy
    -- before restoring; it cannot represent a newer external selection.
    if self:IsStepSuperTracking() then
        self:ClearStepSuperTracking(false)
        previous.restore()
        return
    end
    -- A new native selection wins over the interrupted target, including a
    -- changed user waypoint or Blizzard-owned scenario guidance.
    if source and (source ~= previous.owner or targetID ~= previous.targetID) then return end
    if not source and C_SuperTrack.IsSuperTrackingAnything() then
        if not C_SuperTrack.IsSuperTrackingUserWaypoint() then return end
        local waypoint, old = C_Map.GetUserWaypoint(), previous.waypoint
        if not waypoint or not old or waypoint.uiMapID ~= old.uiMapID or
            waypoint.position.x ~= old.position.x or waypoint.position.y ~= old.position.y then return end
    end
    previous.restore()
end

MapPinEnhanced:RegisterEvent("LOADING_SCREEN_ENABLED", function() loadingScreen = true end)
MapPinEnhanced:RegisterEvent("LOADING_SCREEN_DISABLED", function()
    loadingScreen = false
    Wayfinders:RefreshSuperTrackingSelection()
end)

-- Callers validate the selected source identity before invoking native writes.
---@param source string
function Wayfinders:UntrackSuperTrackingSource(source)
    local control = controls[source]
    if control then control.untrack() end
end

---@param source string
---@param targetID string
---@param changeNumber integer
function Wayfinders:RemoveSuperTrackingDestination(source, targetID, changeNumber)
    if not self:ClearSuperTrackingWayfinderData(source, targetID, changeNumber) then return end
    self:UntrackSuperTrackingSource(source)
end

---Native selection stays with Wayfinders; the provider retains only a read hint.
---@param poiID number
---@param mapID number
---@param texture string|number?
---@param usesAtlas boolean?
---@return boolean
function Wayfinders:TrackAreaPOI(poiID, mapID, texture, usesAtlas)
    if not C_SuperTrack.SetSuperTrackedMapPin or not Providers:ReadLocationAreaPOI(mapID, poiID) then return false end
    -- Abandon any previous Step before establishing the new native source.
    self:CancelAddonPinSelection()
    self:ClearStepSuperTracking(false)
    MapPinEnhanced:GetModule("Pins"):UntrackTrackedPin()
    Providers:SetAreaPOILocationHint(poiID, mapID, texture, usesAtlas)
    C_SuperTrack.SetSuperTrackedMapPin(Enum.SuperTrackingMapPinType.AreaPOI, poiID)
    self:RefreshSuperTrackingProvider("mapPin")
    return true
end
