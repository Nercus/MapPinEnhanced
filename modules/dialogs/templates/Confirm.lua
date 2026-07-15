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
    self.onClose = options.onClose
end

function MapPinEnhancedConfirmDialogContentMixin:OnClose()
    if self.onClose then
        self.onClose()
    end
    self.onClose = nil
end

Dialogs.dialogTypeConfig[Dialogs.DIALOG_TYPES.CONFIRM] = {
    title = L["Confirm"],
    getContent = function(dialogs)
        return dialogs:GetConfirmContent()
    end,
    setup = function(content, options)
        ---@cast content MapPinEnhancedConfirmDialogContentTemplate
        ---@cast options ConfirmDialogOptions
        content:Setup(options)
    end,
    buttons = function(_, options)
        ---@cast options ConfirmDialogOptions
        return {
            {
                label = options.confirmText or L["Confirm"],
                callback = options.onConfirm,
                accept = true,
            },
            {
                label = options.cancelText or L["Cancel"],
                callback = options.onCancel,
                cancel = true,
            },
        }
    end,
}
