local core = LibStub("AceAddon-3.0"):GetAddon("MapPinEnhanced")
local module = core:NewModule("Importbox")

local AceGUI = LibStub("AceGUI-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("MapPinEnhanced")

local function ParseImport(importstring)
    if not importstring then return end
    local msg
    for s in importstring:gmatch("[^\r\n]+") do
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

local function CreateWindow()
    if module.gui then return end

    local saved = core.db.profile.saved
    local textStore
    local name
    local selectedload

    local f = AceGUI:Create("Frame")
    f:Hide()
    module.gui = f
    f:SetLayout("flow")
    f:SetWidth(600)
    f:SetAutoAdjustHeight(true)
    f:SetTitle("Waypoint Import")
    f:EnableResize(false)

    local group1 = AceGUI:Create("SimpleGroup")
    group1:SetLayout("flow")
    group1:SetFullWidth(true)
    group1:SetAutoAdjustHeight(true)
    f:AddChild(group1)

    local button = AceGUI:Create("Button")
    button:SetRelativeWidth(1)
    button:SetText("Import")
    button:SetCallback("OnClick", function()
        ParseImport(textStore)
        core:ToggleImportWindow()
    end)
    group1:AddChild(button)

    local group2 = AceGUI:Create("SimpleGroup")
    group2:SetFullWidth(true)
    group2:SetFullHeight(true)
    group2:SetLayout("fill")
    f:AddChild(group2)

    local edit = AceGUI:Create("MultiLineEditBox")
    group2:AddChild(edit)
    edit.label:SetText("")
    edit:SetText("")
    edit.button:Hide()
    edit:SetFullHeight(true)
    edit:SetFullWidth(true)
    edit:SetCallback("OnTextChanged", function(widget, event, text)
        textStore = text
    end)
    module.edit = edit

    _G["MapPinEnhanced_ImportFrame"] = f.frame
    table.insert(UISpecialFrames, "MapPinEnhanced_ImportFrame")
end


function core:ToggleImportWindow()
    if not module.gui then CreateWindow() end
    if module.gui:IsShown() then
        module.gui:Hide()
    else
        module.edit:SetText("")
        module.gui:Show()
    end
end
