---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L
local Options = MapPinEnhanced:GetModule("Options")
local MODE_ETA = Options.WAYFINDER_READOUT_MODE_ETA
local MODE_DISTANCE = Options.WAYFINDER_READOUT_MODE_DISTANCE
local MODE_COMBINED = Options.WAYFINDER_READOUT_MODE_COMBINED
local MODE_CYCLING = Options.WAYFINDER_READOUT_MODE_CYCLING
local CYCLE_DURATION = 5
local SLIDE_OFFSET = 8

---@alias WayfinderReadoutValueKind "eta"|"distance"|"combined"

---@class MapPinEnhancedWayfinderReadoutText : FontString
---@field fadeSlideIn AnimationGroup
---@field fadeSlideOut AnimationGroup
---@field readoutValueKind WayfinderReadoutValueKind?

---@class MapPinEnhancedWayfinderReadoutTemplate : Frame
---@field primaryText MapPinEnhancedWayfinderReadoutText
---@field secondaryText MapPinEnhancedWayfinderReadoutText
---@field currentText MapPinEnhancedWayfinderReadoutText?
---@field incomingText MapPinEnhancedWayfinderReadoutText?
---@field outgoingText MapPinEnhancedWayfinderReadoutText?
---@field mode WayfinderReadoutMode?
---@field distanceText string?
---@field etaText string?
---@field hasETA boolean?
---@field currentValueKind WayfinderReadoutValueKind?
---@field incomingValueKind WayfinderReadoutValueKind?
---@field cycleElapsed number?
---@field transitioning boolean?
MapPinEnhancedWayfinderReadoutMixin = {}

local VALID_MODES = {
    [MODE_ETA] = true,
    [MODE_DISTANCE] = true,
    [MODE_COMBINED] = true,
    [MODE_CYCLING] = true,
}

---@param valueKind WayfinderReadoutValueKind
---@param distanceText string
---@param etaText string
---@param hasETA boolean
---@return string
local function GetReadoutText(valueKind, distanceText, etaText, hasETA)
    if distanceText == "" then return "" end
    if valueKind == MODE_ETA then return etaText end
    if valueKind == MODE_COMBINED then
        if not hasETA then return distanceText end
        return string.format(L["%s - %s"], distanceText, etaText)
    end
    return distanceText
end

---@param textRegion MapPinEnhancedWayfinderReadoutText
---@param offsetY number
function MapPinEnhancedWayfinderReadoutMixin:SetTextRegionOffset(textRegion, offsetY)
    textRegion:ClearAllPoints()
    textRegion:SetPoint("CENTER", self, "CENTER", 0, offsetY)
end

---@param textRegion MapPinEnhancedWayfinderReadoutText
function MapPinEnhancedWayfinderReadoutMixin:StopTextRegionAnimations(textRegion)
    if textRegion.fadeSlideIn:IsPlaying() then textRegion.fadeSlideIn:Stop() end
    if textRegion.fadeSlideOut:IsPlaying() then textRegion.fadeSlideOut:Stop() end
end

function MapPinEnhancedWayfinderReadoutMixin:StopPresentation()
    self:SetScript("OnUpdate", nil)
    self.transitioning = nil
    self.incomingText = nil
    self.outgoingText = nil
    self.incomingValueKind = nil
    self.cycleElapsed = 0
    self:StopTextRegionAnimations(self.primaryText)
    self:StopTextRegionAnimations(self.secondaryText)
    self:SetTextRegionOffset(self.primaryText, 0)
    self:SetTextRegionOffset(self.secondaryText, 0)
end

function MapPinEnhancedWayfinderReadoutMixin:ClearTextRegions()
    for _, textRegion in ipairs({ self.primaryText, self.secondaryText }) do
        textRegion.readoutValueKind = nil
        textRegion:SetText("")
        textRegion:SetAlpha(0)
        textRegion:Hide()
    end
    self.currentText = nil
    self.currentValueKind = nil
end

---@param textRegion MapPinEnhancedWayfinderReadoutText
function MapPinEnhancedWayfinderReadoutMixin:UpdateTextRegion(textRegion)
    local valueKind = textRegion.readoutValueKind
    if not valueKind then return end
    textRegion:SetText(GetReadoutText(valueKind, self.distanceText or "", self.etaText or "", self.hasETA == true))
end

function MapPinEnhancedWayfinderReadoutMixin:UpdateTextRegions()
    self:UpdateTextRegion(self.primaryText)
    self:UpdateTextRegion(self.secondaryText)
end

function MapPinEnhancedWayfinderReadoutMixin:CanCycle()
    return self.mode == MODE_CYCLING and self.distanceText ~= nil and self.distanceText ~= "" and
        self.hasETA == true and self:IsVisible()
end

function MapPinEnhancedWayfinderReadoutMixin:RefreshCycling()
    if self:CanCycle() then
        if not self:GetScript("OnUpdate") then
            self:SetScript("OnUpdate", function(_, elapsed) self:OnUpdate(elapsed) end)
        end
    else
        self:SetScript("OnUpdate", nil)
    end
end

---@param valueKind WayfinderReadoutValueKind
function MapPinEnhancedWayfinderReadoutMixin:ShowValue(valueKind)
    self:StopPresentation()
    self:ClearTextRegions()

    local textRegion = self.primaryText
    textRegion.readoutValueKind = valueKind
    self:UpdateTextRegion(textRegion)
    local text = textRegion:GetText() or ""
    if text ~= "" then
        textRegion:SetAlpha(1)
        textRegion:Show()
    end

    self.currentText = textRegion
    self.currentValueKind = valueKind
    self:RefreshCycling()
end

