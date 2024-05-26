---@class WayfinderWorldPinMixin : Frame
---@field normalTexture Texture
---@field highlightTexture Texture
WayfinderWorldPinMixin = {}


function WayfinderWorldPinMixin:SetNormalTexture(normalTexture)
    self.normalTexture:SetTexture(normalTexture)
end

function WayfinderWorldPinMixin:SetHighlightTexture(highlightTexture)
    self.highlightTexture:SetTexture(highlightTexture)
end

function WayfinderWorldPinMixin:SetNormalAtlas(normalTexture)
    self.normalTexture:SetAtlas(normalTexture)
end

function WayfinderWorldPinMixin:SetHighlightAtlas(highlightTexture)
    self.highlightTexture:SetAtlas(highlightTexture)
end

function WayfinderWorldPinMixin:SetTitle(title)
    self.titleDisplay:SetText(title)
end


function WayfinderWorldPinMixin:OnLoad()
    print("WayfinderWorldPinMixin:OnLoad()")
end

function WayfinderWorldPinMixin:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_TOP", -16, -4)
    if self.texture then
        GameTooltip:AddAtlas(self.texture, true)
    end
    if self.title then
        GameTooltip:AddLine(self.title)
    end
    GameTooltip:AddLine(self.description, 1, 1, 1)
    GameTooltip:Show()
end

function WayfinderWorldPinMixin:OnLeave()
    GameTooltip:Hide()
end

---@param pinData pinData
function WayfinderWorldPinMixin:Setup(pinData)
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
    self:SetTitle(pinData.title)
    self.description = string.format("Map: %s, x: %s, y: %s", pinData.mapID, pinData.x, pinData.y)
    self.pinData = pinData


    if WayfinderCompass then
        WayfinderCompass:AddPin(self)
    end
end
