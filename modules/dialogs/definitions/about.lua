---@diagnostic disable: undefined-global
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

local L = MapPinEnhanced.L
local definition = Dialogs.DIALOG_DEFINITIONS.ABOUT

Dialogs:RegisterStaticDialogDefinition(definition, {
    text = "",
    button1 = L["Close"],
    OnHide = function()
        Dialogs:MarkStaticDialogClosed(definition)
    end,
})

---@return string
local function BuildAboutText()
    return table.concat({
        MapPinEnhanced.displayName,
        "by Nerc",
        "",
        string.format(L["Version: %s (%s)"], MapPinEnhanced.version, MapPinEnhanced.numericVersion),
        string.format(L["Build: %s"], GetBuildInfo()),
        "",
        L
            ["Thanks to Eminos for the countless hours creating textures, rubber-ducking and thinking about ideas with me. Thanks to all who helped me test new versions, gave feedback and reported bugs! <3"],
    }, "\n")
end

---@return MapPinEnhancedStaticDialogFrame?
function Dialogs:ShowAboutDialog()
    return self:ShowDialog(definition)
end

Dialogs:RegisterDialogHandler(definition, function(dialogs)
    return dialogs:ShowStaticDialog(definition, BuildAboutText(), nil)
end)

MapPinEnhanced:AddSlashCommand({ "version", "about" },
    function() Dialogs:ShowAboutDialog() end,
    L["Open the about dialog to view version information."])
