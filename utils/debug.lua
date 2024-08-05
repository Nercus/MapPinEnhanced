---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local EnableAllAddOns = C_AddOns.EnableAllAddOns
local DisableAllAddOns = C_AddOns.DisableAllAddOns
local EnableAddOn = C_AddOns.EnableAddOn
local DisableAddOn = C_AddOns.DisableAddOn
local IsAddOnLoaded = C_AddOns.IsAddOnLoaded
local GetNumAddOns = C_AddOns.GetNumAddOns
local GetAddOnInfo = C_AddOns.GetAddOnInfo
---@type function
local ReloadUI = C_UI.Reload

local playerLoginFired = false
local preFiredQueue = {}

-- TODO: dont package this in the release version
-- TODO: add a test system that automatically tests different things
-- this should move the current saved vars to a different location and then test different things and then reset the saved vars -> always a fresh use
-- should be able to test the following:
-- - Add a pin
-- - Remove a pin
-- - Track a pin
-- - Untrack a pin
-- - Change the color of a pin
-- - Change the title of a pin
-- - Change the icon of a pin
-- - Create a set
-- - Delete a set
-- - Update the name of a set
-- - Add a pin to a set
-- - Remove a pin from a set
-- - Edit a pin in a set
-- - Change option values and see if they work
-- - Change the position of the tracker
-- - Open the seteditor
-- - Close the seteditor
-- - Open the tracker
-- - Close the tracker
-- - Open the options
-- - Close the options
-- - Test migration from old saved vars

---add debug message to DevTool
---@param ... table | string | number | boolean | nil
function MapPinEnhanced:Debug(...)
    local args = ...
    if (playerLoginFired == false) then
        table.insert(preFiredQueue, { args })
        return
    end
    if (IsAddOnLoaded("DevTool") == false) then
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
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    playerLoginFired = true
    C_Timer.After(1, function()
        for i = 1, #preFiredQueue do
            MapPinEnhanced:Debug(unpack(preFiredQueue[i]))
        end
    end)
end)



local function AddTestPins()
    ---@class PinManager : Module
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
        DisableAddOn(MapPinEnhanced.addonName)
        local loadedAddons = MapPinEnhanced:GetVar("loadedAddons") or {}
        if #loadedAddons == 0 then
            EnableAllAddOns()
            return
        end
        for i = 1, #loadedAddons do
            local name = loadedAddons[i] ---@type string
            EnableAddOn(name)
        end
    else
        DisableAllAddOns()
        for i = 1, #devAddonList do
            local name = devAddonList[i]
            EnableAddOn(name)
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
MapPinEnhanced:AddSlashCommand("dev", setDevMode)



StaticPopupDialogs["MAP_PIN_ENHANCED_RESET_SAVED_VARS"] = {
    text = "Are you sure you want to reset all saved variables?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
        MapPinEnhancedDB = {}
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
    local f = CreateFrame("frame", nil, UIParent, "DefaultPanelFlatTemplate")
    f:SetPoint("TOPLEFT", 5, -5)
    f:SetSize(150, 400)
    f:SetFrameStrata("HIGH")
    f:SetFrameLevel(100)

    local totalHeight = 0
    local text = f:CreateFontString(nil, "OVERLAY")
    text:SetFontObject(GameFontNormal)
    text:SetPoint("TOP", 0, -30)
    text:SetText("Press 1 to reload UI")
    f:SetScript("OnKeyDown", function(_, key)
        if key == "1" then
            ReloadUI()
        end
    end)

    totalHeight = totalHeight + text:GetHeight()

    local button1 = CreateFrame("Button", nil, f, "MapPinEnhancedButtonYellowTemplate")
    button1:SetPoint("TOP", text, "BOTTOM", 0, -10)
    button1:SetSize(130, 40)
    button1:SetScale(0.8)
    button1:SetText("Add Test Pins")
    button1:SetScript("OnClick", AddTestPins)

    totalHeight = totalHeight + button1:GetHeight()

    local button2 = CreateFrame("Button", nil, f, "MapPinEnhancedButtonYellowTemplate")
    button2:SetPoint("TOP", button1, "BOTTOM", 0, -10)
    button2:SetSize(130, 40)
    button2:SetScale(0.8)
    button2:SetText("Reset Saved Vars")
    button2:SetScript("OnClick", ResetSavedVars)

    totalHeight = totalHeight + button2:GetHeight()

    local button3 = CreateFrame("Button", nil, f, "MapPinEnhancedButtonYellowTemplate")
    button3:SetPoint("TOP", button2, "BOTTOM", 0, -10)
    button3:SetSize(130, 40)
    button3:SetScale(0.8)
    button3:SetText("Debug MPH")
    button3:SetScript("OnClick", function()
        MapPinEnhanced:Debug(MapPinEnhanced)
    end)

    totalHeight = totalHeight + button3:GetHeight()

    local button4 = CreateFrame("Button", nil, f, "MapPinEnhancedButtonRedTemplate")
    button4:SetPoint("TOP", button3, "BOTTOM", 0, -10)
    button4:SetSize(130, 40)
    button4:SetScale(0.8)
    button4:SetText("Exit Dev Mode")
    button4:SetScript("OnClick", setDevMode)

    totalHeight = totalHeight + button4:GetHeight()

    f:SetPropagateKeyboardInput(true)
    f:SetSize(150, totalHeight + 50)
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
        for i = 1, GetNumAddOns() do
            local name, _, _, _, reason = GetAddOnInfo(i)
            if reason ~= "DISABLED" then
                table.insert(loadedAddons, name)
            end
        end
        MapPinEnhanced:SaveVar("loadedAddons", loadedAddons)
    end
end

MapPinEnhanced:RegisterEvent("ADDON_LOADED", loadDevMode)
