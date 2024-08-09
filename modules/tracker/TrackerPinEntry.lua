-- Template: file://./TrackerPinEntry.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinEntryPin : MapPinEnhancedBasePinMixin
---@field count FontString


---@class MapPinEnhancedTrackerPinEntryMixin :  Button
---@field Pin MapPinEnhancedTrackerPinEntryPin
---@field titlePosition string | nil
---@field titleXOffset number | nil
---@field titleYOffset number | nil
---@field zoneText FontString
MapPinEnhancedTrackerPinEntryMixin = {}


function MapPinEnhancedTrackerPinEntryMixin:OnLoad()
    if (not self.Pin.SetPropagateMouseClicks or not self.Pin.SetPropagateMouseMotion) then
        return
    end
    self.Pin:SetPropagateMouseClicks(true)
    self.Pin:SetPropagateMouseMotion(true)
end

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
    -- NOTE: change the texture of the tracker entry here
    self.Pin:SetTrackedTexture()
end

function MapPinEnhancedTrackerPinEntryMixin:SetUntrackedTexture()
    -- NOTE: change the texture of the tracker entry here
    self.Pin:SetUntrackedTexture()
end

function MapPinEnhancedTrackerPinEntryMixin:SetEntryIndex(index)
    self.Pin.count:SetText(index)
end

---comment we override the title position function from the base pin mixin to include the other pathing to the title
function MapPinEnhancedTrackerPinEntryMixin:SetTitle(overrideTitle)
    self.Pin:SetTitle(overrideTitle)
end

function MapPinEnhancedTrackerPinEntryMixin:OnEnter()
    self.Pin:LockHighlight()
end

function MapPinEnhancedTrackerPinEntryMixin:OnLeave()
    self.Pin:UnlockHighlight()
end
