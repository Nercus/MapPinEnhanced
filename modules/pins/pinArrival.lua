---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Options = MapPinEnhanced:GetModule("Options")

---@class PinArrivalConfig
---@field SAMPLE_INTERVAL number
---@field STATIC_RADIUS number
---@field STATIC_CONFIRM_SAMPLES integer
---@field DYNAMIC_ARM_RADIUS number
---@field DYNAMIC_STOP_RADIUS number
---@field DYNAMIC_STOP_MAX_SPEED number
---@field DYNAMIC_STOP_DWELL_TIME number
---@field DYNAMIC_PASS_RADIUS number
---@field DYNAMIC_PASS_HYSTERESIS number

---@class Pins
---@field ARRIVAL_CONFIG PinArrivalConfig
---@field arrivalTrackedPinID UUID?
---@field arrivalMinimumDistance number?
---@field arrivalStoppedTime number
---@field arrivalStaticSamples integer
local Pins = MapPinEnhanced:GetModule("Pins")

-- Arrival detection tuning. Distances and speeds are in yards / yards per second.
-- Keep these values together so the detector can be tuned from in-game testing.
Pins.ARRIVAL_CONFIG = {
    SAMPLE_INTERVAL = 0.10,

    -- Static mode: 10 metres converted to yards.
    STATIC_RADIUS = 10.9361,
    STATIC_CONFIRM_SAMPLES = 2,

    -- Dynamic mode starts collecting approach history inside this radius.
    DYNAMIC_ARM_RADIUS = 50,

    -- A stopped player must be very close and remain there for this long.
    DYNAMIC_STOP_RADIUS = 7,
    DYNAMIC_STOP_MAX_SPEED = 0.75,
    DYNAMIC_STOP_DWELL_TIME = 1.50,

    -- A moving player must come within this radius, then move far enough away
    -- from their closest sample to confirm that the pin was passed.
    DYNAMIC_PASS_RADIUS = 10,
    DYNAMIC_PASS_HYSTERESIS = 3,
}

local frame = CreateFrame("Frame")
---@type number
local elapsedSinceSample = 0

---@param pinID UUID?
function Pins:ResetArrivalDetection(pinID)
    self.arrivalTrackedPinID = pinID
    self.arrivalMinimumDistance = nil
    self.arrivalStoppedTime = 0
    self.arrivalStaticSamples = 0
    elapsedSinceSample = 0
end

---@param pin MapPinEnhancedPinMixin
function Pins:CompleteArrivedPin(pin)
    local group = pin.group
    if not group then return end

    local pinID = pin.pinID
    self:ResetArrivalDetection(nil)
    group:MarkPinReached(pinID)
end

---@param pin MapPinEnhancedPinMixin
---@param distance number
function Pins:UpdateStaticArrival(pin, distance)
    local config = self.ARRIVAL_CONFIG
    if distance <= config.STATIC_RADIUS then
        self.arrivalStaticSamples = self.arrivalStaticSamples + 1
    else
        self.arrivalStaticSamples = 0
    end

    if self.arrivalStaticSamples >= config.STATIC_CONFIRM_SAMPLES then
        self:CompleteArrivedPin(pin)
    end
end

---@param pin MapPinEnhancedPinMixin
---@param distance number
---@param elapsed number
function Pins:UpdateDynamicArrival(pin, distance, elapsed)
    local config = self.ARRIVAL_CONFIG
    if distance > config.DYNAMIC_ARM_RADIUS then
        self.arrivalMinimumDistance = nil
        self.arrivalStoppedTime = 0
        return
    end

    local minimumDistance = math.min(self.arrivalMinimumDistance or distance, distance)
    self.arrivalMinimumDistance = minimumDistance

    local speed = GetUnitSpeed("player") or 0
    if distance <= config.DYNAMIC_STOP_RADIUS and speed <= config.DYNAMIC_STOP_MAX_SPEED then
        self.arrivalStoppedTime = self.arrivalStoppedTime + elapsed
        if self.arrivalStoppedTime >= config.DYNAMIC_STOP_DWELL_TIME then
            self:CompleteArrivedPin(pin)
        end
        return
    end

    self.arrivalStoppedTime = 0
    if minimumDistance <= config.DYNAMIC_PASS_RADIUS and
        distance >= minimumDistance + config.DYNAMIC_PASS_HYSTERESIS then
        self:CompleteArrivedPin(pin)
    end
end

---@return nil
function Pins:SampleTrackedPinArrival()
    local pin = self:GetTrackedPin()
    if not pin or not pin:IsTracked() or pin:IsLocked() then
        if self.arrivalTrackedPinID then self:ResetArrivalDetection(nil) end
        return
    end

    if self.arrivalTrackedPinID ~= pin.pinID then
        self:ResetArrivalDetection(pin.pinID)
    end

    local data = pin:GetPinData()
    if not data or not data.mapID or not data.x or not data.y then return end

    local distance = MapPinEnhanced:GetDistanceToTarget(data.mapID, data.x, data.y)
    if not distance or distance <= 0 then return end
    ---@type PinArrivalMode
    local mode = Options:GetOptionValue("General.Tracking.ArrivalMode")
    if mode == Options.ARRIVAL_MODE_STATIC then
        self:UpdateStaticArrival(pin, distance)
    else
        self:UpdateDynamicArrival(pin, distance, self.ARRIVAL_CONFIG.SAMPLE_INTERVAL)
    end
end

---@param _ Frame
---@param elapsed number
local function OnUpdate(_, elapsed)
    elapsedSinceSample = elapsedSinceSample + elapsed
    if elapsedSinceSample < Pins.ARRIVAL_CONFIG.SAMPLE_INTERVAL then return end
    elapsedSinceSample = elapsedSinceSample - Pins.ARRIVAL_CONFIG.SAMPLE_INTERVAL
    Pins:SampleTrackedPinArrival()
end

frame:SetScript("OnUpdate", OnUpdate)

---@param _ string
---@param pinID UUID
---@param isTracked boolean
local function OnPinTrackingChanged(_, pinID, isTracked)
    Pins:ResetArrivalDetection(isTracked and pinID or nil)
end

MapPinEnhanced:RegisterCallback("PIN_TRACKING_CHANGED", OnPinTrackingChanged)

local function OnArrivalModeChanged()
    local trackedPin = Pins:GetTrackedPin()
    Pins:ResetArrivalDetection(trackedPin and trackedPin.pinID or nil)
end

Options:SubscribeToOptionChanges("General.Tracking.ArrivalMode", OnArrivalModeChanged)
