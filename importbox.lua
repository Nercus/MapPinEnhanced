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

function core:ToggleImportWindow()
    if not module.gui then CreateWindow() end
    if module.gui:IsShown() then
        module.gui:Hide()
    else
        module.edit:SetText("")
        module.gui:Show()
    end
end

function CreateWindow()
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

    local namebox = AceGUI:Create("EditBox")
    namebox:DisableButton(false)
    namebox:SetRelativeWidth(0.5)
    namebox:SetCallback("OnEnterPressed",
                        function(widget, event, text) name = text namebox:ClearFocus() end)
    group1:AddChild(namebox)

    local saveddropdown = AceGUI:Create("Dropdown")
    saveddropdown:SetRelativeWidth(0.5)
    saveddropdown:SetMultiselect(false)
    saveddropdown:SetCallback("OnValueChanged", function(widget, event, key)
        selectedload = key
    end)
    saveddropdown:SetList(saved)
    group1:AddChild(saveddropdown)

    local savebutton = AceGUI:Create("Button")
    savebutton:SetRelativeWidth(0.5)
    savebutton:SetDisabled(true)
        savebutton:SetText("Save")
    group1:AddChild(savebutton)

    local loadbutton = AceGUI:Create("Button")
    loadbutton:SetRelativeWidth(0.25)
    loadbutton:SetText("Load")
    group1:AddChild(loadbutton)

    local delbutton = AceGUI:Create("Button")
    delbutton:SetRelativeWidth(0.25)
    delbutton:SetText("Delete")
       group1:AddChild(delbutton)

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
        if text then savebutton:SetDisabled(false) end
    end)
    module.edit = edit

    loadbutton:SetCallback("OnClick", function(widget, event)
        if selectedload then
            edit:SetText(saved[selectedload])
        end
    end)


    delbutton:SetCallback("OnClick", function(widget, event)
        saved[selectedload] = nil
        saveddropdown:SetList(saved)
        saveddropdown:SetText("")
        edit:SetText("")
    end)

    savebutton:SetCallback("OnClick", function(widget, event)
        saved[name] = textStore
        saveddropdown:SetList(saved)
        namebox:SetText("")
        edit:SetText("")
    end)

    core.db.profile.saved = saved

    _G["MapPinEnhanced_ImportFrame"] = f.frame
    table.insert(UISpecialFrames, "MapPinEnhanced_ImportFrame")
end
