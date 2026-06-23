---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class Notifications
local Notifications = MapPinEnhanced:GetModule("Notifications")

---@class MapPinEnhancedNotificationFrame : Frame
---@field text FontString
---@field fadeIn AnimationGroup
---@field fadeOut AnimationGroup
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
    if self.fadeOut:IsPlaying() then
        self.fadeOut:Stop()
    end
    self.fadeIn:Play()
end

function MapPinEnhancedNotificationFrameMixin:FadeOut()
    if self.fadeOut:IsPlaying() then return end
    if self.fadeIn:IsPlaying() then
        self.fadeIn:Stop()
    end
    self.fadeOut:Play()
end

---@param instant boolean?
function MapPinEnhancedNotificationFrameMixin:HideMessage(instant)
    if instant then
        if self.fadeIn:IsPlaying() then
            self.fadeIn:Stop()
        end
        if self.fadeOut:IsPlaying() then
            self.fadeOut:Stop()
        end
        self:Hide()
        return
    end

    self:FadeOut()
end

function MapPinEnhancedNotificationFrameMixin:OnClick()
    self:HideMessage(true)
end
