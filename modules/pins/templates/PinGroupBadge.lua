---@class MapPinEnhancedPinGroupBadgeTemplate : Frame
---@field icon Texture
---@field lastIcon string|number?
MapPinEnhancedPinGroupBadgeMixin = {}

---@param icon string|number?
function MapPinEnhancedPinGroupBadgeMixin:SetIcon(icon)
    if self.lastIcon == icon then return end
    self.lastIcon = icon
    if not icon then
        self:Hide()
        return
    end

    self.icon:SetTexture(icon)
    self:Show()
end

function MapPinEnhancedPinGroupBadgeMixin:OnLoad()
    self:Reset()
end

function MapPinEnhancedPinGroupBadgeMixin:Reset()
    self.lastIcon = nil
    self:Hide()
end
