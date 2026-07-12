---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

local L = MapPinEnhanced.L

---@return MapPinEnhancedConfirmDialogContentTemplate
function Dialogs:GetConfirmContent()
    if not self.confirmDialog then
        self.confirmDialog = CreateFrame("Frame", "MapPinEnhancedConfirmDialogContent", UIParent,
            "MapPinEnhancedConfirmDialogContentTemplate")
    end
    return self.confirmDialog
end

---@class MapPinEnhancedConfirmDialogContentTemplate : Frame
---@field messageText FontString
---@field confirmButton MapPinEnhancedButtonTemplate
---@field cancelButton MapPinEnhancedButtonTemplate
---@field onConfirm function? callback for when the confirm button is clicked, can be set via Setup()
---@field onCancel function? callback for when the cancel button is clicked, can be set via Setup()
---@field onClose function? callback for when the dialog is closed, can be set via Setup()
MapPinEnhancedConfirmDialogContentMixin = {}

---@class ConfirmDialogOptions
---@field title string?
---@field message string
---@field onConfirm function?
---@field onCancel function?
---@field onClose function?
---@field confirmText string?
---@field cancelText string?

---@param options ConfirmDialogOptions
function MapPinEnhancedConfirmDialogContentMixin:Setup(options)
    self.messageText:SetText(options.message or "")
    self.confirmButton:SetText(options.confirmText or L["Confirm"])
    self.cancelButton:SetText(options.cancelText or L["Cancel"])

    self.onConfirm = options.onConfirm
    self.onCancel = options.onCancel
    self.onClose = options.onClose

    self.confirmButton:SetScript("OnClick", function()
        if self.onConfirm then
            self.onConfirm()
        end
        Dialogs:HideDialog(Dialogs.DIALOG_TYPES.CONFIRM)
    end)

    self.cancelButton:SetScript("OnClick", function()
        if self.onCancel then
            self.onCancel()
        end
        Dialogs:HideDialog(Dialogs.DIALOG_TYPES.CONFIRM)
    end)
end

function MapPinEnhancedConfirmDialogContentMixin:OnClose()
    if self.onClose then
        self.onClose()
    end
    self.onConfirm = nil
    self.onCancel = nil
    self.onClose = nil
end
