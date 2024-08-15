---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinManager : Module
local PinManager = MapPinEnhanced:CreateModule("PinManager")

---@class PinFactory : Module
local PinFactory = MapPinEnhanced:CreateModule("PinFactory")

---@class SetManager : Module
local SetManager = MapPinEnhanced:CreateModule("SetManager")

---@class SetFactory : Module
local SetFactory = MapPinEnhanced:CreateModule("SetFactory")

---@class Blizz : Module
local Blizz = MapPinEnhanced:CreateModule("Blizz")

local L = MapPinEnhanced.L

---toggle the pin tracker
---@param forceShow? boolean if true, the tracker will be shown, if false, the tracker will be hidden, if nil, the tracker will be toggled
function MapPinEnhanced:TogglePinTracker(forceShow)
    if not self.pinTracker then
        self.pinTracker = CreateFrame("Frame", "MapPinEnhancedTracker", UIParent, "MapPinEnhancedTrackerFrameTemplate") --[[@as MapPinEnhancedTrackerFrameMixin]]
    end
    if forceShow == true then
        self.pinTracker:Open()
    elseif forceShow == false then
        self.pinTracker:Close()
    else
        self.pinTracker:Toggle()
    end
end

---@param viewType TrackerView
function MapPinEnhanced:SetPinTrackerView(viewType)
    if not self.pinTracker then
        self:TogglePinTracker(true)
    end
    if viewType == "Import" then
        self.pinTracker:SetImportView()
        return
    end
    if viewType == "Pins" then
        self.pinTracker:SetPinView()
        return
    end
    if viewType == "Sets" then
        self.pinTracker:SetSetView()
        return
    end
end

---@param viewType EditorViews
function MapPinEnhanced:SetEditorView(viewType)
    if not self.editorWindow then
        self:ToggleEditorWindow()
    end
    self.editorWindow:SetActiveView(viewType)
end

function MapPinEnhanced:ToggleEditorWindow()
    if not self.editorWindow then
        self.editorWindow = CreateFrame("Frame", "MapPinEnhancedEditorWindow", UIParent,
            "MapPinEnhancedEditorWindowTemplate") --[[@as MapPinEnhancedEditorWindowMixin]]
        self.editorWindow:Open()
        return
    end
    if self.editorWindow:IsVisible() then
        self.editorWindow:Close()
    else
        self.editorWindow:Open()
    end
end

---@param pinData pinData | nil if nil, the super tracked pin will be hidden
---@param timeToTarget number?
function MapPinEnhanced:SetSuperTrackedPin(pinData, timeToTarget)
    if not self.SuperTrackedPin then
        self.SuperTrackedPin = CreateFrame("Frame", "MapPinEnhancedSuperTrackedPin", UIParent,
            "MapPinEnhancedSuperTrackedPinTemplate") --[[@as MapPinEnhancedSuperTrackedPinMixin]]
    end
    if not pinData then
        self.SuperTrackedPin:Clear()
        return
    end
    self.SuperTrackedPin:Setup(pinData)
    self.SuperTrackedPin:SetTrackedTexture()
    self.SuperTrackedPin:UpdateTimeText(timeToTarget)
    if not self.SuperTrackedPin:IsShown() then
        self.SuperTrackedPin:Show()
    end
end

function MapPinEnhanced:ToggleMinimapButton(init)
    if not self.minimapIconCreated then
        local MapPinEnhancedBroker = LibStub("LibDataBroker-1.1"):NewDataObject(self.addonName, {
            type = "launcher",
            text = self.addonName,
            icon = "Interface\\Addons\\MapPinEnhanced\\assets\\logo.png",
            OnClick = function(owner, button)
                if button == "LeftButton" then
                    self:TogglePinTracker()
                elseif button == "RightButton" then
                    MenuUtil.CreateContextMenu(owner, function(_, rootDescription)
                        rootDescription:CreateTitle(MapPinEnhanced.nameVersionString)
                        rootDescription:CreateButton(L["Toggle tracker"], function()
                            MapPinEnhanced:TogglePinTracker()
                        end)
                        rootDescription:CreateButton(L["Toggle Editor"], function()
                            MapPinEnhanced:ToggleEditorWindow()
                        end)
                        rootDescription:CreateDivider()
                        rootDescription:CreateButton(L["Hide Minimap Button"], function()
                            MapPinEnhanced:ToggleMinimapButton()
                        end)
                    end)
                end
            end,
        })
        self.minimapIconCreated = true
        if not MapPinEnhancedDB.minimapIcon then
            MapPinEnhancedDB.minimapIcon = MapPinEnhanced:GetDefault("minimapIcon") --[[@as table]]
        end
        self.LDBIcon:Register("MapPinEnhanced", MapPinEnhancedBroker,
            MapPinEnhancedDB.minimapIcon --[[@as LibDBIcon.button.DB]])
    end
    if init then return end
    local currentState = MapPinEnhanced:GetVar("minimapIcon", "hide") --[[@as boolean]]
    if currentState then
        MapPinEnhanced:SaveVar("minimapIcon", "hide", false)
        MapPinEnhanced:Notify(L["Minimap button is now visible"])
    else
        MapPinEnhanced:SaveVar("minimapIcon", "hide", true)
        MapPinEnhanced:Notify(L["Minimap button is now hidden"])
    end
    self.LDBIcon:Refresh("MapPinEnhanced", MapPinEnhancedDB.minimapIcon --[[@as LibDBIcon.button.DB]])
