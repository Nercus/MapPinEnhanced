---@class Wayfinder
local Wayfinder = select(2, ...)

---@class PinManager : Module
local PinManager = Wayfinder:CreateModule("PinManager")
-- NOTE: Create, delete and manage pins here (multiple pins)

---@class PinFactory : Module
local PinFactory = Wayfinder:GetModule("PinFactory")



---add a pin
---@param pinData pinData
function PinManager:AddPin(pinData)
    assert(pinData, "Pin data is required to create a pin.")
    assert(pinData.mapID, "Pin data must contain a mapID.")
    assert(pinData.x, "Pin data must contain an x coordinate.")
    assert(pinData.y, "Pin data must contain a y coordinate.")

    PinFactory:CreatePin(pinData)
end
