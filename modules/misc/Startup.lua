---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Startup
local Startup = MapPinEnhanced:GetModule("Startup")
local Options = MapPinEnhanced:GetModule("Options")
local Groups = MapPinEnhanced:GetModule("Groups")
local Tracker = MapPinEnhanced:GetModule("Tracker")
local L = MapPinEnhanced.L

---@class StartupProgress
---@field step integer
---@field completed boolean
---@field suppressed boolean

---@type StartupProgress?
local progress
---@type MapPinEnhancedStartupTemplate?
local frame
local active, loginReady, worldReady, suspending = false, false, false, false
---@return StartupProgress
local function GetProgress()
    if not progress then
        local saved = MapPinEnhanced:GetVar("startupWizard")
        if type(saved) ~= "table" then saved = {} end
        ---@cast saved table<string, any>
        local step = saved.step
        progress = {
            step = type(step) == "number" and step >= 1 and step <= 5 and math.floor(step) or 1,
            completed = saved.completed == true,
            suppressed = saved.suppressed == true,
        }
    end
    return progress
end

local function PersistProgress()
    -- Keep the compatibility key; only this plain copy crosses the save boundary.
    MapPinEnhanced:SetVar("startupWizard", CopyTable(GetProgress()))
end

local function Close()
    active = false
    PersistProgress()
    if frame then frame:Hide() end
end

local function Suspend()
    if not frame then return end
    -- Hiding for combat/loading releases view subscriptions, but keeps the session.
    suspending = true
    frame:Hide()
    suspending = false
end

local function TryShow()
    if not active or not loginReady or not worldReady then return end
    if InCombatLockdown() then return end
    if not frame then
        frame = CreateFrame("Frame", "MapPinEnhancedStartup", UIParent,
            "MapPinEnhancedStartupTemplate") --[[@as MapPinEnhancedStartupTemplate]]
    end
    frame:Refresh()
    frame:Show()
end

function Startup:Open()
    if active then
        TryShow()
        return
    end
    local state = GetProgress()
    if state.completed or state.suppressed then state.step = 1 end
    active = true
    PersistProgress()
    TryShow()
end

---@return pinData?
local function GetExamplePosition()
    local mapID = C_Map.GetBestMapForUnit("player")
    if not MapPinEnhanced:IsReadablePositiveInteger(mapID) or not C_Map.CanSetUserWaypointOnMap(mapID) then return end
    local position = C_Map.GetPlayerMapPosition(mapID, "player")
    if not position then return end
    local x, y = position:GetXY()
    if not MapPinEnhanced:IsCoordinate(x) or not MapPinEnhanced:IsCoordinate(y) then return end
    local hbd = MapPinEnhanced.HBD
    local wx, wy, instance = hbd:GetWorldCoordinatesFromZone(x, y, mapID)
    local cx, cy, centerInstance = hbd:GetWorldCoordinatesFromZone(0.5, 0.5, mapID)
    if not wx or not wy or not cx or not cy or not instance or instance ~= centerInstance then return end
    local angle = math.atan2(cy - wy, cx - wx) + (math.random() - 0.5) * math.pi / 3
    local px, py = hbd:GetZoneCoordinatesFromWorldInstance(
        wx + 200 * math.cos(angle), wy + 200 * math.sin(angle), instance, mapID)
    if not MapPinEnhanced:IsCoordinate(px) or not MapPinEnhanced:IsCoordinate(py) then return end
    return { mapID = mapID, x = px, y = py, title = L["Example pin"], setTracked = true }
end

local function PlaceExample()
    local group = Groups:GetUngroupedGroup()
    local data = GetExamplePosition()
    if not group or not data then return end
    local _, pinID = group:AddPin(data)
    if pinID then Tracker:OnUserPinsAdded() end
end

