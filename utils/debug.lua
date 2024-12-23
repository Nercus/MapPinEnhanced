---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

--@do-not-package@
---@type function
local ReloadUI = C_UI.Reload



local playerLoginFired = false
local preFiredQueue = {}
--@end-do-not-package@

---add debug message to DevTool
---@param ... table | string | number | boolean | nil
function MapPinEnhanced:Debug(...)
    --@do-not-package@
    local args = ...
    if (playerLoginFired == false) then
        table.insert(preFiredQueue, { args })
        return
    end
    if (C_AddOns.IsAddOnLoaded("DevTool") == false) then
        C_Timer.After(1, function()
            MapPinEnhanced:Debug(args)
        end)
        return
    end
    local DevToolFrame = _G["DevToolFrame"] ---@type Frame
    local DevTool = _G["DevTool"] ---@type any // dont want to type all of DevTool
    DevTool:AddData(args)
    if not DevToolFrame then
        return
    end
    if not DevToolFrame:IsShown() then
        DevTool:ToggleUI()
        C_Timer.After(1, function()
            MapPinEnhanced:Debug(args)
        end)
        return
    end
    --@end-do-not-package@
end

--@do-not-package@
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    playerLoginFired = true
    C_Timer.After(1, function()
        for i = 1, #preFiredQueue do
            MapPinEnhanced:Debug(unpack(preFiredQueue[i]))
        end
    end)
end)



local function AddTestPins()
    ---@class PinManager
    local PinManager = MapPinEnhanced:GetModule("PinManager")
    PinManager:AddPin({
        mapID = C_Map.GetBestMapForUnit("player") or 37, -- Elwynn Forest
        x = math.random(),
        y = math.random(),
        setTracked = true,
        title = "Test Pin",
    })
end

local devAddonList = {
    "!BugGrabber",
    "BugSack",
    "TextureAtlasViewer",
    "DevTool",
    "MapPinEnhanced",
    "Wowlua"
}



local function loadDevAddons(isDev)
    if not isDev then
        C_AddOns.DisableAddOn(MapPinEnhanced.addonName)
        local loadedAddons = MapPinEnhanced:GetVar("loadedAddons") or {}
        if #loadedAddons == 0 then
            C_AddOns.EnableAllAddOns()
            return
        end
        for i = 1, #loadedAddons do
            local name = loadedAddons[i] ---@type string
            C_AddOns.EnableAddOn(name)
        end
    else
        C_AddOns.DisableAllAddOns()
        for i = 1, #devAddonList do
            local name = devAddonList[i]
            C_AddOns.EnableAddOn(name)
        end
    end
end


local function setDevMode()
    local devModeEnabled = MapPinEnhanced:GetVar("devMode")
    if (devModeEnabled) then
        MapPinEnhanced:SaveVar("devMode", false)
    else
        MapPinEnhanced:SaveVar("devMode", true)
    end
    loadDevAddons(not devModeEnabled)
    ReloadUI()
end
MapPinEnhanced:AddSlashCommand("dev", setDevMode, "Toggle dev mode")



local keysToKeep = {
    ["devMode"] = true,
    ["loadedAddons"] = true,
    ["version"] = true,
}

