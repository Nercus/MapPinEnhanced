---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinManager : Module
local PinManager = MapPinEnhanced:CreateModule("PinManager")
-- NOTE: Create, delete and manage pins here (multiple pins)

---@class PinFactory : Module
local PinFactory = MapPinEnhanced:GetModule("PinFactory")

---@type table<string, PinObject>
PinManager.Pins = {}


local MAX_COUNT_PINS = 1000

---Get a string representation of a position from pinData
---@param pinData pinData
---@return string
local function GetPinIDFromPinData(pinData)
    -- the x and y coordinates are normalized so we cut them here to avoid to many pins on the same point
    return string.format("%s:%.4f:%.4f", pinData.mapID, pinData.x, pinData.y)
end


function PinManager:GetPinByID(pinID)
    return self.Pins[pinID]
end

function PinManager:TrackPinByID(pinID)
    local pin = self.Pins[pinID]
    if not pin then
        return false
    end
    PinManager:UntrackTrackedPin()
    local pinData = pin.pinData
    MapPinEnhanced:SetBlizzardWaypoint(pinData.x, pinData.y, pinData.mapID)
    return true
end

function PinManager:UntrackTrackedPin()
    for _, pin in pairs(self.Pins) do
        if pin:IsTracked() then
            pin:Untrack()
        end
    end
end

---add a pin
---@param pinData pinData
function PinManager:AddPin(pinData)
    assert(pinData, "Pin data is required to create a pin.")
    assert(pinData.mapID, "Pin data must contain a mapID.")
    assert(pinData.x, "Pin data must contain an x coordinate.")
    assert(pinData.y, "Pin data must contain a y coordinate.")

    if #self.Pins >= MAX_COUNT_PINS then
        -- too many pins
        -- TODO: notify the player here
        return
    end

    local pinID = GetPinIDFromPinData(pinData)
    if self.Pins[pinID] then
        -- pin already exists
        -- TODO: notify the player here
        return
    end


    -- set defaults
    if (pinData.texture == nil) then
        pinData.texture = "Waypoint-MapPin-Untracked"
        pinData.usesAtlas = true
    end


    local pinObject = PinFactory:CreatePin(pinData, pinID)
    self.Pins[pinID] = pinObject

    if pinData.setTracked then
        pinObject:Track()
    else
        pinObject:Untrack()
    end
end
