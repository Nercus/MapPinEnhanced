---@class NercLibPrivate : NercLib
local NercLib = _G.NercLib

---@type function
local ReloadUI = C_UI.Reload

---@param addon NercLibAddon
function NercLib:AddDebugModule(addon)
    ---@class Debug
    local Debug = addon:GetModule("Debug")

    local Events = addon:GetModule("Events")
    local Text = addon:GetModule("Text")
    local SlashCommand = addon:GetModule("SlashCommand")
    local SavedVars = addon:GetModule("SavedVars")
    local Tests = addon:GetModule("Tests")


    local playerLoginFired = false
    local preFiredQueue = {}

    ---add debug message to DevTool
    ---@param ... table | string | number | boolean | nil
    function Debug:Debug(...)
        --@do-not-package@
        local args = ...
        if (playerLoginFired == false) then
            table.insert(preFiredQueue, { args })
            return
        end
        if (C_AddOns.IsAddOnLoaded("DevTool") == false) then
            C_Timer.After(1, function()
                Debug:Debug(args)
            end)
            return
        end
        local DevToolFrame = _G["DevToolFrame"] ---@type Frame
        local DevTool = _G["DevTool"] ---@type any // don't want to type all of DevTool
        DevTool:AddData(args)
        if not DevToolFrame then
            return
        end
        if not DevToolFrame:IsShown() then
            DevTool:ToggleUI()
            C_Timer.After(1, function()
                Debug:Debug(args)
            end)
            return
        end
        --@end-do-not-package@
    end

    --@do-not-package@
    Events:RegisterEvent("PLAYER_LOGIN", function()
        playerLoginFired = true
        C_Timer.After(1, function()
            for i = 1, #preFiredQueue do
                Debug:Debug(unpack(preFiredQueue[i]))
            end
        end)
    end)
    --@do-not-package@
    local devAddonList = {
        "!BugGrabber",
        "BugSack",
        "TextureAtlasViewer",
        "DevTool",
        "ScriptLibrary",
        addon.name
    }


    function Debug:AddAddonToWhitelist(addonName)
        assert(type(addonName) == "string", "Addon name must be a string")
        assert(C_AddOns.GetAddOnInfo(addonName), "Addon must exist")
        table.insert(devAddonList, addonName)
    end

    local function loadDevAddons(isDev)
        if not isDev then
            local loadedAddons = SavedVars:GetVar("loadedAddons") or {}
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
        local Logging = addon:GetModule("Logging")
        local devModeEnabled = SavedVars:GetVar("devMode")
        if (devModeEnabled) then
            SavedVars:SetVar("devMode", false)
            Logging:DisableLogging()
        else
            SavedVars:SetVar("devMode", true)
            Logging:EnableLogging()
        end
        loadDevAddons(not devModeEnabled)
        ReloadUI()
    end
    SlashCommand:AddSlashCommand("dev", setDevMode, "Toggle dev mode")


    ---@enum DevModeKeysToKeep
    local keysToKeep = {
        "devMode",
        "loadedAddons",
        "version",
    }

    ---@diagnostic disable-next-line: no-unknown
    StaticPopupDialogs[addon.name .. "RESETSAVEDVARS_POPUP"] = {
        text = "Are you sure you want to reset all saved variables?",
        button1 = "Yes",
        button2 = "No",
        onAccept = function()
            ---@type table?
            local DB = _G[addon.tableName]
            if not DB then
                DB = {}
                ---@type table
                _G[addon.tableName] = DB
            end
            ---@type table<DevModeKeysToKeep, any>
            local DBToKeep = {}
            for i = 1, #keysToKeep do
                local key = keysToKeep[i] --[[@as DevModeKeysToKeep]]
                DBToKeep[key] = DB[key]
            end
            DB = DBToKeep
            ReloadUI()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }


    local function ResetSavedVars()
        StaticPopup_Show(addon.name .. "RESETSAVEDVARS_POPUP")
    end


    local tickAtlas = "UI-QuestTracker-Tracker-Check"
    local crossAtlas = "UI-QuestTracker-Objective-Fail"
    local pausedAtlas = "CreditsScreen-Assets-Buttons-Pause"
    local debugMenuTemplate = {}


    local function AddDevReload()
        local f = CreateFrame("frame", nil, UIParent, "DefaultPanelTemplate")
        f:SetPoint("BOTTOM", 0, 5)
        f:SetFrameStrata("HIGH")
        f:SetFrameLevel(100)

        local totalWidth = 60
        local text = f:CreateFontString(nil, "OVERLAY")
        text:SetFontObject(GameFontNormal)
        text:SetPoint("TOP", 0, -30)
        text:SetText("Press 1 to reload UI")
        f:SetScript("OnKeyDown", function(_, key)
            if key == "1" then
                ReloadUI()
            end
        end)

        local button1 = CreateFrame("Button", nil, f, "SharedButtonLargeTemplate")
        button1:SetSize(150, 40)
        button1:SetFrameStrata("HIGH")
        button1:SetText("Open Debug Menu")
        button1:SetScript("OnClick", function(self)
            local Menu = addon:GetModule("Menu")
            if #debugMenuTemplate == 0 then return end
            Menu:GenerateMenu(self, debugMenuTemplate)
        end)

        totalWidth = totalWidth + button1:GetWidth() + 10

        local button2 = CreateFrame("Button", nil, f, "SharedButtonLargeTemplate")
        button2:SetSize(150, 40)
        button2:SetFrameStrata("HIGH")
        button2:SetText("Reset Saved Vars")
        button2:SetScript("OnClick", ResetSavedVars)

        totalWidth = totalWidth + button2:GetWidth() + 10

        local button3 = CreateFrame("Button", nil, f, "SharedButtonLargeTemplate")
        button3:SetSize(150, 40)
        button3:SetFrameStrata("HIGH")
        button3:SetText("Debug Addon")
        button3:SetScript("OnClick", function()
            Debug:Debug(addon)
        end)

        totalWidth = totalWidth + button3:GetWidth() + 10

        local button4 = CreateFrame("Button", nil, f, "SharedButtonLargeTemplate")
        button4:SetSize(150, 40)
        button4:SetFrameStrata("HIGH")
        button4:SetText("Exit Dev Mode")
        button4:SetScript("OnClick", setDevMode)

        totalWidth = totalWidth + button4:GetWidth() + 10


        --- SetPoint for the 4 buttons so they are centered horizontally in the frame
        button2:SetPoint("RIGHT", f, "CENTER", -5, 0)
        button1:SetPoint("RIGHT", button2, "LEFT", -5, 0)
        button3:SetPoint("LEFT", f, "CENTER", 5, 0)
        button4:SetPoint("LEFT", button3, "RIGHT", 5, 0)

        local testStatusbar = CreateFrame("StatusBar", nil, f)
        testStatusbar:SetSize(420, 27)
        testStatusbar:SetStatusBarTexture("delves-dashboard-bar-fill")
        testStatusbar:SetStatusBarDesaturated(true)
        testStatusbar:SetStatusBarColor(1, 1, 1)
        testStatusbar:SetPoint("BOTTOM", 0, 10)

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

        ---@type table<string, boolean>
        local states
        local testCount = Tests:GetNumberOfTests()
        SetStatusbarValue(0, testCount, 0)
        runTestsButton:SetScript("OnClick", function()
            local testIndex = 0
            runTestsButton:Disable()
            runTestsButton:DesaturateHierarchy(1)
            Tests:RunTests(function(success)
                if not success then return end
                testIndex = testIndex + 1
                SetStatusbarValue(0, testCount, testIndex)
            end, function(testsStates)
                runTestsButton:Enable()
                runTestsButton:DesaturateHierarchy(0)
                states = testsStates
                local numErrors = 0
                for _, v in pairs(testsStates) do
                    if not v then
                        numErrors = numErrors + 1
                    end
                end
                testStatusbar.text:SetText(string.format("Tests successful: %d / %d", testCount - numErrors, testCount))
            end)
        end)

        local Menu = addon:GetModule("Menu")
        ---@param testsStates table<string, boolean>
        ---@return AnyMenuEntry[]
        local function BuildStatusBarMenu(testsStates)
            if not testsStates then return {} end

            ---@type AnyMenuEntry[]
            local menuTemplate = {}
            local tests = Tests:GetTests()

            for _, test in ipairs(tests) do
                ---@type string
                local testStateIcon
                if testsStates[test.name] == nil then
                    testStateIcon = CreateAtlasMarkup(pausedAtlas, 16, 16)
                elseif testsStates[test.name] == true then
                    testStateIcon = CreateAtlasMarkup(tickAtlas, 16, 16)
                elseif testsStates[test.name] == false then
                    testStateIcon = CreateAtlasMarkup(crossAtlas, 16, 16)
                end
                table.insert(menuTemplate, {
                    type = "button",
                    label = string.format("%s %s", test.name, testStateIcon),
                    onClick = function()
                        test:Run()
                    end
                })
            end
            return menuTemplate
        end

        testStatusbar:SetScript("OnEnter", function(self)
            if not states then return end
            Menu:GenerateMenu(self, BuildStatusBarMenu(states),
                { gridModeColumns = math.ceil(Tests:GetNumberOfTests() / 25) })
        end)

        f:SetPropagateKeyboardInput(true)
        f:SetSize(totalWidth, 130)
        f:Show()
    end

    local function loadDevMode(_, loadedAddon)
        if loadedAddon ~= addon.name then
            return
        end
        local Logging = addon:GetModule("Logging")

        local devModeEnabled = SavedVars:GetVar("devMode")
        local LDBIcon = LibStub("LibDBIcon-1.0", true)
        if (devModeEnabled) then
            Text:Print("Dev mode enabled")
            AddDevReload()
            C_Timer.After(1, function()
                LDBIcon:Show("BugSack")
                LDBIcon:Show(addon.name)
                Logging:ToggleLoggingWindow()
            end)
        else
            -- check what addons are loaded right now and save them
            local loadedAddons = {}
            for i = 1, C_AddOns.GetNumAddOns() do
                local name, _, _, _, reason = C_AddOns.GetAddOnInfo(i)
                if reason ~= "DISABLED" then
                    table.insert(loadedAddons, name)
                end
            end
            SavedVars:SetVar("loadedAddons", loadedAddons)
            C_Timer.After(1, function()
                LDBIcon:Hide("BugSack")
                LDBIcon:Hide(addon.name)
            end)
        end
    end



    ---@param menuTemplate AnyMenuEntry
    function Debug:AddDebugCustomDebugAction(menuTemplate)
        assert(type(menuTemplate) == "table", "Menu template not provided or not a table")
        table.insert(debugMenuTemplate, menuTemplate)
    end

    Events:RegisterEvent("ADDON_LOADED", loadDevMode)
    --@end-do-not-package@
end
