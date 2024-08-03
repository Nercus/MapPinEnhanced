-- Template: file://./TrackerTextImportButton.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedTrackerTextImportButtonMixin : Button
MapPinEnhancedTrackerTextImportButtonMixin = {}

function MapPinEnhancedTrackerTextImportButtonMixin:OnClick()
    MapPinEnhanced:ToggleImportWindow()
end
