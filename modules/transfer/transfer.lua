---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Transfer
---@field importWindow MapPinEnhancedWindowTemplate?
---@field exportWindow MapPinEnhancedExportWindowTemplate?
local Transfer = MapPinEnhanced:GetModule("Transfer")

local L = MapPinEnhanced.L

---@return MapPinEnhancedWindowTemplate
function Transfer:GetImportWindow()
    if not self.importWindow then
        self.importWindow = CreateFrame("Frame", "MapPinEnhancedImportWindow", UIParent,
            "MapPinEnhancedImportWindowTemplate")
    end

    return self.importWindow
end

---@return MapPinEnhancedExportWindowTemplate
function Transfer:GetExportWindow()
    if not self.exportWindow then
        self.exportWindow = CreateFrame("Frame", "MapPinEnhancedExportWindow", UIParent,
            "MapPinEnhancedExportWindowTemplate")
    end

    return self.exportWindow
end

function Transfer:ShowImportWindow()
    self:GetImportWindow():Show()
end

function Transfer:HideImportWindow()
    if self.importWindow then
        self.importWindow:Hide()
    end
end

---@param target MapPinEnhancedPinMixin|MapPinEnhancedGroupMixin?
function Transfer:ShowExportWindow(target)
    local window = self:GetExportWindow()
    ---@cast window MapPinEnhancedExportWindowTemplate
    window:SetExportTarget(target)
    window:Show()
end

function Transfer:HideExportWindow()
    if self.exportWindow then
        self.exportWindow:Hide()
    end
end

MapPinEnhanced:AddSlashCommand("import",
    function() Transfer:ShowImportWindow() end,
    L["Open the import dialog to import map pins from a string."])

MapPinEnhanced:AddSlashCommand("export",
    function() Transfer:ShowExportWindow() end,
    L["Open the export dialog to export your map pins to a string."])
