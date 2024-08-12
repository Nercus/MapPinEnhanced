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
    self.pinTracker:SetActiveView(viewType)
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
        local MapPinEnhancedBroker = LibStub("LibDataBroker-1.1"):NewDataObject("Bunnies", {
            type = "launcher",
            text = self.addonName,
            icon = "Interface\\Addons\\MapPinEnhanced\\assets\\MPH_Logo.png",
            OnClick = function(owner, button)
                if button == "LeftButton" then
                    self:TogglePinTracker()
                elseif button == "RightButton" then
                    MenuUtil.CreateContextMenu(owner, function(_, rootDescription)
                        rootDescription:CreateTitle(MapPinEnhanced.nameVersionString)
                        rootDescription:CreateButton("Toggle Pin Tracker", function()
                            MapPinEnhanced:TogglePinTracker()
                        end)
                        rootDescription:CreateButton("Toggle Editor", function()
                            MapPinEnhanced:ToggleEditorWindow()
                        end)
                        rootDescription:CreateDivider()
                        rootDescription:CreateButton("Hide Minimap Button", function()
                            MapPinEnhanced:ToggleMinimapButton()
                        end)
                    end)
                end
            end,
        })
        self.minimapIconCreated = true
        if not MapPinEnhancedDB.MinimapIcon then
            MapPinEnhancedDB.MinimapIcon = MapPinEnhanced:GetDefault("MinimapIcon") --[[@as table]]
        end
        self.LDBIcon:Register("MapPinEnhanced", MapPinEnhancedBroker,
            MapPinEnhancedDB.MinimapIcon --[[@as LibDBIcon.button.DB]])
    end
    if init then return end
    local currentState = MapPinEnhanced:GetVar("MinimapIcon", "hide") --[[@as boolean]]
    if currentState then
        MapPinEnhanced:SaveVar("MinimapIcon", "hide", false)
        MapPinEnhanced:Notify("Minimapbutton is now visible")
    else
        MapPinEnhanced:SaveVar("MinimapIcon", "hide", true)
        MapPinEnhanced:Notify("Minimapbutton is now hidden")
    end
    self.LDBIcon:Refresh("MapPinEnhanced", MapPinEnhancedDB.MinimapIcon --[[@as LibDBIcon.button.DB]])
end

function MapPinEnhanced:RegisterAddonCompartment()
    AddonCompartmentFrame:RegisterAddon({
        text = self.addonName,
        icon = "Interface\\Addons\\MapPinEnhanced\\assets\\MPH_Logo.png",
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
    self.lastVersion = MapPinEnhanced:GetVar("version")
    local currentVersion = MapPinEnhanced.version
    if not MapPinEnhanced.lastVersion or MapPinEnhanced.lastVersion ~= currentVersion then
        MapPinEnhanced:SaveVar("version", currentVersion)
        MapPinEnhanced:PrintHelp() -- show the help message after a new upate
    end
end

function MapPinEnhanced:CheckNavigationEnabled()
    if GetCVar("showInGameNavigation") == "1" then return end
    self:ShowPopup({
        text =
        "The in-game navigation is disabled! Not all features of MapPinEnhanced will work properly. Do you want to enable it?",
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
    self:Notify("TomTom is loaded! The usage of /way is disabled.")
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    MapPinEnhanced:ToggleMinimapButton(true)
    MapPinEnhanced:RegisterAddonCompartment()
    MapPinEnhanced:UpdateVersionInfo()
    MapPinEnhanced:CheckNavigationEnabled()
    MapPinEnhanced:CheckForTomTom()
end)

MapPinEnhanced:AddSlashCommand("minimap", function()
    MapPinEnhanced:ToggleMinimapButton()
end, "Toggle the minimap button")

MapPinEnhanced:AddSlashCommand("back", function()
    local currentMapID = C_Map.GetBestMapForUnit("player")
    if not currentMapID then
        MapPinEnhanced:Notify("You are in an instance or a zone where the map is not available")
        return
    end
    local x, y = C_Map.GetPlayerMapPosition(currentMapID, "player"):GetXY()
    PinManager:AddPin({
        title = "My way back pin",
        mapID = currentMapID,
        x = x,
        y = y,
        setTracked = true,
        persistent = true,
    })
end, "Create a pin at your current location")

MapPinEnhanced:AddSlashCommand("tracker", function()
    MapPinEnhanced:TogglePinTracker()
end, "Toggle the tracker window")


MapPinEnhanced:AddSlashCommand("import", function()
    MapPinEnhanced:TogglePinTracker(true)
    MapPinEnhanced:SetPinTrackerView("Import")
end, "Import a set from a string")

MapPinEnhanced:AddSlashCommand("editor", function()
    MapPinEnhanced:ToggleEditorWindow()
end, "Toggle the editor window")

MapPinEnhanced:AddSlashCommand("options", function()
    MapPinEnhanced:ToggleEditorWindow()
    MapPinEnhanced:SetEditorView("optionView")
end, "Open the options window")
