WayfinderWorldMapPinMixin = {}

function WayfinderWorldMapPinMixin:SetNormalTexture(normalTexture)
    self.normalTexture:SetTexture(normalTexture)
end

function WayfinderWorldMapPinMixin:SetHighlightTexture(highlightTexture)
    self.highlightTexture:SetTexture(highlightTexture)
end

function WayfinderWorldMapPinMixin:OnLoad()
    print("WayfinderWorldMapPinMixin:OnLoad()")
end

function WayfinderWorldMapPinMixin:OnEnter()
    print("WayfinderWorldMapPinMixin:OnEnter()")
end

function WayfinderWorldMapPinMixin:OnLeave()
    print("WayfinderWorldMapPinMixin:OnLeave()")
end

function WayfinderWorldMapPinMixin:OnClick(button)
    print("WayfinderWorldMapPinMixin:OnClick()", button)
end
