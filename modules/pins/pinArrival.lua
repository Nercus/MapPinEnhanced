---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")
local Options = MapPinEnhanced:GetModule("Options")
local Notifications = MapPinEnhanced:GetModule("Notifications")

---@param pinID UUID
---@param notify boolean
function Pins:ApplyTrackedPinArrival(pinID, notify)
    local pin = self:GetPinByID(pinID)
    if not pin or not pin:IsTracked() then return end
    local locked = pin:IsLocked()
    if notify then
        local mode = Options:GetOptionValue("Pins.Tracking.ArrivalNotification") --[[@as string]]
        if mode == "all" or mode == "locked" and locked then
            local data = pin:GetPinData()
            local location = string.format("%.2f, %.2f", data.x * 100, data.y * 100)
            Notifications:ShowNotification(locked and "PIN_LOCKED_NAMED" or "PIN_NAMED_REACHED",
                data.title or MapPinEnhanced.L["Map Pin"], location)
        end
    end
    -- Detection is independent of removal permission; a locked destination stays owned.
    if not locked and pin.group then pin.group:MarkPinReached(pinID) end
end
