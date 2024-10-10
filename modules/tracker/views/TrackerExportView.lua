---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerExportViewCheckbox : MapPinEnhancedCheckbox
---@field label FontString

---@class MapPinEnhancedTrackerExportViewExportMode : Frame
---@field checkbox MapPinEnhancedTrackerExportViewCheckbox

---@class MapPinEnhancedTrackerExportView : MapPinEnhancedTrackerView
---@field textBox MapPinEnhancedScrollableTextarea
---@field exportMode MapPinEnhancedTrackerExportViewExportMode
---@field cancelButton MapPinEnhancedButtonRed
MapPinEnhancedTrackerExportViewMixin = {}


function MapPinEnhancedTrackerExportViewMixin:Update()
end

function MapPinEnhancedTrackerExportViewMixin:GetViewHeight()
end

function MapPinEnhancedTrackerExportViewMixin:UpdateHeight()
end
