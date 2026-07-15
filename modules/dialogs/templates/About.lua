---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

local L = MapPinEnhanced.L

---@return MapPinEnhancedAboutDialogContentTemplate
function Dialogs:GetAboutContent()
    if not self.aboutDialog then
        self.aboutDialog = CreateFrame("Frame", "MapPinEnhancedAboutDialogContent", UIParent,
            "MapPinEnhancedAboutDialogContentTemplate")
    end
    return self.aboutDialog
end

---@class MapPinEnhancedAboutDialogContentTemplate : Frame
---@field title FontString
---@field version FontString
---@field build FontString
---@field thanks FontString
MapPinEnhancedAboutDialogContentMixin = {}


function MapPinEnhancedAboutDialogContentMixin:OnLoad()
    self.version:SetText(string.format(L["Version: %s (%s)"], MapPinEnhanced.version, MapPinEnhanced.numericVersion))
    self.build:SetText(string.format(L["Build: %s"], GetBuildInfo()))
    self.thanks:SetText(L
        ["Thanks to Eminos for the countless hours creating textures, rubber-ducking and thinking about ideas with me. Thanks to all who helped me test new versions, gave feedback and reported bugs! <3"])
end

Dialogs.dialogTypeConfig[Dialogs.DIALOG_TYPES.ABOUT] = {
    title = "by Nerc",
    getContent = function(dialogs)
        return dialogs:GetAboutContent()
    end,
    buttons = function()
        return {
            {
                label = L["Close"],
                accept = true,
                cancel = true,
            },
        }
    end,
}
