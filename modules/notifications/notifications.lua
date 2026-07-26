---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class Notifications
---@field notificationFrame MapPinEnhancedNotificationFrame
---@field isDisplaying boolean
---@field displayTimer FunctionContainer
local Notifications = MapPinEnhanced:GetModule("Notifications")
Notifications.queue = {}
Notifications.isDisplaying = false
Notifications.displayTimer = nil

local L = MapPinEnhanced.L

local DISPLAY_DURATION_SECONDS = 2

---@enum (key) NotificationTypes
local NOTIFICATION_MESSAGES = {
    ["PIN_NAMED_REACHED"] = L["\"%s\" reached at %s."],
    ["PIN_REACHED"] = L["Location reached at %s."],
    ["PIN_LOCKED_NAMED"] = L["\"%s\" reached at %s."] .. "\n" .. L["It is locked."],
    ["PIN_LOCKED"] = L["Location reached at %s."] .. "\n" .. L["It is locked."],
    ["MAP_UNAVAILABLE"] = L["Cannot set waypoint on the %s map."],
}


---@param message NotificationTypes
---@param ... any
---@return string
local function GetNotificationText(message, ...)
    assert(NOTIFICATION_MESSAGES[message], "Unknown notification message: " .. tostring(message))
    local text = NOTIFICATION_MESSAGES[message]
    if select("#", ...) > 0 then
        return string.format(text, ...)
    end
    return text
end

function Notifications:UpdateQueue()
    if self.isDisplaying then return end

    local notificationFrame = self.notificationFrame
    if not notificationFrame then return end

    local message = table.remove(self.queue, 1)
    if not message then return end

    self.isDisplaying = true
    notificationFrame:ShowMessage(message)

    self.displayTimer = C_Timer.NewTimer(DISPLAY_DURATION_SECONDS, function()
        self.displayTimer = nil
        notificationFrame:HideMessage()
    end)
end

---@param message NotificationTypes
---@param ... any
function Notifications:ShowNotification(message, ...)
    assert(self.notificationFrame, "Notification frame not loaded.")
    table.insert(self.queue, GetNotificationText(message, ...))
    self:UpdateQueue()
end

function Notifications:OnNotificationHidden()
    if self.displayTimer and not self.displayTimer:IsCancelled() then
        self.displayTimer:Cancel()
    end
    self.displayTimer = nil
    self.isDisplaying = false
    self:UpdateQueue()
end
