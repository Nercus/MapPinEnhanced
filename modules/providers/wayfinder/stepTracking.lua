---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Pins = MapPinEnhanced:GetModule("Pins")

---@type UiMapPoint?
local stepWaypoint
---@type UiMapPoint?
local previousWaypoint
---@type fun()?
local restoreTracking
---@type string?
local restoredTrackingIdentity
local changingTracking = false
local restoreReachedEvent = false

---@param left UiMapPoint?
---@param right UiMapPoint?
---@return boolean
local function WaypointsMatch(left, right)
    if not left or not right then return left == right end
    return left.uiMapID == right.uiMapID and
        math.abs(left.position.x - right.position.x) <= 0.0001 and
        math.abs(left.position.y - right.position.y) <= 0.0001
end

---@return string
local function GetTrackingIdentity()
    local trackingType = C_SuperTrack.GetHighestPrioritySuperTrackingType()
    local pinType, pinID = C_SuperTrack.GetSuperTrackedMapPin()
    local contentType, contentID = C_SuperTrack.GetSuperTrackedContent()
    local waypoint = C_Map.GetUserWaypoint()
    return table.concat({ tostring(trackingType), tostring(C_SuperTrack.GetSuperTrackedQuestID()),
        tostring(pinType), tostring(pinID), tostring(contentType), tostring(contentID),
        tostring(C_SuperTrack.GetSuperTrackedVignette()), tostring(waypoint and waypoint.uiMapID),
        tostring(waypoint and waypoint.position.x), tostring(waypoint and waypoint.position.y) }, ":")
end

---@return fun()
local function CaptureTrackingRestore()
    -- Addon pins select their waypoint on the next frame. A fast calculation
    -- can publish its first step before that pending selection has run.
    if Pins:GetTrackedPin() then
        return function() C_SuperTrack.SetSuperTrackedUserWaypoint(true) end
    end
    local trackingType = C_SuperTrack.GetHighestPrioritySuperTrackingType()
    if trackingType == Enum.SuperTrackingType.Quest then
        local questID = C_SuperTrack.GetSuperTrackedQuestID()
        return function() if questID then C_SuperTrack.SetSuperTrackedQuestID(questID) end end
    elseif trackingType == Enum.SuperTrackingType.MapPin then
        local pinType, pinID = C_SuperTrack.GetSuperTrackedMapPin()
        return function() C_SuperTrack.SetSuperTrackedMapPin(pinType, pinID) end
    elseif trackingType == Enum.SuperTrackingType.Content then
        local contentType, contentID = C_SuperTrack.GetSuperTrackedContent()
        return function() C_SuperTrack.SetSuperTrackedContent(contentType, contentID) end
    elseif trackingType == Enum.SuperTrackingType.Vignette then
        local vignetteGUID = C_SuperTrack.GetSuperTrackedVignette()
        return function() if vignetteGUID then C_SuperTrack.SetSuperTrackedVignette(vignetteGUID) end end
    end
    return function()
        C_SuperTrack.SetSuperTrackedUserWaypoint(trackingType == Enum.SuperTrackingType.UserWaypoint)
    end
end

-- Blizzard must not clear a step waypoint on proximity; Navigation owns the
-- interaction/transition evidence and final-destination arrival separately.
local function KeepStepWaypointOnArrival()
    if not stepWaypoint or not SuperTrackedFrame then return end
    if SuperTrackedFrame:IsEventRegistered("NAVIGATION_DESTINATION_REACHED") then
        restoreReachedEvent = true
        SuperTrackedFrame:UnregisterEvent("NAVIGATION_DESTINATION_REACHED")
    end
end

---@return boolean
function Providers:IsStepSuperTracking()
    return changingTracking or stepWaypoint ~= nil and
        C_SuperTrack.IsSuperTrackingUserWaypoint() and WaypointsMatch(stepWaypoint, C_Map.GetUserWaypoint())
end

---@param restore boolean? restore the previous selection unless another selection has taken ownership
function Providers:ClearStepSuperTracking(restore)
    if not stepWaypoint then return end
    local ownsWaypoint = WaypointsMatch(stepWaypoint, C_Map.GetUserWaypoint())
    local ownsTracking = ownsWaypoint and C_SuperTrack.IsSuperTrackingUserWaypoint()
    local waypoint = previousWaypoint
    local applyTracking = restoreTracking
    restoredTrackingIdentity = nil
    stepWaypoint = nil
    previousWaypoint = nil
    restoreTracking = nil
    changingTracking = true
    if restore == false and ownsTracking then
        C_SuperTrack.SetSuperTrackedUserWaypoint(false)
    end
    if ownsWaypoint then
        if waypoint then
            C_Map.SetUserWaypoint(waypoint)
        else
            C_Map.ClearUserWaypoint()
        end
    end
    if restore ~= false and ownsTracking and applyTracking then
        C_SuperTrack.SetSuperTrackedUserWaypoint(false)
        applyTracking()
        -- The path can finish rebuilding after this call. Ignore its common
        -- events until the selection changes; source-specific updates still run.
        restoredTrackingIdentity = GetTrackingIdentity()
    end
    changingTracking = false
    if restoreReachedEvent and SuperTrackedFrame then
        SuperTrackedFrame:RegisterEvent("NAVIGATION_DESTINATION_REACHED")
    end
    restoreReachedEvent = false
end

---@param sourceChanged boolean? refresh the original source after restoration
---@return boolean
function Providers:ShouldIgnoreStepTrackingChange(sourceChanged)
    if self:IsStepSuperTracking() then return true end
    if stepWaypoint then self:ClearStepSuperTracking(false) end
    if not sourceChanged and restoredTrackingIdentity == GetTrackingIdentity() then return true end
    restoredTrackingIdentity = nil
    return false
end

---@param data WayfinderData
---@return boolean usesNavigationFrame
function Providers:SetStepSuperTracking(data)
    local mapID, x, y = data.mapID, data.x, data.y
    if not mapID or not x or not y or not C_Map.CanSetUserWaypointOnMap(mapID) then
        self:ClearStepSuperTracking()
        return false
    end
    local waypoint = UiMapPoint.CreateFromCoordinates(mapID, x, y, 0)
    if stepWaypoint and not self:IsStepSuperTracking() then self:ClearStepSuperTracking(false) end
    if stepWaypoint and WaypointsMatch(stepWaypoint, waypoint) then return true end
    if not stepWaypoint then
        local currentWaypoint = C_Map.GetUserWaypoint()
        previousWaypoint = currentWaypoint and UiMapPoint.CreateFromCoordinates(currentWaypoint.uiMapID,
            currentWaypoint.position.x, currentWaypoint.position.y, 0) or nil
        restoreTracking = CaptureTrackingRestore()
        self:CancelSuperTrackingTargetRetries()
    end
    restoredTrackingIdentity = nil
    stepWaypoint = waypoint
    changingTracking = true
    KeepStepWaypointOnArrival()
    -- Rebuild native guidance even when both adjacent Steps use user waypoints.
    C_SuperTrack.SetSuperTrackedUserWaypoint(false)
    C_Map.SetUserWaypoint(waypoint)
    C_SuperTrack.SetSuperTrackedUserWaypoint(true)
    changingTracking = false
    if self:IsStepSuperTracking() then return true end
    self:ClearStepSuperTracking()
    return false
end

MapPinEnhanced:RegisterEvent("NAVIGATION_FRAME_CREATED", KeepStepWaypointOnArrival)
MapPinEnhanced:RegisterEvent("PLAYER_LOGOUT", function() Providers:ClearStepSuperTracking() end)
