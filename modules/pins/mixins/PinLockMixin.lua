---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinLockMixin = {}


function MapPinEnhancedPinLockMixin:SetLock(lock)
    self.pinData.lock = lock
    self:PersistPin()

    self.worldmapPin:SetLock(lock)
    self.minimapPin:SetLock(lock)

    if not self.suppressChangePublication then
        MapPinEnhanced:FireCallback("PIN_UPDATED_LOCK", self.pinID, lock)
    end
end

---@return boolean
function MapPinEnhancedPinLockMixin:IsLocked()
    return self.pinData.lock
end

---@return boolean
function MapPinEnhancedPinLockMixin:IsUnlocked()
    return not self:IsLocked()
end

function MapPinEnhancedPinLockMixin:ToggleLock()
    self:SetLock(not self:IsLocked())
end
