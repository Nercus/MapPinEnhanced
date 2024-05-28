---@class WayfinderWorldMapPinMixin : Frame
---@field normalTexture Texture
---@field highlightTexture Texture
WayfinderWorldMapPinMixin = {}


function WayfinderWorldMapPinMixin:SetNormalTexture(normalTexture)
    self.normalTexture:SetTexture(normalTexture)
end

function WayfinderWorldMapPinMixin:SetHighlightTexture(highlightTexture)
    self.highlightTexture:SetTexture(highlightTexture)
end

function WayfinderWorldMapPinMixin:SetNormalAtlas(normalTexture)
    self.normalTexture:SetAtlas(normalTexture)
end

function WayfinderWorldMapPinMixin:SetHighlightAtlas(highlightTexture)
    self.highlightTexture:SetAtlas(highlightTexture)
end

function WayfinderWorldMapPinMixin:OnLoad()
    print("WayfinderWorldMapPinMixin:OnLoad()")
end

function WayfinderWorldMapPinMixin:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -16, -4)
    if self.texture then
        GameTooltip:AddAtlas(self.texture, true)
    end
    if self.title then
        GameTooltip:AddLine(self.title)
    end
    GameTooltip:AddLine(self.description, 1, 1, 1)
    GameTooltip:Show()
end

function WayfinderWorldMapPinMixin:OnLeave()
    GameTooltip:Hide()
end


function WayfinderWorldMapPinMixin:SetClickCallback(callback)
    self.callback = callback
end

function WayfinderWorldMapPinMixin:OnClick(button)
    if self.callback then
        self.callback(self)
    end
end


function WayfinderWorldMapPinMixin:Track()
  self:SetAlpha(1)
end

function WayfinderWorldMapPinMixin:Untrack()
  self:SetAlpha(0.5)
end

---@param pinData pinData
function WayfinderWorldMapPinMixin:Setup(pinData)
    assert(pinData, "pinData is nil")
    if pinData.texture then
        if pinData.usesAtlas then
            self:SetNormalAtlas(pinData.texture)
        else
            self:SetNormalTexture(pinData.texture)
        end
    end

    if pinData.usesAtlas then
        self.texture = pinData.texture
    end
    self.title = pinData.title
    self.description = string.format("Map: %s, x: %s, y: %s", pinData.mapID, pinData.x, pinData.y)
end
