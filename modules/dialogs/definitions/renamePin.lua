---@diagnostic disable: undefined-global
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

local L = MapPinEnhanced.L
local definition = Dialogs.DIALOG_DEFINITIONS.RENAME_PIN

---@class RenamePinDialogOptions
---@field pin MapPinEnhancedPinMixin

---@param pin MapPinEnhancedPinMixin?
---@return string
local function GetPinTitle(pin)
    if not pin then return "" end

    local pinData = pin:GetPinData()
    return pinData.title or ""
end

Dialogs:RegisterStaticDialogDefinition(definition, {
    text = "",
    button1 = L["Save"],
    button2 = L["Cancel"],
    hasEditBox = true,
    editBoxWidth = 320,
    OnShow = function(self, data)
        ---@cast self MapPinEnhancedStaticDialogFrame
        ---@cast data RenamePinDialogOptions
        local editBox = Dialogs:GetStaticDialogEditBox(self)
        if not editBox then return end

        editBox:SetNumeric(false)
        editBox:SetMaxLetters(0)
        editBox:SetText(GetPinTitle(data and data.pin))
        editBox:SetFocus()
        editBox:HighlightText()
    end,
    OnAccept = function(self, data)
        ---@cast self MapPinEnhancedStaticDialogFrame
        ---@cast data RenamePinDialogOptions
        if not data or not data.pin then return end

        local editBox = Dialogs:GetStaticDialogEditBox(self)
        local title = strtrim(editBox and editBox:GetText() or "")
        if title == "" then
            title = L["Map Pin"]
        end

        data.pin:SetTitle(title)
    end,
    EditBoxOnEnterPressed = function(editBox)
        Dialogs:ClickStaticDialogButtonForEditBox(editBox, 1)
    end,
    EditBoxOnEscapePressed = function(editBox)
        Dialogs:ClickStaticDialogButtonForEditBox(editBox, 2)
    end,
    OnHide = function(self)
        ---@cast self MapPinEnhancedStaticDialogFrame
        local editBox = Dialogs:GetStaticDialogEditBox(self)
        if editBox then
            editBox:ClearFocus()
        end
        Dialogs:MarkStaticDialogClosed(definition)
    end,
})

---@param pin MapPinEnhancedPinMixin
---@return MapPinEnhancedStaticDialogFrame?
function Dialogs:ShowRenamePinDialog(pin)
    return self:ShowDialog(definition, L["Rename Pin"], {
        pin = pin,
    })
end

Dialogs:RegisterDialogHandler(definition, function(dialogs, overrideTitle, options)
    ---@cast options RenamePinDialogOptions
    assert(options.pin, "Dialogs:ShowRenamePinDialog: pin is nil")

    return dialogs:ShowStaticDialog(definition, overrideTitle or L["Rename Pin"], options)
end)
