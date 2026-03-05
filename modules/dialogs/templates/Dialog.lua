---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

-- base template for dialogs
---@class MapPinEnhancedDialog : DefaultPanelFlatTemplate
---@field content DialogContentFrame
MapPinEnhancedDialogMixin = {}

---@class Dialogs
---@field dialogFrame MapPinEnhancedDialog
local Dialogs = MapPinEnhanced:GetModule("Dialogs")


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
    self.content:SetPoint("TOPLEFT", self, "TOPLEFT", 6, -20)
    self.content:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -2, 2)
    self.content:SetFrameStrata(self:GetFrameStrata())
    self.content:SetFrameLevel(self:GetFrameLevel() + 10)
    self.content:Show()

    local contentWidth, contentHeight = self.content:GetSize()
    self:SetSize(contentWidth + 10, contentHeight + 20)
    self:Show()
end

function MapPinEnhancedDialogMixin:OnLoad()
    self.Bg:SetFrameStrata("BACKGROUND") -- i dont know why I need this, but I can't figure out another solution
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
