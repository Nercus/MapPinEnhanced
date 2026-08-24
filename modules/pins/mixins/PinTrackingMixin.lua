---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinTrackingMixin = {}

local Pins = MapPinEnhanced:GetModule("Pins")

---@param pin MapPinEnhancedPinMixin
---@param persist boolean
local function Track(pin, persist)
    local trackedPin = Pins:GetTrackedPin()
    if trackedPin and trackedPin ~= pin then
        if not persist and trackedPin.group == pin.group then
            trackedPin:UntrackWithoutPersisting()
        else
            trackedPin:Untrack()
        end
    end

    pin.worldmapPin:SetTracked()
    pin.minimapPin:SetTracked()

    pin.isTracked = true
    if persist then pin:PersistPin() end

    Pins:SetTrackedPin(pin)
    if pin.group then
        pin.group:SetTrackingCursorPin(pin)
    end

    MapPinEnhanced:FireCallback("PIN_UPDATED_TRACKING", pin.pinID, true)
    MapPinEnhanced:FireCallback("PIN_TRACKING_CHANGED", nil, pin.pinID, true)
end

function MapPinEnhancedPinTrackingMixin:Track()
    Track(self, true)
end

-- The group already requested a save, so do not request another one here.
function MapPinEnhancedPinTrackingMixin:TrackWithoutPersisting()
    Track(self, false)
end

---@param pin MapPinEnhancedPinMixin
---@param persist boolean
local function Untrack(pin, persist)
    local trackedPin = Pins:GetTrackedPin()
    if trackedPin and trackedPin == pin then
        Pins:SetTrackedPin(nil)
    end

    pin.worldmapPin:SetUntracked()
    pin.minimapPin:SetUntracked()

    pin.isTracked = false
    if persist then pin:PersistPin() end

    MapPinEnhanced:DisableContinuousDistanceCheck(pin.pinData.mapID, pin.pinData.x, pin.pinData.y)

    MapPinEnhanced:FireCallback("PIN_UPDATED_TRACKING", pin.pinID, false)
    MapPinEnhanced:FireCallback("PIN_TRACKING_CHANGED", nil, pin.pinID, false)
end

function MapPinEnhancedPinTrackingMixin:Untrack()
    Untrack(self, true)
end

-- The group already requested a save, so do not request another one here.
function MapPinEnhancedPinTrackingMixin:UntrackWithoutPersisting()
    Untrack(self, false)
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
