local core = LibStub("AceAddon-3.0"):GetAddon("MapPinEnhanced")
local module = core:NewModule("Importbox")


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

StaticPopupDialogs["MPH_EDIT_PRESETNAME"] = {
    text = "Changing name of this preset",
    button1 = "Accept",
    button2 = "Cancel",
    EditBoxOnTextChanged = function(self)
        local text = self:GetText()
        if text ~= nil and text ~= "" then
            self:GetParent().button1:Enable()
        else
            self:GetParent().button1:Disable()
        end
    end,
    hasEditBox = true,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}


StaticPopupDialogs["MPH_CONFIRM_DELETE"] = {
    text = "Do you really want to delete the preset '%s' ?",
    showAlert = true,
    button1 = "Accept",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}


StaticPopupDialogs["MPH_CONFIRM_RELOAD"] = {
    text = "Changing this setting requires that you reload the Interface",
    button1 = "Reload",
    button2 = "Cancel",
    OnAccept = function()
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}




local presetEntryPool = CreateFramePool("Button", nil, "MPHPresetTemplate")

local function updatePresetsList()
    local previousFrame = nil
    presetEntryPool:ReleaseAll()
    for k, v in pairs(core.db.profile.presets) do
        local presetButton = presetEntryPool:Acquire()
        if previousFrame then
            presetButton:SetPoint("TOPLEFT", previousFrame, "BOTTOMLEFT", 0, 12)
        else
            presetButton:SetPoint("TOPLEFT", module.importFrame.presetsFrame.scrollFrame.scrollChild, "TOPLEFT", 0, 0)
        end
        previousFrame = presetButton
        presetButton:SetParent(module.importFrame.presetsFrame.scrollFrame.scrollChild)
        presetButton.title:SetText(v.name)
        presetButton:SetFrameLevel(k + 1)
        presetButton:SetScript("OnClick", function(self)
            module.importFrame.editBoxFrame.scrollFrame.editBox:SetText(v.input)
        end)
        presetButton:SetScript("OnDoubleClick", function(self)
            StaticPopupDialogs["MPH_EDIT_PRESETNAME"].OnAccept = function(self)
                local newName = self.editBox:GetText()
                if newName == "" then
                    core:Print(L["Name can't be empty"])
                    return
                end
                core.db.profile.presets[k].name = newName
                presetButton.title:SetText(newName)
            end
            StaticPopup_Show("MPH_EDIT_PRESETNAME")
        end)
        presetButton.delete:SetScript("OnClick", function(self)
            StaticPopupDialogs["MPH_CONFIRM_DELETE"].OnAccept = function(self)
                core.db.profile.presets[k] = nil
                if k == 1 then
                    previousFrame = nil
                end
                updatePresetsList()
            end

            StaticPopup_Show("MPH_CONFIRM_DELETE", v.name)
        end)
        presetButton.delete:SetScript("OnEnter", function()
            presetButton:SetHighlightLocked(true)
        end)
        presetButton.delete:SetScript("OnLeave", function()
            presetButton:SetHighlightLocked(false)
        end)
        presetButton:Show()
    end
end

local function CreateWindow()
    if module.importFrame then return end
    local textStore

    local importFrame = CreateFrame("Frame", nil, UIParent, "MPHImportFrameTemplate")
    importFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

    importFrame.export:SetScript("OnClick", function()
        local output = core.ParseExport()
        if output then
            importFrame.editBoxFrame.scrollFrame.editBox:SetText(output)
        end
    end)

    importFrame.save:SetScript("OnClick", function()
        local input = importFrame.editBoxFrame.scrollFrame.editBox:GetText()
        table.insert(core.db.profile.presets, {
            name = tostring(#core.db.profile.presets + 1),
            input = input
        })
        updatePresetsList()
    end)

    importFrame.import:SetScript("OnClick", function()
        local input = importFrame.editBoxFrame.scrollFrame.editBox:GetText()
        ParseImport(input)
        core:ToggleImportWindow()
    end)
    module.importFrame = importFrame
    updatePresetsList()
end

function core:ToggleImportWindow()
    if not module.importFrame then CreateWindow() end
    if module.importFrame:IsShown() then
        module.importFrame:Hide()
    else
        module.importFrame:Show()
    end
end
