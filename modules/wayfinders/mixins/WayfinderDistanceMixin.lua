---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Options = MapPinEnhanced:GetModule("Options")
local READOUT_MODE_OPTION = "Wayfinder.General.ReadoutMode"

---@class MapPinEnhancedWayfinderDistanceMixin
---@field distanceCallback fun(distance: number?, timeToTarget: number?)?
---@field distanceReadout MapPinEnhancedWayfinderReadoutTemplate?
---@field unsubscribeReadoutMode fun()?
---@field lastDistanceText string?
---@field lastEtaText string?
---@field lastHasETA boolean?
MapPinEnhancedWayfinderDistanceMixin = {}

function MapPinEnhancedWayfinderDistanceMixin:ResetDistanceReadout()
    self.lastDistanceText = nil
    self.lastEtaText = nil
    self.lastHasETA = nil
    if self.distanceReadout then self.distanceReadout:PrepareForTarget() end
end

---@param readout MapPinEnhancedWayfinderReadoutTemplate
---@param onDistance fun(distance: number?, timeToTarget: number?)
function MapPinEnhancedWayfinderDistanceMixin:StartDistanceUpdates(readout, onDistance)
    assert(readout and readout.SetValues and readout.SetMode,
        "WayfinderDistance:StartDistanceUpdates: a readout is required")
    assert(type(onDistance) == "function", "WayfinderDistance:StartDistanceUpdates: onDistance must be a function")
    self:StopDistanceUpdates()
    self.distanceReadout = readout
    self:ResetDistanceReadout()
    self.unsubscribeReadoutMode = Options:SubscribeToOptionChanges(READOUT_MODE_OPTION, function(mode)
        readout:SetMode(mode --[[@as WayfinderReadoutMode]])
    end)
    self.distanceCallback = function(distance, timeToTarget)
        local formattedDistance = ""
        local formattedETA = ""
        local hasETA = type(timeToTarget) == "number" and timeToTarget >= 0
        if distance then
            formattedDistance = MapPinEnhanced:FormatDistance(distance)
            formattedETA = MapPinEnhanced:FormatETA(timeToTarget or -1)
        end

        if self.lastDistanceText ~= formattedDistance or self.lastEtaText ~= formattedETA or
            self.lastHasETA ~= hasETA then
            self.lastDistanceText = formattedDistance
            self.lastEtaText = formattedETA
            self.lastHasETA = hasETA
            readout:SetValues(formattedDistance, formattedETA, hasETA)
        end
        onDistance(distance, timeToTarget)
    end
    MapPinEnhanced:RegisterContinuousDistanceCallback(self.distanceCallback)
end

function MapPinEnhancedWayfinderDistanceMixin:StopDistanceUpdates()
    if self.unsubscribeReadoutMode then
        self.unsubscribeReadoutMode()
        self.unsubscribeReadoutMode = nil
    end
    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
    if self.distanceReadout then self.distanceReadout:PrepareForTarget() end
    self.distanceReadout = nil
    self.lastDistanceText = nil
    self.lastEtaText = nil
    self.lastHasETA = nil
end
