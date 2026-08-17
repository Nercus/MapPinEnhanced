---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedMinimapPinTemplate : MapPinEnhancedBasePinTemplate
---@field groupBadge MapPinEnhancedPinGroupBadgeTemplate
---@field hoverScaleEnabled boolean
---@field hoverScaleTarget number | nil
MapPinEnhancedMinimapPinMixin = {}

local Options = MapPinEnhanced:GetModule("Options")

local HOVER_SCALE = 1.2
local HOVER_SCALE_DURATION = 0.15
local HOVER_SCALE_SPEED = (HOVER_SCALE - 1) / HOVER_SCALE_DURATION

function MapPinEnhancedMinimapPinMixin:OnLoad()
    self.pulseHighlight:SetIgnoreParentScale(true)
    Options:SubscribeToOptionChanges("Pins.Miscellaneous.ScaleOnHover", function(value)
        self.hoverScaleEnabled = value
        if value then return end
        self:ResetHoverScale()
    end)
end

function MapPinEnhancedMinimapPinMixin:ResetHoverScale()
    self:SetScript("OnUpdate", nil)
    self.hoverScaleTarget = nil
    self:SetScale(1)
end

function MapPinEnhancedMinimapPinMixin:OnHide()
    self:ResetHoverScale()
end

---@param elapsed number
function MapPinEnhancedMinimapPinMixin:OnHoverScaleUpdate(elapsed)
    local target = self.hoverScaleTarget or 1
    local scale = self:GetScale()
    local step = HOVER_SCALE_SPEED * elapsed

    if scale < target then
        scale = math.min(scale + step, target)
    else
        scale = math.max(scale - step, target)
    end

    self:SetScale(scale)
    if scale == target then
        self:SetScript("OnUpdate", nil)
        self.hoverScaleTarget = nil
    end
end

---@param hovered boolean
function MapPinEnhancedMinimapPinMixin:SetHoverScale(hovered)
    local target = hovered and self.hoverScaleEnabled and HOVER_SCALE or 1
    if self:GetScale() == target then return end

    self.hoverScaleTarget = target
    self:SetScript("OnUpdate", self.OnHoverScaleUpdate)
end

function MapPinEnhancedMinimapPinMixin:OnEnter()
    self:SetHoverScale(true)
    if not self.pin then return end
    self.pin:ShowTooltip(self)
end

function MapPinEnhancedMinimapPinMixin:OnLeave()
    self:SetHoverScale(false)
    GameTooltip:Hide()
end