---@class MapPinEnhancedStartupTemplate : MapPinEnhancedWindowTemplate
---@field heading FontString
---@field description FontString
---@field pageNumber FontString
---@field arrow MapPinEnhancedStartupWayfinderCard
---@field floating MapPinEnhancedStartupWayfinderCard
---@field logo Texture
---@field addonName FontString
---@field preview MapPinEnhancedImageTemplate
---@field navigationOption MapPinEnhancedStartupNavigationOption
---@field tooltipHelp MapPinEnhancedStartupCheckboxOption
---@field minimapButton MapPinEnhancedStartupCheckboxOption
---@field lockedPins MapPinEnhancedStartupCheckboxOption
---@field coordinates MapPinEnhancedStartupCheckboxOption
---@field example MapPinEnhancedButtonTemplate
---@field back MapPinEnhancedButtonTemplate
---@field next MapPinEnhancedButtonTemplate
---@field compactHeight number
---@field illustratedHeight number
---@field commonOptionsHeight number
---@field unsubscribeOptions fun()[]?
MapPinEnhancedStartupMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

---@class MapPinEnhancedStartupWayfinderCard : Button
---@field preview MapPinEnhancedImageTemplate
---@field background Texture
---@field label FontString
---@field value WayfinderSelection

---@class MapPinEnhancedStartupNavigationOption : Button
---@field toggle MapPinEnhancedToggleTemplate
---@field label FontString

---@class MapPinEnhancedStartupCheckboxOption : Button
---@field optionKey string
---@field checkbox MapPinEnhancedCheckboxTemplate
---@field label FontString
---@field description FontString

local COMMON_OPTIONS = { "tooltipHelp", "minimapButton", "lockedPins", "coordinates" }

local STEPS = {
    { "Welcome to Map Pin Enhanced!", "This introduction covers some of the addon's core settings. You can change all of these choices later in settings." },
    { "Select a wayfinder",           "Floating shows a diamond in the world at your target. Arrow uses a simple pointer to show the direction." },
    { "Enable navigation",            "Navigation shows the best available route to your target location." },
    { "Common options",              "Choose which helpers you want to enable. You can change these choices later in settings." },
    { "Place your first pin",         "Hold Ctrl and click the world map to place a pin. The button below creates a test pin near your character and finishes the introduction." },
}

local OPTION_KEYS = {
    "Wayfinder.General.Selection", "Wayfinder.Navigation.Enable",
    "General.TooltipHelper", "General.Minimap.ShowButton",
    "Pins.Miscellaneous.EnableLockedPins", "Miscellaneous.Coords.Enable",
}

function MapPinEnhancedStartupMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)
    -- Close/Escape must settle before another event can reverse the shared fade.
    -- Combat/loading also hides synchronously while the suspension flag is set.
    self.Hide = self.HideStartup
    self:SetTitle(L["Introduction"])
    self.arrow.label:SetText(L["Arrow"])
    self.floating.label:SetText(L["Floating"])
    self.navigationOption.label:SetText(L["Wayfinder.Navigation.Enable_LABEL"])
    for _, name in ipairs(COMMON_OPTIONS) do
        local card = self[name] --[[@as MapPinEnhancedStartupCheckboxOption]]
        card.label:SetText(L[card.optionKey .. "_LABEL"])
        card.description:SetText(L[card.optionKey .. "_DESCRIPTION"])
    end
    self.addonName:SetText(MapPinEnhanced.displayName)
end

function MapPinEnhancedStartupMixin:HideStartup()
    if active and not suspending then
        GetProgress().suppressed = true
        Close()
    else
        self:HideImmediately()
    end
end

