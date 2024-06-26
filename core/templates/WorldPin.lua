---@class MapPinEnhancedWorldPinMixin : Frame
---@field normalTexture Texture
---@field highlightTexture Texture
---@field titleDisplay FontString
MapPinEnhancedWorldPinMixin = {}


function MapPinEnhancedWorldPinMixin:SetNormalTexture(normalTexture)
    self.normalTexture:SetTexture(normalTexture)
end

function MapPinEnhancedWorldPinMixin:SetHighlightTexture(highlightTexture)
    self.highlightTexture:SetTexture(highlightTexture)
end

function MapPinEnhancedWorldPinMixin:SetNormalAtlas(normalTexture)
    self.normalTexture:SetAtlas(normalTexture)
end

function MapPinEnhancedWorldPinMixin:SetHighlightAtlas(highlightTexture)
    self.highlightTexture:SetAtlas(highlightTexture)
end

function MapPinEnhancedWorldPinMixin:SetTitle(title)
    self.titleDisplay:SetText(title)
end

function MapPinEnhancedWorldPinMixin:OnLoad()
    print("MapPinEnhancedWorldPinMixin:OnLoad()")
end

function MapPinEnhancedWorldPinMixin:OnEnter()
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

function MapPinEnhancedWorldPinMixin:OnLeave()
    GameTooltip:Hide()
end

function MapPinEnhancedWorldPinMixin:Track()
    self:SetAlpha(1)
end

function MapPinEnhancedWorldPinMixin:Untrack()
    self:SetAlpha(0.5)
end

---@param pinData pinData
function MapPinEnhancedWorldPinMixin:Setup(pinData)
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


    -- if MapPinEnhancedCompass then
    --     MapPinEnhancedCompass:AddPin(self)
    -- end
end
