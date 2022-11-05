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

local function CreateWindow()
    if module.importFrame then return end
    local textStore

    local importFrame = CreateFrame("Frame", "MapPinEnhancedImportFrame", UIParent, "MPHImportFrameTemplate")
    importFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)


    for i = 1, 20 do
        local presetButton = CreateFrame("Button", nil, importFrame.presetsFrame.scrollFrame.scrollChild,
            "MPHPresetTemplate")
        presetButton:SetPoint("TOPLEFT", importFrame.presetsFrame.scrollFrame.scrollChild, "TOPLEFT", 0, -((i - 1) * 40))
        presetButton.title:SetText("Preset" .. i)
        presetButton:Show()
    end



    module.importFrame = importFrame

end

function core:ToggleImportWindow()
    if not module.importFrame then CreateWindow() end
    if module.importFrame:IsShown() then
        module.importFrame:Hide()
    else
        module.importFrame:Show()
    end
end

core:ToggleImportWindow()
