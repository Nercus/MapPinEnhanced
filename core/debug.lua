---@class MapPinEnhanced
---@field debugMenuTemplate table<AnyMenuEntry[]> a list of menu templates for the debug menu
local MapPinEnhanced = select(2, ...)


local devAddonList = {
    "!!NoWarnings",
    "!BugGrabber",
    "BugSack",
    "TextureAtlasViewer",
    "DevTool",
}
local preFiredQueue = {}
local playerLoginFired = false

---Debug a value to DevTools
---@param ... any The value to debug
function MapPinEnhanced:Debug(...)
    --@do-not-package@
    local args = ...
    if (playerLoginFired == false) then
        table.insert(preFiredQueue, { args })
        return
    end
    if (C_AddOns.IsAddOnLoaded("DevTool") == false) then
        C_Timer.After(1, function()
            self:Debug(args)
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
            self:Debug(args)
        end)
        return
    end
    --@end-do-not-package@
end

---Add an addon to the whitelist of addons to load in dev mode
---@param addonName string The name of the addon to add to the whitelist
function MapPinEnhanced:AddAddonToWhitelist(addonName)
    --@do-not-package@
    assert(type(addonName) == "string", "Addon name must be a string")
    assert(C_AddOns.GetAddOnInfo(addonName), "Addon must exist")
    table.insert(devAddonList, addonName)
    --@end-do-not-package@
end

---Add a custom action to the debug menu should be a AnyMenuEntry
---@param menuTemplate AnyMenuEntry The menu template to add the action to
function MapPinEnhanced:AddDebugCustomDebugAction(menuTemplate)
    assert(type(menuTemplate) == "table", "Menu template not provided or not a table")
    table.insert(self.debugMenuTemplate, menuTemplate)
end

--@do-not-package@
local tickAtlas = "UI-QuestTracker-Tracker-Check"
local crossAtlas = "UI-QuestTracker-Objective-Fail"
local pausedAtlas = "CreditsScreen-Assets-Buttons-Pause"


table.insert(devAddonList, MapPinEnhanced.name)
local function loadDevAddons(isDev)
    if not isDev then
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
        MapPinEnhanced:SetVar("devMode", false)
    else
        MapPinEnhanced:SetVar("devMode", true)
    end
    loadDevAddons(not devModeEnabled)
    C_UI.Reload()
end
MapPinEnhanced:AddSlashCommand("dev", setDevMode, "Toggle dev mode")

---@enum DevModeKeysToKeep
local keysToKeep = {
    "devMode",
    "loadedAddons",
    "version",
}

---@diagnostic disable-next-line: no-unknown
StaticPopupDialogs[MapPinEnhanced.name .. "RESETSAVEDVARS_POPUP"] = {
    text = "Are you sure you want to reset all saved variables?",
    button1 = "Yes",
    button2 = "No",
    onAccept = function()
        ---@type table<string, any>
        local DB = _G["MapPinEnhancedDB"]
        if not DB then
            DB = {}
            _G["MapPinEnhancedDB"] = DB
        end
        local DBToKeep = {}
        for i = 1, #keysToKeep do
            local key = keysToKeep[i] --[[@as DevModeKeysToKeep]]
            ---@type table<string, any>
            DBToKeep[key] = DB[key]
        end
        DB = DBToKeep
        C_UI.Reload()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}



---@class MapPinEnhancedDebugMenuFrameTemplate : DefaultPanelTemplate
---@field title FontString
---@field debugMenuButton Button
---@field resetVarsButton Button
---@field debugAddonButton Button
---@field exitDevButton Button
---@field testStatusbar MapPinEnhancedDebugMenuFrameStatusBar
MapPinEnhancedDebugMenuFrameMixin = {}

---@class MapPinEnhancedDebugMenuFrameStatusBar : StatusBar
---@field label FontString
---@field runTestsButton Button



function MapPinEnhancedDebugMenuFrameMixin:OnKeyDown(key)
    if key == "1" then
        C_UI.Reload()
    end
end

