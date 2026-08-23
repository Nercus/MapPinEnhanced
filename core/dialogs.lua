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
---@field editBox MapPinEnhancedStaticDialogEditBox?
---@field button1 MapPinEnhancedStaticDialogButton?
---@field button2 MapPinEnhancedStaticDialogButton?
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

---@class ConfirmDialogData
---@field onConfirm function?
---@field onCancel function?

---@class RenamePinDialogData
---@field pin MapPinEnhancedPinMixin

---@class RenameGroupDialogData
---@field group MapPinEnhancedGroupMixin

---@type table<string, MapPinEnhancedStaticDialogDefinition>
local StaticDialogDefinitions = StaticPopupDialogs

---@type number?
local STATIC_DIALOG_PREFERRED_INDEX = _G["STATICPOPUP_NUMDIALOGS"]

---@type fun(dialog: MapPinEnhancedStaticDialogFrame, buttonID: number)
local ClickStaticDialogButton = StaticPopup_OnClick

---@type fun(dialogName: string, textArg1?: any, textArg2?: any, data?: table): MapPinEnhancedStaticDialogFrame?
local ShowStaticDialogFrame = StaticPopup_Show

local L = MapPinEnhanced.L

local DIALOG_PREFIX = MapPinEnhanced.name .. "_DIALOG_"
local CONFIRM_DIALOG_NAME = DIALOG_PREFIX .. "CONFIRM"
local RENAME_PIN_DIALOG_NAME = DIALOG_PREFIX .. "RENAME_PIN"
local RENAME_GROUP_DIALOG_NAME = DIALOG_PREFIX .. "RENAME_GROUP"
local ABOUT_DIALOG_NAME = DIALOG_PREFIX .. "ABOUT"

---@param dialogName string
---@param definition MapPinEnhancedStaticDialogDefinition
local function RegisterStaticDialog(dialogName, definition)
    definition.timeout = false
    definition.whileDead = true
    definition.hideOnEscape = true
    definition.preferredIndex = STATIC_DIALOG_PREFERRED_INDEX
    StaticDialogDefinitions[dialogName] = definition
end

---@param dialogName string
---@param text string
---@param data table?
---@return MapPinEnhancedStaticDialogFrame?
local function ShowStaticDialog(dialogName, text, data)
    local definition = StaticDialogDefinitions[dialogName]
    assert(definition, "MapPinEnhanced dialogs: unknown static dialog: " .. dialogName)

    definition.text = string.gsub(text, "%%", "%%%%")

    local dialog = ShowStaticDialogFrame(dialogName, nil, nil, data)
    if dialog then
        dialog:ClearAllPoints()
        dialog:SetPoint("CENTER", UIParent, "CENTER")
    end

    return dialog
end

---@param title string?
---@param message string?
---@return string
local function BuildDialogText(title, message)
    if title and title ~= "" and message and message ~= "" then
        return title .. "\n\n" .. message
    end

    return message or title or ""
end

---@param dialog MapPinEnhancedStaticDialogFrame
---@return MapPinEnhancedStaticDialogEditBox?
local function GetStaticDialogEditBox(dialog)
    if dialog.GetEditBox then
        return dialog:GetEditBox()
    end

    return dialog.editBox or _G[dialog:GetName() .. "EditBox"]
end

---@param dialog MapPinEnhancedStaticDialogFrame
---@param index number
---@return MapPinEnhancedStaticDialogButton?
local function GetStaticDialogButton(dialog, index)
    if index == 1 and dialog.GetButton1 then
        return dialog:GetButton1()
    elseif index == 2 and dialog.GetButton2 then
        return dialog:GetButton2()
    elseif index == 1 then
        return dialog.button1 or _G[dialog:GetName() .. "Button1"]
    elseif index == 2 then
        return dialog.button2 or _G[dialog:GetName() .. "Button2"]
    end
end

---@param editBox MapPinEnhancedStaticDialogEditBox
---@param buttonIndex number
local function ClickStaticDialogButtonForEditBox(editBox, buttonIndex)
    local dialog = editBox:GetParent()
    ---@cast dialog MapPinEnhancedStaticDialogFrame
    local button = GetStaticDialogButton(dialog, buttonIndex)
    if not button then return end

    ClickStaticDialogButton(dialog, button:GetID())
end

---@param pin MapPinEnhancedPinMixin?
---@return string
local function GetPinTitle(pin)
    if not pin then return "" end

    local pinData = pin:GetPinData()
    return pinData.title or ""
end

RegisterStaticDialog(CONFIRM_DIALOG_NAME, {
    text = "",
    button1 = L["Confirm"],
    button2 = L["Cancel"],
    showAlert = true,
    OnAccept = function(_, data)
        ---@cast data ConfirmDialogData
        if data and data.onConfirm then
            data.onConfirm()
        end
    end,
    OnCancel = function(_, data, reason)
        ---@cast data ConfirmDialogData
        if data and data.onCancel and reason ~= "override" then
            data.onCancel()
        end
    end,
})

