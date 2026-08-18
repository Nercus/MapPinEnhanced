---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Options = MapPinEnhanced:GetModule("Options")

---@class WayfinderArrivalConfig
---@field STATIC_RADIUS number
---@field STATIC_CONFIRM_SAMPLES integer
---@field DYNAMIC_MIN_RADIUS number
---@field DYNAMIC_MAX_RADIUS number

---@class Wayfinders
---@field ARRIVAL_CONFIG WayfinderArrivalConfig
---@field arrivalStaticSamples integer
---@field arrivalDynamicSamples integer
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

-- Arrival detection tuning. Distances and speeds are in yards / yards per second.
-- Keep these values together so the detector can be tuned from in-game testing.
Wayfinders.ARRIVAL_CONFIG = {
    STATIC_RADIUS = 10,
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
    local config = Wayfinders.ARRIVAL_CONFIG
    if movementState == "movingAway" or movementState == "unknown" then return nil end
    if movementState == "stationary" then return config.DYNAMIC_MIN_RADIUS end

    local predictedRadius = config.DYNAMIC_MIN_RADIUS + max(0, closingSpeed) * nextUpdateInterval
    return max(config.DYNAMIC_MIN_RADIUS, min(config.DYNAMIC_MAX_RADIUS, predictedRadius))
end

function Wayfinders:ResetArrivalDetection()
    self.arrivalStaticSamples = 0
    self.arrivalDynamicSamples = 0
end

function Wayfinders:CompleteArrival()
    local removeTarget = self.removeTarget
    if not removeTarget then return end

    self.removeTarget = nil
    self:ResetArrivalDetection()
    removeTarget()
end

---@param distance number
---@param movementState DistanceMovementState
function Wayfinders:UpdateStaticArrival(distance, movementState)
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
        self:CompleteArrival()
    end
end

---@param distance number
---@param closingSpeed number
---@param nextUpdateInterval number
---@param movementState DistanceMovementState
function Wayfinders:UpdateDynamicArrival(distance, closingSpeed, nextUpdateInterval, movementState)
    if movementState == "unknown" then
        self.arrivalDynamicSamples = 1
        return
    end

    self.arrivalDynamicSamples = self.arrivalDynamicSamples + 1
    if self.arrivalDynamicSamples < 2 then return end

    local arrivalRadius = GetDynamicArrivalRadius(closingSpeed, nextUpdateInterval, movementState)
    if arrivalRadius and distance <= arrivalRadius then
        self:CompleteArrival()
    end
end

---@param distance number
---@param closingSpeed number
---@param nextUpdateInterval number
---@param movementState DistanceMovementState
function Wayfinders:ProcessArrivalSample(distance, closingSpeed, nextUpdateInterval, movementState)
    local data = self.cachedData
    if not data or data.lock or not self.removeTarget then
        self:ResetArrivalDetection()
        return
    end

    ---@type PinArrivalMode
    local mode = Options:GetOptionValue("General.Tracking.ArrivalMode")
    if mode == Options.ARRIVAL_MODE_STATIC then
        self:UpdateStaticArrival(distance, movementState)
    else
        self:UpdateDynamicArrival(distance, closingSpeed, nextUpdateInterval, movementState)
    end
end

---@param distance number
---@param _ number
---@param closingSpeed number
---@param nextUpdateInterval number
---@param movementState DistanceMovementState
local function OnDistanceUpdate(distance, _, closingSpeed, nextUpdateInterval, movementState)
    Wayfinders:ProcessArrivalSample(distance, closingSpeed, nextUpdateInterval, movementState)
end

MapPinEnhanced:RegisterContinuousDistanceSampleCallback(OnDistanceUpdate)

local function OnArrivalModeChanged()
    Wayfinders:ResetArrivalDetection()
end

Options:SubscribeToOptionChanges("General.Tracking.ArrivalMode", OnArrivalModeChanged)
