---@class MapPinEnhancedTrackerSetEntryMixin : Button
---@field title FontString
---@field activeTexture Texture
MapPinEnhancedTrackerSetEntryMixin = {}


function MapPinEnhancedTrackerSetEntryMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerSetEntryMixin:SetActive()
    self.activeTexture:Show()
end

function MapPinEnhancedTrackerSetEntryMixin:SetInActive()
    self.activeTexture:Hide()
end
