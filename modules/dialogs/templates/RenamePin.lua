---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

local L = MapPinEnhanced.L

---@return MapPinEnhancedRenamePinDialogContentTemplate
function Dialogs:GetRenamePinContent()
    if not self.renamePinDialog then
        self.renamePinDialog = CreateFrame("Frame", "MapPinEnhancedRenamePinDialogContent", UIParent,
            "MapPinEnhancedRenamePinDialogContentTemplate")
    end
    return self.renamePinDialog
end

---@class MapPinEnhancedRenamePinDialogContentTemplate : Frame
---@field titleInput MapPinEnhancedInputTemplate
---@field acceptButton MapPinEnhancedButtonTemplate
---@field pin MapPinEnhancedPinMixin | nil
MapPinEnhancedRenamePinDialogContentMixin = {}

---@class RenamePinDialogOptions
---@field pin MapPinEnhancedPinMixin

function MapPinEnhancedRenamePinDialogContentMixin:Accept()
    if not self.pin then return end

    local title = strtrim(self.titleInput:GetText() or "")
    if title == "" then
        title = L["Map Pin"]
    end

    self.pin:SetTitle(title)
    Dialogs:HideDialog(Dialogs.DIALOG_TYPES.RENAME_PIN)
end

---@param options RenamePinDialogOptions
function MapPinEnhancedRenamePinDialogContentMixin:Setup(options)
    assert(options.pin, "MapPinEnhancedRenamePinDialogContentMixin:Setup requires a pin")

    self.pin = options.pin
    self.titleInput:SetPlaceholderText(L["Pin Title"])
    self.acceptButton:SetText(L["Save"])
    self.acceptButton:SetScript("OnClick", function()
        self:Accept()
    end)
    self.titleInput:SetScript("OnEnterPressed", function()
        self:Accept()
    end)

    local pinData = self.pin:GetPinData()
    self.titleInput:SetText(pinData.title or "")
    self.titleInput:UpdatePlaceholderVisibility()
    self.titleInput:UpdateClearButtonVisibility()
    self.titleInput:SetFocus()
    self.titleInput:HighlightText()
end

function MapPinEnhancedRenamePinDialogContentMixin:OnClose()
    self.pin = nil
    self.titleInput:SetScript("OnEnterPressed", nil)
    self.titleInput:ClearFocus()
end
