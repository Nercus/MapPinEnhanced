---@class MapPinEnhancedFadingFrameTemplate : Frame
---@field visibilityFadeIn AnimationGroup | { alpha: Alpha }
---@field visibilityFadeOut AnimationGroup | { alpha: Alpha }
---@field showWithoutFade fun(self: MapPinEnhancedFadingFrameTemplate)
---@field hideWithoutFade fun(self: MapPinEnhancedFadingFrameTemplate)
---@field visibilityHiding boolean?
MapPinEnhancedFadingFrameMixin = {}

-- Opted-in frames keep existing callers, including Blizzard close buttons and
-- UISpecialFrames Escape. The paired template owns their animation groups.
---@param keepNativeVisibility? boolean Secure drivers must keep native visibility methods.
function MapPinEnhancedFadingFrameMixin:SetupVisibilityFade(keepNativeVisibility)
    assert(not self.showWithoutFade, "FadingFrameMixin:SetupVisibilityFade must run only once")
    self.showWithoutFade = self.Show
    self.hideWithoutFade = self.Hide
    if not keepNativeVisibility then
        self.Show = self.ShowWithFade
        self.Hide = self.HideWithFade
        self.SetShown = self.SetShownWithFade
    end
    self:HookScript("OnHide", self.ResetVisibilityFade)
end

---@return number
function MapPinEnhancedFadingFrameMixin:StopVisibilityFade()
    local alpha = self:GetAlpha()
    local group = self.visibilityFadeIn:IsPlaying() and self.visibilityFadeIn or self.visibilityFadeOut
    if group:IsPlaying() then
        local animation = group.alpha
        alpha = Lerp(animation:GetFromAlpha(), animation:GetToAlpha(), animation:GetSmoothProgress())
    end
    self.visibilityFadeIn:Stop()
    self.visibilityFadeOut:Stop()
    self:SetAlpha(alpha)
    return alpha
end

function MapPinEnhancedFadingFrameMixin:ShowWithFade()
    if self:IsShown() and not self.visibilityFadeOut:IsPlaying() then return end
    local alpha = self:IsShown() and self:StopVisibilityFade() or 0
    self.visibilityHiding = nil
    self:SetAlpha(alpha)
    self.showWithoutFade(self)
    self.visibilityFadeIn.alpha:SetFromAlpha(alpha)
    self.visibilityFadeIn:Play()
end

function MapPinEnhancedFadingFrameMixin:HideWithFade()
    if not self:IsShown() or self.visibilityFadeOut:IsPlaying() then return end
    if not self:IsVisible() then
        self:HideImmediately()
        return
    end
    local alpha = self:StopVisibilityFade()
    self.visibilityHiding = true
    self.visibilityFadeOut.alpha:SetFromAlpha(alpha)
    self.visibilityFadeOut:Play()
end

---@param shown boolean
function MapPinEnhancedFadingFrameMixin:SetShownWithFade(shown)
    if shown then self:ShowWithFade() else self:HideWithFade() end
end

function MapPinEnhancedFadingFrameMixin:FinishVisibilityHide()
    -- FloatingPanel's secure driver owns combat hiding. Never issue a delayed
    -- protected Hide if combat began while the fade was playing.
    if not self.visibilityHiding or (self:IsProtected() and InCombatLockdown()) then return end
    self.hideWithoutFade(self)
end

function MapPinEnhancedFadingFrameMixin:HideImmediately()
    self.visibilityHiding = nil
    self.visibilityFadeIn:Stop()
    self.visibilityFadeOut:Stop()
    self.hideWithoutFade(self)
    self:SetAlpha(1)
end

function MapPinEnhancedFadingFrameMixin:ResetVisibilityFade()
    local wasHiding = self.visibilityHiding
    self.visibilityHiding = nil
    self.visibilityFadeIn:Stop()
    self.visibilityFadeOut:Stop()
    self:SetAlpha(1)
    -- Ancestor hiding finishes a pending close, but preserves an otherwise-open
    -- frame (for example when the player temporarily hides UIParent).
    if wasHiding and self:IsShown() and not (self:IsProtected() and InCombatLockdown()) then
        self.hideWithoutFade(self)
    end
end
