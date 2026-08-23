---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

-- ---@class Animations
-- local Animations = MapPinEnhanced:GetModule("Animations")

---@class MapPinEnhancedAnimationVisibilityMixin : AnimationGroup
---@field showOnPlay boolean? Whether to show the parent when the animation plays, setable via keyvalues
---@field hideOnFinished boolean? Whether to hide the parent when the animation finishes, setable via keyvalues
MapPinEnhancedAnimationVisibilityMixin = {}

---@param oppositeAnimation AnimationGroup?
function MapPinEnhancedAnimationVisibilityMixin:PlayReplacing(oppositeAnimation)
    if oppositeAnimation and oppositeAnimation:IsPlaying() then
        oppositeAnimation:Stop()
    end
    if self:IsPlaying() then return end
    self:Play()
end

---@param oppositeAnimation AnimationGroup?
function MapPinEnhancedAnimationVisibilityMixin:PlayShowing(oppositeAnimation)
    local parent = self:GetParent()
    if parent:IsShown() and parent:GetAlpha() >= 1 and not self:IsPlaying() then return end
    self:PlayReplacing(oppositeAnimation)
end

---@param oppositeAnimation AnimationGroup?
function MapPinEnhancedAnimationVisibilityMixin:PlayHiding(oppositeAnimation)
    local parent = self:GetParent()
    if (not parent:IsShown() or parent:GetAlpha() <= 0) and not self:IsPlaying() then return end
    self:PlayReplacing(oppositeAnimation)
end

---@param shown boolean
---@param oppositeAnimation AnimationGroup?
function MapPinEnhancedAnimationVisibilityMixin:SetParentShownInstantly(shown, oppositeAnimation)
    if oppositeAnimation and oppositeAnimation:IsPlaying() then
        oppositeAnimation:Stop()
    end
    if self:IsPlaying() then
        self:Stop()
    end

    local parent = self:GetParent()
    parent:SetAlpha(shown and 1 or 0)
    parent:SetShown(shown)
end

---@param shown boolean
---@param oppositeAnimation MapPinEnhancedAnimationVisibilityMixin
---@param instantly? boolean
function MapPinEnhancedAnimationVisibilityMixin:ApplyParentShown(shown, oppositeAnimation, instantly)
    if instantly then
        self:SetParentShownInstantly(shown, oppositeAnimation)
    elseif shown then
        self:PlayShowing(oppositeAnimation)
    else
        self:GetParent():Show()
        oppositeAnimation:PlayHiding(self)
    end
end

function MapPinEnhancedAnimationVisibilityMixin:OnPlayShow()
    if not self.showOnPlay then return end
    self:GetParent():Show()
end

function MapPinEnhancedAnimationVisibilityMixin:OnFinishedHide()
    if not self.hideOnFinished then return end
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
