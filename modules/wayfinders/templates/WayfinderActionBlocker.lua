---@class MapPinEnhancedWayfinderActionVisual : Button
---@field icon Texture
---@field cooldown Cooldown
MapPinEnhancedWayfinderActionBlockerMixin = {}

function MapPinEnhancedWayfinderActionBlockerMixin:Setup()
    self:SetPropagateMouseClicks(false)
end

function MapPinEnhancedWayfinderActionBlockerMixin:OnEnter()
    local instruction = self:GetParent()
    ---@cast instruction MapPinEnhancedWayfinderInstructionTemplate
    instruction:OnActionEnter(self)
end

function MapPinEnhancedWayfinderActionBlockerMixin:OnLeave()
    local instruction = self:GetParent()
    ---@cast instruction MapPinEnhancedWayfinderInstructionTemplate
    instruction:OnActionLeave()
end
