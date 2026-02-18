---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinTrackingMixin = {}

local Distance = MapPinEnhanced:GetModule("Distance")
local Pins = MapPinEnhanced:GetModule("Pins")

function MapPinEnhancedPinTrackingMixin:Track()
    local trackedPin = Pins:GetTrackedPin()
    if trackedPin and trackedPin ~= self then
        trackedPin:Untrack()
    end

    self.worldmapPin:SetTracked()
    self.minimapPin:SetTracked()

    self.isTracked = true
    self:PersistPin()

    Pins:SetTrackedPin(self)

    MapPinEnhanced:FireCallback("PIN_UPDATED_TRACKING", self.pinID, true)
    MapPinEnhanced:FireCallback("PIN_TRACKING_CHANGED", nil, self.pinID, true)
end

function MapPinEnhancedPinTrackingMixin:Untrack()
    local trackedPin = Pins:GetTrackedPin()
    if trackedPin and trackedPin == self then
        Pins:SetTrackedPin(nil)
    end

    self.worldmapPin:SetUntracked()
    self.minimapPin:SetUntracked()

    self.isTracked = false
    self:PersistPin()

    Distance:DisableDistanceCheck(self.pinData.mapID, self.pinData.x, self.pinData.y)

    MapPinEnhanced:FireCallback("PIN_UPDATED_TRACKING", self.pinID, false)
    MapPinEnhanced:FireCallback("PIN_TRACKING_CHANGED", nil, self.pinID, false)
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
