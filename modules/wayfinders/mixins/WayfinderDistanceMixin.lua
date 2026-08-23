---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedWayfinderDistanceMixin
---@field distanceCallback fun(distance: number?, timeToTarget: number?)?
---@field distanceText FontString?
---@field etaText FontString?
---@field lastDistanceText string?
---@field lastEtaText string?
MapPinEnhancedWayfinderDistanceMixin = {}

---@param distanceText FontString
---@param etaText FontString
---@param onDistance fun(distance: number?, timeToTarget: number?)
function MapPinEnhancedWayfinderDistanceMixin:StartDistanceUpdates(distanceText, etaText, onDistance)
    assert(distanceText and etaText, "WayfinderDistance:StartDistanceUpdates: text regions are required")
    assert(type(onDistance) == "function", "WayfinderDistance:StartDistanceUpdates: onDistance must be a function")
    self:StopDistanceUpdates()
    self.distanceText = distanceText
    self.etaText = etaText
    self.distanceCallback = function(distance, timeToTarget)
        local formattedDistance = ""
        local formattedETA = ""
        if distance and timeToTarget then
            formattedDistance = MapPinEnhanced:FormatDistance(distance)
            formattedETA = MapPinEnhanced:FormatETA(timeToTarget)
        end

        if self.lastDistanceText ~= formattedDistance then
            self.lastDistanceText = formattedDistance
            distanceText:SetText(formattedDistance)
        end
        if self.lastEtaText ~= formattedETA then
            self.lastEtaText = formattedETA
            etaText:SetText(formattedETA)
        end
        onDistance(distance, timeToTarget)
    end
    MapPinEnhanced:RegisterContinuousDistanceCallback(self.distanceCallback)
end

function MapPinEnhancedWayfinderDistanceMixin:StopDistanceUpdates()
    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
    if self.distanceText then self.distanceText:SetText("") end
    if self.etaText then self.etaText:SetText("") end
    self.lastDistanceText = ""
    self.lastEtaText = ""
end
