---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Pins = MapPinEnhanced:GetModule("Pins")
local Notifications = MapPinEnhanced:GetModule("Notifications")

---@type UiMapPoint?
local placedUserWaypoint = nil
---@type UUID?
local trackedPinID = nil
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
    }
end


local oldPinId = nil
---@param title string
local function onPinTitleUpdated(_, title)
    Wayfinders:OverrideWayfinderTitle(title)
end

---@param color PinColor
local function onPinColorUpdated(_, color)
    Wayfinders:OverrideWayfinderColor(color)
end

---@param texture string
---@param usesAtlas boolean
local function onPinIconUpdated(_, texture, usesAtlas)
    Wayfinders:OverrideWayfinderTexture(texture, usesAtlas)
end

local function SetupPinCallbacks(pinId)
    if oldPinId and oldPinId ~= pinId then
        MapPinEnhanced:UnregisterCallback("PIN_UPDATED_TITLE", onPinTitleUpdated, oldPinId)
        MapPinEnhanced:UnregisterCallback("PIN_UPDATED_COLOR", onPinColorUpdated, oldPinId)
        MapPinEnhanced:UnregisterCallback("PIN_UPDATED_ICON", onPinIconUpdated, oldPinId)
    end

    MapPinEnhanced:RegisterCallback("PIN_UPDATED_TITLE", onPinTitleUpdated, pinId)
    MapPinEnhanced:RegisterCallback("PIN_UPDATED_COLOR", onPinColorUpdated, pinId)
    MapPinEnhanced:RegisterCallback("PIN_UPDATED_ICON", onPinIconUpdated, pinId)
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
        Wayfinders:SetWayfinderData(wayfinderData)
        SetupPinCallbacks(pinID)
        oldPinId = pinID
    elseif pinID == trackedPinID and not isTracked then
        trackedPinID = nil
        ClearTrackedPinUserWaypoint()
        Wayfinders:ClearWayfinderData()
    end
end

MapPinEnhanced:OnLoad(function()
    MapPinEnhanced:RegisterCallback("PIN_TRACKING_CHANGED", onPinTrackingChanged)
    local trackedPin = Pins:GetTrackedPin()
    if not trackedPin then return end
    onPinTrackingChanged("PIN_TRACKING_CHANGED", trackedPin.pinID, trackedPin:IsTracked())
end)

MapPinEnhanced:RegisterEvent("USER_WAYPOINT_UPDATED", OnUserWaypointUpdated)
