---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class Notifications
local Notifications = MapPinEnhanced:GetModule("Notifications")

---@class MapPinEnhancedNotificationFrame : Frame
---@field text FontString
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin
MapPinEnhancedNotificationFrameMixin = {}

function MapPinEnhancedNotificationFrameMixin:OnLoad()
    Notifications.notificationFrame = self
end

function MapPinEnhancedNotificationFrameMixin:OnHide()
    Notifications:OnNotificationHidden()
end

function MapPinEnhancedNotificationFrameMixin:ShowMessage(message)
    self.text:SetText(message)
    self:FadeIn()
end

function MapPinEnhancedNotificationFrameMixin:FadeIn()
    self.fadeIn:PlayShowing(self.fadeOut)
end

function MapPinEnhancedNotificationFrameMixin:FadeOut()
    self.fadeOut:PlayHiding(self.fadeIn)
end

---@param instant boolean?
function MapPinEnhancedNotificationFrameMixin:HideMessage(instant)
    if instant then
        self.fadeOut:SetParentShownInstantly(false, self.fadeIn)
        return
    end

    self:FadeOut()
end

function MapPinEnhancedNotificationFrameMixin:OnClick()
    self:HideMessage(true)
end
