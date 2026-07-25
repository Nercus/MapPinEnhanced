---@diagnostic disable: undefined-global
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

local L = MapPinEnhanced.L
local definition = Dialogs.DIALOG_DEFINITIONS.CONFIRM

---@class ConfirmDialogOptions
---@field title string?
---@field message string
---@field onConfirm function?
---@field onCancel function?
---@field onClose function?
---@field confirmText string?
---@field cancelText string?

Dialogs:RegisterStaticDialogDefinition(definition, {
    text = "",
    button1 = L["Confirm"],
    button2 = L["Cancel"],
    showAlert = true,
    OnAccept = function(_, data)
        ---@cast data ConfirmDialogOptions
        if data and data.onConfirm then
            data.onConfirm()
        end
    end,
    OnCancel = function(_, data, reason)
        ---@cast data ConfirmDialogOptions
        if data and data.onCancel and reason ~= "override" then
            data.onCancel()
        end
    end,
    OnHide = function(self)
        ---@cast self MapPinEnhancedStaticDialogFrame
        ---@type ConfirmDialogOptions?
        local data = self.data
        if data and data.onClose then
            data.onClose()
        end
        Dialogs:MarkStaticDialogClosed(definition)
    end,
})

---@param title string?
---@param message string
---@param onConfirm function?
---@param onCancel function?
---@return MapPinEnhancedStaticDialogFrame?
function Dialogs:ShowConfirmDialog(title, message, onConfirm, onCancel)
    ---@type ConfirmDialogOptions
    local options = {
        title = title,
        message = message,
        onConfirm = onConfirm,
        onCancel = onCancel,
    }

    self:SetStaticDialogButtons(definition, options.confirmText or L["Confirm"], options.cancelText or L["Cancel"])

    return self:ShowStaticDialog(definition, self:BuildStaticDialogText(title or L["Confirm"], message), options)
end

Dialogs:RegisterDialogHandler(definition, function(dialogs, overrideTitle, options)
    ---@cast options ConfirmDialogOptions
    local title = overrideTitle or options.title or L["Confirm"]

    dialogs:SetStaticDialogButtons(definition, options.confirmText or L["Confirm"], options.cancelText or L["Cancel"])

    return dialogs:ShowStaticDialog(definition, dialogs:BuildStaticDialogText(title, options.message), options)
end)
