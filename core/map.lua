---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Options = MapPinEnhanced:GetModule("Options")

---@alias DistanceMovementState "unknown"|"approaching"|"stationary"|"movingAway"
---@alias DistanceSource "navigation"|"map"

local MIN_UPDATE_INTERVAL, MAX_UPDATE_INTERVAL = 0.05, 1.5
local DIRECTION_UPDATE_INTERVAL = 0.5
local DISTANCE_DEAD_ZONE = 0.1
local SPEED_SMOOTHING_WINDOW = 1

---@type number?
local lastDistance = nil
local lastTimeToTarget = -1
---@type number?
local lastSampleTime = nil
local smoothedClosingSpeed = 0
local hasSmoothedClosingSpeed = false
---@type DistanceMovementState
local movementState = "unknown"
---@type DistanceSource?
local distanceSource = nil
---@type number?
local lastNotifiedDistance = nil
---@type number?
local lastNotifiedEta = nil
local elapsedSinceUpdate = 0
local throttleInterval = MIN_UPDATE_INTERVAL

---@type {mapID: number, x: number, y: number} | nil
local target = nil
---@type fun(distance: number, timeToTarget: number, closingSpeed: number, nextUpdateInterval: number, movementState: DistanceMovementState)[]
local onUpdateCallbacks = {}
---@type fun(distance: number, timeToTarget: number, closingSpeed: number, nextUpdateInterval: number, movementState: DistanceMovementState)[]
local onSampleCallbacks = {}
local distanceFrame = CreateFrame("Frame")

local HBD = MapPinEnhanced.HBD
local IsSuperTracking = C_SuperTrack.IsSuperTrackingAnything
local GetNavigationDistance = C_Navigation.GetDistance
local max = math.max
local min = math.min
local abs = math.abs
local floor = math.floor

---@param distance number
---@param timeToTarget number
---@param force boolean?
local function NotifyDistanceCallbacks(distance, timeToTarget, force)
    local roundedDistance = Round(distance)
    local roundedEta = timeToTarget < 0 and -1 or floor(timeToTarget)
    if not force and roundedDistance == lastNotifiedDistance and roundedEta == lastNotifiedEta then return end

    lastNotifiedDistance = roundedDistance
    lastNotifiedEta = roundedEta
    local closingSpeed = smoothedClosingSpeed
    local nextUpdateInterval = throttleInterval
    local currentMovementState = movementState
    for _, callback in ipairs(onUpdateCallbacks) do
        if type(callback) == "function" then
            callback(distance, timeToTarget, closingSpeed, nextUpdateInterval, currentMovementState)
        end
    end
end

---@param distance number
---@param timeToTarget number
local function NotifyDistanceSampleCallbacks(distance, timeToTarget)
    local closingSpeed = smoothedClosingSpeed
    local nextUpdateInterval = throttleInterval
    local currentMovementState = movementState
    for _, callback in ipairs(onSampleCallbacks) do
        if type(callback) == "function" then
            callback(distance, timeToTarget, closingSpeed, nextUpdateInterval, currentMovementState)
        end
    end
end

---@param distance number
---@param timeToTarget number
local function PublishDistanceSample(distance, timeToTarget)
    NotifyDistanceCallbacks(distance, timeToTarget)
    NotifyDistanceSampleCallbacks(distance, timeToTarget)
end

local function ResetDistanceSampleState()
    lastDistance = nil
    lastTimeToTarget = -1
    lastSampleTime = nil
    smoothedClosingSpeed = 0
    hasSmoothedClosingSpeed = false
    movementState = "unknown"
    distanceSource = nil
    lastNotifiedDistance = nil
    lastNotifiedEta = nil
end

