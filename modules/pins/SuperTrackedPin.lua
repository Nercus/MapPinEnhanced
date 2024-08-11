-- Template: file://./SuperTrackedPin.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedSuperTrackedPinMixin : MapPinEnhancedBasePinMixin
---@field navFrameCreated boolean
---@field hooked boolean
---@field fadeIn AnimationGroup
---@field distantText FontString
MapPinEnhancedSuperTrackedPinMixin = {}
MapPinEnhancedSuperTrackedPinMixin.navFrameCreated = false;


local CONSTANTS = MapPinEnhanced.CONSTANTS

function MapPinEnhancedSuperTrackedPinMixin:Clear()
    self:Hide()
end

function MapPinEnhancedSuperTrackedPinMixin:OnClamped()
    self.title:Hide()
    self.distantText:Hide()
end

function MapPinEnhancedSuperTrackedPinMixin:OnUnclamped()
    self.title:Show()
    self.distantText:Show()
end

function MapPinEnhancedSuperTrackedPinMixin:OnClampedStateChanged()
    local clamped = C_Navigation.WasClampedToScreen();
    if clamped then
        self:OnClamped()
    else
        self:OnUnclamped()
    end
end

function MapPinEnhancedSuperTrackedPinMixin:SetPersitentState(isPersistent)
    if not self.pinData then return end
    local hasDefaultTitle = self.pinData.title == CONSTANTS.DEFAULT_PIN_NAME
    if isPersistent and not hasDefaultTitle then
        self.persitentIcon:Show()
    else
        self.persitentIcon:Hide()
    end
end

function MapPinEnhancedSuperTrackedPinMixin:UpdateTitleVisibility()
    local clamped = C_Navigation.WasClampedToScreen();
    if clamped then
        self.title:Hide()
        self.distantText:Hide()
        self.persitentIcon:Hide()
    else
        self.title:Show()
        self.distantText:Show()
        self.persitentIcon:Show()
    end

    if not self.pinData then return end
    local hasDefaultTitle = self.pinData.title == CONSTANTS.DEFAULT_PIN_NAME
    self.title:SetShown(not hasDefaultTitle)
    self.persitentIcon:SetShown(not hasDefaultTitle)
end

---override the function in the base pin mixin to handle the title visibilty for the default title
---@param overrideTitle any
function MapPinEnhancedSuperTrackedPinMixin:SetTitle(overrideTitle)
    if not self.pinData then
        return
    end
    if overrideTitle then
        self.pinData.title = overrideTitle
    end
    local title = self.pinData.title
    self.title:SetText(title)
    self:UpdateTitleVisibility()
end

function MapPinEnhancedSuperTrackedPinMixin:OnShow()
    -- set anchor
    local f = SuperTrackedFrame
    if not f then
        return
    end
    if not self.hooked then
        hooksecurefunc(f, "PingNavFrame", function()
            self:UpdateTitleVisibility()
        end)
        self.hooked = true
    end
    self:SetParent(f)
    self:SetPoint("CENTER", f, "CENTER", 0, 0)
    self:SetFrameLevel(f:GetFrameLevel() + 1)
    self:SetFrameStrata(f:GetFrameStrata())
    self.fadeIn:Play()
    self:UpdateTitleVisibility()
end

---@param timeInSeconds number? time in seconds, if nil, ??:?? will be displayed
function MapPinEnhancedSuperTrackedPinMixin:UpdateTimeText(timeInSeconds)
    if not timeInSeconds or timeInSeconds < 0 then
        self.distantText:SetText("??:??")
        return
    end
    local timeText = SecondsToClock(timeInSeconds)
    self.distantText:SetText(timeText)
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
