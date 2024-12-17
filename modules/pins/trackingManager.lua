---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinTracking
---@field TrackedPin PinObject
local PinTracking = MapPinEnhanced:GetModule("PinTracking")
local PinSections = MapPinEnhanced:GetModule("PinSections")
local Blizzard = MapPinEnhanced:GetModule("Blizzard")

function PinTracking:TrackNearestInSection(sectioName)
    local section = PinSections:GetSectionByName(sectioName)
    if not section then return end
    local pins = section:GetPins()
    local nearestPin = nil
    local playerX, playerY, playerMap = Blizzard:GetPlayerMapPosition()
    if not playerMap or not playerX or not playerY then return end

    for _, pin in pairs(pins) do
        local distance = pin:GetDistanceToPin()
        if not nearestPin or (distance > 0 and distance < nearestPin.distance) then -- there is no nearest pin or the current iteration pin is closer
            nearestPin = {
                pin = pin,
                distance = distance
            }
        end
    end
    if nearestPin then
        nearestPin.pin:Track()
        self.TrackedPin = nearestPin.pin
    end
end

function PinTracking:TrackNextPinInSection(sectionName, lastPinOrder)
    local section = PinSections:GetSectionByName(sectionName)
    if not section then return end
    local pins = section:GetPins()
    if not lastPinOrder then
        lastPinOrder = 0 -- start from the beginning
    end
    for _, pin in pairs(pins) do
        local pinData = pin:GetPinData()
        local order = pinData.order
        if order and order > lastPinOrder then
            pin:Track()
            self.TrackedPin = pin
            return
        end
    end
end

---@param pin PinObject
---@return boolean success
function PinTracking:SetTrackedPin(pin)
    if self.TrackedPin then
        self.TrackedPin:Untrack()
    end
    self.TrackedPin = pin
    local pinData = pin.pinData
    Blizzard:SetBlizzardWaypoint(pinData.x, pinData.y, pinData.mapID)
    return true
end

function PinTracking:ClearTrackedPin()
    if self.TrackedPin then
        self.TrackedPin = nil
    end
end

function PinTracking:GetTrackedPin()
    return self.TrackedPin
end

function PinTracking:UntrackTrackedPin()
    if self.TrackedPin then
        self.TrackedPin:Untrack()
        self.TrackedPin = nil
    end
end
