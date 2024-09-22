---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerImportView : Frame
---@field textBox MapPinEnhancedScrollableTextarea
---@field radioButtons Frame
---@field acceptButton MapPinEnhancedButtonYellow
---@field cancelButton MapPinEnhancedButtonRed
---@field type "Import"
MapPinEnhancedTrackerImportViewMixin = {}


function MapPinEnhancedTrackerImportViewMixin:Update()
end

function MapPinEnhancedTrackerImportViewMixin:GetViewHeight()
end

function MapPinEnhancedTrackerImportViewMixin:UpdateHeight()
end