---@param distance number
---@param state DistanceMovementState
---@return number
local function GetDistanceUpdateInterval(distance, state)
    local distanceInterval = max(MIN_UPDATE_INTERVAL,
        min(MAX_UPDATE_INTERVAL, MAX_UPDATE_INTERVAL * (distance / 100)))

    if state == "movingAway" then
        return min(distanceInterval, DIRECTION_UPDATE_INTERVAL)
    elseif state == "stationary" then
        return max(distanceInterval, DIRECTION_UPDATE_INTERVAL)
    end

    return distanceInterval
end

---@param distanceDelta number
---@return DistanceMovementState
local function GetMovementState(distanceDelta)
    if abs(distanceDelta) < DISTANCE_DEAD_ZONE then
        return "stationary"
    elseif distanceDelta > 0 then
        return "approaching"
    end

    return "movingAway"
end

---@param currentSpeed number
---@param hasCurrentSpeed boolean
---@param rawClosingSpeed number
---@param sampleElapsed number
---@return number speed
---@return boolean hasSpeed
local function GetSmoothedClosingSpeed(currentSpeed, hasCurrentSpeed, rawClosingSpeed, sampleElapsed)
    local closingSpeed = max(0, rawClosingSpeed)
    if not hasCurrentSpeed then
        if closingSpeed <= 0 then return 0, false end
        return closingSpeed, true
    end

    local alpha = min(1, sampleElapsed / SPEED_SMOOTHING_WINDOW)
    return currentSpeed + alpha * (closingSpeed - currentSpeed), true
end

---Wrapper for the current map the player is on
---@return number? mapID
function MapPinEnhanced:GetPlayerMap()
    return C_Map.GetBestMapForUnit("player")
end

---Wrapper for the current map position of the player
---@return number x, number y, number currentPlayerUIMapID, Enum.UIMapType currentPlayerUIMapType
function MapPinEnhanced:GetPlayerMapPosition()
    return HBD:GetPlayerZonePosition()
end

--- Get the distance between two points on the map
--- @param mapID1 number The map ID of the first location
--- @param x1 number The X coordinate of the first location (0 to 1)
--- @param y1 number The Y coordinate of the first location (0 to 1)
--- @param mapID2 number The map ID of the second location
--- @param x2 number The X coordinate of the second location (0 to 1)
--- @param y2 number The Y coordinate of the second location (0 to 1)
--- @return number The distance in yards between the two locations
function MapPinEnhanced:GetDistanceBetweenPoints(mapID1, x1, y1, mapID2, x2, y2)
    if not mapID1 or not x1 or not y1 or not mapID2 or not x2 or not y2 then
        return 0
    end
    return HBD:GetZoneDistance(mapID1, x1, y1, mapID2, x2, y2) or 0
end

--- Get the distance from the player to a target point on the map
--- @param mapID number The map ID of the target location
--- @param x number The X coordinate of the target location (0 to 1)
--- @param y number The Y coordinate of the target location (0 to 1)
--- @return number The distance in yards from the player to the target location
function MapPinEnhanced:GetDistanceToTarget(mapID, x, y)
    local playerX, playerY, playerMap = self:GetPlayerMapPosition()
    if not playerMap or not playerX or not playerY then return 0 end
    return self:GetDistanceBetweenPoints(playerMap, playerX, playerY, mapID, x, y)
end

function MapPinEnhanced:GetWorldVectorForTarget(mapID, x, y)
    local playerX, playerY, playerMap = self:GetPlayerMapPosition()
    if not playerMap or not playerX or not playerY then return nil end

    local pwx, pwy, pInst = HBD:GetWorldCoordinatesFromZone(playerX, playerY, playerMap)
    local twx, twy, tInst = HBD:GetWorldCoordinatesFromZone(x, y, mapID)
    if not pwx or not pwy or not twx or not twy then return nil end
    if pInst ~= tInst then return nil end

    return HBD:GetWorldVector(pInst, pwx, pwy, twx, twy)
end

---@param distance any
---@return boolean
local function IsUsableDistance(distance)
    if MapPinEnhanced:IsSecretValue(distance) then return false end
    return type(distance) == "number" and distance >= 0
