---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinTrackingMixin = {}

local Distance = MapPinEnhanced:GetModule("Distance")
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

function MapPinEnhancedPinTrackingMixin:Track()
    if Wayfinders.trackedPin and Wayfinders.trackedPin ~= self then
        Wayfinders.trackedPin:Untrack()
    end

    self.worldmapPin:SetTracked()
    self.minimapPin:SetTracked()

    self.isTracked = true
    self:PersistPin()

    Wayfinders:SetTrackedPin(self)

    MapPinEnhanced:FireCallback("PIN_UPDATED_TRACKING", self.pinID, true)
end

function MapPinEnhancedPinTrackingMixin:Untrack()
    self.worldmapPin:SetUntracked()
    self.minimapPin:SetUntracked()

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
