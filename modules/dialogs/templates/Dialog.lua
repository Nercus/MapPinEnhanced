---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedDialogHeader : Frame
---@field title FontString

---@class MapPinEnhancedDialogBackground : Frame
---@field bg Texture
---@field backgroundArt Texture
---@field backgroundMask Texture

---@class MapPinEnhancedDialog : Frame
---@field content DialogContentFrame
---@field header MapPinEnhancedDialogHeader
---@field background MapPinEnhancedDialogBackground
---@field buttonContainer Frame
---@field buttonPool FramePool<MapPinEnhancedButtonTemplate>
---@field buttons MapPinEnhancedButtonTemplate[]
---@field buttonData DialogButtonInfo[]
---@field acceptButtonIndex number?
---@field cancelButtonIndex number?
MapPinEnhancedDialogMixin = {}

---@class Dialogs
---@field dialogFrame MapPinEnhancedDialog
---@field openDialog DialogTypes?
---@field dialogTypeConfig table<DialogTypes, DialogTypeConfig>
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

---@enum DialogTypes
Dialogs.DIALOG_TYPES = {
    CONFIRM = "CONFIRM",
    INFO = "INFO",
    RENAME_PIN = "RENAME_PIN",
    RENAME_GROUP = "RENAME_GROUP",
    ABOUT = "ABOUT",
}

---@alias DialogContentFrame MapPinEnhancedConfirmDialogContentTemplate | MapPinEnhancedInfoDialogContentTemplate | MapPinEnhancedRenamePinDialogContentTemplate | MapPinEnhancedRenameGroupDialogContentTemplate | MapPinEnhancedAboutDialogContentTemplate

---@class DialogButtonInfo
---@field label string
---@field callback function?
---@field accept boolean?
---@field cancel boolean?
---@field closeDialog boolean?

---@class DialogTypeConfig
---@field title string|fun(options: table?): string
---@field getContent fun(dialogs: Dialogs): DialogContentFrame
---@field setup fun(content: DialogContentFrame, options: table?)?
---@field buttons fun(content: DialogContentFrame, options: table?): DialogButtonInfo[]?

Dialogs.dialogTypeConfig = Dialogs.dialogTypeConfig or {}

local BUTTON_WIDTH = 100
local BUTTON_HEIGHT = 30
local BUTTON_SPACING = 10
local CONTENT_TOP_OFFSET = -30
local CONTENT_SIDE_PADDING = 20
local CONTENT_BOTTOM_PADDING = 10
local BUTTON_TOP_PADDING = 10

local function SetKeyboardPropagation(frame, propagate)
    if frame.SetPropagateKeyboardInput then
        frame:SetPropagateKeyboardInput(propagate)
    end
end

local function GetKeyboardFocus()
    if GetCurrentKeyBoardFocus then
        return GetCurrentKeyBoardFocus()
    end
end

local function ResetDialogButton(_, button)
    button:SetScript("OnClick", nil)
    button:SetText("")
    button:ClearAllPoints()
    button:Hide()
end

function MapPinEnhancedDialogMixin:SetTitle(title)
    self.header.title:SetText(title)
end

function MapPinEnhancedDialogMixin:ClearButtons()
    self.buttons = {}
    self.buttonData = {}
    self.acceptButtonIndex = nil
    self.cancelButtonIndex = nil
    if self.buttonPool then
        self.buttonPool:ReleaseAll()
    end
end

---@param index number
function MapPinEnhancedDialogMixin:ExecuteButton(index)
    local buttonInfo = self.buttonData[index]
    if not buttonInfo then return end

    local dialogType = Dialogs.openDialog
    if buttonInfo.callback then
        buttonInfo.callback()
    end

    if buttonInfo.closeDialog ~= false then
        Dialogs:HideDialog(dialogType)
    end
end

function MapPinEnhancedDialogMixin:ExecuteAcceptButton()
    if not self.acceptButtonIndex then return false end

    self:ExecuteButton(self.acceptButtonIndex)
    return true
end

function MapPinEnhancedDialogMixin:ExecuteCancelButton()
    if not self.cancelButtonIndex then return false end

    self:ExecuteButton(self.cancelButtonIndex)
    return true
end

