---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

-- ---@class Animations
-- local Animations = MapPinEnhanced:GetModule("Animations")

---@class MapPinEnhancedAnimationVisibilityMixin : AnimationGroup
---@field showOnPlay boolean? Wether to show the parent when the animation plays, setable via keyvalues
---@field hideOnFinished boolean? Wether to hide the parent when the animation finishes, setable via keyvalues
MapPinEnhancedAnimationVisibilityMixin = {}


function MapPinEnhancedAnimationVisibilityMixin:OnPlayShow()
    self:GetParent():Show()
end

function MapPinEnhancedAnimationVisibilityMixin:OnFinishedHide()
    self:GetParent():Hide()
end

---@class MapPinEnhancedAnimationRotationMixin : AnimationGroup
---@field stopAtEnd boolean? Wether to stop the rotation at the end, setable via keyvalues
MapPinEnhancedAnimationRotationMixin = {}


function MapPinEnhancedAnimationRotationMixin:OnFinishedRotateLeft90()
    if not self.stopAtEnd then return end
    local parent = self:GetParent() --[[@as Texture]] -- The parent is expected to be a Texture here
    local currentRotation = parent:GetRotation() or 0
    parent:SetRotation(currentRotation - math.pi / 2)
end

function MapPinEnhancedAnimationRotationMixin:OnFinishedRotateRight90()
    if not self.stopAtEnd then return end
    local parent = self:GetParent() --[[@as Texture]] -- The parent is expected to be a Texture here
    local currentRotation = parent:GetRotation() or 0
    parent:SetRotation(currentRotation + math.pi / 2)
end