function MapPinEnhancedDebugMenuFrameMixin:SetStatusbarValue(min, max, value)
    self.testStatusbar:SetMinMaxValues(min, max)
    self.testStatusbar:SetValue(value)
    self.testStatusbar.label:SetText(string.format("Tests completed: %d/%d", value, max))
end

function MapPinEnhancedDebugMenuFrameMixin:OnLoad()
    self.debugMenuButton:SetScript("OnClick", function(button)
        if not MapPinEnhanced.debugMenuTemplate or #MapPinEnhanced.debugMenuTemplate == 0 then return end
        MapPinEnhanced:GenerateMenu(button, MapPinEnhanced.debugMenuTemplate)
    end)
    self.resetVarsButton:SetScript("OnClick", function()
        StaticPopup_Show(MapPinEnhanced.name .. "RESETSAVEDVARS_POPUP")
    end)
    self.debugAddonButton:SetScript("OnClick", function()
        MapPinEnhanced:Debug(MapPinEnhanced)
    end)
    self.exitDevButton:SetScript("OnClick", setDevMode)

    local testCount = MapPinEnhanced:GetNumberOfTests()
    self:SetStatusbarValue(0, testCount, 0)

    self.testStatusbar.runTestsButton:SetScript("OnClick", function(b)
        testCount = MapPinEnhanced:GetNumberOfTests()
        self.testStates = {}
        if not testCount or testCount == 0 then return end
        local testIndex = 0
        b:Disable()
        b:DesaturateHierarchy(1)
        MapPinEnhanced:RunTests(function(success)
            if not success then return end
            testIndex = testIndex + 1
            self:SetStatusbarValue(0, testCount, testIndex)
        end, function(states)
            b:Enable()
            b:DesaturateHierarchy(0)
            self.testStates = states
            local numErrors = 0
            for _, v in pairs(states) do
                if not v then
                    numErrors = numErrors + 1
                end
            end
            self:SetStatusbarValue(0, testCount, testCount)
        end)
    end)

    self.testStatusbar:SetScript("OnEnter", function(bar)
        if not self.testStates then return end
        MapPinEnhanced:GenerateMenu(bar, self:BuildStatusBarMenu(self.testStates),
            { gridModeColumns = math.ceil(MapPinEnhanced:GetNumberOfTests() / 25) })
    end)
end

---@param testsStates table<string, boolean>
---@return AnyMenuEntry[]?
function MapPinEnhancedDebugMenuFrameMixin:BuildStatusBarMenu(testsStates)
    if not testsStates then return end

    ---@type AnyMenuEntry[]
    local menuTemplate = {}
    local tests = MapPinEnhanced:GetTests()

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

local function GetDebugMenuFrame()
    if not MapPinEnhanced.debugMenuFrame then
        MapPinEnhanced.debugMenuFrame = CreateFrame("Frame", "MapPinEnhancedDebugMenuFrame", UIParent,
            "MapPinEnhancedDebugMenuFrameTemplate")
        MapPinEnhanced.debugMenuFrame:SetTitle(MapPinEnhanced.name .. " Debug Menu")
    end
    return MapPinEnhanced.debugMenuFrame
end

local function loadDevMode()
    local devModeEnabled = MapPinEnhanced:GetVar("devMode")
    local LDBIcon = LibStub("LibDBIcon-1.0", true)
    local f = GetDebugMenuFrame()
    if (devModeEnabled) then
        MapPinEnhanced:Print("Dev mode enabled")
        f:Show()
        C_Timer.After(1, function()
            LDBIcon:Show("BugSack")
            LDBIcon:Show(MapPinEnhanced.name)
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
        if f and f:IsShown() then
            f:Hide()
        end
        MapPinEnhanced:SetVar("loadedAddons", loadedAddons)
        C_Timer.After(1, function()
            LDBIcon:Hide("BugSack")
            LDBIcon:Hide(MapPinEnhanced.name)
        end)
    end
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    playerLoginFired = true
    C_Timer.After(0.1, function()
        for i = 1, #preFiredQueue do
            MapPinEnhanced:Debug(unpack(preFiredQueue[i]))
        end
    end)
    loadDevMode()
end)


--@do-not-package@