end

---@return number?
local function GetFallbackDistance()
    if not target then return nil end

    local playerX, playerY, playerMap = MapPinEnhanced:GetPlayerMapPosition()
    if playerMap == nil or playerX == nil or playerY == nil then return nil end

    local distance = HBD:GetZoneDistance(playerMap, playerX, playerY, target.mapID, target.x, target.y)
    if not IsUsableDistance(distance) then return nil end
    return distance
end

---@param allowNavigation boolean
---@return number? distance
---@return DistanceSource? source
local function GetCurrentTargetDistance(allowNavigation)
    if allowNavigation and GetNavigationDistance and IsSuperTracking() then
        local navigationDistance = GetNavigationDistance()
        if IsUsableDistance(navigationDistance) then
            return navigationDistance, "navigation"
        end
    end

    local mapDistance = GetFallbackDistance()
    if mapDistance ~= nil then
        return mapDistance, "map"
    end
end

---@param distance number
---@param source DistanceSource
---@param currentTime number
local function ProcessDistanceSample(distance, source, currentTime)
    if distanceSource ~= source or lastDistance == nil or lastSampleTime == nil then
        lastDistance = distance
        lastSampleTime = currentTime
        lastTimeToTarget = -1
        smoothedClosingSpeed = 0
        hasSmoothedClosingSpeed = false
        movementState = "unknown"
        distanceSource = source
        throttleInterval = GetDistanceUpdateInterval(distance, movementState)
        PublishDistanceSample(distance, lastTimeToTarget)
        return
    end

    local sampleElapsed = currentTime - lastSampleTime
    if sampleElapsed <= 0 then return end

    local distanceDelta = lastDistance - distance
    movementState = GetMovementState(distanceDelta)

    local rawClosingSpeed = distanceDelta / sampleElapsed
    smoothedClosingSpeed, hasSmoothedClosingSpeed = GetSmoothedClosingSpeed(smoothedClosingSpeed,
        hasSmoothedClosingSpeed, rawClosingSpeed, sampleElapsed)
    throttleInterval = GetDistanceUpdateInterval(distance, movementState)

    if movementState == "approaching" and smoothedClosingSpeed > 0 then
        lastTimeToTarget = distance / smoothedClosingSpeed
    else
        lastTimeToTarget = -1
    end

    lastDistance = distance
    lastSampleTime = currentTime
    PublishDistanceSample(distance, lastTimeToTarget)
end

---@param allowNavigation boolean
local function SampleTargetDistance(allowNavigation)
    local distance, source = GetCurrentTargetDistance(allowNavigation)
    if distance == nil or not source then
        ResetDistanceSampleState()
        throttleInterval = DIRECTION_UPDATE_INTERVAL
        return
    end

    ProcessDistanceSample(distance, source, GetTime())
end

---@param _ Frame
---@param elapsed number
local function OnUpdate(_, elapsed)
    if not target then return end

    elapsedSinceUpdate = elapsedSinceUpdate + elapsed
    if elapsedSinceUpdate < throttleInterval then return end
    elapsedSinceUpdate = 0
    SampleTargetDistance(true)
end

--- Register a callback to be called when the distance to the target is updated
---@param callback fun(distance: number, timeToTarget: number, closingSpeed: number, nextUpdateInterval: number, movementState: DistanceMovementState) The callback function that will be called with the current navigation sample
function MapPinEnhanced:RegisterContinuousDistanceCallback(callback)
    if type(callback) == "function" then
        table.insert(onUpdateCallbacks, callback)
        if target and lastDistance ~= nil then
            callback(lastDistance, lastTimeToTarget, smoothedClosingSpeed, throttleInterval, movementState)
        end
    end
end

