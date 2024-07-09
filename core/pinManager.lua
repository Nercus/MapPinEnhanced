---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinManager : Module
local PinManager = MapPinEnhanced:GetModule("PinManager")
---@class PinFactory : Module
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
---@class Blizz : Module
local Blizz = MapPinEnhanced:GetModule("Blizz")
local CONSTANTS = MapPinEnhanced.CONSTANTS

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


function PinManager:GetPins()
    return self.Pins
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
    Blizz:SetBlizzardWaypoint(pinData.x, pinData.y, pinData.mapID)
    return true
end

function PinManager:UntrackTrackedPin()
    for _, pin in pairs(self.Pins) do
        if pin:IsTracked() then
            pin:Untrack()
        end
    end
end

function PinManager:RemovePinByID(pinID)
    local pin = self.Pins[pinID]
    if not pin then
        return
    end
    pin:Remove()
    self.Pins[pinID] = nil
    self:PersistPins()
end

function PinManager:PersistPins()
    ---@type table<string, pinData>
    local reducedPins = {}
    for pinID, pin in pairs(self.Pins) do
        reducedPins[pinID] = pin:GetPinData()
    end
    MapPinEnhanced:SaveVar("storedPins", reducedPins)
end

function PinManager:RestorePins()
    local storedPins = MapPinEnhanced:GetVar("storedPins") --[[@as table<string, pinData> | nil]]
    if storedPins then
        for _, pinData in pairs(storedPins) do
            self:AddPin(pinData)
        end
    end
end

---add a pin
---@param pinData pinData
function PinManager:AddPin(pinData)
    assert(pinData, "Pin data is required to create a pin.")
    assert(type(pinData) == "table", "Pin data must be a table.")
    assert(pinData.mapID, "Pin data must contain a mapID.")
    assert(pinData.x, "Pin data must contain an x coordinate.")
    assert(pinData.y, "Pin data must contain a y coordinate.")
    assert(
        (pinData.color and CONSTANTS.PIN_COLORS_BY_NAME[pinData.color] or pinData.color == 'Custom') or
        not pinData.color,
        "Pin data must contain a valid color.")

    if (pinData.x > 1) then
        pinData.x = pinData.x / 100
    end
    if (pinData.y > 1) then
        pinData.y = pinData.y / 100
    end

    if #PinManager.Pins >= MAX_COUNT_PINS then
        -- too many pins
        -- TODO: notify the player here
        return
    end

    local pinID = GetPinIDFromPinData(pinData)
    if PinManager.Pins[pinID] then
        -- pin already exists
        -- TODO: notify the player here
        return
    end

    -- set defaults
    if (pinData.texture == nil and pinData.color == nil) then
        pinData.color = "Yellow"
    end

    if (pinData.title == nil) then
        pinData.title = "Custom Pin"
    end

    local pinObject = PinFactory:CreatePin(pinData, pinID)
    PinManager.Pins[pinID] = pinObject

    if pinData.setTracked then
        pinObject:Track()
    else
        pinObject:Untrack()
    end

    self:PersistPins()
    if MapPinEnhanced.pinTracker:GetActiveView() == "Pins" then
        MapPinEnhanced.pinTracker:AddEntry(pinObject.TrackerPinEntry)
    end
end

MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    PinManager:RestorePins()
end)
