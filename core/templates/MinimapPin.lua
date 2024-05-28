---@class WayfinderMinimapPinMixin : Frame
---@field normalTexture Texture
---@field highlightTexture Texture
WayfinderMinimapPinMixin = {}


function WayfinderMinimapPinMixin:SetNormalTexture(normalTexture)
    self.normalTexture:SetTexture(normalTexture)
end

function WayfinderMinimapPinMixin:SetHighlightTexture(highlightTexture)
    self.highlightTexture:SetTexture(highlightTexture)
end

function WayfinderMinimapPinMixin:OnLoad()
    print("WayfinderMinimapPinMixin:OnLoad()")
end

function WayfinderMinimapPinMixin:OnEnter()
    print("WayfinderMinimapPinMixin:OnEnter()")
end

function WayfinderMinimapPinMixin:OnLeave()
    print("WayfinderMinimapPinMixin:OnLeave()")
end

function WayfinderMinimapPinMixin:Track()
  self:SetAlpha(1)
end

function WayfinderMinimapPinMixin:Untrack()
  self:SetAlpha(0.5)
end

---@param pinData pinData
function WayfinderMinimapPinMixin:Setup(pinData)
    assert(pinData, "pinData is nil")
    print("WayfinderMinimapPinMixin:Setup()")
end
