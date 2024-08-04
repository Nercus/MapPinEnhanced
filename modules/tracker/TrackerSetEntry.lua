-- Template: file://./TrackerSetEntry.xml
---@class MapPinEnhancedTrackerSetEntryMixin : Button
---@field title FontString
---@field activeTexture Texture
MapPinEnhancedTrackerSetEntryMixin = {}

function MapPinEnhancedTrackerSetEntryMixin:SetEntryIndex(index)
    -- NOTE: This is a placeholder function
end

function MapPinEnhancedTrackerSetEntryMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerSetEntryMixin:SetActive()
    self.activeTexture:Show()
end

function MapPinEnhancedTrackerSetEntryMixin:SetInactive()
    self.activeTexture:Hide()
end
