---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Tracking
---@field trackedPin MapPinEnhancedPinMixin
local Tracking = MapPinEnhanced:GetModule("Tracking")
local Groups = MapPinEnhanced:GetModule("Groups")
local Blizzard = MapPinEnhanced:GetModule("Blizzard")
local Distance = MapPinEnhanced:GetModule("Distance")

---@param groupName string
function Tracking:TrackNearestInSection(groupName)
    local group = Groups:GetGroupByName(groupName)
    if not group then return end
    local nearestPin = nil
    local playerX, playerY, playerMap = Blizzard:GetPlayerMapPosition()
    if not playerMap or not playerX or not playerY then return end

    for _, pin in group:EnumeratePins() do
        local pinData = pin:GetPinData()
        local mapID, x, y = pinData.mapID, pinData.x, pinData.y
        local distance = Distance:GetDistanceToTarget(mapID, x, y)
        if not nearestPin or (distance > 0 and distance < nearestPin.distance) then -- there is no nearest pin or the current iteration pin is closer
            nearestPin = {
                pin = pin,
                distance = distance
            }
        end
    end
    if nearestPin then
        nearestPin.pin:Track()
    end
end

function Tracking:TrackNextPinInSection(groupName)
    local group = Groups:GetGroupByName(groupName)
    if not group then return end
    for _, pin in group:EnumeratePins() do
        local pinData = pin:GetPinData()
        if pinData then
            pin:Track()
            return
        end
    end
end

---@param pin MapPinEnhancedPinMixin | nil
function Tracking:SetTrackedPin(pin)
    self.trackedPin = pin
end

function Tracking:UntrackTrackedPin()
    if self.trackedPin then
        self.trackedPin:Untrack()
    end
end
