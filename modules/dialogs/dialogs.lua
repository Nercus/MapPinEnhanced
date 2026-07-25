---@diagnostic disable: undefined-global
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedStaticDialogButton
---@field GetID fun(self: MapPinEnhancedStaticDialogButton): number

---@class MapPinEnhancedStaticDialogEditBox
---@field GetParent fun(self: MapPinEnhancedStaticDialogEditBox): MapPinEnhancedStaticDialogFrame
---@field GetText fun(self: MapPinEnhancedStaticDialogEditBox): string
---@field SetText fun(self: MapPinEnhancedStaticDialogEditBox, text: string)
---@field SetNumeric fun(self: MapPinEnhancedStaticDialogEditBox, numeric: boolean)
---@field SetMaxLetters fun(self: MapPinEnhancedStaticDialogEditBox, maxLetters: number)
---@field SetFocus fun(self: MapPinEnhancedStaticDialogEditBox)
---@field ClearFocus fun(self: MapPinEnhancedStaticDialogEditBox)
---@field HighlightText fun(self: MapPinEnhancedStaticDialogEditBox)

---@class MapPinEnhancedStaticDialogFrame
---@field data table?
---@field editBox MapPinEnhancedStaticDialogEditBox?
---@field button1 MapPinEnhancedStaticDialogButton?
---@field button2 MapPinEnhancedStaticDialogButton?
---@field button3 MapPinEnhancedStaticDialogButton?
---@field GetName fun(self: MapPinEnhancedStaticDialogFrame): string
---@field ClearAllPoints fun(self: MapPinEnhancedStaticDialogFrame)
---@field SetPoint fun(self: MapPinEnhancedStaticDialogFrame, point: string, relativeTo: any, relativePoint: string, offsetX?: number, offsetY?: number)
---@field GetEditBox? fun(self: MapPinEnhancedStaticDialogFrame): MapPinEnhancedStaticDialogEditBox?
---@field GetButton1? fun(self: MapPinEnhancedStaticDialogFrame): MapPinEnhancedStaticDialogButton?
---@field GetButton2? fun(self: MapPinEnhancedStaticDialogFrame): MapPinEnhancedStaticDialogButton?

---@class MapPinEnhancedStaticDialogDefinition
---@field text string
---@field button1 string?
---@field button2 string?
---@field button3 string?
---@field showAlert? boolean
---@field timeout? boolean|number
---@field whileDead? boolean
---@field hideOnEscape? boolean
---@field preferredIndex? number
---@field hasEditBox? boolean
---@field editBoxWidth? number
---@field OnShow? fun(self: MapPinEnhancedStaticDialogFrame, data: table?)
---@field OnAccept? fun(self: MapPinEnhancedStaticDialogFrame, data: table?): boolean?
---@field OnCancel? fun(self: MapPinEnhancedStaticDialogFrame, data: table?, reason: string?)
---@field OnHide? fun(self: MapPinEnhancedStaticDialogFrame)
---@field EditBoxOnEnterPressed? fun(editBox: MapPinEnhancedStaticDialogEditBox)
---@field EditBoxOnEscapePressed? fun(editBox: MapPinEnhancedStaticDialogEditBox)

---@type table<string, MapPinEnhancedStaticDialogDefinition>
local StaticDialogDefinitions = StaticPopupDialogs

---@type number?
local STATIC_DIALOG_PREFERRED_INDEX = _G["STATICPOPUP_NUMDIALOGS"]

---@type fun(dialog: MapPinEnhancedStaticDialogFrame, buttonID: number)
local ClickStaticDialogButton = StaticPopup_OnClick

---@type fun(dialogName: string, textArg1?: any, textArg2?: any, data?: table): MapPinEnhancedStaticDialogFrame?
local ShowStaticDialogFrame = StaticPopup_Show

---@type fun(dialogName: string)
local HideStaticDialogFrame = StaticPopup_Hide

---@class Dialogs
---@field openDialog DialogDefinitions?
---@field dialogHandlers table<DialogDefinitions, fun(dialogs: Dialogs, overrideTitle: string?, options: table?): MapPinEnhancedStaticDialogFrame?>
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

---@enum DialogDefinitions
Dialogs.DIALOG_DEFINITIONS = {
    CONFIRM = "CONFIRM",
    INFO = "INFO",
    RENAME_PIN = "RENAME_PIN",
    RENAME_GROUP = "RENAME_GROUP",
    ABOUT = "ABOUT",
}

Dialogs.dialogHandlers = Dialogs.dialogHandlers or {}

local DIALOG_PREFIX = MapPinEnhanced.name .. "_DIALOG_"

---@param text any
---@return string
function Dialogs:EscapeStaticDialogText(text)
    local escapedText = string.gsub(tostring(text or ""), "%%", "%%%%")
    return escapedText
end

---@param title string?
---@param message string?
---@return string
function Dialogs:BuildStaticDialogText(title, message)
    if title and title ~= "" and message and message ~= "" then
        return title .. "\n\n" .. message
    end

    return message or title or ""
end

---@param dialogType DialogDefinitions
---@return string
function Dialogs:GetStaticDialogName(dialogType)
    assert(dialogType, "Dialogs:GetStaticDialogName: dialogType is nil")
    return DIALOG_PREFIX .. dialogType
