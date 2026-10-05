---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class MapPinEnhancedWayfinderReadoutTemplate : MapPinEnhancedFadingFrameTemplate
---@field text FontString
---@field distanceText string?
---@field etaText string?
---@field hasETA boolean?
---@field showETA boolean?
---@field displayVisible boolean?
---@field onTextChanged fun()?
---@field maxWidth number?
---@field statusText string?
---@field layoutWidth number?
---@field layoutHeight number?
---@field layoutScale number?
---@field layoutShown boolean?
---@field layoutVisible boolean?
---@field layoutHiding boolean?
MapPinEnhancedWayfinderReadoutMixin = {}

-- Text samples may change without changing the space retained by the fade.
function MapPinEnhancedWayfinderReadoutMixin:NotifyLayoutChanged()
    local width, height = self:GetSize()
    local shown, hiding, scale = self:IsShown(), self.visibilityHiding == true, self:GetEffectiveScale()
    local visible = self:IsVisible()
    if width == self.layoutWidth and height == self.layoutHeight and scale == self.layoutScale and
        shown == self.layoutShown and visible == self.layoutVisible and hiding == self.layoutHiding then
        return
    end
    self.layoutWidth, self.layoutHeight, self.layoutScale = width, height, scale
    self.layoutShown, self.layoutHiding, self.layoutVisible = shown, hiding, visible
    if self.onTextChanged then self.onTextChanged() end
end

function MapPinEnhancedWayfinderReadoutMixin:UpdateText()
    local text = self.statusText or self.distanceText or ""
    local showETA = not self.statusText and self.showETA and self.hasETA
    if text ~= "" and showETA then
        text = string.format(L["%s - %s"], text, self.etaText or "")
    end
    -- Ancestor suppression retains current text; OnShow measures it before rendering again.
    if not self:GetParent():IsVisible() then
        self.text:SetText(text)
        self:SetShown(self.displayVisible == true and text ~= "")
        self:NotifyLayoutChanged()
        return
    end
    if text ~= "" or not self:IsVisible() then
        self.text:SetText(text)
        local width = self.maxWidth or 325
        if text ~= "" and showETA and self.text:GetUnboundedStringWidth() > width then
            self.text:SetText(self.distanceText .. "\n" .. (self.etaText or ""))
        end
        self.text:SetWidth(width)
        self.text:SetHeight(0)
        self.text:SetWordWrap(true)
        self.text:SetNonSpaceWrap(true)
        self:SetSize(width, math.max(1, self.text:GetStringHeight()))
    end
    self:SetShown(self.displayVisible == true and text ~= "")
    self:NotifyLayoutChanged()
end

---@param text string?
function MapPinEnhancedWayfinderReadoutMixin:SetStatusText(text)
    self.statusText = text
    self:UpdateText()
end

-- Floating's clamped presentation can suppress a readout while samples continue.
---@param visible boolean
function MapPinEnhancedWayfinderReadoutMixin:SetDisplayVisible(visible)
    self.displayVisible = visible
    self:UpdateText()
end

function MapPinEnhancedWayfinderReadoutMixin:OnHide()
    if not self.distanceText or self.distanceText == "" then self.text:SetText("") end
    self:NotifyLayoutChanged()
end

---@param showETA boolean
function MapPinEnhancedWayfinderReadoutMixin:SetShowETA(showETA)
    self.showETA = showETA
    self:UpdateText()
end

---@param distanceText string?
---@param etaText string?
---@param hasETA boolean
function MapPinEnhancedWayfinderReadoutMixin:SetValues(distanceText, etaText, hasETA)
    self.distanceText = distanceText
    self.etaText = etaText
    self.hasETA = hasETA
    self:UpdateText()
end

function MapPinEnhancedWayfinderReadoutMixin:PrepareForTarget()
    self.statusText = nil
    self:HideImmediately()
    self:SetValues(nil, nil, false)
end

function MapPinEnhancedWayfinderReadoutMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self)
    self.displayVisible = true
    self.showETA = true
    self:PrepareForTarget()
end
