-- Template: file://./TrackerSetEntry.xml#
---@class MapPinEnhancedTrackerSetEntryMixin : Button
---@field title FontString
---@field highlight Texture
---@field tooltip string?
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
    if not self.tooltip then return end
    ---@type string
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(self.tooltip)
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