end

---@param dialog MapPinEnhancedStaticDialogFrame
---@return MapPinEnhancedStaticDialogEditBox?
function Dialogs:GetStaticDialogEditBox(dialog)
    if dialog.GetEditBox then
        return dialog:GetEditBox()
    end

    return dialog.editBox or _G[dialog:GetName() .. "EditBox"]
end

---@param dialog MapPinEnhancedStaticDialogFrame
---@param index number
---@return MapPinEnhancedStaticDialogButton?
function Dialogs:GetStaticDialogButton(dialog, index)
    if index == 1 and dialog.GetButton1 then
        return dialog:GetButton1()
    elseif index == 2 and dialog.GetButton2 then
        return dialog:GetButton2()
    end

    if index == 1 then
        return dialog.button1 or _G[dialog:GetName() .. "Button1"]
    elseif index == 2 then
        return dialog.button2 or _G[dialog:GetName() .. "Button2"]
    elseif index == 3 then
        return dialog.button3 or _G[dialog:GetName() .. "Button3"]
    end
end

---@param editBox MapPinEnhancedStaticDialogEditBox
---@param buttonIndex number
function Dialogs:ClickStaticDialogButtonForEditBox(editBox, buttonIndex)
    local dialog = editBox:GetParent()
    ---@cast dialog MapPinEnhancedStaticDialogFrame
    local button = self:GetStaticDialogButton(dialog, buttonIndex)
    if not button then return end

    ClickStaticDialogButton(dialog, button:GetID())
end

---@param dialogType DialogDefinitions
---@param handler fun(dialogs: Dialogs, overrideTitle: string?, options: table?): MapPinEnhancedStaticDialogFrame?
function Dialogs:RegisterDialogHandler(dialogType, handler)
    assert(dialogType, "Dialogs:RegisterDialogHandler: dialogType is nil")
    assert(type(handler) == "function", "Dialogs:RegisterDialogHandler: handler must be a function")

    self.dialogHandlers[dialogType] = handler
end

---@param dialogType DialogDefinitions
---@param definition MapPinEnhancedStaticDialogDefinition
---@return string
function Dialogs:RegisterStaticDialogDefinition(dialogType, definition)
    assert(dialogType, "Dialogs:RegisterStaticDialogDefinition: dialogType is nil")
    assert(type(definition) == "table", "Dialogs:RegisterStaticDialogDefinition: definition must be a table")

    if definition.timeout == nil then
        definition.timeout = false
    end
    if definition.whileDead == nil then
        definition.whileDead = true
    end
    if definition.hideOnEscape == nil then
        definition.hideOnEscape = true
    end
    if definition.preferredIndex == nil and STATIC_DIALOG_PREFERRED_INDEX then
        definition.preferredIndex = STATIC_DIALOG_PREFERRED_INDEX
    end

    local dialogName = self:GetStaticDialogName(dialogType)
    StaticDialogDefinitions[dialogName] = definition
    return dialogName
end

---@param dialogType DialogDefinitions
---@param button1 string?
---@param button2 string?
function Dialogs:SetStaticDialogButtons(dialogType, button1, button2)
    local dialogName = self:GetStaticDialogName(dialogType)
    ---@type MapPinEnhancedStaticDialogDefinition
    local definition = StaticDialogDefinitions[dialogName]
    assert(definition, "Dialogs:SetStaticDialogButtons: unknown dialog type: " .. tostring(dialogType))

    definition.button1 = button1
    definition.button2 = button2
end

---@param dialogType DialogDefinitions
function Dialogs:MarkStaticDialogClosed(dialogType)
    if self.openDialog == dialogType then
        self.openDialog = nil
    end
end

---@param dialogType DialogDefinitions
---@param text string
---@param data table?
---@return MapPinEnhancedStaticDialogFrame?
function Dialogs:ShowStaticDialog(dialogType, text, data)
    local dialogName = self:GetStaticDialogName(dialogType)
    local definition = StaticDialogDefinitions[dialogName]
    assert(definition, "Dialogs:ShowStaticDialog: unknown dialog type: " .. tostring(dialogType))

    definition.text = self:EscapeStaticDialogText(text)

    local dialog = ShowStaticDialogFrame(dialogName, nil, nil, data)
    if dialog then
        self.openDialog = dialogType
        dialog:ClearAllPoints()
        dialog:SetPoint("CENTER", UIParent, "CENTER")
    end

    return dialog
end

---@param dialogType DialogDefinitions
---@param overrideTitle string?
---@param options table?
---@return MapPinEnhancedStaticDialogFrame?
function Dialogs:ShowDialog(dialogType, overrideTitle, options)
    local handler = self.dialogHandlers[dialogType]
    if not handler then
        error("Unknown dialog type: " .. tostring(dialogType))
    end

    return handler(self, overrideTitle, options or {})
end

---@param dialogType DialogDefinitions?
function Dialogs:HideDialog(dialogType)
    local openDialog = self.openDialog
    if dialogType and openDialog and dialogType ~= openDialog then
        return
    end

    if dialogType then
        HideStaticDialogFrame(self:GetStaticDialogName(dialogType))
    elseif openDialog then
        HideStaticDialogFrame(self:GetStaticDialogName(openDialog))
    end

    self.openDialog = nil
end
