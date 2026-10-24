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

---@class MapPinEnhancedStaticDialogFrame : Frame
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
---@field OnHide? fun(self: MapPinEnhancedStaticDialogFrame, data: table?)
---@field EditBoxOnEnterPressed? fun(editBox: MapPinEnhancedStaticDialogEditBox)
---@field EditBoxOnEscapePressed? fun(editBox: MapPinEnhancedStaticDialogEditBox)

---@class ConfirmDialogData
---@field onConfirm function?
---@field onCancel function?
---@field onHide function?

---@class TextInputDialogData
---@field value string
---@field maxLetters number
---@field onAccept fun(value: string): boolean? true keeps the dialog open

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
local TEXT_INPUT_DIALOG_NAME = DIALOG_PREFIX .. "TEXT_INPUT"
local ABOUT_DIALOG_NAME = DIALOG_PREFIX .. "ABOUT"
local COPY_TEXT_DIALOG_NAME = DIALOG_PREFIX .. "COPY_TEXT"
local ADDON_CONFLICTS_DIALOG_NAME = DIALOG_PREFIX .. "ADDON_CONFLICTS"

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
    OnHide = function(_, data)
        ---@cast data ConfirmDialogData
        if data and data.onHide then
            data.onHide()
        end
    end,
})

RegisterStaticDialog(TEXT_INPUT_DIALOG_NAME, {
    text = "",
    button1 = L["Save"],
    button2 = L["Cancel"],
    hasEditBox = true,
    editBoxWidth = 320,
    OnShow = function(self, data)
        ---@cast data TextInputDialogData
        local editBox = GetStaticDialogEditBox(self)
        if not editBox or not data then return end
        editBox:SetNumeric(false)
        editBox:SetMaxLetters(data.maxLetters)
        editBox:SetText(data.value)
        editBox:SetFocus()
        editBox:HighlightText()
    end,
    OnAccept = function(self, data)
        ---@cast data TextInputDialogData
        local editBox = GetStaticDialogEditBox(self)
        if data and editBox then return data.onAccept(strtrim(editBox:GetText())) end
    end,
    EditBoxOnEnterPressed = function(editBox)
        ClickStaticDialogButtonForEditBox(editBox, 1)
    end,
    EditBoxOnEscapePressed = function(editBox)
        ClickStaticDialogButtonForEditBox(editBox, 2)
    end,
    OnHide = function(self)
        local editBox = GetStaticDialogEditBox(self)
        if editBox then editBox:ClearFocus() end
    end,
})

RegisterStaticDialog(ABOUT_DIALOG_NAME, {
    text = "",
    button1 = L["Close"],
})

RegisterStaticDialog(ADDON_CONFLICTS_DIALOG_NAME, {
    text = "",
    button1 = L["Close"],
    showAlert = true,
})

RegisterStaticDialog(COPY_TEXT_DIALOG_NAME, {
    text = "",
    button1 = L["Close"],
    hasEditBox = true,
    editBoxWidth = 360,
    OnShow = function(self, data)
        local editBox = GetStaticDialogEditBox(self)
        if not editBox then return end
        editBox:SetNumeric(false)
        editBox:SetMaxLetters(0)
        editBox:SetText(data and data.text or "")
        editBox:SetFocus()
        editBox:HighlightText()
    end,
    EditBoxOnEnterPressed = function(editBox)
        editBox:HighlightText()
    end,
    EditBoxOnEscapePressed = function(editBox)
        ClickStaticDialogButtonForEditBox(editBox, 1)
    end,
    OnHide = function(self)
        local editBox = GetStaticDialogEditBox(self)
        if editBox then editBox:ClearFocus() end
    end,
})

---@param title string?
---@param message string
---@param onConfirm function?
---@param onCancel function?
---@param onHide function?
---@return MapPinEnhancedStaticDialogFrame?
function MapPinEnhanced:ShowConfirmDialog(title, message, onConfirm, onCancel, onHide)
    ---@type ConfirmDialogData
    local data = {
        onConfirm = onConfirm,
        onCancel = onCancel,
        onHide = onHide,
    }

    return ShowStaticDialog(CONFIRM_DIALOG_NAME, BuildDialogText(title or L["Confirm"], message), data)
end

---@param addonNames string[]
---@return MapPinEnhancedStaticDialogFrame?
function MapPinEnhanced:ShowAddonConflictsDialog(addonNames)
    local message = string.format(
        L
        ["The following addons interfere with Map Pin Enhanced and should not be used together:\n\n%s\n\nDisable them in the AddOns menu and reload your UI."],
        table.concat(addonNames, "\n"))
    return ShowStaticDialog(ADDON_CONFLICTS_DIALOG_NAME, BuildDialogText(L["Addon conflicts"], message))
end

---@param title string
---@param value string
---@param maxLetters number
---@param onAccept fun(value: string): boolean? true keeps the dialog open
---@return MapPinEnhancedStaticDialogFrame?
function MapPinEnhanced:ShowTextInputDialog(title, value, maxLetters, onAccept)
    return ShowStaticDialog(TEXT_INPUT_DIALOG_NAME, title,
        { value = value, maxLetters = maxLetters, onAccept = onAccept })
end

local MPHLogoSequence = "|T" .. MapPinEnhanced.assetsPath .. "\\LogoTransparent.png" .. ":64:64|t"
local HeartIcon = " |A:" .. "delves-scenario-heart-icon" .. ":16:16|a"

---@return MapPinEnhancedStaticDialogFrame?
function MapPinEnhanced:ShowAboutDialog()
    local text = table.concat({
        MPHLogoSequence,
        MapPinEnhanced.displayName,
        "by Nerc",
        "",
        string.format(L["Version: %s (%s)"], MapPinEnhanced.version, MapPinEnhanced.numericVersion),
        string.format(L["Build: %s"], GetBuildInfo()),
        "",
        L
        ["Thanks to Eminos for the countless hours creating textures, rubber-ducking and thinking about ideas with me. Thanks to all who helped me test new versions, gave feedback and reported bugs!"] ..
        HeartIcon,
        L["Special thanks to Byyrax and Pamoo for the help with translations"],
    }, "\n")

    return ShowStaticDialog(ABOUT_DIALOG_NAME, text, nil)
end

local copyTextWindow ---@type MapPinEnhancedCopyTextDialogTemplate?

---@param title string
---@param text string
---@return MapPinEnhancedStaticDialogFrame|MapPinEnhancedCopyTextDialogTemplate|nil
function MapPinEnhanced:ShowCopyTextDialog(title, text)
    assert(type(title) == "string", "MapPinEnhanced:ShowCopyTextDialog requires a title")
    assert(type(text) == "string", "MapPinEnhanced:ShowCopyTextDialog requires text")
    if text:find("\n", 1, true) then
        if not copyTextWindow then
            copyTextWindow = CreateFrame("Frame", "MapPinEnhancedCopyTextDialog", UIParent,
                "MapPinEnhancedCopyTextDialogTemplate")
        end
        copyTextWindow:Open(title, text)
        return copyTextWindow
    end
    return ShowStaticDialog(COPY_TEXT_DIALOG_NAME, title, { text = text })
end

MapPinEnhanced:AddSlashCommand({ "version", "about" },
    function() MapPinEnhanced:ShowAboutDialog() end,
    L["Open the about dialog to view version information."])
