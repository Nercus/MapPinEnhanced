---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local CONSTANTS = MapPinEnhanced.CONSTANTS

---@class MapPinEnhancedTrackerPinEntryPin : MapPinEnhancedBasePin
---@field numbering FontString


---@class MapPinEnhancedTrackerPinEntry : Button
---@field Pin MapPinEnhancedTrackerPinEntryPin
---@field highlight Texture
---@field coordsText FontString
---@field zoneText FontString
---@field bgLeft Texture
---@field bgRight Texture
---@field bgMiddle Texture
---@field titlePosition string | nil
---@field titleXOffset number | nil
---@field titleYOffset number | nil
---@field tracked boolean?
MapPinEnhancedTrackerPinEntryMixin = {}


function MapPinEnhancedTrackerPinEntryMixin:SetZoneText(mapID)
    if not self.pinData then return end
    local mapInfo = C_Map.GetMapInfo(mapID)
    if mapInfo then
        self.zoneText:SetText(mapInfo.name)
    end
end

function MapPinEnhancedTrackerPinEntryMixin:SetCoordsText(x, y)
    if not self.pinData then return end
    local coordsText = string.format(CONSTANTS.COORDS_TEXT_PATTERN, x * 100, y * 100)
    self.coordsText:SetText(coordsText)
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
    self:SetCoordsText(pinData.x, pinData.y)
    self.Pin.title:SetWidth(self:GetWidth() - 100)
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
---@param overrideTitle string
function MapPinEnhancedTrackerPinEntryMixin:SetTitle(overrideTitle)
    self.Pin:SetTitle(overrideTitle)
end

function MapPinEnhancedTrackerPinEntryMixin:ShowTooltip()
    if not self.pinData then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(self.pinData.title, 1, 1, 1, 1, true)
    GameTooltip:Show()
end

function MapPinEnhancedTrackerPinEntryMixin:OnEnter()
    self.Pin:LockHighlight()
    self.highlight:Show()
    self.Pin.numbering:SetAlpha(1)
    local isTitleEllipsis = self.Pin.title:IsTruncated()
    if isTitleEllipsis then
        self:ShowTooltip()
    end
end

function MapPinEnhancedTrackerPinEntryMixin:OnLeave()
    GameTooltip:Hide()
    self.Pin:UnlockHighlight()
    self.highlight:Hide()
    if self.tracked then return end
    self.Pin.numbering:SetAlpha(0.7)
end

function MapPinEnhancedTrackerPinEntryMixin:SetNext(frame)
    -- TODO: check if it makes sense to move the anchoring logic in here
    self.next = frame
    MapPinEnhanced:Debug(self)
end

function MapPinEnhancedTrackerPinEntryMixin:SetPrevious(frame)
    self.previous = frame
end
