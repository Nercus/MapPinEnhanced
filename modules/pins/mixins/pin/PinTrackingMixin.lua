---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinTrackingMixin = {}

local Tracking = MapPinEnhanced:GetModule("Tracking")
local Distance = MapPinEnhanced:GetModule("Distance")

function MapPinEnhancedPinTrackingMixin:Track()
    Tracking:UntrackTrackedPin() -- untrack any previously tracked pin
    self:SuperTrackLocation()
    self.worldmapPin:SetTracked()
    self.minimapPin:SetTracked()

    self.isTracked = true
    Tracking:SetTrackedPin(self)
    self:PersistPin()

    MapPinEnhanced:FireCallback("PIN_UPDATED_TRACKING", self.pinID, true)
end

function MapPinEnhancedPinTrackingMixin:Untrack()
    self.worldmapPin:SetUntracked()
    self.minimapPin:SetUntracked()
    if self:IsTracked() then
        self:ClearLocation()
        Tracking:SetTrackedPin(nil)
    end

    self.isTracked = false
    self:PersistPin()

    Distance:DisableDistanceCheck(self.pinData.mapID, self.pinData.x, self.pinData.y)
    MapPinEnhanced:FireCallback("PIN_UPDATED_TRACKING", self.pinID, false)
end

function MapPinEnhancedPinTrackingMixin:ToggleTracked()
    if self:IsTracked() then
        self:Untrack()
    else
        self:Track()
    end
end

function MapPinEnhancedPinTrackingMixin:IsTracked()
    return self.isTracked
end

---@param x number
---@param y number
---@param mapID number
function MapPinEnhancedPinTrackingMixin:SetUserWaypoint(x, y, mapID)
    if not C_Map.CanSetUserWaypointOnMap(mapID) then
        local mapInfo = C_Map.GetMapInfo(mapID)
        MapPinEnhanced:Print("Cannot set waypoint on " .. mapInfo.name)
        return
    end

    local hasUserWaypoint = C_Map.HasUserWaypoint()
    if hasUserWaypoint then
        C_Map.ClearUserWaypoint()
    end

    if x < 0 then
        x = 0
    end
    if y < 0 then
        y = 0
    end

    local uiMapPoint = UiMapPoint.CreateFromCoordinates(mapID, x, y, 0)
    C_Map.SetUserWaypoint(uiMapPoint)
    C_SuperTrack.ClearAllSuperTracked()
    C_Timer.After(0.1, function()
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
    end)
end

---@param pinType Enum.SuperTrackingMapPinType
---@param typeID number
function MapPinEnhancedPinTrackingMixin:SetBlizzardMapPin(pinType, typeID)
    C_SuperTrack.SetSuperTrackedMapPin(pinType, typeID)
end

function MapPinEnhancedPinTrackingMixin:SuperTrackLocation()
    local x, y, mapID = self.pinData.x, self.pinData.y, self.pinData.mapID
    self:SetUserWaypoint(x, y, mapID)
end

function MapPinEnhancedPinTrackingMixin:ClearLocation()
    if C_Map.HasUserWaypoint() then
        C_Map.ClearUserWaypoint()
    end
    C_SuperTrack.ClearAllSuperTracked()
end
