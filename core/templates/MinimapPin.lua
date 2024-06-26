---@class MapPinEnhancedMinimapPinMixin : Frame
---@field normalTexture Texture
---@field highlightTexture Texture
MapPinEnhancedMinimapPinMixin = {}


function MapPinEnhancedMinimapPinMixin:SetNormalTexture(normalTexture)
    self.normalTexture:SetTexture(normalTexture)
end

function MapPinEnhancedMinimapPinMixin:SetHighlightTexture(highlightTexture)
    self.highlightTexture:SetTexture(highlightTexture)
end

function MapPinEnhancedMinimapPinMixin:OnLoad()
    print("MapPinEnhancedMinimapPinMixin:OnLoad()")
end

function MapPinEnhancedMinimapPinMixin:OnEnter()
    print("MapPinEnhancedMinimapPinMixin:OnEnter()")
end

function MapPinEnhancedMinimapPinMixin:OnLeave()
    print("MapPinEnhancedMinimapPinMixin:OnLeave()")
end

function MapPinEnhancedMinimapPinMixin:Track()
    self:SetAlpha(1)
end

function MapPinEnhancedMinimapPinMixin:Untrack()
    self:SetAlpha(0.5)
end

---@param pinData pinData
function MapPinEnhancedMinimapPinMixin:Setup(pinData)
    assert(pinData, "pinData is nil")
    print("MapPinEnhancedMinimapPinMixin:Setup()")
end
