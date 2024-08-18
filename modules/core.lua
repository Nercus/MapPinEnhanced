---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---------------------------------------------------------------------------

MapPinEnhanced:CreateModule("PinManager")
MapPinEnhanced:CreateModule("PinFactory")
MapPinEnhanced:CreateModule("SetManager")
MapPinEnhanced:CreateModule("SetFactory")
MapPinEnhanced:CreateModule("Blizz")

---------------------------------------------------------------------------

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
                        rootDescription:CreateButton(L["Toggle Tracker"], function()
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
        MapPinEnhanced:Print(L["Minimap Button Is Now Visible"])
    else
        MapPinEnhanced:SaveVar("minimapIcon", "hide", true)
        MapPinEnhanced:Print(L["Minimap Button Is Now Hidden"])
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
    self:Print(L["TomTom Is Loaded! You may experience some unexpected behavior."])
end

---------------------------------------------------------------------------

MapPinEnhanced:AddSlashCommand(L["Minimap"]:lower(), function()
    MapPinEnhanced:ToggleMinimapButton()
end, L["Toggle Minimap Button"])

---------------------------------------------------------------------------

function MapPinEnhanced:Initialize()
    if MapPinEnhanced.init then return end
    MapPinEnhanced:ToggleMinimapButton(true)
    MapPinEnhanced:RegisterAddonCompartment()
    MapPinEnhanced:CheckNavigationEnabled()
    MapPinEnhanced:CheckForTomTom()
    MapPinEnhanced.init = true
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", MapPinEnhanced.Initialize)
