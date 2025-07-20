---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinEntryTemplate : Button
---@field template string
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field treeNode SubTreeNodeMixin
---@field pin MapPinEnhancedPinMixin
---@field overlayTexture Texture
MapPinEnhancedTrackerPinEntryMixin = {}

---@param treeNode SubTreeNodeMixin
function MapPinEnhancedTrackerPinEntryMixin:Init(treeNode)
    self:SetPin(treeNode:GetData())
end

---@param pin MapPinEnhancedPinMixin
function MapPinEnhancedTrackerPinEntryMixin:SetPin(pin)
    self.pin = pin
    pin.trackerEntry:SetFrame(self)
    self.pin:SetPinColor(pin.pinData.color)
    self.pin:SetPinIcon(pin.pinData.texture, pin.pinData.usesAtlas)
end

function MapPinEnhancedTrackerPinEntryMixin:OnMouseDown(button)
    self.pin:OnMouseDown(self, button)
end

function MapPinEnhancedTrackerPinEntryMixin:OnEnter()
    self.pinFrame:LockHighlight()
end

function MapPinEnhancedTrackerPinEntryMixin:OnLeave()
    self.pinFrame:UnlockHighlight()
end
