---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local MIN_UPDATE_INTERVAL, MAX_UPDATE_INTERVAL = 0.05, 1.5 -- tune as needed
local BASE_UPDATE_INTERVAL = 1
local DISTANCE_CACHE_SIZE = 5

---@type {distance: number, time: number}[]
local distanceCache = table.create(DISTANCE_CACHE_SIZE)
local lastDistance = 0
local elapsedSinceUpdate = 0
local throttle_interval = BASE_UPDATE_INTERVAL

---@type {mapID: number, x: number, y: number} | nil
local target = nil
---@type fun(distance: number, timeToTarget: number)[]
local onUpdateCallbacks = {}
local distanceFrame = CreateFrame("Frame")

local HBD = MapPinEnhanced.HBD
local IsSuperTracking = C_SuperTrack.IsSuperTrackingAnything
local max = math.max
local min = math.min
local abs = math.abs
local wipe = table.wipe


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

---@param _ Frame
---@param elapsed number
local function OnUpdate(_, elapsed)
    if not target then return end

    elapsedSinceUpdate = elapsedSinceUpdate + elapsed
    if elapsedSinceUpdate < throttle_interval then return end
    elapsedSinceUpdate = 0

    local currentTime = GetTime()

    if not IsSuperTracking() then return end

    local mapID, x, y = target.mapID, target.x, target.y
    local distance = MapPinEnhanced:GetDistanceToTarget(mapID, x, y)
    if distance == 0 then return end
    if abs(lastDistance - distance) < 1 then return end

    -- Maintain a cache of recent distances
    if #distanceCache >= DISTANCE_CACHE_SIZE then
        table.remove(distanceCache, 1)
    end
    table.insert(distanceCache, { distance = distance, time = currentTime })

    -- Calculate total distance and time from the cache
    local totalDistance = 0
    local totalTime = 0
    for i = 2, #distanceCache do
        local prev = distanceCache[i - 1]
        local current = distanceCache[i]
        totalDistance = totalDistance + (prev.distance - current.distance)
        totalTime = totalTime + (current.time - prev.time)
    end

    if totalTime == 0 then return end
    if totalDistance == 0 then return end

    -- Calculate speed (yards per second)
    ---@type number
    local speed = totalDistance / totalTime
    if speed <= 0 then
        wipe(distanceCache)
        lastDistance = distance
        return
    end

    -- Calculate time to target
    local timeToTarget = distance / speed

    -- Update UPDATE interval based on distance
    throttle_interval = max(MIN_UPDATE_INTERVAL, min(MAX_UPDATE_INTERVAL, MAX_UPDATE_INTERVAL * (distance / 100)))

    for _, callback in ipairs(onUpdateCallbacks) do
        if type(callback) == "function" then
            callback(distance, timeToTarget)
        end
    end

    lastDistance = distance
end

--- Register a callback to be called when the distance to the target is updated
---@param callback fun(distance: number, timeToTarget: number) The callback function that will be called with the updated distance and estimated time to target
function MapPinEnhanced:RegisterContinuousDistanceCallback(callback)
    if type(callback) == "function" then
        table.insert(onUpdateCallbacks, callback)
    end
end

--- Unregister a previously registered distance update callback
---@param callback fun(distance: number, timeToTarget: number) The callback function to unregister
function MapPinEnhanced:UnregisterContinuousDistanceCallback(callback)
    for i, cb in ipairs(onUpdateCallbacks) do
        if cb == callback then
            table.remove(onUpdateCallbacks, i)
            return
        end
    end
end

--- Enable distance check for a specific target
---@param mapID number
---@param x number
---@param y number
function MapPinEnhanced:EnableContinuousDistanceCheck(mapID, x, y)
    throttle_interval = BASE_UPDATE_INTERVAL
    wipe(distanceCache)
    lastDistance = 0
    elapsedSinceUpdate = 0
    target = { mapID = mapID, x = x, y = y }

    local initialDistance = self:GetDistanceToTarget(mapID, x, y)
    for _, callback in ipairs(onUpdateCallbacks) do
        if type(callback) == "function" then
            callback(initialDistance, -1) -- -1 indicates unknown time to target
        end
    end

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
            wipe(distanceCache)
            lastDistance = 0
            distanceFrame:SetScript("OnUpdate", nil)
            return
        end
    else
        target = nil
        wipe(distanceCache)
        lastDistance = 0
        distanceFrame:SetScript("OnUpdate", nil)
    end
end

function MapPinEnhanced:FormatDistance(distance)
    local distanceRound = Round(distance)
    if distance >= 1000 then
        return string.format(IN_GAME_NAVIGATION_RANGE, tostring(AbbreviateNumbers(distanceRound)))
    else
        return string.format(IN_GAME_NAVIGATION_RANGE, tostring(distanceRound))
    end
end

function MapPinEnhanced:FormatETA(time)
    if time < 0 then
        return "--:--"
    end
    local minutes = math.floor(time / 60)
    local seconds = math.floor(time % 60)
    return string.format("%02d:%02d", minutes, seconds)
end
