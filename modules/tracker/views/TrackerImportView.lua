---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerImportView : MapPinEnhancedTrackerView
---@field textBox MapPinEnhancedScrollableTextarea
---@field radioButtons Frame
---@field acceptButton MapPinEnhancedButtonYellow
---@field cancelButton MapPinEnhancedButtonRed
MapPinEnhancedTrackerImportViewMixin = {}


function MapPinEnhancedTrackerImportViewMixin:Update()
end

function MapPinEnhancedTrackerImportViewMixin:GetViewHeight()
end

function MapPinEnhancedTrackerImportViewMixin:UpdateHeight()
end
