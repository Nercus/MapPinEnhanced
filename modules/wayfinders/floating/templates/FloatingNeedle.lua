---@class MapPinEnhancedFloatingFallbackTexture : Texture
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@class MapPinEnhancedFloatingFallbackCloseTexture : MapPinEnhancedFloatingFallbackTexture
---@field jump AnimationGroup

---@class MapPinEnhancedWayfinderFloatingNeedleTemplate : Frame
---@field texture Texture
---@field fallbackTexture MapPinEnhancedFloatingFallbackTexture
---@field fallbackCloseTexture MapPinEnhancedFloatingFallbackCloseTexture
---@field fallbackBackground Texture
---@field rotation number?
---@field spriteCell number?
---@field fallback boolean?
---@field fallbackClose boolean?
MapPinEnhancedWayfinderFloatingNeedleMixin = {}

function MapPinEnhancedWayfinderFloatingNeedleMixin:OnLoad()
    self:SetActive(false)
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingNeedleMixin:SetColor(color)
    self.texture:SetVertexColor(color:GetRGBA())
    self.fallbackTexture:SetVertexColor(color:GetRGBA())
    self.fallbackCloseTexture:SetVertexColor(color:GetRGBA())
end

---@param fallback boolean
---@param close boolean?
function MapPinEnhancedWayfinderFloatingNeedleMixin:SetFallback(fallback, close)
    self.fallback = fallback
    self.fallbackClose = fallback and close == true
    self.texture:SetShown(not fallback)
    self.fallbackBackground:SetShown(fallback)
    local instantly = not fallback or not self:IsVisible()
    local farTexture = self.fallbackTexture
    local closeTexture = self.fallbackCloseTexture
    if instantly then
        farTexture.fadeIn:SetParentShownInstantly(fallback and not close, farTexture.fadeOut)
        closeTexture.fadeIn:SetParentShownInstantly(self.fallbackClose, closeTexture.fadeOut)
        closeTexture.jump:Stop()
        return
    end
    -- Keep only the latest requested state while the visible texture fades out.
    if farTexture.fadeOut:IsPlaying() or closeTexture.fadeOut:IsPlaying() then return end
    local outgoing = self.fallbackClose and farTexture or closeTexture
    if outgoing:IsShown() then
        outgoing.fadeOut:PlayReplacing(outgoing.fadeIn)
    else
        self:FinishFallbackTransition()
    end
end

function MapPinEnhancedWayfinderFloatingNeedleMixin:FinishFallbackTransition()
    if not self.fallback or not self:IsVisible() then return end
    if self.fallbackClose then
        local closeTexture = self.fallbackCloseTexture
        closeTexture.fadeIn:PlayReplacing(closeTexture.fadeOut)
        if not closeTexture.jump:IsPlaying() then closeTexture.jump:Play() end
    else
        self.fallbackTexture.fadeIn:PlayReplacing(self.fallbackTexture.fadeOut)
    end
end

function MapPinEnhancedWayfinderFloatingNeedleMixin:OnShow()
    self:SetFallback(self.fallback == true, self.fallbackClose)
    self:SetRotation(self.rotation or 0)
end

function MapPinEnhancedWayfinderFloatingNeedleMixin:OnHide()
    -- Keep the requested presentation for re-show, but release all animation work.
    self.fallbackCloseTexture.jump:Stop()
    self.fallbackCloseTexture.fadeIn:SetParentShownInstantly(false, self.fallbackCloseTexture.fadeOut)
    self.fallbackTexture.fadeIn:SetParentShownInstantly(false, self.fallbackTexture.fadeOut)
    self:SetRotation(0)
end

---@param active boolean
function MapPinEnhancedWayfinderFloatingNeedleMixin:SetActive(active)
    if not active then
        self:SetRotation(0)
    end
    self:SetShown(active)
end

---@param rotation number
function MapPinEnhancedWayfinderFloatingNeedleMixin:SetRotation(rotation)
    self.rotation = rotation
    if self.texture:IsShown() then self.texture:SetRotation(rotation) end
    if not self.fallbackTexture:IsShown() then return end
    -- Match Arrow's clockwise, 120-frame sheet while retaining continuous native clamping.
    local fullRotation = 2 * math.pi
    local frame = math.floor((-rotation % fullRotation) / fullRotation * 120 + 0.5) % 120
    if self.spriteCell == frame then return end
    self.spriteCell = frame
    local column = frame % 16
    local row = math.floor(frame / 16)
    self.fallbackTexture:SetTexCoord(column / 16, (column + 1) / 16, row / 8, (row + 1) / 8)
end
