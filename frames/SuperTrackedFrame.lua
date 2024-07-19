---@class MapPinEnhancedSuperTrackedFrameMixin : MapPinEnhancedBasePinMixin
---@field navFrameCreated boolean
---@field hooked boolean
MapPinEnhancedSuperTrackedFrameMixin = {}
MapPinEnhancedSuperTrackedFrameMixin.navFrameCreated = false;

-- FIXME: SuperTrackeFrame is not reseted when the supertracking is changed to a different no pin type (i.e. quest, death, etc)


function MapPinEnhancedSuperTrackedFrameMixin:Clear()
    self:Hide()
end

function MapPinEnhancedSuperTrackedFrameMixin:OnClamped()
    self.title:Hide()
end

function MapPinEnhancedSuperTrackedFrameMixin:OnUnclamped()
    self.title:Show()
end

function MapPinEnhancedSuperTrackedFrameMixin:OnClampedStateChanged()
    local clamped = C_Navigation.WasClampedToScreen();
    if clamped then
        self:OnClamped()
    else
        self:OnUnclamped()
    end
end

function MapPinEnhancedSuperTrackedFrameMixin:OnShow()
    -- set anchor
    local f = SuperTrackedFrame
    if not f then
        return
    end
    if not self.hooked then
        hooksecurefunc(f, "PingNavFrame", function()
            self:OnClampedStateChanged()
        end)
        self.hooked = true
    end
    self:SetParent(f)
    self:SetPoint("CENTER", f, "CENTER", 0, 0)
    self:SetFrameLevel(f:GetFrameLevel() + 1)
    self:SetFrameStrata(f:GetFrameStrata())
end

function MapPinEnhancedSuperTrackedFrameMixin:OnLoad()
    self:RegisterEvent("NAVIGATION_FRAME_CREATED");
    self:RegisterEvent("NAVIGATION_FRAME_DESTROYED");
    self:RegisterEvent("SUPER_TRACKING_CHANGED");
    self.hooked = false
end

function MapPinEnhancedSuperTrackedFrameMixin:OnEvent(event)
    if event == "NAVIGATION_FRAME_CREATED" then
        self.navFrameCreated = true;
    elseif event == "NAVIGATION_FRAME_DESTROYED" then
        self.navFrameCreated = false;
    end
end
