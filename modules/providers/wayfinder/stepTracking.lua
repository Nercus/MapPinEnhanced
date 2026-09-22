---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Pins = MapPinEnhanced:GetModule("Pins")

---@type UiMapPoint?
local stepWaypoint
---@type UiMapPoint?
local stepTarget
---@type UiMapPoint?
local previousWaypoint
---@type fun()?
local restoreTracking
---@type string?
local restoredTrackingIdentity
local changingTracking = false
local restoreReachedEvent = false

---@param mapID number
---@return number?
local function GetParentMapID(mapID)
    local info = C_Map.GetMapInfo(mapID)
    return info and info.parentMapID ~= 0 and info.parentMapID or nil
end

---@param mapID number
---@param x number
---@param y number
---@param candidateMapID number
---@return UiMapPoint?
local function ProjectStepWaypoint(mapID, x, y, candidateMapID)
    if not C_Map.CanSetUserWaypointOnMap(candidateMapID) then return end
    local hbd = MapPinEnhanced.HBD
    local projectedX, projectedY = hbd:TranslateZoneCoordinates(x, y, mapID, candidateMapID)
    if not projectedX or not projectedY or
        not (projectedX >= 0 and projectedX <= 1 and projectedY >= 0 and projectedY <= 1) then return end
    -- A shared map hierarchy alone does not establish compatible world geometry.
    local distance = hbd:GetZoneDistance(mapID, x, y, candidateMapID, projectedX, projectedY)
    if not distance or distance > 5 then return end
    return UiMapPoint.CreateFromCoordinates(candidateMapID, projectedX, projectedY, 0)
end

---@param mapID number
---@param x number
---@param y number
---@return UiMapPoint?
local function CreateStepWaypoint(mapID, x, y)
    local playerMapID = C_Map.GetBestMapForUnit("player")
    if playerMapID and playerMapID ~= mapID then
        local waypoint = ProjectStepWaypoint(mapID, x, y, playerMapID)
        if waypoint then return waypoint end

        ---@type table<number, boolean>
        local targetParents = {}
        local parentMapID = mapID
        while parentMapID and not targetParents[parentMapID] do
            targetParents[parentMapID] = true
            parentMapID = GetParentMapID(parentMapID)
        end
        ---@type table<number, boolean>
        local visited = { [playerMapID] = true }
        parentMapID = GetParentMapID(playerMapID)
        while parentMapID and not visited[parentMapID] do
            visited[parentMapID] = true
            if targetParents[parentMapID] then
                waypoint = ProjectStepWaypoint(mapID, x, y, parentMapID)
                if waypoint then return waypoint end
            end
            parentMapID = GetParentMapID(parentMapID)
        end
    end
    if C_Map.CanSetUserWaypointOnMap(mapID) then
        return UiMapPoint.CreateFromCoordinates(mapID, x, y, 0)
    end
end

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
    stepTarget = nil
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
    if restoreReachedEvent and SuperTrackedFrame and not Pins:GetTrackedPin() then
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

---@param data {mapID: number?, x: number?, y: number?}
---@return boolean usesNavigationFrame
function Providers:SetStepSuperTracking(data)
    local mapID, x, y = data.mapID, data.x, data.y
    local waypoint = mapID and x and y and CreateStepWaypoint(mapID, x, y)
    if not waypoint then
        self:ClearStepSuperTracking()
        return false
    end
    if stepWaypoint and not self:IsStepSuperTracking() then self:ClearStepSuperTracking(false) end
    stepTarget = UiMapPoint.CreateFromCoordinates(mapID, x, y, 0)
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
-- Reproject the owned location when the player crosses maps during one Step.
-- Clearing tracking releases this copy; zone events never reclaim another selection.
local function RefreshStepWaypointMap()
    if changingTracking or not stepTarget or not Providers:IsStepSuperTracking() then return end
    Providers:SetStepSuperTracking({ mapID = stepTarget.uiMapID,
        x = stepTarget.position.x, y = stepTarget.position.y })
end

MapPinEnhanced:RegisterEvent("ZONE_CHANGED", RefreshStepWaypointMap)
MapPinEnhanced:RegisterEvent("ZONE_CHANGED_INDOORS", RefreshStepWaypointMap)
MapPinEnhanced:RegisterEvent("ZONE_CHANGED_NEW_AREA", RefreshStepWaypointMap)
MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", RefreshStepWaypointMap)
MapPinEnhanced:RegisterEvent("PLAYER_LOGOUT", function() Providers:ClearStepSuperTracking() end)
