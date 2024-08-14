-- Template: file://./TrackerSetEntry.xml
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

function MapPinEnhancedTrackerSetEntryMixin:OnEnter()
    self.highlight:Show()
end

function MapPinEnhancedTrackerSetEntryMixin:OnLeave()
    if self.isActive then return end
    self.highlight:Hide()
end
