---@diagnostic disable: undefined-global
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

local L = MapPinEnhanced.L
local definition = Dialogs.DIALOG_DEFINITIONS.INFO

---@class InfoDialogOptions
---@field title string?
---@field message string
---@field onClose function?
---@field closeText string?

Dialogs:RegisterStaticDialogDefinition(definition, {
    text = "",
    button1 = L["Close"],
    OnHide = function(self)
        ---@cast self MapPinEnhancedStaticDialogFrame
        ---@type InfoDialogOptions?
        local data = self.data
        if data and data.onClose then
            data.onClose()
        end
        Dialogs:MarkStaticDialogClosed(definition)
    end,
})

---@param title string?
---@param message string
---@param onClose function?
---@return MapPinEnhancedStaticDialogFrame?
function Dialogs:ShowInfoDialog(title, message, onClose)
    ---@type InfoDialogOptions
    local options = {
        title = title,
        message = message,
        onClose = onClose,
    }

    self:SetStaticDialogButtons(definition, options.closeText or L["Close"], nil)

    return self:ShowStaticDialog(definition, self:BuildStaticDialogText(title or L["Info"], message), options)
end

Dialogs:RegisterDialogHandler(definition, function(dialogs, overrideTitle, options)
    ---@cast options InfoDialogOptions
    local title = overrideTitle or options.title or L["Info"]

    dialogs:SetStaticDialogButtons(definition, options.closeText or L["Close"], nil)

    return dialogs:ShowStaticDialog(definition, dialogs:BuildStaticDialogText(title, options.message), options)
end)