--- Unregister a previously registered distance update callback
---@param callback fun(distance: number, timeToTarget: number, closingSpeed: number, nextUpdateInterval: number, movementState: DistanceMovementState) The callback function to unregister
function MapPinEnhanced:UnregisterContinuousDistanceCallback(callback)
    for i, cb in ipairs(onUpdateCallbacks) do
        if cb == callback then
            table.remove(onUpdateCallbacks, i)
            return
        end
    end
end

--- Register a callback for every valid navigation sample, including samples
--- whose rounded distance and ETA have not changed.
---@param callback fun(distance: number, timeToTarget: number, closingSpeed: number, nextUpdateInterval: number, movementState: DistanceMovementState)
function MapPinEnhanced:RegisterContinuousDistanceSampleCallback(callback)
    if type(callback) ~= "function" then return end
    table.insert(onSampleCallbacks, callback)
    if target and lastDistance ~= nil then
        callback(lastDistance, lastTimeToTarget, smoothedClosingSpeed, throttleInterval, movementState)
    end
end

---@param callback fun(distance: number, timeToTarget: number, closingSpeed: number, nextUpdateInterval: number, movementState: DistanceMovementState)
function MapPinEnhanced:UnregisterContinuousDistanceSampleCallback(callback)
    for i, currentCallback in ipairs(onSampleCallbacks) do
        if currentCallback == callback then
            table.remove(onSampleCallbacks, i)
            return
        end
    end
end

--- Enable distance check for a specific target
---@param mapID number
---@param x number
---@param y number
function MapPinEnhanced:EnableContinuousDistanceCheck(mapID, x, y)
    elapsedSinceUpdate = 0
    target = { mapID = mapID, x = x, y = y }
    ResetDistanceSampleState()

    -- The super-tracked destination may still be changing. Seed from the explicit
    -- map target, then prefer Blizzard navigation on the next sample.
    SampleTargetDistance(false)
    throttleInterval = MIN_UPDATE_INTERVAL

    if not distanceFrame:GetScript("OnUpdate") then
        distanceFrame:SetScript("OnUpdate", OnUpdate)
    end
end

---@param mapID number?
---@param x number?
---@param y number?
function MapPinEnhanced:DisableContinuousDistanceCheck(mapID, x, y)
    if mapID and x and y then
        -- If specific coordinates are provided, we can clear the target
        if target and target.mapID == mapID and target.x == x and target.y == y then
            target = nil
            ResetDistanceSampleState()
            distanceFrame:SetScript("OnUpdate", nil)
            return
        end
    else
        target = nil
        ResetDistanceSampleState()
        distanceFrame:SetScript("OnUpdate", nil)
    end
end

local function OnSuperTrackingChanged()
    if not target then return end
    ResetDistanceSampleState()
    elapsedSinceUpdate = 0
    throttleInterval = MIN_UPDATE_INTERVAL
end

MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", OnSuperTrackingChanged)

function MapPinEnhanced:FormatDistance(distance)
    ---@type boolean
    local showDistanceUnit = Options:GetOptionValue("General.Distance.ShowUnit")
    local distanceRound = Round(distance)
    ---@type string
    local distanceText
    if distance >= 1000 then
        distanceText = tostring(AbbreviateNumbers(distanceRound))
    else
        distanceText = tostring(distanceRound)
    end

    if not showDistanceUnit then
        return distanceText
    end

    return string.format(IN_GAME_NAVIGATION_RANGE, distanceText)
end

function MapPinEnhanced:FormatETA(time)
    if time < 0 then
        return "--:--"
    end
    local minutes = math.floor(time / 60)
    local seconds = math.floor(time % 60)
    return string.format("%02d:%02d", minutes, seconds)
end

MapPinEnhanced:OnLoad(function()
    Options:SubscribeToOptionChanges("General.Distance.ShowUnit", function()
        if lastDistance ~= nil then
            NotifyDistanceCallbacks(lastDistance, lastTimeToTarget, true)
        end
    end)
end)
