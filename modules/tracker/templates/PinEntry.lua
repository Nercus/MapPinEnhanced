---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinEntryTemplate : Button
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field treeNode TreeNodeMixin
---@field pin MapPinEnhancedPinMixin
---@field title FontString
MapPinEnhancedTrackerPinEntryMixin = {}

function MapPinEnhancedTrackerPinEntryMixin:Reset(oldPinId)
    assert(oldPinId, "oldPinId is required to reset a pin entry")
    MapPinEnhanced:UnregisterCallback("PIN_UPDATED_TRACKING", oldPinId)
    MapPinEnhanced:UnregisterCallback("PIN_UPDATED_TITLE", oldPinId)
    self.pin = nil
end

---@param treeNode TreeNodeMixin
function MapPinEnhancedTrackerPinEntryMixin:Init(treeNode)
    ---@type MapPinEnhancedPinMixin
    local pin = treeNode:GetData()
    self.pin = pin

    MapPinEnhanced:RegisterCallback("PIN_UPDATED_TRACKING", function(_, isTracked)
        if isTracked then
            self.pinFrame:SetTracked()
        else
            self.pinFrame:SetUntracked()
        end
    end, pin.pinID)

    MapPinEnhanced:RegisterCallback("PIN_UPDATED_TITLE", function(_, title)
        if pin.pinData.title == title then return end
        self:SetTitle(title)
    end, pin.pinID)

    MapPinEnhanced:RegisterCallback("PIN_UPDATED_COLOR", function(_, color)
        if pin.pinData.color == color then return end
        self.pinFrame:SetColor(color)
    end, pin.pinID)

    if pin:IsTracked() then
        self.pinFrame:SetTracked()
    else
        self.pinFrame:SetUntracked()
    end
    self.pin:SetColor(pin.pinData.color)
    self.pin:SetIcon(pin.pinData.texture, pin.pinData.usesAtlas)
    self:SetTitle(pin.pinData.title)
end

function MapPinEnhancedTrackerPinEntryMixin:SetTitle(title)
    self.title:SetText(title)
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
