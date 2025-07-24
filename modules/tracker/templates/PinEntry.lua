---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinEntryTemplate : Button
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field treeNode TreeNodeMixin
---@field pin MapPinEnhancedPinMixin
---@field overlayTexture Texture
MapPinEnhancedTrackerPinEntryMixin = {}

---@param treeNode TreeNodeMixin
function MapPinEnhancedTrackerPinEntryMixin:Init(treeNode)
    ---@type MapPinEnhancedPinMixin
    local pin = treeNode:GetData()
    self.pin = pin

    pin.trackerEntry:SetTreeNode(treeNode)
    pin.trackerEntry:SetFrame(self)
    self.pin:SetPinColor(pin.pinData.color)
    self.pin:SetPinIcon(pin.pinData.texture, pin.pinData.usesAtlas)
end

function MapPinEnhancedTrackerPinEntryMixin:OnMouseDown(button)
    self.pin:OnMouseDown(self, button)
end

function MapPinEnhancedTrackerPinEntryMixin:OnEnter()
    self.pinFrame:LockHighlight()

    local tooltipData = self.pin and self.pin.pinData.tooltip
    if not tooltipData then return end
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    local title = tooltipData.title
    local text = tooltipData.text
    if title then
        GameTooltip:AddLine(tooltipData.title, 1, 0.82, 0)
    end
    if text then
        GameTooltip:AddLine(tooltipData.text, 1, 1, 1)
    end
    GameTooltip:Show()
end

function MapPinEnhancedTrackerPinEntryMixin:OnLeave()
    self.pinFrame:UnlockHighlight()
    GameTooltip:Hide()
end
