---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

-- base template for dialogs
---@class MapPinEnhancedDialog : DefaultPanelFlatTemplate
---@field content DialogContentFrame
MapPinEnhancedDialogMixin = {}

---@class Dialogs
---@field dialogFrame MapPinEnhancedDialog
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

local defaultPoint = { "CENTER", nil, "CENTER", 0, 0 }

---@alias DialogContentFrame MapPinEnhancedExportDialogContentTemplate |MapPinEnhancedImportDialogContentTemplate | MapPinEnhancedConfirmDialogContentTemplate |MapPinEnhancedInfoDialogContentTemplate


---@param content DialogContentFrame
---@param title string
function MapPinEnhancedDialogMixin:ShowDialog(content, title)
    if self.content and self.content ~= content then
        self.content:Hide()
        self.content:SetParent(nil)
    end

    self:SetTitle(string.format("%s - %s", MapPinEnhanced.displayName, title))
    self.content = content
    self.content:SetParent(self)
    self.content:ClearAllPoints()
    self.content:SetPoint(unpack(defaultPoint))
    self.content:Show()

    local contentWidth, contentHeight = self.content:GetSize()
    local paddingX, paddingY = 40, 60
    self:SetSize(contentWidth + paddingX, contentHeight + paddingY)
    self:Show()
end

function MapPinEnhancedDialogMixin:OnLoad()
    MapPinEnhanced:RegisterDraggableFrame(self, "MapPinEnhancedDialog", self.TitleContainer, function()
        return false
    end)
    Dialogs.dialogFrame = self

    _G["MapPinEnhancedDialog"] = self
    table.insert(UISpecialFrames, "MapPinEnhancedDialog")
end

function MapPinEnhancedDialogMixin:OnShow()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
end

function MapPinEnhancedDialogMixin:OnHide()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)
    if self.content then
        self.content:Hide()
    end
end