function MapPinEnhancedWayfinderReadoutMixin:ResetPresentation()
    local mode = self.mode or MODE_COMBINED
    if mode == MODE_CYCLING then
        self:ShowValue(MODE_DISTANCE)
    else
        self:ShowValue(mode --[[@as WayfinderReadoutValueKind]])
    end
end

---@param mode WayfinderReadoutMode
function MapPinEnhancedWayfinderReadoutMixin:SetMode(mode)
    if not VALID_MODES[mode] then mode = MODE_COMBINED end
    if self.mode == mode then return end
    self.mode = mode
    self:ResetPresentation()
end

---@param distanceText string?
---@param etaText string?
---@param hasETA boolean
function MapPinEnhancedWayfinderReadoutMixin:SetValues(distanceText, etaText, hasETA)
    local previousDistanceAvailable = self.distanceText ~= nil and self.distanceText ~= ""
    local previousHasETA = self.hasETA == true

    self.distanceText = distanceText or ""
    self.etaText = etaText or ""
    self.hasETA = hasETA == true

    local distanceAvailable = self.distanceText ~= ""
    local availabilityChanged = previousDistanceAvailable ~= distanceAvailable or previousHasETA ~= self.hasETA
    if not self.currentText or availabilityChanged and self.mode == MODE_CYCLING then
        self:ResetPresentation()
        return
    end

    self:UpdateTextRegions()
    self:RefreshCycling()
end

function MapPinEnhancedWayfinderReadoutMixin:PrepareForTarget()
    self.distanceText = ""
    self.etaText = ""
    self.hasETA = false
    self:ResetPresentation()
end

function MapPinEnhancedWayfinderReadoutMixin:StartCycleTransition()
    if self.transitioning or not self:CanCycle() then return end

    local outgoingText = self.currentText or self.primaryText
    local incomingText = outgoingText == self.primaryText and self.secondaryText or self.primaryText
    local incomingValueKind = self.currentValueKind == MODE_DISTANCE and MODE_ETA or MODE_DISTANCE

    self:StopTextRegionAnimations(outgoingText)
    self:StopTextRegionAnimations(incomingText)

    outgoingText.readoutValueKind = self.currentValueKind
    outgoingText:SetAlpha(1)
    outgoingText:Show()
    self:SetTextRegionOffset(outgoingText, 0)

    incomingText.readoutValueKind = incomingValueKind
    self:UpdateTextRegion(incomingText)
    incomingText:SetAlpha(0)
    incomingText:Show()
    self:SetTextRegionOffset(incomingText, -SLIDE_OFFSET)

    self.transitioning = true
    self.incomingText = incomingText
    self.outgoingText = outgoingText
    self.incomingValueKind = incomingValueKind
    incomingText.fadeSlideIn:Play()
    outgoingText.fadeSlideOut:Play()
end

---@param incomingText MapPinEnhancedWayfinderReadoutText
function MapPinEnhancedWayfinderReadoutMixin:FinishCycleTransition(incomingText)
    if not self.transitioning or self.incomingText ~= incomingText then return end

    local outgoingText = self.outgoingText
    if outgoingText then
        if outgoingText.fadeSlideOut:IsPlaying() then outgoingText.fadeSlideOut:Stop() end
        outgoingText:SetAlpha(0)
        outgoingText:Hide()
        outgoingText.readoutValueKind = nil
        self:SetTextRegionOffset(outgoingText, 0)
    end

    incomingText:SetAlpha(1)
    incomingText:Show()
    self:SetTextRegionOffset(incomingText, 0)
    self.currentText = incomingText
    self.currentValueKind = self.incomingValueKind
    self.transitioning = nil
    self.incomingText = nil
    self.outgoingText = nil
    self.incomingValueKind = nil
    self.cycleElapsed = 0
end

---@param elapsed number
function MapPinEnhancedWayfinderReadoutMixin:OnUpdate(elapsed)
    if self.transitioning then return end
    self.cycleElapsed = (self.cycleElapsed or 0) + elapsed
    if self.cycleElapsed < CYCLE_DURATION then return end
    self.cycleElapsed = 0
    self:StartCycleTransition()
end

function MapPinEnhancedWayfinderReadoutMixin:OnLoad()
    self.primaryText.fadeSlideIn:SetScript("OnFinished", function()
        self:FinishCycleTransition(self.primaryText)
    end)
    self.secondaryText.fadeSlideIn:SetScript("OnFinished", function()
        self:FinishCycleTransition(self.secondaryText)
    end)
    self.mode = MODE_COMBINED
    self:PrepareForTarget()
end

function MapPinEnhancedWayfinderReadoutMixin:OnShow()
    self:ResetPresentation()
end

function MapPinEnhancedWayfinderReadoutMixin:OnHide()
    self:StopPresentation()
    self:ClearTextRegions()
end

--@debug@
MapPinEnhanced:Test("Wayfinder readout text selection", function(test)
    local combinedText = string.format(L["%s - %s"], "120 yd", "01:25")
    test:Expect(GetReadoutText(MODE_DISTANCE, "120 yd", "01:25", true)):ToBe("120 yd")
    test:Expect(GetReadoutText(MODE_ETA, "120 yd", "01:25", true)):ToBe("01:25")
    test:Expect(GetReadoutText(MODE_ETA, "120 yd", "--:--", false)):ToBe("--:--")
    test:Expect(GetReadoutText(MODE_COMBINED, "120 yd", "01:25", true)):ToBe(combinedText)
    test:Expect(GetReadoutText(MODE_COMBINED, "120 yd", "--:--", false)):ToBe("120 yd")
    test:Expect(GetReadoutText(MODE_DISTANCE, "", "--:--", false)):ToBe("")
end)
--@end-debug@
