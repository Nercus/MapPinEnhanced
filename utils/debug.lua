---@class Wayfinder
local Wayfinder = select(2, ...)

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
function Wayfinder:Debug(...)
  local args = ...
  if (playerLoginFired == false) then
    table.insert(preFiredQueue, { args })
    return
  end
  if (IsAddOnLoaded("DevTool") == false) then
    C_Timer.After(1, function()
      Wayfinder:Debug(args)
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
      Wayfinder:Debug(args)
    end)
    return
  end
end

Wayfinder:RegisterEvent("PLAYER_LOGIN", function()
  playerLoginFired = true
  C_Timer.After(1, function()
    for i = 1, #preFiredQueue do
      Wayfinder:Debug(unpack(preFiredQueue[i]))
    end
  end)
end)




local devAddonList = {
  "!BugGrabber",
  "BugSack",
  "TextureAtlasViewer",
  "DevTool",
  "Wayfinder",
  "Wowlua"
}



local function loadDevAddons(isDev)
  if not isDev then
    DisableAddOn(Wayfinder.addonName)
    local loadedAddons = Wayfinder:GetVar("loadedAddons") or {}
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
  local devModeEnabled = Wayfinder:GetVar("devMode")
  if (devModeEnabled) then
    Wayfinder:SaveVar("devMode", false)
  else
    Wayfinder:SaveVar("devMode", true)
  end
  loadDevAddons(not devModeEnabled)
  ReloadUI()
end
Wayfinder:AddSlashCommand("dev", setDevMode)


local function AddDevReload()
  local f = CreateFrame("frame")
  f:SetPoint("BOTTOM", 0, 10)
  f:SetSize(200, 20)
  f:SetFrameStrata("HIGH")
  f:SetFrameLevel(100)
  local text = f:CreateFontString(nil, "OVERLAY")
  text:SetFontObject(GameFontNormal)
  text:SetPoint("CENTER")
  text:SetText("Press 1 to reload UI | Press 0 to exit dev mode")
  f:SetScript("OnKeyDown", function(_, key)
    if key == "1" then
      ReloadUI()
    elseif key == "0" then
      setDevMode()
    end
  end)
  f:SetPropagateKeyboardInput(true)
  f:Show()
end

local function loadDevMode(_, loadedAddon)
  if loadedAddon ~= Wayfinder.addonName then
    return
  end
  local devModeEnabled = Wayfinder:GetVar("devMode")
  if (devModeEnabled) then
    Wayfinder:Print("Dev mode enabled")
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
    Wayfinder:SaveVar("loadedAddons", loadedAddons)
  end
end

Wayfinder:RegisterEvent("ADDON_LOADED", loadDevMode)
