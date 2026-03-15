---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedDialogHeader : Frame
---@field title FontString

---@class MapPinEnhancedDialogBackground : Frame
---@field bg Texture
---@field backgroundArt Texture
---@field backgroundMask Texture

-- base template for dialogs
---@class MapPinEnhancedDialog : Frame
---@field content DialogContentFrame
---@field header MapPinEnhancedDialogHeader
---@field background MapPinEnhancedDialogBackground
MapPinEnhancedDialogMixin = {}

---@class Dialogs
---@field dialogFrame MapPinEnhancedDialog
local Dialogs = MapPinEnhanced:GetModule("Dialogs")


---@alias DialogContentFrame MapPinEnhancedExportDialogContentTemplate |MapPinEnhancedImportDialogContentTemplate | MapPinEnhancedConfirmDialogContentTemplate |MapPinEnhancedInfoDialogContentTemplate

function MapPinEnhancedDialogMixin:SetTitle(title)
    self.header.title:SetText(title)
end

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
    self.content:SetPoint("TOP", self, "TOP", 0, -30)
    self.content:SetFrameStrata(self:GetFrameStrata())
    self.content:SetFrameLevel(self:GetFrameLevel() + 10)
    self.content:Show()

    local contentWidth, contentHeight = self.content:GetSize()
    self:SetSize(contentWidth + 20, contentHeight + 30)
    self.background.backgroundMask:SetSize(contentWidth + 10, contentHeight + 20)
    self:Show()
end

function MapPinEnhancedDialogMixin:OnLoad()
    MapPinEnhanced:RegisterDraggableFrame(self, "MapPinEnhancedDialog", self.header, function()
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
