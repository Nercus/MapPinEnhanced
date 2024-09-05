---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinFactory
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
local Blizz = MapPinEnhanced:GetModule("Blizz")
local PinManager = MapPinEnhanced:GetModule("PinManager")


---@type {distance: number, time: number}[]
local distanceCache = {}
local throttle_interval = 1
local lastDistance = 0
local lastUpdate = nil
local IsSuperTrackingUserWaypoint = C_SuperTrack.IsSuperTrackingUserWaypoint

---@param GetDistanceToPin function
---@param isClose boolean?
---@param OnDistanceClose function
---@param OnDistanceFar function
local function UpdateDistance(GetDistanceToPin, isClose, OnDistanceClose, OnDistanceFar)
    local currentTime = GetTime()
    -- Check if we need to update based on throttle interval
    if not lastUpdate or currentTime - lastUpdate > throttle_interval then
        ---@type boolean
        local isSuperTrackingUserWaypoint = IsSuperTrackingUserWaypoint()
        if not isSuperTrackingUserWaypoint then return end
        ---@type number
        local distance = GetDistanceToPin()
        if distance == 0 then return end            -- No distance to get to the waypoint
        if lastDistance == distance then return end -- No need to update if the distance is the same
        lastDistance = distance

        -- Maintain a cache of recent distances
        if #distanceCache > 5 then
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
            distanceCache = {}
            if MapPinEnhanced.SuperTrackedPin then
                MapPinEnhanced.SuperTrackedPin:UpdateTimeText()
            end
        end

        -- Calculate time to target
        local timeToTarget = distance / speed
        if timeToTarget <= 0 then
            if MapPinEnhanced.SuperTrackedPin then
                MapPinEnhanced.SuperTrackedPin:UpdateTimeText()
            end
        end

        -- Update throttle interval based on distance
        throttle_interval = 0.1 + 2e-04 * distance - 5e-09 * distance * distance

        -- Update the UI with the new time to target
        if MapPinEnhanced.SuperTrackedPin then
            MapPinEnhanced.SuperTrackedPin:UpdateTimeText(timeToTarget)
        end

        local newIsClose = distance < 20

        if isClose ~= newIsClose then
            if newIsClose then
                OnDistanceClose()
            else
                OnDistanceFar()
            end
        end
        lastUpdate = currentTime
    end
end



---@param pin PinObject
local function EnableDistanceCheck(pin)
    local isClose = nil

    local function GetDistanceToPin()
        local playerX, playerY, playerMap = Blizz:GetPlayerMapPosition()
        if not playerMap or not playerX or not playerY then return 0 end
        local distance = MapPinEnhanced.HBD:GetZoneDistance(playerMap, playerX, playerY, pin.pinData.mapID, pin.pinData
            .x,
            pin.pinData.y)
        if not distance then return 0 end
        return distance
    end

    local function OnDistanceClose()
        isClose = true
        MapPinEnhanced.SuperTrackedPin:ShowSwirl()
        local trackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
        if trackingCorpse then return end
        if pin.pinData.lock then return end
        if not pin:IsTracked() then return end
        PinManager:RemovePinByID(pin.pinID)
    end

    local function OnDistanceFar()
        isClose = false
        MapPinEnhanced.SuperTrackedPin:HideSwirl()
    end

    local function ManualDistanceCheck()
        local distance = GetDistanceToPin()
        if distance < 20 and distance ~= 0 then
            OnDistanceClose()
        else
            OnDistanceFar()
        end
    end

    UpdateDistance(GetDistanceToPin, isClose, OnDistanceClose, OnDistanceFar)
    pin.superTrackedPin:SetScript("OnUpdate", UpdateDistance)
    ManualDistanceCheck()
end

local function DisableDistanceCheck(pin)
    pin.superTrackedPin:SetScript("OnUpdate", nil)
end

---@class PinObject
---@field EnableDistanceCheck function
---@field DisableDistanceCheck function

---@param pin PinObject
function PinFactory:HandleDistanceCheck(pin)
    if not pin then return end
    function pin:EnableDistanceCheck()
        EnableDistanceCheck(self)
    end

    function pin:DisableDistanceCheck()
        DisableDistanceCheck(self)
    end
end

local function ToggleLockState()
    pinData.lock = not pinData.lock
    trackerPinEntry.Pin:SetLockState(pinData.lock)
    if MapPinEnhanced.SuperTrackedPin then
        MapPinEnhanced.SuperTrackedPin:SetLockState(pinData.lock)
    end
    PinManager:PersistPins()
    ManualDistanceCheck()
end
