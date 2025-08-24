---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedSuperTrackedPinTitle : Frame
---@field text FontString
---@field bg Texture

---@class MapPinEnhancedSuperTrackedPinTemplate : Frame
---@field distantText FontString
---@field navFrameCreated boolean
---@field hooked boolean
---@field FadeIn AnimationGroup
---@field FadeOut AnimationGroup
---@field title MapPinEnhancedSuperTrackedPinTitle
---@field beam Texture
---@field arrows Texture
---@field pinFrame MapPinEnhancedBasePinTemplate
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

function MapPinEnhancedSuperTrackedPinMixin:SetTracked()
    MapPinEnhancedBasePinMixin.SetTracked(self.pinFrame) -- call base method to set pin data
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
    self:LockHighlight()
end

function MapPinEnhancedSuperTrackedPinMixin:SetUntracked()
    MapPinEnhancedBasePinMixin.SetUntracked(self.pinFrame) -- call base method to set pin data
    local f = SuperTrackedFrame
    if not f then
        return
    end
    f.Icon:SetAlpha(1)
    self:ClearAllPoints()
end

function MapPinEnhancedSuperTrackedPinMixin:SetPinIcon(icon, usesAtlas)
    MapPinEnhancedBasePinMixin.SetPinIcon(self.pinFrame, icon, usesAtlas) -- call base
end

function MapPinEnhancedSuperTrackedPinMixin:ShowPulse()
    MapPinEnhancedBasePinMixin.ShowPulse(self.pinFrame)
end

function MapPinEnhancedSuperTrackedPinMixin:ShowPulseFor(seconds)
    MapPinEnhancedBasePinMixin.ShowPulseFor(self.pinFrame, seconds)
end

function MapPinEnhancedSuperTrackedPinMixin:ShowPulseOnce()
    MapPinEnhancedBasePinMixin.ShowPulseOnce(self.pinFrame)
end

function MapPinEnhancedSuperTrackedPinMixin:HidePulse()
    MapPinEnhancedBasePinMixin.HidePulse(self.pinFrame)
end

function MapPinEnhancedSuperTrackedPinMixin:GetColorValue()
    MapPinEnhancedBasePinMixin.GetColorValue(self.pinFrame)
end

function MapPinEnhancedSuperTrackedPinMixin:SetPinColor(color)
    MapPinEnhancedBasePinMixin.SetPinColor(self.pinFrame, color)
end

function MapPinEnhancedSuperTrackedPinMixin:OnLoad()
    self:RegisterEvent("NAVIGATION_FRAME_CREATED");
    self:RegisterEvent("NAVIGATION_FRAME_DESTROYED");
    self:RegisterEvent("SUPER_TRACKING_CHANGED")
    self.hooked = false
    self.navFrameCreated = false;

    self.FadeOut:SetScript("OnFinished", function()
        if self.activeStyle == "beacon" then
            self:SetBeacon()
        else
            self:SetGrounded()
        end
    end)
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

function MapPinEnhancedSuperTrackedPinMixin:SetBeacon()
    local pinFrameScale = self.pinFrame:GetEffectiveScale()
    self.pinFrame:SetPoint("CENTER", 0, -25 * pinFrameScale)
    self.pinFrame:SetScale(0.6)
    self.beam:Show()
    self.arrows:Hide()
    self.title:ClearAllPoints()
    self.title:SetPoint("CENTER", 0, -15)
    self.title.bg:SetRotation(math.pi)
    self.title.bg:SetAlpha(0.5)
    self.title:SetScale(1)
    self.FadeIn:Play()
    -- self.pinFrame:HidePulse()
end

function MapPinEnhancedSuperTrackedPinMixin:SetGrounded()
    local pinFrameScale = self.pinFrame:GetEffectiveScale()
    self.pinFrame:SetPoint("CENTER", 0, 60 * pinFrameScale)
    self.pinFrame:SetScale(1)
    self.beam:Hide()
    self.arrows:Show()
    self.title:ClearAllPoints()
    self.title:SetPoint("CENTER", 0, 40)
    self.title.bg:SetRotation(0)
    self.title:SetScale(1.2)
    self.FadeIn:Play()
    -- self.pinFrame:ShowPulse()
end

---@param style 'grounded' | 'beacon'
function MapPinEnhancedSuperTrackedPinMixin:SetStyle(style)
    if self.activeStyle == style then
        return
    end
    self.activeStyle = style
    self.FadeIn:Stop()
    self.FadeOut:Stop()
    self.FadeOut:Play() -- fade out current style
end
