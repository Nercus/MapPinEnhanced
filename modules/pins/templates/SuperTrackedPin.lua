---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedSuperTrackedPinTemplate : Frame
---@field distantText FontString
---@field navFrameCreated boolean
---@field hooked boolean
---@field fadeIn AnimationGroup
---@field morphToBeacon AnimationGroup
---@field morphToGrounded AnimationGroup
---@field titleBG Texture
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

function MapPinEnhancedSuperTrackedPinMixin:SetBeacon()
    -- Set scale
    self.pinFrame:SetScale(0.6)
    -- Set translation (vertical offset)
    self.pinFrame:SetPoint("CENTER", self, "CENTER", 0, -15)
    self.titleBG:SetPoint("CENTER", self, "CENTER", 0, 10)
    -- Set alpha
    self.beam:SetAlpha(1)
    self.arrows:SetAlpha(0)
end

function MapPinEnhancedSuperTrackedPinMixin:SetGrounded()
    -- Set scale
    self.pinFrame:SetScale(1.0)
    -- Set translation (vertical offset)
    self.pinFrame:SetPoint("CENTER", self, "CENTER", 0, 50)
    self.titleBG:SetPoint("CENTER", self, "CENTER", 0, 30)
    -- Set alpha
    self.beam:SetAlpha(0)
    self.arrows:SetAlpha(1)
end

function MapPinEnhancedSuperTrackedPinMixin:OnLoad()
    self:RegisterEvent("NAVIGATION_FRAME_CREATED");
    self:RegisterEvent("NAVIGATION_FRAME_DESTROYED");
    self:RegisterEvent("SUPER_TRACKING_CHANGED")
    self.hooked = false
    self.navFrameCreated = false;
    self.morphToBeacon:SetScript("OnFinished", function()
        self:SetBeacon()
    end)

    self.morphToGrounded:SetScript("OnFinished", function()
        self:SetGrounded()
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

---@param style 'grounded' | 'beacon'
function MapPinEnhancedSuperTrackedPinMixin:SetStyle(style)
    if self.activeStyle == style then
        return
    end
    self.activeStyle = style
    if style == "grounded" then
        self.morphToGrounded:Play()
    elseif style == "beacon" then
        self.morphToBeacon:Play()
    end
end
