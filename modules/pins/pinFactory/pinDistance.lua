---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinFactory
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
local Blizzard = MapPinEnhanced:GetModule("Blizzard")
local PinSections = MapPinEnhanced:GetModule("PinSections")


---@type {distance: number, time: number}[]
local distanceCache = {}
local throttle_interval = 1
local lastDistance = 0
local lastUpdate = nil
local IsSuperTrackingUserWaypoint = C_SuperTrack.IsSuperTrackingUserWaypoint

---@param pin PinObject
local function UpdateDistance(pin)
    local currentTime = GetTime()
    -- Check if we need to update based on throttle interval
    if not lastUpdate or currentTime - lastUpdate > throttle_interval then
        ---@type boolean
        local isSuperTrackingUserWaypoint = IsSuperTrackingUserWaypoint()
        if not isSuperTrackingUserWaypoint then return end
        ---@type number
        local distance = pin:GetDistanceToPin()
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
            if pin.superTrackedPin then
                pin.superTrackedPin:UpdateTimeText()
            end
        end

        -- Calculate time to target
        local timeToTarget = distance / speed
        if timeToTarget <= 0 then
            if pin.superTrackedPin then
                pin.superTrackedPin:UpdateTimeText()
            end
        end

        -- Update throttle interval based on distance
        throttle_interval = 0.1 + 2e-04 * distance - 5e-09 * distance * distance

        -- Update the UI with the new time to target
        if pin.superTrackedPin then
            pin.superTrackedPin:UpdateTimeText(timeToTarget)
        end

        local newIsClose = distance < 20

        if pin.isClose ~= newIsClose then
            if newIsClose then
                pin:OnDistanceClose()
            else
                pin:OnDistanceFar()
            end
        end
        lastUpdate = currentTime
    end
end



---@class PinObject
---@field GetDistanceToPin fun(_):number
---@field ManualDistanceCheck fun(_)
---@field EnableDistanceCheck fun(_)
---@field DisableDistanceCheck fun(_)
---@field EnableLock fun(_)
---@field DisableLock fun(_)
---@field OnDistanceClose fun(_)
---@field OnDistanceFar fun(_)
---@field isClose boolean

---@param pin PinObject
function PinFactory:HandleDistanceCheck(pin)
    if not pin then return end


    function pin:OnDistanceClose()
        self.isClose = true
        self.superTrackedPin:ShowSwirl()
        local trackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
        if trackingCorpse then return end
        if pin.pinData.lock then return end
        if not pin:IsTracked() then return end
        pin.section:RemovePin(pin.pinID)
    end

    function pin:OnDistanceFar()
        self.isClose = false
        self.superTrackedPin:HideSwirl()
    end

    function pin:ManualDistanceCheck()
        local distance = pin:GetDistanceToPin()
        if distance < 20 and distance ~= 0 then
            self:OnDistanceClose()
        else
            self:OnDistanceFar()
        end
    end

    function pin:GetDistanceToPin()
        local playerX, playerY, playerMap = Blizzard:GetPlayerMapPosition()
        if not playerMap or not playerX or not playerY then return 0 end
        local distance = MapPinEnhanced.HBD:GetZoneDistance(
            playerMap, playerX, playerY,
            pin.pinData.mapID, pin.pinData.x, pin.pinData.y
        )
        if not distance then return 0 end
        return distance
    end

    local OnUpdateDistance = function()
        UpdateDistance(pin)
    end

    function pin:EnableDistanceCheck()
        self.superTrackedPin:SetScript("OnUpdate", OnUpdateDistance)
        self:ManualDistanceCheck()
    end

    function pin:DisableDistanceCheck()
        self.superTrackedPin:SetScript("OnUpdate", nil)
    end
end

---@param pin PinObject
function PinFactory:HandleLock(pin)
    if not pin then return end
    function pin:EnableLock()
        pin.pinData.lock = true
        pin.trackerPinEntry.Pin:SetLockState(true)
        pin.superTrackedPin:SetLockState(true)
        PinSections:PersistSections(pin.section.name, pin.pinID)
    end

    function pin:DisableLock()
        pin.pinData.lock = false
        pin.trackerPinEntry.Pin:SetLockState(false)
        pin.superTrackedPin:SetLockState(false)
        PinSections:PersistSections(pin.section.name, pin.pinID)
    end

    pin:ManualDistanceCheck()
end