function MapPinEnhancedStartupMixin:Refresh()
    local step = GetProgress().step
    self:SetHeight(step == 4 and self.commonOptionsHeight or
        step <= 2 and self.compactHeight or self.illustratedHeight)
    self.heading:SetText(L[STEPS[step][1]])
    self.description:SetText(L[STEPS[step][2]])
    self.pageNumber:SetText(string.format(L["Step %d of %d"], step, #STEPS))
    self.back:SetShown(step > 1)
    self.next:SetLabel(L[step == 1 and "Let's go!" or step == #STEPS and "Finish" or "Next"])
    self.logo:SetShown(step == 1)
    self.addonName:SetShown(step == 1)
    self.arrow:SetShown(step == 2)
    self.floating:SetShown(step == 2)
    self.navigationOption:SetShown(step == 3)
    self.preview:SetShown(step == 3 or step == 5)
    if step == 3 or step == 5 then
        self.preview:SetImage(MapPinEnhanced.assetsPath .. "/options/" ..
            (step == 3 and "OptionNavigation.png" or "OptionPin.png"))
    end
    self.example:SetShown(step == 5)
    for _, name in ipairs(COMMON_OPTIONS) do
        local card = self[name] --[[@as MapPinEnhancedStartupCheckboxOption]]
        card:SetShown(step == 4)
        card.checkbox:SetValue(Options:GetOptionValue(card.optionKey) == true, false, true)
    end
    local selection = Options:GetOptionValue(OPTION_KEYS[1]) --[[@as WayfinderSelection]]
    for _, card in ipairs({ self.arrow, self.floating }) do
        local selected = card.value == selection
        card.preview.image:SetDesaturated(not selected)
        card.background:SetVertexColor(1, selected and 0.82 or 1, selected and 0 or 1)
        card.label:SetTextColor(1, selected and 0.82 or 1, selected and 0 or 1)
    end
    self.navigationOption.toggle:SetValue(Options:GetOptionValue(OPTION_KEYS[2]) == true, false, true)
end

function MapPinEnhancedStartupMixin:OnShow()
    MapPinEnhancedWindowMixin.OnShow(self)
    self.unsubscribeOptions = {}
    for _, key in ipairs(OPTION_KEYS) do
        self.unsubscribeOptions[#self.unsubscribeOptions + 1] = Options:SubscribeToOptionChanges(key, function()
            if active and self:IsShown() then self:Refresh() end
        end)
    end
end

function MapPinEnhancedStartupMixin:OnHide()
    for _, unsubscribe in ipairs(self.unsubscribeOptions or {}) do unsubscribe() end
    self.unsubscribeOptions = nil
    MapPinEnhancedWindowMixin.OnHide(self)
    if active and not suspending and not self:IsShown() then
        GetProgress().suppressed = true
        Close()
    end
end

---@param action string
function MapPinEnhancedStartupMixin:ApplyAction(action)
    if not active or InCombatLockdown() then return end
    local state = GetProgress()
    if action == "example" or action == "next" and state.step == #STEPS then
        if action == "example" then PlaceExample() end
        state.completed = true
        Close()
    else
        state.step = math.max(1, math.min(#STEPS, state.step + (action == "back" and -1 or 1)))
        PersistProgress()
        self:Refresh()
    end
end

---@class MapPinEnhancedStartupControl : Button
---@field action string?
---@field optionKey string?
---@field value string?
MapPinEnhancedStartupControlMixin = {}

function MapPinEnhancedStartupControlMixin:OnStartupOptionClick()
    -- The child consumes its own click; the card owns the option write.
    local card = self:GetParent() --[[@as MapPinEnhancedStartupControl]]
    card:OnStartupClick()
end

function MapPinEnhancedStartupControlMixin:OnStartupClick()
    if not active or InCombatLockdown() then return end
    if self.optionKey then
        Options:SetOptionValue(self.optionKey, self.value or not Options:GetOptionValue(self.optionKey))
    else
        local parent = self:GetParent() --[[@as MapPinEnhancedStartupTemplate]]
        parent:ApplyAction(self.action)
    end
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    loginReady = true
    local state = GetProgress()
    if not state.completed and not state.suppressed then Startup:Open() end
end)
MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    worldReady = true
    TryShow()
end)
MapPinEnhanced:RegisterEvent("LOADING_SCREEN_ENABLED", function()
    worldReady = false
    Suspend()
end)
MapPinEnhanced:RegisterEvent("LOADING_SCREEN_DISABLED", function()
    worldReady = true
    TryShow()
end)
MapPinEnhanced:RegisterEvent("PLAYER_REGEN_DISABLED", Suspend)
MapPinEnhanced:RegisterEvent("PLAYER_REGEN_ENABLED", TryShow)
MapPinEnhanced:RegisterEvent("PLAYER_LOGOUT", function()
    if active then Close() end
end)

MapPinEnhanced:AddSlashCommand("resetstartup", function()
    Close()
    MapPinEnhanced:DeleteVar("startupWizard")
    progress = nil
    Startup:Open()
end, L["Reset the startup introduction."], false)
