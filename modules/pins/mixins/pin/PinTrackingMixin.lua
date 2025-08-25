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
    self.supertrackedPin:SetTracked()
    self.supertrackedPin:Show()
    if self.trackerEntry then
        self.trackerEntry:SetTracked()
    end
    self.isTracked = true
    Tracking:SetTrackedPin(self)
    self:PersistPin()

    Distance:EnableDistanceCheck(self.pinData.mapID, self.pinData.x, self.pinData.y, function(distance, timeToTarget)
        if not self:IsTracked() then return end
        if distance < 0 then distance = 0 end
        if timeToTarget < 0 then timeToTarget = 0 end

        self.supertrackedPin:UpdateTimeText(timeToTarget)
        if distance < 100 then
            self.supertrackedPin:SetStyle("grounded")
        else
            self.supertrackedPin:SetStyle("beacon")
        end
    end)
end

function MapPinEnhancedPinTrackingMixin:Untrack()
    self.worldmapPin:SetUntracked()
    self.minimapPin:SetUntracked()
    self.supertrackedPin:SetUntracked()
    self.supertrackedPin:Hide()
    if self.trackerEntry then
        self.trackerEntry:SetUntracked()
    end
    if self:IsTracked() then
        self:ClearLocation()
        Tracking:SetTrackedPin(nil)
    end
    self.isTracked = false
    self:PersistPin()

    Distance:DisableDistanceCheck(self.pinData.mapID, self.pinData.x, self.pinData.y)
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
    local x, y, mapID, pinType, typeID = self.pinData.x, self.pinData.y, self.pinData.mapID, self.pinData.pinType,
        self.pinData.typeID

    if pinType and typeID then
        self:SetBlizzardMapPin(pinType, typeID)
    else
        self:SetUserWaypoint(x, y, mapID)
    end
end

function MapPinEnhancedPinTrackingMixin:ClearLocation()
    local pinType, typeID = self.pinData.pinType, self.pinData.typeID

    if pinType and typeID then
        C_SuperTrack.ClearSuperTrackedMapPin()
    else
        if C_Map.HasUserWaypoint() then
            C_Map.ClearUserWaypoint()
        end
        C_SuperTrack.ClearAllSuperTracked()
    end
end
