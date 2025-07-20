---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinEntryTemplate
---@field template string
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field treeNode SubTreeNodeMixin
---@field pin MapPinEnhancedPinMixin
MapPinEnhancedTrackerPinEntryMixin = {}

---@param treeNode SubTreeNodeMixin
function MapPinEnhancedTrackerPinEntryMixin:Init(treeNode)
    self:SetPin(treeNode:GetData())
end

---@param pin MapPinEnhancedPinMixin
function MapPinEnhancedTrackerPinEntryMixin:SetPin(pin)
    self.pin = pin
    pin.trackerEntry:SetFrame(self)
    self.pin.trackerEntry:SetPinColor(pin.pinData.color)
    self.pin.trackerEntry:SetPinIcon(pin.pinData.texture, pin.pinData.usesAtlas)
    if pin:IsTracked() then
        self.pin.trackerEntry:SetTracked(true)
    else
        self.pin.trackerEntry:SetUntracked()
    end
end

function MapPinEnhancedTrackerPinEntryMixin:OnMouseDown(button)
    self.pin:OnMouseDown(self, button)
end
