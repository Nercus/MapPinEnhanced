---@class Wayfinder
local Wayfinder = select(2, ...)

---@class PinManager : Module
local PinManager = Wayfinder:CreateModule("PinManager")
-- NOTE: Create, delete and manage pins here (multiple pins)

---@class PinFactory : Module
local PinFactory = Wayfinder:GetModule("PinFactory")

---@type table<string, PinObject>
PinManager.Pins = {}

---Get a string representation of a position from pinData
---@param pinData pinData
---@return string
local function GetPositionStringFromPinData(pinData)
    -- the x and y coordinates are normalized so we cut them here to avoid to many pins on the same point
    return string.format("%s:%.4f:%.4f", pinData.mapID, pinData.x, pinData.y)
end


---add a pin
---@param pinData pinData
function PinManager:AddPin(pinData)
    assert(pinData, "Pin data is required to create a pin.")
    assert(pinData.mapID, "Pin data must contain a mapID.")
    assert(pinData.x, "Pin data must contain an x coordinate.")
    assert(pinData.y, "Pin data must contain a y coordinate.")

    local positionString = GetPositionStringFromPinData(pinData)
    if self.Pins[positionString] then
        -- pin already exists
        -- NOTE: maybe we should notify the player here
        return
    end
    local pinID = positionString
    local pinObject = PinFactory:CreatePin(pinData, pinID)
    self.Pins[positionString] = pinObject
end
