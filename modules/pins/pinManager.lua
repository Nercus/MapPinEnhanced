---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")

local function CreatePin()
    local pinID = MapPinEnhanced:GenerateUUID('pin')
    return CreateAndInitFromMixin(MapPinEnhancedPinMixin, pinID)
end

local function ResetPin(_, pin, isNew)
    if not pin then return end
    if isNew then return end
    pin:Reset()
end

---@type ObjectPool<MapPinEnhancedPinMixin>
local pinsPool = CreateObjectPool(CreatePin, ResetPin)
pinsPool.capacity = 1000 -- only allow 1000 pins at the same time


---@param initPinData pinData
---@return MapPinEnhancedPinMixin
function Pins:CreatePin(initPinData)
    local pin = pinsPool:Acquire()
    pin.pinData = initPinData
    pin:SetPinData(initPinData)
    return pin
end

function Pins:GetPinByID(pinID)
    if not pinID then return nil end
    ---@param pin MapPinEnhancedPinMixin
    for pin in pinsPool:EnumerateActive() do
        if pin.pinID == pinID then
            return pin
        end
    end
end

---@param pinID UUID
function Pins:RemovePin(pinID)
    if not pinID then return end
    local pin = self:GetPinByID(pinID)
    pinsPool:Release(pin)
end
