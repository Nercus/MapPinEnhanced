---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

local L = MapPinEnhanced.L

---@return MapPinEnhancedInfoDialogContentTemplate
function Dialogs:GetInfoContent()
    if not self.infoDialog then
        self.infoDialog = CreateFrame("Frame", "MapPinEnhancedInfoDialogContent", UIParent,
            "MapPinEnhancedInfoDialogContentTemplate")
    end
    return self.infoDialog
end

---@class MapPinEnhancedInfoDialogContentTemplate : Frame
---@field messageText FontString
---@field okayButton MapPinEnhancedButtonTemplate
---@field onClose function? callback for when the dialog is closed, can be set via Setup()
MapPinEnhancedInfoDialogContentMixin = {}

---@class InfoDialogOptions
---@field title string?
---@field message string
---@field onClose function?
---@field closeText string?

---@param options InfoDialogOptions
function MapPinEnhancedInfoDialogContentMixin:Setup(options)
    self.messageText:SetText(options.message or "")
    self.okayButton:SetText(options.closeText or L["Close"])
    self.onClose = options.onClose

    self.okayButton:SetScript("OnClick", function()
        Dialogs:HideDialog(Dialogs.DIALOG_TYPES.INFO)
    end)
end

function MapPinEnhancedInfoDialogContentMixin:OnClose()
    if self.onClose then
        self.onClose()
    end
    self.onClose = nil
end