StaticPopupDialogs["MAP_PIN_ENHANCED_RESET_SAVED_VARS"] = {
    text = "Are you sure you want to reset all saved variables?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
        for key, _ in pairs(MapPinEnhancedDB) do
            if not keysToKeep[key] then
                MapPinEnhancedDB[key] = nil
            end
        end
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

local function ResetSavedVars()
    -- use a static popup to confirm
    StaticPopup_Show("MAP_PIN_ENHANCED_RESET_SAVED_VARS")
end


local function AddDevReload()
    local f = CreateFrame("frame", nil, UIParent, "MapPinEnhancedBaseFrameTemplate")
    f:SetPoint("BOTTOM", 0, 10)
    f:SetFrameStrata("HIGH")
    f:SetFrameLevel(100)

    local totalWidth = 60
    local text = f:CreateFontString(nil, "OVERLAY")
    text:SetFontObject(GameFontNormalLarge)
    text:SetPoint("TOP", 0, -20)
    text:SetText("Press 1 to reload UI")
    f:SetScript("OnKeyDown", function(_, key)
        if key == "1" then
            ReloadUI()
        end
    end)

    local button1 = CreateFrame("Button", nil, f, "MapPinEnhancedButtonYellowTemplate")
    button1:SetPoint("LEFT", 30, 0)
    button1:SetSize(130, 40)
    button1:SetFrameStrata("HIGH")
    button1:SetText("Add Test Pins")
    button1:SetScript("OnClick", AddTestPins)

    totalWidth = totalWidth + button1:GetWidth() + 10

    local button2 = CreateFrame("Button", nil, f, "MapPinEnhancedButtonYellowTemplate")
    button2:SetPoint("LEFT", button1, "RIGHT", 10, 0)
    button2:SetSize(130, 40)
    button2:SetFrameStrata("HIGH")
    button2:SetText("Reset Saved Vars")
    button2:SetScript("OnClick", ResetSavedVars)

    totalWidth = totalWidth + button2:GetWidth() + 10

    local button3 = CreateFrame("Button", nil, f, "MapPinEnhancedButtonYellowTemplate")
    button3:SetPoint("LEFT", button2, "RIGHT", 10, 0)
    button3:SetSize(130, 40)
    button3:SetFrameStrata("HIGH")
    button3:SetText("Debug MPH")
    button3:SetScript("OnClick", function()
        MapPinEnhanced:Debug(MapPinEnhanced)
    end)

    totalWidth = totalWidth + button3:GetWidth() + 10

    local button4 = CreateFrame("Button", nil, f, "MapPinEnhancedButtonRedTemplate")
    button4:SetPoint("LEFT", button3, "RIGHT", 10, 0)
    button4:SetSize(130, 40)
    button4:SetFrameStrata("HIGH")
    button4:SetText("Exit Dev Mode")
    button4:SetScript("OnClick", setDevMode)

    totalWidth = totalWidth + button4:GetWidth() + 10

    local testStatusbar = CreateFrame("StatusBar", nil, f)
    testStatusbar:SetSize(420, 27)
    testStatusbar:SetStatusBarTexture("delves-dashboard-bar-fill")
    testStatusbar:SetStatusBarDesaturated(true)
    testStatusbar:SetStatusBarColor(1, 1, 1)
    testStatusbar:SetPoint("BOTTOM", 0, 13)


    testStatusbar.border = testStatusbar:CreateTexture(nil, "BACKGROUND")
    testStatusbar.border:SetAtlas("delves-dashboard-bar-border")
    testStatusbar.border:SetPoint("TOPLEFT", 1, 0)
    testStatusbar.border:SetPoint("BOTTOMRIGHT", 0, 0)

    testStatusbar.text = testStatusbar:CreateFontString(nil, "OVERLAY")
    testStatusbar.text:SetFontObject(GameFontNormal)
    testStatusbar.text:SetPoint("CENTER", 0, 1)


    local runTestsButton = CreateFrame("Button", nil, f)
    runTestsButton:SetPoint("LEFT", testStatusbar, "RIGHT", 5, 0)
    runTestsButton:SetSize(30, 30)
    runTestsButton:SetFrameStrata("HIGH")
    runTestsButton:SetNormalAtlas("CreditsScreen-Assets-Buttons-Play")

    local function SetStatusbarValue(min, max, current)
        testStatusbar:SetMinMaxValues(min, max)
        testStatusbar:SetValue(current)
        testStatusbar.text:SetText(string.format("Tests completed: %d/%d", current, max))
    end

    local Tests = MapPinEnhanced.Tests
    local tickPath = MapPinEnhanced:GetTexture("IconTick_Yellow")
    local crossPath = MapPinEnhanced:GetTexture("IconCross_Yellow")

    local testCount = Tests:GetNumberOfTests()
    SetStatusbarValue(0, testCount, 0)

    local defaultTextColor = { testStatusbar.text:GetTextColor() }
    runTestsButton:SetScript("OnClick", function()
        local testIndex = 0
        testStatusbar.text:SetTextColor(unpack(defaultTextColor))
        Tests:RunTests(function(success)
            if not success then return end
            testIndex = testIndex + 1
            SetStatusbarValue(0, testCount, testIndex)
        end, function(errorList)
            local numErrors = #errorList
            local allTestsPassed = numErrors == 0
            testStatusbar.errorList = errorList
            if allTestsPassed then
                testStatusbar.text:SetTextColor(0, 1, 0)
            else
                testStatusbar.text:SetTextColor(1, 0, 0)
                return
            end
            testStatusbar.text:SetText(string.format("Tests successful: %d/%d", testCount - numErrors, testCount))
        end)
    end)

    -- NOTE: if we have a lot of tests we might to change the tooltip to a menu element to have a scrollable list/grid
    local function BuildStatusbarTooltip(errorList)
        if not errorList then
            return
        end
        GameTooltip:SetText("Test results:")
        local tests = Tests:GetTests()
        ---@type table<string, boolean>
        local erroredTests = {}
        for i = 1, #errorList do
            ---@type string[]
            local err = errorList[i]
            erroredTests[err[2]] = true
        end


        for _, test in ipairs(tests) do
            local testStateIcon = "|T" .. tickPath .. ":16:16:0:0:16:16:0:16:0:16:255:255: 255|t"
            if erroredTests[test.name] then
                testStateIcon = "|T" .. crossPath .. ":16:16:0:0:16:16:0:16:0:16:255:0:0|t"
            end
            GameTooltip:AddDoubleLine(test.name, testStateIcon, 1, 1, 1, 1, 1, 1)
        end
    end



    testStatusbar:SetScript("OnEnter", function()
        GameTooltip:SetOwner(testStatusbar, "ANCHOR_TOP")
        BuildStatusbarTooltip(testStatusbar.errorList)
        GameTooltip:Show()
    end)

    testStatusbar:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    f:SetPropagateKeyboardInput(true)
    f:SetSize(totalWidth, 130)
    f:Show()
end

local function loadDevMode(_, loadedAddon)
    if loadedAddon ~= MapPinEnhanced.addonName then
        return
    end
    local devModeEnabled = MapPinEnhanced:GetVar("devMode")
    if (devModeEnabled) then
        MapPinEnhanced:Print("Dev mode enabled")
        AddDevReload()
    else
        -- check what addons are loaded right now and save them
        local loadedAddons = {}
        for i = 1, C_AddOns.GetNumAddOns() do
            local name, _, _, _, reason = C_AddOns.GetAddOnInfo(i)
            if reason ~= "DISABLED" then
                table.insert(loadedAddons, name)
            end
        end
        MapPinEnhanced:SaveVar("loadedAddons", loadedAddons)
    end
end

MapPinEnhanced:RegisterEvent("ADDON_LOADED", loadDevMode)

--@end-do-not-package@
