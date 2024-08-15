-- Template: file://./WorldmapPin.xml
---@class CreationPulseFrame : Frame
---@field Anim Animation


---@class MapPinEnhancedWorldMapPinMixin : MapPinEnhancedBasePinMixin, Button
---@field CreationPulse CreationPulseFrame
MapPinEnhancedWorldMapPinMixin = {}

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

function MapPinEnhancedWorldMapPinMixin:ShowTooltip()
    if not self.pinData then return end
    if not self.pinData.title then return end
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 20)
    GameTooltip:SetText(self.pinData.title, 1, 1, 1)
    GameTooltip:Show()
end

function MapPinEnhancedWorldMapPinMixin:OnEnter()
    self:ShowTooltip()
end

function MapPinEnhancedWorldMapPinMixin:OnLeave()
    GameTooltip:Hide()
end
