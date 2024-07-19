---@class MapPinEnhancedSuperTrackedPinMixin : MapPinEnhancedBasePinMixin
---@field navFrameCreated boolean
---@field hooked boolean
MapPinEnhancedSuperTrackedPinMixin = {}
MapPinEnhancedSuperTrackedPinMixin.navFrameCreated = false;

-- FIXME: SuperTrackeFrame is not reseted when the supertracking is changed to a different no pin type (i.e. quest, death, etc)


function MapPinEnhancedSuperTrackedPinMixin:Clear()
    self:Hide()
end

function MapPinEnhancedSuperTrackedPinMixin:OnClamped()
    self.title:Hide()
end

function MapPinEnhancedSuperTrackedPinMixin:OnUnclamped()
    self.title:Show()
end

function MapPinEnhancedSuperTrackedPinMixin:OnClampedStateChanged()
    local clamped = C_Navigation.WasClampedToScreen();
    if clamped then
        self:OnClamped()
    else
        self:OnUnclamped()
    end
end

function MapPinEnhancedSuperTrackedPinMixin:OnShow()
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

function MapPinEnhancedSuperTrackedPinMixin:OnLoad()
    self:RegisterEvent("NAVIGATION_FRAME_CREATED");
    self:RegisterEvent("NAVIGATION_FRAME_DESTROYED");
    self:RegisterEvent("SUPER_TRACKING_CHANGED");
    self.hooked = false
end

function MapPinEnhancedSuperTrackedPinMixin:OnEvent(event)
    if event == "NAVIGATION_FRAME_CREATED" then
        self.navFrameCreated = true;
    elseif event == "NAVIGATION_FRAME_DESTROYED" then
        self.navFrameCreated = false;
    end
end