---@param buttonData DialogButtonInfo[]?
function MapPinEnhancedDialogMixin:SetupButtons(buttonData)
    self:ClearButtons()
    if not buttonData or #buttonData == 0 then
        self.buttonContainer:Hide()
        return
    end

    self.buttonContainer:Show()
    self.buttonContainer:SetSize(#buttonData * BUTTON_WIDTH + (#buttonData - 1) * BUTTON_SPACING, BUTTON_HEIGHT)

    local totalWidth = self.buttonContainer:GetWidth()
    for index, buttonInfo in ipairs(buttonData) do
        local button = self.buttonPool:Acquire()
        ---@cast button MapPinEnhancedButtonTemplate
        button:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)
        button:SetLabel(buttonInfo.label)
        button:SetScript("OnClick", function()
            self:ExecuteButton(index)
        end)
        button:ClearAllPoints()
        button:SetPoint("CENTER", self.buttonContainer, "CENTER",
            -totalWidth / 2 + BUTTON_WIDTH / 2 + (index - 1) * (BUTTON_WIDTH + BUTTON_SPACING), 0)
        button:Show()

        self.buttons[index] = button
        self.buttonData[index] = buttonInfo

        if buttonInfo.accept then
            self.acceptButtonIndex = index
        end
        if buttonInfo.cancel then
            self.cancelButtonIndex = index
        end
    end
end

---@param content DialogContentFrame
---@param title string
---@param buttonData DialogButtonInfo[]?
function MapPinEnhancedDialogMixin:ShowDialog(content, title, buttonData)
    if self.content and self.content ~= content then
        self.content:Hide()
        self.content:SetParent(nil)
    end

    self:SetTitle(title)
    self:SetupButtons(buttonData)
    self.content = content
    self.content:SetParent(self)
    self.content:ClearAllPoints()
    self.content:SetPoint("TOP", self, "TOP", 0, CONTENT_TOP_OFFSET)
    self.content:SetFrameStrata(self:GetFrameStrata())
    self.content:SetFrameLevel(self:GetFrameLevel() + 10)
    self.content:Show()

    self.buttonContainer:ClearAllPoints()
    self.buttonContainer:SetPoint("TOP", self.content, "BOTTOM", 0, -BUTTON_TOP_PADDING)
    self.buttonContainer:SetFrameStrata(self:GetFrameStrata())
    self.buttonContainer:SetFrameLevel(self:GetFrameLevel() + 10)

    local contentWidth, contentHeight = self.content:GetSize()
    local buttonContainerWidth = self.buttonContainer:IsShown() and self.buttonContainer:GetWidth() or 0
    local buttonHeight = self.buttonContainer:IsShown() and BUTTON_HEIGHT + BUTTON_TOP_PADDING or 0
    local dialogWidth = math.max(contentWidth, buttonContainerWidth) + CONTENT_SIDE_PADDING
    local dialogHeight = math.abs(CONTENT_TOP_OFFSET) + contentHeight + buttonHeight + CONTENT_BOTTOM_PADDING
    self:SetSize(dialogWidth, dialogHeight)
    self.background.backgroundMask:SetSize(dialogWidth - 10, dialogHeight - 10)
    self:Show()
end

function MapPinEnhancedDialogMixin:OnLoad()
    self.buttons = {}
    self.buttonData = {}
    self.buttonPool = CreateFramePool("Button", self.buttonContainer, "MapPinEnhancedButtonTemplate",
        ResetDialogButton)
    self:EnableKeyboard(true)
    MapPinEnhanced:RegisterDraggableFrame(self, "MapPinEnhancedDialog", self.header, function()
        return false
    end)
    Dialogs.dialogFrame = self

    _G["MapPinEnhancedDialog"] = self
    table.insert(UISpecialFrames, "MapPinEnhancedDialog")
end

function MapPinEnhancedDialogMixin:OnShow()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
end

function MapPinEnhancedDialogMixin:OnHide()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)
    Dialogs.openDialog = nil
    if self.content then
        self.content:Hide()
    end
    self:ClearButtons()
end

function MapPinEnhancedDialogMixin:OnKeyDown(key)
    SetKeyboardPropagation(self, true)

    local keyboardFocus = GetKeyboardFocus()
    if keyboardFocus and keyboardFocus ~= self then
        if key == "ESCAPE" then
            if not self:ExecuteCancelButton() then
                Dialogs:HideDialog(Dialogs.openDialog)
            end
            SetKeyboardPropagation(self, false)
            return
        end

        return
    end

    if key == "ENTER" or key == "NUMPADENTER" then
        if self:ExecuteAcceptButton() then
            SetKeyboardPropagation(self, false)
        end
        return
    end

    if key == "ESCAPE" then
        if self:ExecuteCancelButton() then
            SetKeyboardPropagation(self, false)
            return
        end

        Dialogs:HideDialog(Dialogs.openDialog)
        SetKeyboardPropagation(self, false)
    end
end