RegisterStaticDialog(RENAME_PIN_DIALOG_NAME, {
    text = "",
    button1 = L["Save"],
    button2 = L["Cancel"],
    hasEditBox = true,
    editBoxWidth = 320,
    OnShow = function(self, data)
        ---@cast self MapPinEnhancedStaticDialogFrame
        ---@cast data RenamePinDialogData
        local editBox = GetStaticDialogEditBox(self)
        if not editBox then return end

        editBox:SetNumeric(false)
        editBox:SetMaxLetters(0)
        editBox:SetText(GetPinTitle(data and data.pin))
        editBox:SetFocus()
        editBox:HighlightText()
    end,
    OnAccept = function(self, data)
        ---@cast self MapPinEnhancedStaticDialogFrame
        ---@cast data RenamePinDialogData
        if not data or not data.pin then return end

        local editBox = GetStaticDialogEditBox(self)
        local title = strtrim(editBox and editBox:GetText() or "")
        if title == "" then
            title = L["Map Pin"]
        end

        data.pin:SetTitle(title)
    end,
    EditBoxOnEnterPressed = function(editBox)
        ClickStaticDialogButtonForEditBox(editBox, 1)
    end,
    EditBoxOnEscapePressed = function(editBox)
        ClickStaticDialogButtonForEditBox(editBox, 2)
    end,
    OnHide = function(self)
        ---@cast self MapPinEnhancedStaticDialogFrame
        local editBox = GetStaticDialogEditBox(self)
        if editBox then
            editBox:ClearFocus()
        end
    end,
})

RegisterStaticDialog(RENAME_GROUP_DIALOG_NAME, {
    text = "",
    button1 = L["Save"],
    button2 = L["Cancel"],
    hasEditBox = true,
    editBoxWidth = 320,
    OnShow = function(self, data)
        ---@cast self MapPinEnhancedStaticDialogFrame
        ---@cast data RenameGroupDialogData
        local editBox = GetStaticDialogEditBox(self)
        if not editBox then return end

        editBox:SetNumeric(false)
        editBox:SetMaxLetters(0)
        editBox:SetText(data and data.group and data.group:GetName() or "")
        editBox:SetFocus()
        editBox:HighlightText()
    end,
    OnAccept = function(self, data)
        ---@cast self MapPinEnhancedStaticDialogFrame
        ---@cast data RenameGroupDialogData
        if not data or not data.group then return end

        local editBox = GetStaticDialogEditBox(self)
        local groupName = strtrim(editBox and editBox:GetText() or "")
        if groupName == "" then
            return true
        end

        if groupName == data.group:GetName() then
            return
        end

        if not data.group:SetName(groupName) then
            MapPinEnhanced:Notify(string.format(L["A group named \"%s\" already exists."], groupName), "ERROR")
            return true
        end
    end,
    EditBoxOnEnterPressed = function(editBox)
        ClickStaticDialogButtonForEditBox(editBox, 1)
    end,
    EditBoxOnEscapePressed = function(editBox)
        ClickStaticDialogButtonForEditBox(editBox, 2)
    end,
    OnHide = function(self)
        ---@cast self MapPinEnhancedStaticDialogFrame
        local editBox = GetStaticDialogEditBox(self)
        if editBox then
            editBox:ClearFocus()
        end
    end,
})

RegisterStaticDialog(ABOUT_DIALOG_NAME, {
    text = "",
    button1 = L["Close"],
})

---@param title string?
---@param message string
---@param onConfirm function?
---@param onCancel function?
---@return MapPinEnhancedStaticDialogFrame?
function MapPinEnhanced:ShowConfirmDialog(title, message, onConfirm, onCancel)
    ---@type ConfirmDialogData
    local data = {
        onConfirm = onConfirm,
        onCancel = onCancel,
    }

    return ShowStaticDialog(CONFIRM_DIALOG_NAME, BuildDialogText(title or L["Confirm"], message), data)
end

---@param pin MapPinEnhancedPinMixin
---@return MapPinEnhancedStaticDialogFrame?
function MapPinEnhanced:ShowRenamePinDialog(pin)
    assert(pin, "MapPinEnhanced:ShowRenamePinDialog: pin is nil")
    return ShowStaticDialog(RENAME_PIN_DIALOG_NAME, L["Rename Pin"], { pin = pin })
end

---@param group MapPinEnhancedGroupMixin
---@return MapPinEnhancedStaticDialogFrame?
function MapPinEnhanced:ShowRenameGroupDialog(group)
    assert(group, "MapPinEnhanced:ShowRenameGroupDialog: group is nil")
    return ShowStaticDialog(RENAME_GROUP_DIALOG_NAME, L["Rename Group"], { group = group })
end

---@return MapPinEnhancedStaticDialogFrame?
function MapPinEnhanced:ShowAboutDialog()
    local text = table.concat({
        MapPinEnhanced.displayName,
        "by Nerc",
        "",
        string.format(L["Version: %s (%s)"], MapPinEnhanced.version, MapPinEnhanced.numericVersion),
        string.format(L["Build: %s"], GetBuildInfo()),
        "",
        L
            ["Thanks to Eminos for the countless hours creating textures, rubber-ducking and thinking about ideas with me. Thanks to all who helped me test new versions, gave feedback and reported bugs! <3"],
    }, "\n")

    return ShowStaticDialog(ABOUT_DIALOG_NAME, text, nil)
end

MapPinEnhanced:AddSlashCommand({ "version", "about" },
    function() MapPinEnhanced:ShowAboutDialog() end,
    L["Open the about dialog to view version information."])
