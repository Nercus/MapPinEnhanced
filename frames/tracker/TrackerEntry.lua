---@class MapPinEnhancedTrackerEntryMixin : Frame
---@field normalTexture Texture
---@field highlightTexture Texture
---@field titleDisplay FontString
MapPinEnhancedTrackerEntryMixin = {}


function MapPinEnhancedTrackerEntryMixin:SetNormalTexture(normalTexture)
    self.normalTexture:SetTexture(normalTexture)
end

function MapPinEnhancedTrackerEntryMixin:SetHighlightTexture(highlightTexture)
    self.highlightTexture:SetTexture(highlightTexture)
end

function MapPinEnhancedTrackerEntryMixin:SetNormalAtlas(normalTexture)
    self.normalTexture:SetAtlas(normalTexture)
end

function MapPinEnhancedTrackerEntryMixin:SetHighlightAtlas(highlightTexture)
    self.highlightTexture:SetAtlas(highlightTexture)
end

function MapPinEnhancedTrackerEntryMixin:SetTitle(title)
    self.titleDisplay:SetText("Test: " .. (title or "Pin"))
end

function MapPinEnhancedTrackerEntryMixin:OnClick()
    print("MapPinEnhancedTrackerEntryMixin:OnClick()")
    self:SetAlpha(math.random())
end

function MapPinEnhancedTrackerEntryMixin:OnLoad()
    print("MapPinEnhancedTrackerEntryMixin:OnLoad()")
end

function MapPinEnhancedTrackerEntryMixin:OnEnter()
    print("MapPinEnhancedTrackerEntryMixin:OnEnter()")
end

function MapPinEnhancedTrackerEntryMixin:OnLeave()
    print("MapPinEnhancedTrackerEntryMixin:OnLeave()")
end

function MapPinEnhancedTrackerEntryMixin:Track()
    self:SetAlpha(1)
end

function MapPinEnhancedTrackerEntryMixin:Untrack()
    self:SetAlpha(0.5)
end

---@param pinData pinData
function MapPinEnhancedTrackerEntryMixin:Setup(pinData)
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
    self:SetTitle(pinData.title)
    self.description = string.format("Map: %s, x: %s, y: %s", pinData.mapID, pinData.x, pinData.y)

    print("MapPinEnhancedTrackerEntryMixin:Setup()")
end
