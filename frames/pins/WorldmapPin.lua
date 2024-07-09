---@class CreationPulseFrame : Frame
---@field Anim Animation


---@class MapPinEnhancedWorldMapPinMixin : MapPinEnhancedBasePinMixin, Button
---@field CreationPulse CreationPulseFrame
MapPinEnhancedWorldMapPinMixin = {}

function MapPinEnhancedWorldMapPinMixin:OnClick()
    print("MapPinEnhancedWorldMapPinMixin:OnClick()")
end

function MapPinEnhancedWorldMapPinMixin:OnLoad()
    self:SetTitlePosition(self.titlePosition, self.titleXOffset, self.titleYOffset)
    self.CreationPulse.Anim:Stop(); --in case there's one playing already
    self.CreationPulse:Show();
    self.CreationPulse.Anim:Play();
end

-- function MapPinEnhancedWorldMapPinMixin:SetClickCallback(callback)
--     self.callback = callback
-- end
