-- Template: file://./TrackerPinEntry.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinEntryPin : MapPinEnhancedBasePinMixin
---@field numbering FontString


---@class MapPinEnhancedTrackerPinEntryMixin :  Button
---@field Pin MapPinEnhancedTrackerPinEntryPin
---@field titlePosition string | nil
---@field titleXOffset number | nil
---@field titleYOffset number | nil
---@field zoneText FontString
---@field highlight Texture
---@field tracked boolean?
MapPinEnhancedTrackerPinEntryMixin = {}


function MapPinEnhancedTrackerPinEntryMixin:SetZoneText(mapID)
    local mapInfo = C_Map.GetMapInfo(mapID)
    if mapInfo then
        self.zoneText:SetText(mapInfo.name)
    end
end

function MapPinEnhancedTrackerPinEntryMixin:Setup(pinData)
    if pinData then
        self.pinData = pinData
    end
    if not self.pinData then
        return
    end
    self.Pin.titlePosition = self.titlePosition
    self.Pin.titleXOffset = self.titleXOffset
    self.Pin.titleYOffset = self.titleYOffset
    self.Pin:Setup(pinData)
    self:SetZoneText(pinData.mapID)
end

---comment we override the texture function from the base pin mixin to include the other pathing to the texture
function MapPinEnhancedTrackerPinEntryMixin:SetPinIcon()
    self.Pin:SetPinIcon()
end

function MapPinEnhancedTrackerPinEntryMixin:SetPinColor(color)
    self.Pin:SetPinColor(color)
end

function MapPinEnhancedTrackerPinEntryMixin:SetTrackedTexture()
    self.Pin:SetTrackedTexture()
    self.Pin.numbering:SetAlpha(1)
    self.tracked = true
end

function MapPinEnhancedTrackerPinEntryMixin:SetUntrackedTexture()
    self.Pin:SetUntrackedTexture()
    self.Pin.numbering:SetAlpha(0.7)
    self.tracked = false
end

function MapPinEnhancedTrackerPinEntryMixin:SetEntryIndex(index)
    self.Pin.numbering:SetText(index)
end

function MapPinEnhancedTrackerPinEntryMixin:SetEntryIndexVisibility(visible)
    self.Pin.numbering:SetShown(visible)
end

---comment we override the title position function from the base pin mixin to include the other pathing to the title
function MapPinEnhancedTrackerPinEntryMixin:SetTitle(overrideTitle)
    self.Pin:SetTitle(overrideTitle)
end

function MapPinEnhancedTrackerPinEntryMixin:OnEnter()
    self.Pin:LockHighlight()
    self.highlight:Show()
    self.Pin.numbering:SetAlpha(1)
end

function MapPinEnhancedTrackerPinEntryMixin:OnLeave()
    self.Pin:UnlockHighlight()
    self.highlight:Hide()
    if self.tracked then return end
    self.Pin.numbering:SetAlpha(0.7)
end
