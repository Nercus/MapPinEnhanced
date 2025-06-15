---@class MapPinEnhancedIconMixin : Texture
---@field icon string
MapPinEnhancedIconMixin = {}


local ICON_TEXTURES = {
    ['import'] = "Interface\\AddOns\\MapPinEnhanced\\Textures\\Import",
    ['export'] = "Interface\\AddOns\\MapPinEnhanced\\Textures\\Export",
}



function MapPinEnhancedIconMixin:SetIconTexture()
    assert(self.icon, "MapPinEnhancedIconMixin: SetIconTexture called without icon set")
    local texturePath = ICON_TEXTURES[self.icon]
    if not texturePath then
        error("MapPinEnhancedIconMixin: Invalid icon name: " .. tostring(self.icon))
    end
    self:SetTexture(texturePath)
end

function MapPinEnhancedIconMixin:OnLoad()
    self:SetIconTexture()
end
