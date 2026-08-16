---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Options = MapPinEnhanced:GetModule("Options")

---@class PinArrivalConfig
---@field STATIC_RADIUS number
---@field STATIC_CONFIRM_SAMPLES integer
---@field DYNAMIC_MIN_RADIUS number
---@field DYNAMIC_MAX_RADIUS number

---@class Pins
---@field ARRIVAL_CONFIG PinArrivalConfig
---@field arrivalTrackedPinID UUID?
---@field arrivalStaticSamples integer
---@field arrivalDynamicSamples integer
local Pins = MapPinEnhanced:GetModule("Pins")

-- Arrival detection tuning. Distances and speeds are in yards / yards per second.
-- Keep these values together so the detector can be tuned from in-game testing.
Pins.ARRIVAL_CONFIG = {
    -- Static mode: 10 metres converted to yards.
    STATIC_RADIUS = 10.9361,
    STATIC_CONFIRM_SAMPLES = 2,

    -- Dynamic mode adds the distance likely to be travelled before the next
    -- navigation sample to this minimum positional tolerance.
    DYNAMIC_MIN_RADIUS = 3,
    DYNAMIC_MAX_RADIUS = 50,
}

local max = math.max
local min = math.min

---@param closingSpeed number
---@param nextUpdateInterval number
---@param movementState DistanceMovementState
---@return number?
local function GetDynamicArrivalRadius(closingSpeed, nextUpdateInterval, movementState)
    local config = Pins.ARRIVAL_CONFIG
    if movementState == "movingAway" or movementState == "unknown" then return nil end
    if movementState == "stationary" then return config.DYNAMIC_MIN_RADIUS end

    local predictedRadius = config.DYNAMIC_MIN_RADIUS + max(0, closingSpeed) * nextUpdateInterval
    return max(config.DYNAMIC_MIN_RADIUS, min(config.DYNAMIC_MAX_RADIUS, predictedRadius))
end

---@param pinID UUID?
function Pins:ResetArrivalDetection(pinID)
    self.arrivalTrackedPinID = pinID
    self.arrivalStaticSamples = 0
    self.arrivalDynamicSamples = 0
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
---@param movementState DistanceMovementState
function Pins:UpdateStaticArrival(pin, distance, movementState)
    if movementState == "unknown" then
        self.arrivalStaticSamples = 0
    end

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
---@param closingSpeed number
---@param nextUpdateInterval number
---@param movementState DistanceMovementState
function Pins:UpdateDynamicArrival(pin, distance, closingSpeed, nextUpdateInterval, movementState)
    if movementState == "unknown" then
        self.arrivalDynamicSamples = 1
        return
    end

    self.arrivalDynamicSamples = self.arrivalDynamicSamples + 1
    if self.arrivalDynamicSamples < 2 then return end

    local arrivalRadius = GetDynamicArrivalRadius(closingSpeed, nextUpdateInterval, movementState)
    if arrivalRadius and distance <= arrivalRadius then
        self:CompleteArrivedPin(pin)
    end
end

---@param distance number
---@param _ number
---@param closingSpeed number
---@param nextUpdateInterval number
---@param movementState DistanceMovementState
local function OnDistanceUpdate(distance, _, closingSpeed, nextUpdateInterval, movementState)
    local pin = Pins:GetTrackedPin()
    if not pin or not pin:IsTracked() or pin:IsLocked() then
        if Pins.arrivalTrackedPinID then Pins:ResetArrivalDetection(nil) end
        return
    end

    if Pins.arrivalTrackedPinID ~= pin.pinID then
        Pins:ResetArrivalDetection(pin.pinID)
    end

    ---@type PinArrivalMode
    local mode = Options:GetOptionValue("General.Tracking.ArrivalMode")
    if mode == Options.ARRIVAL_MODE_STATIC then
        Pins:UpdateStaticArrival(pin, distance, movementState)
    else
        Pins:UpdateDynamicArrival(pin, distance, closingSpeed, nextUpdateInterval, movementState)
    end
end

MapPinEnhanced:RegisterContinuousDistanceSampleCallback(OnDistanceUpdate)

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
