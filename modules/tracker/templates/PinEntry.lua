---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinEntryTemplate : Button
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field pin MapPinEnhancedPinMixin
---@field title FontString
---@field location FontString
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
        self:SetTitle(title)
    end, pin.pinID)

    MapPinEnhanced:RegisterCallback("PIN_UPDATED_COLOR", function(_, color)
        self.pinFrame:SetColor(color)
    end, pin.pinID)

    MapPinEnhanced:RegisterCallback("PIN_UPDATED_ICON", function(_, texture, usesAtlas)
        self.pinFrame:SetIconTexture(texture, usesAtlas)
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
    self.title:SetAlpha(0.5)
    self.location:SetAlpha(0.5)
end

---@param treeNode TreeNodeMixin
function MapPinEnhancedTrackerPinEntryMixin:Init(treeNode)
    ---@type MapPinEnhancedPinMixin
    local pin = treeNode:GetData()
    self.pin = pin

    if pin:IsTracked() then
        self.pinFrame:SetTracked()
        self.title:SetAlpha(1)
        self.location:SetAlpha(1)
    else
        self.pinFrame:SetUntracked()
    end

    self.pinFrame:SetColor(pin.pinData.color)
    self:SetTitle(pin.pinData.title)
    self:SetLocationText(pin.pinData.x, pin.pinData.y, pin.pinData.mapID)

    self.pinFrame:SetIconTexture(pin.pinData.texture, pin.pinData.usesAtlas)
    self:RegisterCallbackEvents()
end

function MapPinEnhancedTrackerPinEntryMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerPinEntryMixin:SetLocationText(x, y, mapID)
    local mapInfo = C_Map.GetMapInfo(mapID)
    local mapName = mapInfo and mapInfo.name or ""
    self.location:SetText(string.format("%d, %d - %s", x * 100, y * 100, mapName))
end

function MapPinEnhancedTrackerPinEntryMixin:SetIcon(icon)
    self.pinFrame:SetIconTexture(icon)
end

function MapPinEnhancedTrackerPinEntryMixin:OnMouseDown(button)
    self.pin:OnMouseDown(self, button)
end

function MapPinEnhancedTrackerPinEntryMixin:ShowTooltip()
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

function MapPinEnhancedTrackerPinEntryMixin:OnEnter()
    self.pinFrame:LockHighlight()
    self:ShowTooltip()

    self.title:SetAlpha(1)
    self.location:SetAlpha(1)
end

function MapPinEnhancedTrackerPinEntryMixin:OnLeave()
    self.pinFrame:UnlockHighlight()
    GameTooltip:Hide()

    if self.pin and not self.pin:IsTracked() then
        self.title:SetAlpha(0.5)
        self.location:SetAlpha(0.5)
    end
end
