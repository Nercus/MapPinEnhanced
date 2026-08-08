---@class MapPinEnhancedPinGroupBadgeTemplate : Frame
---@field icon Texture
MapPinEnhancedPinGroupBadgeMixin = {}

---@param icon string|number?
function MapPinEnhancedPinGroupBadgeMixin:SetIcon(icon)
    if not icon then
        self:Hide()
        return
    end

    self.icon:SetTexture(icon)
    self:Show()
end

function MapPinEnhancedPinGroupBadgeMixin:OnLoad()
    self:SetIcon(nil)
end
