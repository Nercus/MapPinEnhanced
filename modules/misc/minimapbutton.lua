---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L
local SavedVars = MapPinEnhanced:GetModule("SavedVars")
local Menu = MapPinEnhanced:GetModule("Menu")
local Utils = MapPinEnhanced:GetModule("Utils")
local Events = MapPinEnhanced:GetModule("Events")
local SlashCommand = MapPinEnhanced:GetModule("SlashCommand")
local Tracker = MapPinEnhanced:GetModule("Tracker")
local PinSections = MapPinEnhanced:GetModule("PinSections")


---@type AnyMenuEntry[]
local MinimapButtonTemplate = {
    {
        type = "title",
        label = MapPinEnhanced.nameVersionString,
    },
    {
        type = "button",
        label = L["Toggle Tracker"],
        onClick = function()
            Tracker:ToggleTracker()
        end,
    },
    {
        type = "button",
        label = L["Toggle Editor"],
        onClick = function()
            local EditorWindow = MapPinEnhanced:GetModule("EditorWindow")
            EditorWindow:Toggle()
        end,
    },
    {
        type = "button",
        label = L["Clear All Pins"],
        onClick = function()
            -- local PinManager = MapPinEnhanced:GetModule("PinManager")
            -- PinManager:ClearPins()
        end,
    },
    {
        type = "submenu",
        label = L["Load Set"],
        entries = function()
            local SetManager = MapPinEnhanced:GetModule("SetManager")
            local sets = SetManager:GetSets()
            ---@type MenuButtonEntry[]
            local entries = {}
            for _, set in pairs(sets) do
                entries[#entries + 1] = {
                    type = "button",
                    label = set.name,
                    onClick = function()
                        set.LoadSet()
                    end
                }
            end
            return entries
        end
    },
    {
        type = "divider",
    },
    {
        type = "button",
        label = L["Hide Minimap Button"],
        onClick = function()
            MapPinEnhanced:ToggleMinimapButton()
        end,
    },
}


function MapPinEnhanced:ToggleMinimapButton(init)
    if not self.minimapIconCreated then
        local MapPinEnhancedBroker = LibStub("LibDataBroker-1.1"):NewDataObject(self.addonName, {
            type = "launcher",
            text = self.addonName,
            icon = "Interface\\Addons\\MapPinEnhanced\\assets\\logo.png",
            OnClick = function(owner, button)
                if button == "LeftButton" then
                    if IsAltKeyDown() then
                        PinSections:ClearPins()
                        return
                    end
                    Tracker:ToggleTracker()
                elseif button == "RightButton" then
                    Menu:GenerateMenu(owner, MinimapButtonTemplate)
                end
            end,
        })
        self.minimapIconCreated = true
        if not MapPinEnhancedDB then
            MapPinEnhancedDB = {}
        end
        -- if not MapPinEnhancedDB.minimapIcon then
        --     MapPinEnhancedDB.minimapIcon = SavedVars:GetDefault("minimapIcon") --[[@as table]]
        -- end
        self.LDBIcon:Register("MapPinEnhanced", MapPinEnhancedBroker,
            MapPinEnhancedDB.minimapIcon --[[@as LibDBIcon.button.DB]])
    end
    if init then return end
    local currentState = SavedVars:Get("minimapIcon", "hide") --[[@as boolean]]
    if currentState then
        SavedVars:Save("minimapIcon", "hide", false)
        Utils:Print(L["Minimap Button Is Now Visible"])
    else
        SavedVars:Save("minimapIcon", "hide", true)
        Utils:Print(L["Minimap Button Is Now Hidden"])
    end
    self.LDBIcon:Refresh("MapPinEnhanced", MapPinEnhancedDB.minimapIcon --[[@as LibDBIcon.button.DB]])
end

function MapPinEnhanced:RegisterAddonCompartment()
    AddonCompartmentFrame:RegisterAddon({
        text = self.addonName,
        icon = "Interface\\Addons\\MapPinEnhanced\\assets\\logo.png",
        notCheckable = true,
        func = function()
            Tracker:ToggleTracker()
        end,
    })
end

Events:RegisterEvent("PLAYER_LOGIN", function()
    MapPinEnhanced:ToggleMinimapButton(true)
    MapPinEnhanced:RegisterAddonCompartment()
end)


SlashCommand:AddSlashCommand(L["Minimap"]:lower(), function()
    MapPinEnhanced:ToggleMinimapButton()
end, L["Toggle Minimap Button"])
