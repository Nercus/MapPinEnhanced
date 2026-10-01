---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Transfer
---@field importWindow MapPinEnhancedImportWindowTemplate?
---@field exportWindow MapPinEnhancedExportWindowTemplate?
local Transfer = MapPinEnhanced:GetModule("Transfer")

local L = MapPinEnhanced.L

---@return MapPinEnhancedImportWindowTemplate
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

---@param dataString string?
function Transfer:ShowImportWindow(dataString)
    local window = self:GetImportWindow()
    window:Show()
    if dataString then
        window.dataString = dataString
        window.textarea:SetValue(dataString)
        window:PreparseImport(dataString)
    elseif not window.parsedData and not window.cancelPreview then
        window:PreparseImport(window.dataString)
    end
end

---Received data uses exactly the same validator as pasted serialized text.
---@param data table
---@param onReady fun(name: string) called only after a valid preview is published
---@return fun() cancel
function Transfer:ShowDecodedImportWindow(data, onReady)
    local window = self:GetImportWindow()
    window:Show()
    window.dataString = nil
    window.textarea:SetValue("")
    return window:PreparseImport(data, onReady)
end

function Transfer:HideImportWindow()
    if self.importWindow then
        self.importWindow:Hide()
    end
end

---@param target MapPinEnhancedPinMixin|MapPinEnhancedGroupMixin
function Transfer:ShowExportWindow(target)
    if not target then return end
    if target.classification == "group" and target:GetTotalPinCount() == 0 then return end
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
