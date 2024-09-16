---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerExportViewCheckbox : MapPinEnhancedCheckbox
---@field label FontString

---@class MapPinEnhancedTrackerExportViewExportMode : Frame
---@field checkbox MapPinEnhancedTrackerExportViewCheckbox

---@class MapPinEnhancedTrackerExportView : Frame
---@field textBox MapPinEnhancedScrollableTextarea
---@field exportMode MapPinEnhancedTrackerExportViewExportMode
---@field cancelButton MapPinEnhancedButtonRed
---@field type "Export"
MapPinEnhancedTrackerImportViewTemplate = {}


function MapPinEnhancedTrackerImportViewTemplate:Update()
end
