-- Template: file://./TrackerSetEntry.xml#
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L


---@class MapPinEnhancedTrackerSetEntryMixin : Button
---@field title FontString
---@field highlight Texture
MapPinEnhancedTrackerSetEntryMixin = {}

function MapPinEnhancedTrackerSetEntryMixin:SetEntryIndex() end -- not used right now

function MapPinEnhancedTrackerSetEntryMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerSetEntryMixin:SetActive()
    self.highlight:Show()
    self.isActive = true
end

function MapPinEnhancedTrackerSetEntryMixin:SetInactive()
    self.highlight:Hide()
    self.highlight:SetAlpha(1)
    self.isActive = false
end

function MapPinEnhancedTrackerSetEntryMixin:ShowTooltip()
    ---@type string
    local tooltip = L["Click to load set"] .. "\n" .. L["Shift-Click to load and override all pins"]
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(tooltip)
    GameTooltip:Show()
end

function MapPinEnhancedTrackerSetEntryMixin:OnEnter()
    self.highlight:Show()
    self:ShowTooltip()
end

function MapPinEnhancedTrackerSetEntryMixin:OnLeave()
    GameTooltip:Hide()
    if self.isActive then return end
    self.highlight:Hide()
end
