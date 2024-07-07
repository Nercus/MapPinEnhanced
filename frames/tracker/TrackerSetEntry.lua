---@class MapPinEnhancedTrackerSetEntryMixin : Button
---@field title FontString
MapPinEnhancedTrackerSetEntryMixin = {}


function MapPinEnhancedTrackerSetEntryMixin:OnLoad()
    print("MapPinEnhancedTrackerSetEntryMixin:OnLoad() ")
end

function MapPinEnhancedTrackerSetEntryMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerSetEntryMixin:OnClick()
    print("MapPinEnhancedTrackerSetEntryMixin:OnClick() ")
end

function MapPinEnhancedTrackerSetEntryMixin:OnEnter()
    print("MapPinEnhancedTrackerSetEntryMixin:OnEnter() ")
end

function MapPinEnhancedTrackerSetEntryMixin:OnLeave()
    print("MapPinEnhancedTrackerSetEntryMixin:OnLeave() ")
end
