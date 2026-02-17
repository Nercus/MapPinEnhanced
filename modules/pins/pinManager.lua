---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Pins
---@field trackedPin MapPinEnhancedPinMixin the currently tracked pin, used to update wayfinders when the tracked pin changes
local Pins = MapPinEnhanced:GetModule("Pins")

local function CreatePin()
    local pinID = MapPinEnhanced:GenerateUUID("pin")
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
function Pins:ReleasePin(pinID)
    if not pinID then return end
    local pin = self:GetPinByID(pinID)
    pinsPool:Release(pin)
end

---@param pin MapPinEnhancedPinMixin | nil
function Pins:SetTrackedPin(pin)
    self.trackedPin = pin
end

function Pins:GetTrackedPin()
    return self.trackedPin
end

function Pins:UntrackTrackedPin()
    if not self.trackedPin then return end
    self.trackedPin:Untrack()
    self.trackedPin = nil
end

local function OnSuperTrackingChanged()
    local isWaypointTracked = C_SuperTrack.IsSuperTrackingUserWaypoint()
    if not isWaypointTracked then
        Pins:UntrackTrackedPin()
    end
end


MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", OnSuperTrackingChanged)
