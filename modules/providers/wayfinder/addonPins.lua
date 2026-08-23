---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Pins = MapPinEnhanced:GetModule("Pins")
local Notifications = MapPinEnhanced:GetModule("Notifications")
local Providers = MapPinEnhanced:GetModule("Providers")
local TARGET_OWNER = "addonPins"

---@type UiMapPoint?
local placedUserWaypoint = nil
---@type UUID?
local trackedPinID = nil
---@type integer?
local trackedTargetRevision = nil
local shouldSuperTrackUserWaypoint = false
local superTrackedReachedBehaviorOverridden = false

local function OverrideSuperTrackedReachedBehavior()
    if superTrackedReachedBehaviorOverridden then return end
    superTrackedReachedBehaviorOverridden = true

    ---@type function | nil
    local unregisterNavigationReachedEvent

    unregisterNavigationReachedEvent = function()
        if SuperTrackedFrame then
            SuperTrackedFrame:UnregisterEvent("NAVIGATION_DESTINATION_REACHED")
        end
        MapPinEnhanced:UnregisterEventForFunction("NAVIGATION_FRAME_CREATED", unregisterNavigationReachedEvent)
    end

    if SuperTrackedFrame then
        SuperTrackedFrame:UnregisterEvent("NAVIGATION_DESTINATION_REACHED")
    else
        MapPinEnhanced:RegisterEvent("NAVIGATION_FRAME_CREATED", unregisterNavigationReachedEvent)
    end
end

---@param wayfinderData WayfinderData
local function SetTrackedPinUserWaypoint(wayfinderData)
    local mapID, x, y = wayfinderData.mapID, wayfinderData.x, wayfinderData.y
    if not mapID or not x or not y then return end

    if not C_Map.CanSetUserWaypointOnMap(mapID) then
        local mapInfo = C_Map.GetMapInfo(mapID)
        Notifications:ShowNotification("MAP_UNAVAILABLE", (mapInfo and mapInfo.name or tostring(mapID)))
        return
    end

    x = math.max(0, math.min(1, x))
    y = math.max(0, math.min(1, y))

    placedUserWaypoint = UiMapPoint.CreateFromCoordinates(mapID, x, y, 0)
    shouldSuperTrackUserWaypoint = true
    OverrideSuperTrackedReachedBehavior()
    C_Map.SetUserWaypoint(placedUserWaypoint)
end


local coordinateTolerance = 0.0001
local function ClearTrackedPinUserWaypoint()
    shouldSuperTrackUserWaypoint = false
    local currentUserWaypoint = C_Map.GetUserWaypoint()

    if currentUserWaypoint and placedUserWaypoint and
        currentUserWaypoint.uiMapID == placedUserWaypoint.uiMapID and
        math.abs(currentUserWaypoint.position.x - placedUserWaypoint.position.x) <= coordinateTolerance and
        math.abs(currentUserWaypoint.position.y - placedUserWaypoint.position.y) <= coordinateTolerance then
        C_Map.ClearUserWaypoint()
    end
    placedUserWaypoint = nil
end

local function OnUserWaypointUpdated()
    if shouldSuperTrackUserWaypoint then
        shouldSuperTrackUserWaypoint = false
        C_Timer.After(0, function()
            if C_Map.HasUserWaypoint() then
                C_SuperTrack.SetSuperTrackedUserWaypoint(true)
            end
        end)
    end
end

---@param pinData pinData
---@return WayfinderData
local function TransformPinDataToWayfinderData(pinData)
    return {
        mapID = pinData.mapID,
        x = pinData.x,
        y = pinData.y,
        title = pinData.title,
        texture = pinData.texture,
        usesAtlas = pinData.usesAtlas,
        color = pinData.color,
        lock = pinData.lock,
        targetType = Wayfinders.TARGET_TYPE_PIN,
    }
end


---@type UUID?
local boundPinID = nil
---@type fun()?
local unsubscribePinCallbacks = nil
local function UpdateTrackedPinTarget()
    if not trackedPinID or not trackedTargetRevision then return end
    local pin = Pins:GetPinByID(trackedPinID)
    if not pin or not pin:IsTracked() then return end

    local revision = Wayfinders:UpdateTarget(TARGET_OWNER, trackedPinID, trackedTargetRevision,
        TransformPinDataToWayfinderData(pin:GetPinData()))
    if revision and Wayfinders:IsTargetActive(TARGET_OWNER, trackedPinID, revision) then
        trackedTargetRevision = revision
    end
end

local function onPinTitleUpdated() UpdateTrackedPinTarget() end
local function onPinColorUpdated() UpdateTrackedPinTarget() end
local function onPinIconUpdated() UpdateTrackedPinTarget() end
local function onPinLockUpdated() UpdateTrackedPinTarget() end

local function ClearPinCallbacks()
    if unsubscribePinCallbacks then
        unsubscribePinCallbacks()
        unsubscribePinCallbacks = nil
    end
    boundPinID = nil
end

---@param pinID UUID
local function SetupPinCallbacks(pinID)
    if boundPinID == pinID then
        return
    end
    if boundPinID then
        ClearPinCallbacks()
    end

    unsubscribePinCallbacks = MapPinEnhanced:RegisterKeyedCallbacks(pinID, {
        PIN_UPDATED_TITLE = onPinTitleUpdated,
        PIN_UPDATED_COLOR = onPinColorUpdated,
        PIN_UPDATED_ICON = onPinIconUpdated,
        PIN_UPDATED_LOCK = onPinLockUpdated,
    })
    boundPinID = pinID
end

---@param pinID UUID
local function RemoveTrackedPin(pinID)
    local pin = Pins:GetPinByID(pinID)
    local group = pin and pin.group
    if group then
        group:MarkPinReached(pinID)
    end
end

---@param eventName "PIN_TRACKING_CHANGED"
---@param pinID UUID
---@param isTracked boolean
local function onPinTrackingChanged(eventName, pinID, isTracked)
    local trackedPin = Pins:GetTrackedPin()
    if trackedPin and trackedPin.pinID == pinID and isTracked then
        local wayfinderData = TransformPinDataToWayfinderData(trackedPin:GetPinData())
        trackedPinID = pinID
        SetTrackedPinUserWaypoint(wayfinderData)
        Providers:CancelPendingSuperTrackingResolutions()
        trackedTargetRevision = nil
        local revision = Wayfinders:SetTarget(TARGET_OWNER, pinID, wayfinderData, function(_, _, _)
            RemoveTrackedPin(pinID)
        end)
        if Wayfinders:IsTargetActive(TARGET_OWNER, pinID, revision) then
            trackedTargetRevision = revision
            SetupPinCallbacks(pinID)
        end
    elseif pinID == trackedPinID and not isTracked then
        ClearPinCallbacks()
        ClearTrackedPinUserWaypoint()
        Wayfinders:ClearTarget(TARGET_OWNER, trackedPinID, trackedTargetRevision)
        trackedPinID = nil
        trackedTargetRevision = nil
    end
end

MapPinEnhanced:OnLoad(function()
    MapPinEnhanced:RegisterCallback("PIN_TRACKING_CHANGED", onPinTrackingChanged)
    local trackedPin = Pins:GetTrackedPin()
    if not trackedPin then return end
    onPinTrackingChanged("PIN_TRACKING_CHANGED", trackedPin.pinID, trackedPin:IsTracked())
end)

MapPinEnhanced:RegisterEvent("USER_WAYPOINT_UPDATED", OnUserWaypointUpdated)
