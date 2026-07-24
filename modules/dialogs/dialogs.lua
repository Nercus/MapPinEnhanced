---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
---@field openDialog DialogTypes?
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

local L = MapPinEnhanced.L

---@param config DialogTypeConfig
---@param options table?
---@param overrideTitle string?
---@return string
local function GetDialogTitle(config, options, overrideTitle)
    if overrideTitle then
        return overrideTitle
    end

    if type(config.title) == "function" then
        return config.title(options)
    end

    return config.title
end

---@param dialogType DialogTypes
---@param overrideTitle string?
---@param options table?
---@return DialogContentFrame
function Dialogs:ShowDialog(dialogType, overrideTitle, options)
    local dialogFrame = self.dialogFrame
    local config = self.dialogTypeConfig[dialogType]
    if not config then
        error("Unknown dialog type: " .. tostring(dialogType))
    end

    options = options or {}
    local content = config.getContent(self)
    local title = GetDialogTitle(config, options, overrideTitle)
    local buttons = config.buttons and config.buttons(content, options) or nil
    self.openDialog = dialogType
    dialogFrame:ShowDialog(content, title, buttons)
    if config.setup then
        config.setup(content, options)
    end
    return content
end

---@param title string?
---@param message string
---@param onConfirm function?
---@param onCancel function?
function Dialogs:ShowConfirmDialog(title, message, onConfirm, onCancel)
    self:ShowDialog(self.DIALOG_TYPES.CONFIRM, title, {
        title = title,
        message = message,
        onConfirm = onConfirm,
        onCancel = onCancel,
    })
end

---@param title string?
---@param message string
---@param onClose function?
function Dialogs:ShowInfoDialog(title, message, onClose)
    self:ShowDialog(self.DIALOG_TYPES.INFO, title, {
        title = title,
        message = message,
        onClose = onClose,
    })
end

---@param pin MapPinEnhancedPinMixin
function Dialogs:ShowRenamePinDialog(pin)
    self:ShowDialog(self.DIALOG_TYPES.RENAME_PIN, L["Rename Pin"], {
        pin = pin,
    })
end

---@param group MapPinEnhancedGroupMixin
function Dialogs:ShowRenameGroupDialog(group)
    self:ShowDialog(self.DIALOG_TYPES.RENAME_GROUP, L["Rename Group"], {
        group = group,
    })
end

function Dialogs:HideDialog(dialogType)
    if self.openDialog and dialogType ~= self.openDialog then
        return
    end
    self.openDialog = nil
    self.dialogFrame:Hide()
end

MapPinEnhanced:AddSlashCommand({ "version", "about" },
    function() Dialogs:ShowDialog(Dialogs.DIALOG_TYPES.ABOUT) end,
    L["Open the about dialog to view version information."])
