---@class MapPinEnhancedWorldMapPinMixin : Frame
---@field normalTexture Texture
---@field highlightTexture Texture
MapPinEnhancedWorldMapPinMixin = {}


function MapPinEnhancedWorldMapPinMixin:SetNormalTexture(normalTexture)
    self.normalTexture:SetTexture(normalTexture)
end

function MapPinEnhancedWorldMapPinMixin:SetHighlightTexture(highlightTexture)
    self.highlightTexture:SetTexture(highlightTexture)
end

function MapPinEnhancedWorldMapPinMixin:SetNormalAtlas(normalTexture)
    self.normalTexture:SetAtlas(normalTexture)
end

function MapPinEnhancedWorldMapPinMixin:SetHighlightAtlas(highlightTexture)
    self.highlightTexture:SetAtlas(highlightTexture)
end

function MapPinEnhancedWorldMapPinMixin:OnLoad()
    print("MapPinEnhancedWorldMapPinMixin:OnLoad()")
end

function MapPinEnhancedWorldMapPinMixin:OnEnter()
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

function MapPinEnhancedWorldMapPinMixin:OnLeave()
    GameTooltip:Hide()
end

function MapPinEnhancedWorldMapPinMixin:SetClickCallback(callback)
    self.callback = callback
end

function MapPinEnhancedWorldMapPinMixin:OnClick()
    if self.callback then
        self.callback(self)
    end
end

function MapPinEnhancedWorldMapPinMixin:Track()
    self:SetAlpha(1)
end

function MapPinEnhancedWorldMapPinMixin:Untrack()
    self:SetAlpha(0.5)
end

---@param pinData pinData
function MapPinEnhancedWorldMapPinMixin:Setup(pinData)
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
