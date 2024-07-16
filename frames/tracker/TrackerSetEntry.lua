---@class MapPinEnhancedTrackerSetEntryMixin : Button
---@field title FontString
MapPinEnhancedTrackerSetEntryMixin = {}


function MapPinEnhancedTrackerSetEntryMixin:SetTitle(title)
    self.title:SetText(title)
end
