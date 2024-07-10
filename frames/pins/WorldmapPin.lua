---@class CreationPulseFrame : Frame
---@field Anim Animation


---@class MapPinEnhancedWorldMapPinMixin : MapPinEnhancedBasePinMixin, Button
---@field CreationPulse CreationPulseFrame
MapPinEnhancedWorldMapPinMixin = {}

-- function MapPinEnhancedWorldMapPinMixin:OnLoad()
--     self:SetTitlePosition(self.titlePosition, self.titleXOffset, self.titleYOffset)
-- end

-- there is no other way right now to always show animation just for world map pins and also on reused frames (onload is not triggering on reused frames)
function MapPinEnhancedWorldMapPinMixin:Setup(pinData)
    if pinData then
        self.pinData = pinData
    end
    if not self.pinData then
        return
    end

    self:SetPinColor(self.pinData.color) -- set default color
    self:SetTitle()
    self:SetTitlePosition(self.titlePosition, self.titleXOffset, self.titleYOffset)
    self:SetPinIcon()
    self:SetUntrackedTexture()

    self.CreationPulse.Anim:Stop(); --in case there's one playing already
    self.CreationPulse:Show();
    self.CreationPulse.Anim:Play();
end
