---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinEntryTemplate : Button
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field treeNode TreeNodeMixin
---@field pin MapPinEnhancedPinMixin
---@field title FontString
MapPinEnhancedTrackerPinEntryMixin = {}

local Pins = MapPinEnhanced:GetModule("Pins")

function MapPinEnhancedTrackerPinEntryMixin:RegisterCallbackEvents()
    local pin = self.pin

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

    MapPinEnhanced:RegisterCallback("PIN_UPDATED_ICON", function(_, iconInfo)
        if pin.pinData.texture == iconInfo.path then return end
        self.pinFrame:SetIcon(iconInfo.path, iconInfo.usesAtlas, iconInfo.offset, iconInfo.scale)
    end, pin.pinID)
end

function MapPinEnhancedTrackerPinEntryMixin:UnregisterCallbackEvents(oldPinId)
    MapPinEnhanced:UnregisterCallback("PIN_UPDATED_TRACKING", oldPinId)
    MapPinEnhanced:UnregisterCallback("PIN_UPDATED_TITLE", oldPinId)
    MapPinEnhanced:UnregisterCallback("PIN_UPDATED_COLOR", oldPinId)
    MapPinEnhanced:UnregisterCallback("PIN_UPDATED_ICON", oldPinId)
end

function MapPinEnhancedTrackerPinEntryMixin:Reset(oldPinId)
    assert(oldPinId, "oldPinId is required to reset a pin entry")
    self:UnregisterCallbackEvents(oldPinId)
    self.pin = nil
end

---@param treeNode TreeNodeMixin
function MapPinEnhancedTrackerPinEntryMixin:Init(treeNode)
    ---@type MapPinEnhancedPinMixin
    local pin = treeNode:GetData()
    self.pin = pin

    if pin:IsTracked() then
        self.pinFrame:SetTracked()
    else
        self.pinFrame:SetUntracked()
    end

    self.pinFrame:SetColor(pin.pinData.color)
    self:SetTitle(pin.pinData.title)

    self.pinFrame:SetIcon(pin.pinData.texture, pin.pinData.usesAtlas)
    self:RegisterCallbackEvents()
end

function MapPinEnhancedTrackerPinEntryMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerPinEntryMixin:SetIcon(icon)

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
