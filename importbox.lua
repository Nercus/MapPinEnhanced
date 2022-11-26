local core = LibStub("AceAddon-3.0"):GetAddon("MapPinEnhanced")
local module = core:NewModule("Importbox")





StaticPopupDialogs["MPH_EDIT_PRESETNAME"] = {
    text = "Please enter a name for the preset",
    subText = "Name already exists!",
    button1 = "Accept",
    button2 = "Cancel",
    EditBoxOnTextChanged = function(self)
        local text = self:GetText()
        if text ~= nil and text ~= "" then
            self:GetParent().button1:Enable()
        else
            self:GetParent().button1:Disable()
        end
        -- check if name already exists
        for _, v in pairs(core.db.global.presets) do
            if v.name == text then
                ViragDevTool:AddData(self:GetParent())
                self:GetParent().SubText:Show()
                self:GetParent().button1:Disable()
                break
            else
                self:GetParent().SubText:Hide()
                self:GetParent().button1:Enable()
            end
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






local presetEntryPool = CreateFramePool("Button", nil, "MPHPresetTemplate")

function module:updatePresetsList()
    local previousFrame = nil
    presetEntryPool:ReleaseAll()
    for k, v in pairs(core.db.global.presets) do
        local presetButton = presetEntryPool:Acquire()
        if previousFrame then
            presetButton:SetPoint("TOPLEFT", previousFrame, "BOTTOMLEFT", 0, -3)
        else
            presetButton:SetPoint("TOPLEFT", module.importFrame.presetsFrame.scrollFrame.scrollChild, "TOPLEFT", 0, 0)
        end
        previousFrame = presetButton
        presetButton:SetParent(module.importFrame.presetsFrame.scrollFrame.scrollChild)
        presetButton.title:SetText(v.name)
        presetButton:SetFrameLevel(k + 1)
        presetButton:SetScript("OnClick", function(self)
            module.importFrame.editBoxFrame.scrollFrame.editBox:SetText(v.input)
            core:ParseImport(v.input)
        end)

        presetButton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip_SetTitle(GameTooltip, v.name)
            -- limit input to 8 lines and show ... if there is more
            local input = v.input
            local lines = { strsplit("\n", input) }
            if #lines > 8 then
                input = ""
                for i = 1, 8 do
                    input = input .. lines[i] .. "\n"
                end
                input = input .. "..."
            end
            GameTooltip_AddNormalLine(GameTooltip, input, true)
            GameTooltip:Show()
        end)

        presetButton:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        presetButton.edit:SetScript("OnClick", function(self)
            StaticPopupDialogs["MPH_EDIT_PRESETNAME"].OnAccept = function(self)
                local newName = self.editBox:GetText()
                core.db.global.presets[k].name = newName
                module:updatePresetsList()
            end
            StaticPopup_Show("MPH_EDIT_PRESETNAME")
        end)
        presetButton.delete:SetScript("OnClick", function(self)
            StaticPopupDialogs["MPH_CONFIRM_DELETE"].OnAccept = function(self)
                core.db.global.presets[k] = nil
                if k == 1 then
                    previousFrame = nil
                end
                module:updatePresetsList()
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
        StaticPopupDialogs["MPH_EDIT_PRESETNAME"].OnAccept = function(self)
            local newName = self.editBox:GetText()
            if newName == "" then
                core:PrintMSG("Name can't be empty")
                return
            end
            table.insert(core.db.global.presets, {
                name = newName,
                input = input
            })
            module:updatePresetsList()
        end
        StaticPopup_Show("MPH_EDIT_PRESETNAME")
    end)

    importFrame.import:SetScript("OnClick", function()
        local input = importFrame.editBoxFrame.scrollFrame.editBox:GetText()
        core:ParseImport(input)
        core:ToggleImportWindow()
    end)

    importFrame.editBoxFrame.scrollFrame.editBox:SetScript("OnTextChanged", function(self)
        if self:GetText() == "" then
            importFrame.import:Disable()
            importFrame.save:Disable()
            importFrame.import.text:SetFontObject("GameFontDisable")
            importFrame.save.text:SetFontObject("GameFontDisable")
        else
            importFrame.import:Enable()
            importFrame.save:Enable()
            importFrame.import.text:SetFontObject("GameFontNormal")
            importFrame.save.text:SetFontObject("GameFontNormal")
        end
    end)

    importFrame.import:Disable()
    importFrame.save:Disable()
    importFrame.import.text:SetFontObject("GameFontDisable")
    importFrame.save.text:SetFontObject("GameFontDisable")

    if core.pinManager.GetNumPins() == 0 then
        importFrame.export:Disable()
        importFrame.export.text:SetFontObject("GameFontDisable")
    end



    module.importFrame = importFrame
    module:updatePresetsList()
end

function core:ToggleImportWindow()
    if not module.importFrame then CreateWindow() end
    if module.importFrame:IsShown() then
        module.importFrame:Hide()
        module.checkPinsRepeat:Cancel()
    else
        module.importFrame:Show()
        module.checkPinsRepeat = C_Timer.NewTicker(1, function()
            if core.pinManager.GetNumPins() == 0 then
                module.importFrame.export:Disable()
                module.importFrame.export.text:SetFontObject("GameFontDisable")
            else
                module.importFrame.export:Enable()
                module.importFrame.export.text:SetFontObject("GameFontNormal")
            end
        end)
    end
end
