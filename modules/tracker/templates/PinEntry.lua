---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinEntryTemplate : Button
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field pin MapPinEnhancedPinMixin
---@field title FontString
---@field location FontString
---@field unsubscribePinCallbacks fun()?
MapPinEnhancedTrackerPinEntryMixin = {}

local Pins = MapPinEnhanced:GetModule("Pins")

function MapPinEnhancedTrackerPinEntryMixin:RegisterCallbackEvents()
    local pin = self.pin

    local function trackingCallback(_, isTracked)
        if isTracked then
            self.pinFrame:SetTracked()
        else
            self.pinFrame:SetUntracked()
            self.title:SetAlpha(0.5)
            self.location:SetAlpha(0.5)
        end
    end
    local function titleCallback(_, title)
        self:SetTitle(title)
    end
    local function colorCallback(_, color)
        self.pinFrame:SetColor(color)
    end
    local function iconCallback(_, texture, usesAtlas)
        self.pinFrame:SetIconTexture(texture, usesAtlas)
    end

    self.unsubscribePinCallbacks = MapPinEnhanced:RegisterKeyedCallbacks(pin.pinID, {
        PIN_UPDATED_TRACKING = trackingCallback,
        PIN_UPDATED_TITLE = titleCallback,
        PIN_UPDATED_COLOR = colorCallback,
        PIN_UPDATED_ICON = iconCallback,
    })
end

function MapPinEnhancedTrackerPinEntryMixin:Reset()
    if self.unsubscribePinCallbacks then
        self.unsubscribePinCallbacks()
        self.unsubscribePinCallbacks = nil
    end
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
    if not self.pin then return end
    self.pin:ShowTooltip(self, "ANCHOR_LEFT")
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
