---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class MapPinEnhancedTooltipMixin : Frame
---@field tooltip string?
---@field tooltipAnchor string?
---@field tooltipInitialized boolean?
MapPinEnhancedTooltipMixin = {}

function MapPinEnhancedTooltipMixin:OnTooltipLoad()
    if self.tooltipInitialized or not self.tooltip or self.tooltip == "" then return end
    self.tooltipInitialized = true
    self:HookScript("OnEnter", self.OnTooltipEnter)
    self:HookScript("OnLeave", self.OnTooltipLeave)
end

function MapPinEnhancedTooltipMixin:OnTooltipEnter()
    if not self.tooltip or self.tooltip == "" then return end
    GameTooltip:SetOwner(self, self.tooltipAnchor or "ANCHOR_RIGHT")
    GameTooltip:SetText(rawget(L, self.tooltip) or self.tooltip, 1, 1, 1, 1, true)
    GameTooltip:Show()
end

function MapPinEnhancedTooltipMixin:OnTooltipLeave()
    if GameTooltip:GetOwner() == self then GameTooltip:Hide() end
end

---@param tooltip string?
function MapPinEnhancedTooltipMixin:SetTooltip(tooltip)
    self.tooltip = tooltip
    if tooltip then
        self:OnTooltipLoad()
    elseif GameTooltip:GetOwner() == self then
        GameTooltip:Hide()
    end
end
