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


---@diagnostic disable-next-line: no-unknown
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
    ---@diagnostic disable-next-line: no-unknown
    StaticPopup_Show("MAP_PIN_ENHANCED_RESET_SAVED_VARS")
end


local function AddDevReload()
    local f = CreateFrame("frame")
    f:SetPoint("BOTTOM", 0, 10)
    f:SetSize(200, 20)
    f:SetFrameStrata("HIGH")
    f:SetFrameLevel(100)
    local text = f:CreateFontString(nil, "OVERLAY")
    text:SetFontObject(GameFontNormal)
    text:SetPoint("CENTER")
    text:SetText(
        "Press 1 to reload UI | Press 2 to add test pins | Press 3 to add MapPinEnhanced to devtools | Press 4 to reset saved variables | Press 0 to exit dev mode")
    f:SetScript("OnKeyDown", function(_, key)
        if key == "1" then
            ReloadUI()
        elseif key == "2" then
            AddTestPins()
        elseif key == "3" then
            MapPinEnhanced:Debug(MapPinEnhanced)
        elseif key == "4" then
            ResetSavedVars()
        elseif key == "0" then
            setDevMode()
        end
    end)
    f:SetPropagateKeyboardInput(true)
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
