local core = LibStub("AceAddon-3.0"):GetAddon("MapPinEnhanced")
local module = core:NewModule("Importbox")

local AceGUI = LibStub("AceGUI-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("MapPinEnhanced")

local function ParseImport(importstring)
    if not importstring then return end
    local msg
    for s in importstring:gmatch("[^\r\n]+") do -- TODO: Make better
        if string.match(s, "/way ") then
            msg = string.gsub(s, "/way ", "")
        elseif string.match(s, "/mph ") then
            msg = string.gsub(s, "/mph ", "")
        elseif string.match(s, "/pin ") then
            msg = string.gsub(s, "/pin ", "")
        else
            core:Print(L["Formating error"])
        end
        core:ParseInput(msg)
    end
end

function core:ToggleImportWindow()
    if not module.gui then CreateWindow() end
    if module.gui:IsShown() then
        module.gui:Hide()
    else
        module.gui:Show()
    end
end

function CreateWindow()
    if module.gui then return end

    local textStore

    local f = AceGUI:Create("Frame")
    f:Hide()
    module.gui = f
    f:SetLayout("flow")
    f:SetWidth(600)
    f:SetAutoAdjustHeight(true)
    f:SetTitle("Waypoint Import")

    local button = AceGUI:Create("Button")
    button:SetText("Import")
    button:SetFullWidth(true)
    button:SetCallback("OnClick", function()
        ParseImport(textStore)
        core:ToggleImportWindow()
    end)
    f:AddChild(button)

    local edit = AceGUI:Create("MultiLineEditBox")
    f:AddChild(edit)
    edit.label:SetText("")
    edit:SetText("")
    edit.button:Hide()
    edit:SetFullHeight(true)
    edit:SetFullWidth(true)
    edit:SetCallback("OnTextChanged",
                     function(widget, event, text) textStore = text end)
    module.edit = edit

    _G["MapPinEnhanced_ImportFrame"] = f.frame
    table.insert(UISpecialFrames, "MapPinEnhanced_ImportFrame")
end