end

function MapPinEnhanced:RegisterAddonCompartment()
    AddonCompartmentFrame:RegisterAddon({
        text = self.addonName,
        icon = "Interface\\Addons\\MapPinEnhanced\\assets\\logo.png",
        notCheckable = true,
        func = function()
            self:TogglePinTracker()
        end,
    })
end

--- check if this version is a new version and return the last version
function MapPinEnhanced:IsNewVersion()
    local currentVersion = MapPinEnhanced.version
    local lastVersion = MapPinEnhanced:GetVar("version")
    if not lastVersion or lastVersion ~= currentVersion then
        return lastVersion
    end
end

function MapPinEnhanced:UpdateVersionInfo()
    if self.lastVersion then return end -- only update once
    self.lastVersion = self:GetVar("version") --[[@as number]]
    local currentVersion = self.version
    if not self.lastVersion or self.lastVersion ~= currentVersion then
        self:SaveVar("version", currentVersion)
        self:PrintHelp() -- show the help message after a new upate
    end
    local Options = self:GetModule("Options")
    Options:MigrateOptionByVersion(self.lastVersion or 0)
end

function MapPinEnhanced:CheckNavigationEnabled()
    if GetCVar("showInGameNavigation") == "1" then return end
    self:ShowPopup({
        text = L
            ["The in-game navigation is disabled! Not all features of MapPinEnhanced will work properly. Do you want to enable it?"],
        onAccept = function()
            SetCVar("showInGameNavigation", 1)
        end
    })
end

function MapPinEnhanced:CheckForTomTom()
    self.isTomTomLoaded = C_AddOns.IsAddOnLoaded("TomTom")
    if not self.isTomTomLoaded then
        ---@diagnostic disable-next-line: global-element slash command definition has to be global
        SLASH_MapPinEnhanced3 = "/way"
        return
    end
    self:Print(L["TomTom is loaded! You could experience some unexpected behavior."])
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    MapPinEnhanced:ToggleMinimapButton(true)
    MapPinEnhanced:RegisterAddonCompartment()
    MapPinEnhanced:UpdateVersionInfo()
    MapPinEnhanced:CheckNavigationEnabled()
    MapPinEnhanced:CheckForTomTom()
end)


MapPinEnhanced:AddSlashCommand(L["Minimap"]:lower(), function()
    MapPinEnhanced:ToggleMinimapButton()
end, L["Toggle minimap button"])

MapPinEnhanced:AddSlashCommand(L["Back"]:lower(), function()
    local currentMapID = C_Map.GetBestMapForUnit("player")
    if not currentMapID then
        MapPinEnhanced:Notify(L["You are in an instance or a zone where the map is not available"])
        return
    end
    local x, y = C_Map.GetPlayerMapPosition(currentMapID, "player"):GetXY()
    PinManager:AddPin({
        title = L["My way back"],
        mapID = currentMapID,
        x = x,
        y = y,
        setTracked = true,
        persistent = true,
    })
end, L["Create a pin at your current location"])

MapPinEnhanced:AddSlashCommand(L["Tracker"]:lower(), function()
    MapPinEnhanced:TogglePinTracker()
end, L["Toggle tracker"])


MapPinEnhanced:AddSlashCommand(L["Import"]:lower(), function()
    MapPinEnhanced:TogglePinTracker(true)
    MapPinEnhanced:SetPinTrackerView("Import")
end, L["Import a set"])

MapPinEnhanced:AddSlashCommand(L["Editor"]:lower(), function()
    MapPinEnhanced:ToggleEditorWindow()
end, L["Toggle Editor"])

MapPinEnhanced:AddSlashCommand(L["Options"]:lower(), function()
    MapPinEnhanced:ToggleEditorWindow()
    MapPinEnhanced:SetEditorView("optionView")
end, L["Open options"])
