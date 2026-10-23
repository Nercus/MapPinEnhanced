---@class MapPinEnhancedWayfinderActionVisual : Button
---@field icon Texture
---@field instructionOwner MapPinEnhancedWayfinderInstructionTemplate? for sibling controls
MapPinEnhancedWayfinderActionBlockerMixin = {}

function MapPinEnhancedWayfinderActionBlockerMixin:Setup()
    self:SetPropagateMouseClicks(false)
end

function MapPinEnhancedWayfinderActionBlockerMixin:OnEnter()
    local instruction = self.instructionOwner or self:GetParent()
    ---@cast instruction MapPinEnhancedWayfinderInstructionTemplate
    instruction:OnActionEnter(self)
end

function MapPinEnhancedWayfinderActionBlockerMixin:OnLeave()
    local instruction = self.instructionOwner or self:GetParent()
    ---@cast instruction MapPinEnhancedWayfinderInstructionTemplate
    instruction:OnActionLeave()
end
