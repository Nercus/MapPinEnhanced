---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedSuperTrackedPinTemplate : MapPinEnhancedBasePinTemplate
---@field distantText FontString
---@field navFrameCreated boolean
---@field hooked boolean
---@field fadeIn AnimationGroup
MapPinEnhancedSuperTrackedPinMixin = {}

---@param timeInSeconds number? time in seconds, if nil, ??:?? will be displayed
function MapPinEnhancedSuperTrackedPinMixin:UpdateTimeText(timeInSeconds)
    if not self.distantText:IsShown() then
        return
    end
    if not timeInSeconds or timeInSeconds < 0 then
        self.distantText:SetText("??:??")
        return
    end
    local timeText = SecondsToClock(timeInSeconds)
    self.distantText:SetText(timeText)
end

function MapPinEnhancedSuperTrackedPinMixin:OnUpdateClampedState()
    local clampedState = C_Navigation.WasClampedToScreen()
    if clampedState then
        self:Hide()
    else
        self:Show()
    end
end

function MapPinEnhancedSuperTrackedPinMixin:OnShow()
    -- set anchor
    local f = SuperTrackedFrame
    if not f then
        return
    end
    f.Icon:SetAlpha(0)
    if not self.hooked then
        hooksecurefunc(f, "PingNavFrame", function()
            self:OnUpdateClampedState()
        end)
        self.hooked = true
    end
    self:SetParent(f)
    self:SetPoint("CENTER", f, "CENTER", 0, 0)
    self:SetFrameLevel(f:GetFrameLevel() + 1)
    self:SetFrameStrata(f:GetFrameStrata())
    self:SetTracked()
    self:LockHighlight()
end

function MapPinEnhancedSuperTrackedPinMixin:OnHide()
    local f = SuperTrackedFrame
    if not f then
        return
    end
    f.Icon:SetAlpha(1)
end

function MapPinEnhancedSuperTrackedPinMixin:OnLoad()
    self:RegisterEvent("NAVIGATION_FRAME_CREATED");
    self:RegisterEvent("NAVIGATION_FRAME_DESTROYED");
    self:RegisterEvent("SUPER_TRACKING_CHANGED")
    self.hooked = false
    self.navFrameCreated = false;
end

function MapPinEnhancedSuperTrackedPinMixin:OnEvent(event)
    if event == "NAVIGATION_FRAME_CREATED" then
        self.navFrameCreated = true;
    elseif event == "NAVIGATION_FRAME_DESTROYED" then
        self.navFrameCreated = false;
    elseif event == "SUPER_TRACKING_CHANGED" then
        local isSuperTrackingUserWaypoint = C_SuperTrack.IsSuperTrackingUserWaypoint()
        if not isSuperTrackingUserWaypoint then
            self:Hide()
            return
        else
            if self:IsShown() then return end
            self:Show()
        end
    end
end
