---@class MapPinEnhancedWayfinderActionButton : Button
---@field icon Texture
---@field cooldown Cooldown
MapPinEnhancedWayfinderActionButtonMixin = {}

function MapPinEnhancedWayfinderActionButtonMixin:Setup()
    self:RegisterForClicks("LeftButtonUp", "LeftButtonDown")
    self:SetPropagateMouseClicks(false)
end

function MapPinEnhancedWayfinderActionButtonMixin:OnEnter()
    local instruction = self:GetParent()
    ---@cast instruction MapPinEnhancedWayfinderInstructionTemplate
    instruction:OnActionEnter(self)
end

function MapPinEnhancedWayfinderActionButtonMixin:OnLeave()
    local instruction = self:GetParent()
    ---@cast instruction MapPinEnhancedWayfinderInstructionTemplate
    instruction:OnActionLeave()
end
