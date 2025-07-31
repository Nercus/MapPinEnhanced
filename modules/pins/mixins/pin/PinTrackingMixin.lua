---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinTrackingMixin = {}

local Tracking = MapPinEnhanced:GetModule("Tracking")
local Distance = MapPinEnhanced:GetModule("Distance")

function MapPinEnhancedPinTrackingMixin:Track()
    Tracking:UntrackTrackedPin() -- untrack any previously tracked pin
    self:SetBlizzardWaypoint()
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
        C_Map.ClearUserWaypoint()
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

function MapPinEnhancedPinTrackingMixin:SetBlizzardWaypoint()
    local x, y, mapID = self.pinData.x, self.pinData.y, self.pinData.mapID
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
