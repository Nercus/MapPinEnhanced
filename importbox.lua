local core = LibStub("AceAddon-3.0"):GetAddon("MapPinEnhanced")
local module = core:NewModule("Importbox")

local AceGUI = LibStub("AceGUI-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("MapPinEnhanced")

local xpcall = xpcall


local function safecall(func, ...)
    if func then
        return xpcall(func, errorhandler, ...)
    end
end

AceGUI:RegisterLayout("customlayout",
    function(content, children)
        if children[1] and children[2] and children[3] and children[4] then
            -- Editbox
            children[1]:SetWidth(content:GetWidth() or 0)
            children[1]:SetHeight(content:GetHeight() or 0)
            children[1].frame:ClearAllPoints()
            children[1].frame:SetAllPoints(content)
            children[1].frame:Show()

            -- Import button
            children[2]:SetWidth(85)
            children[2]:SetHeight(25)
            children[2].frame:ClearAllPoints()
            children[2].frame:SetPoint("BOTTOMLEFT", content, "TOPRIGHT", -90, -12)
            children[2].frame:Show()


            -- Checkbox
            children[3].frame:ClearAllPoints()
            children[3].frame:SetPoint("LEFT", content.obj.statustext:GetParent(), "LEFT", 5, 0)
            children[3].frame:Show()

            children[4]:SetWidth(85)
            children[4]:SetHeight(25)
            children[4].frame:ClearAllPoints()
            children[4].frame:SetPoint("BOTTOMRIGHT", content, "TOPLEFT", 90, -12)
            children[4].frame:Show()


            safecall(content.obj.LayoutFinished, content.obj, nil, content:GetHeight())
        end
    end
)



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

-- Reload Popup
StaticPopupDialogs["MPH_RELOAD_POPUP"] = {
    text = "Changing this setting requires that you reload the Interface",
    button1 = "Reload",
    button2 = "Cancel",
    OnAccept = function()
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3, -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}



local function CreateWindow()
    if module.gui then return end

    local textStore
    local db = core.db.profile


    local f = AceGUI:Create("Frame")
    f:Hide()
    module.gui = f
    f:SetLayout("customlayout")
    f:SetWidth(400)
    f:SetAutoAdjustHeight(true)
    f:SetTitle("Waypoint Import")
    f:EnableResize(false)

    local edit = AceGUI:Create("MultiLineEditBox")
    f:AddChild(edit)
    edit.label:SetText("")
    edit:SetText("")
    edit:DisableButton(true)
    edit:SetFullWidth(true)
    edit:SetCallback("OnTextChanged", function(widget, event, text)
        textStore = text
    end)
    module.edit = edit

    local importbutton = AceGUI:Create("Button")
    importbutton:SetRelativeWidth(0.3)
    importbutton:SetText("Import")
    importbutton:SetCallback("OnClick", function()
        ParseImport(textStore)
        core:ToggleImportWindow()
    end)
    f:AddChild(importbutton)

    local checkbox = AceGUI:Create("CheckBox")
    checkbox:SetValue(true)
    checkbox:SetLabel("Change Arrow Alpha")
    checkbox:SetValue(db.options["changedalpha"])
    checkbox:SetCallback("OnValueChanged", function(widget, event, value)
        if value == true then
            db.options["changedalpha"] = true
        elseif value == false then
            db.options["changedalpha"] = false
        end
        StaticPopup_Show("MPH_RELOAD_POPUP");
    end)
    f:AddChild(checkbox)

    local exportbutton = AceGUI:Create("Button")
    exportbutton:SetRelativeWidth(0.3)
    exportbutton:SetText("Export")
    exportbutton:SetCallback("OnClick", function()
        edit:SetText(core:ParseExport())
    end)
    f:AddChild(exportbutton)


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
