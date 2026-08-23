---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedWayfinderDirectionMixin
---@field targetWorldX number?
---@field targetWorldY number?
---@field targetInstance number?
---@field lastDirectionSample number?
MapPinEnhancedWayfinderDirectionMixin = {}

local HBD = MapPinEnhanced.HBD
local mathSin = math.sin
local mathCos = math.cos
local mathAtan2 = math.atan2
local SAMPLE_INTERVAL = 0.1

function MapPinEnhancedWayfinderDirectionMixin:SetTargetLocation(mapID, x, y)
    self.targetMapID = mapID
    self.targetX = x
    self.targetY = y
    self.targetWorldX, self.targetWorldY, self.targetInstance = HBD:GetWorldCoordinatesFromZone(x, y, mapID)
end

---@param elapsed number?
---@return number? angle
function MapPinEnhancedWayfinderDirectionMixin:SampleTargetAngle(elapsed)
    if not self.targetWorldX or not self.targetWorldY or not self.targetInstance then return nil end

    local now = GetTime()
    if elapsed and self.lastDirectionSample and self.lastDirectionSample + SAMPLE_INTERVAL > now then return nil end
    self.lastDirectionSample = now

    local playerWorldX, playerWorldY, playerInstance = HBD:GetPlayerWorldPosition()
    if not playerWorldX or not playerWorldY or playerInstance ~= self.targetInstance then return nil end

    local worldAngle = HBD:GetWorldVector(playerInstance, playerWorldX, playerWorldY,
        self.targetWorldX, self.targetWorldY)
    local facing = GetPlayerFacing()
    if not worldAngle or not facing then return nil end

    local relativeAngle = worldAngle - facing
    return mathAtan2(-mathSin(relativeAngle), mathCos(relativeAngle))
end

function MapPinEnhancedWayfinderDirectionMixin:ResetDirectionSampling()
    self.lastDirectionSample = nil
end
