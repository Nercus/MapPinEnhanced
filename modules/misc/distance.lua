---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Distance
---@field distanceFrame Frame
---@field target {mapID: number, x: number, y: number, onUpdate: fun(distance: number, timeToTarget: number)}
local Distance = MapPinEnhanced:GetModule("Distance")
local Blizzard = MapPinEnhanced:GetModule("Blizzard")

local MIN_UPDATE_INTERVAL, MAX_UPDATE_INTERVAL = 0.05, 1.5 -- tune as needed
local BASE_UPDATE_INTERVAL = 1
local DISTANCE_CACHE_SIZE = 5

---@type {distance: number, time: number}[]
local distanceCache = table.create(DISTANCE_CACHE_SIZE)
local lastDistance = 0
local lastUpdate = nil
local throttle_interval = BASE_UPDATE_INTERVAL

local IsSuperTracking = C_SuperTrack.IsSuperTrackingAnything
local max = math.max
local min = math.min
local abs = math.abs
local wipe = table.wipe


--- Get the distance between two points on the map
--- @param mapID1 number The map ID of the first location
--- @param x1 number The X coordinate of the first location (0 to 1)
--- @param y1 number The Y coordinate of the first location (0 to 1)
--- @param mapID2 number The map ID of the second location
--- @param x2 number The X coordinate of the second location (0 to 1)
--- @param y2 number The Y coordinate of the second location (0 to 1)
--- @return number The distance in yards between the two locations
function Distance:GetDistanceBetweenPoints(mapID1, x1, y1, mapID2, x2, y2)
    if not mapID1 or not x1 or not y1 or not mapID2 or not x2 or not y2 then
        return 0
    end
    return MapPinEnhanced.HBD:GetZoneDistance(mapID1, x1, y1, mapID2, x2, y2) or 0
end

--- Get the distance from the player to a target point on the map
--- @param mapID number The map ID of the target location
--- @param x number The X coordinate of the target location (0 to 1)
--- @param y number The Y coordinate of the target location (0 to 1)
--- @return number The distance in yards from the player to the target location
function Distance:GetDistanceToTarget(mapID, x, y)
    local playerX, playerY, playerMap = Blizzard:GetPlayerMapPosition()
    if not playerMap or not playerX or not playerY then return 0 end
    return self:GetDistanceBetweenPoints(playerMap, playerX, playerY, mapID, x, y)
end

function Distance:OnUpdate()
    if not self.target then return end

    local currentTime = GetTime()
    if lastUpdate and (currentTime - lastUpdate < throttle_interval) then return end

    if not IsSuperTracking() then return end

    local mapID, x, y = self.target.mapID, self.target.x, self.target.y
    local distance = self:GetDistanceToTarget(mapID, x, y)
    if distance == 0 then return end

    if abs(lastDistance - distance) < 1 then return end

    -- Maintain a cache of recent distances
    if #distanceCache > DISTANCE_CACHE_SIZE then
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
    end

    -- Calculate time to target
    local timeToTarget = distance / speed

    -- Update uPDATE interval based on distance
    throttle_interval = max(MIN_UPDATE_INTERVAL, min(MAX_UPDATE_INTERVAL, MAX_UPDATE_INTERVAL * (distance / 100)))

    -- Call the target's onUpdate function with the distance and time to target
    if self.target.onUpdate then
        self.target.onUpdate(distance, timeToTarget)
    end

    lastDistance = distance
    lastUpdate = currentTime
end

--- Enable distance check for a specific target
---@param mapID number
---@param x number
---@param y number
---@param onUpdate function(distance: number, timeToTarget: number)
function Distance:EnableDistanceCheck(mapID, x, y, onUpdate)
    throttle_interval = BASE_UPDATE_INTERVAL
    wipe(distanceCache)
    lastDistance = 0
    lastUpdate = nil
    self.target = { mapID = mapID, x = x, y = y, onUpdate = onUpdate }
    -- Trigger the initial callback immediately
    if self.target.onUpdate then
        local initialDistance = self:GetDistanceToTarget(mapID, x, y)
        self.target.onUpdate(initialDistance, -1) -- -1 indicates unknown time to target
    end
end

---@param mapID number?
---@param x number?
---@param y number?
function Distance:DisableDistanceCheck(mapID, x, y)
    if mapID and x and y then
        -- If specific coordinates are provided, we can clear the target
        if self.target and self.target.mapID == mapID and self.target.x == x and self.target.y == y then
            self.target = nil
            return
        end
    else
        self.target = nil
    end
end

function Distance:Init()
    assert(not self.distanceFrame, "Distance frame already initialized")
    throttle_interval = BASE_UPDATE_INTERVAL
    wipe(distanceCache)
    lastDistance = 0
    lastUpdate = nil
    self.distanceFrame = CreateFrame("Frame")
    -- Set up the frame to handle distance updates
    self.distanceFrame:SetScript("OnUpdate", function()
        self:OnUpdate()
    end)
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    Distance:Init()
end)
