---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LibDBIcon = MapPinEnhanced.LDBIcon
local Options = MapPinEnhanced:GetModule("Options")
local Editor = MapPinEnhanced:GetModule("Editor")
local Tracker = MapPinEnhanced:GetModule("Tracker")
local Pins = MapPinEnhanced:GetModule("Pins")
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L
local SHOW_BUTTON_OPTION = "General.Minimap.ShowButton"

local init = false
local logoPath = MapPinEnhanced.assetsPath .. "\\Logo.png"
local customLogoPath = MapPinEnhanced.assetsPath .. "\\LogoTransparent.png"
local minimapHighlightPath = MapPinEnhanced.assetsPath .. "\\shared\\MinimapHighlight.png"

local function ClearAllPins()
    if not Groups:MarkAllPinsReached() then
        MapPinEnhanced:Print(L
        ["Some pins are still being updated. Try clearing again when the current operation finishes."])
    end
end

---@param owner Region
local function ShowMinimapMenu(owner)
    MapPinEnhanced:GenerateMenu(owner, {
        {
            type = "title",
            label = MapPinEnhanced.displayName .. " " .. MapPinEnhanced.version,
        },
        {
            type = "button",
            label = MapPinEnhanced:Iconize("trash", L["Clear all pins"]),
            onClick = ClearAllPins,
        },
        {
            type = "button",
            label = MapPinEnhanced:Iconize("map", L["Show tracked pin on map"]),
            onClick = function()
                local pin = Pins:GetTrackedPin()
                if pin then pin:ShowOnMap() end
            end,
            initializer = function(_, description)
                description:SetEnabled(Pins:GetTrackedPin() ~= nil)
            end,
        },
        { type = "divider" },
        {
            type = "button",
            label = MapPinEnhanced:Iconize("edit", L["Open editor"]),
            onClick = function()
                Editor:ShowEditor()
            end,
        },
        {
            type = "button",
            label = MapPinEnhanced:Iconize("settings", L["Open options"]),
            onClick = function()
                Options:OpenOptions()
            end,
        },
        { type = "divider" },
        {
            type = "button",
            label = MapPinEnhanced:Iconize("eyeslash", L["Hide minimap button"]),
            onClick = function()
                Options:SetOptionValue(SHOW_BUTTON_OPTION, false)
            end,
        },
    })
end

---@param enabled boolean
local function ApplyCustomMinimapButton(enabled)
    if enabled then
        LibDBIcon:RemoveButtonBorder(MapPinEnhanced.name)
        LibDBIcon:RemoveButtonBackground(MapPinEnhanced.name)
        LibDBIcon:SetButtonIcon(MapPinEnhanced.name, customLogoPath, 42, "CENTER", 0, 0)
        LibDBIcon:SetButtonHighlightTexture(MapPinEnhanced.name, minimapHighlightPath)
    else
        LibDBIcon:ResetButtonBorder(MapPinEnhanced.name)
        LibDBIcon:ResetButtonBackground(MapPinEnhanced.name)
        LibDBIcon:SetButtonIcon(MapPinEnhanced.name, logoPath)
        LibDBIcon:ResetButtonHighlightTexture(MapPinEnhanced.name)
    end
end

---@param shown boolean
local function ApplyMinimapButtonVisibility(shown)
    MapPinEnhanced:SetVar("minimapButton", "hide", not shown)
    if shown then
        LibDBIcon:Show(MapPinEnhanced.name)
    else
        LibDBIcon:Hide(MapPinEnhanced.name)
    end
end

local function InitMinimapIcon()
    if init then return end
    local MapPinEnhancedBroker = LibStub("LibDataBroker-1.1"):NewDataObject(MapPinEnhanced.name, {
        type = "launcher",
        text = MapPinEnhanced.name,
        icon = customLogoPath,
        OnClick = function(owner, button)
            if button == "LeftButton" then
                if IsAltKeyDown() then
                    ClearAllPins()
                else
                    Tracker:ToggleTracker()
                end
            elseif button == "RightButton" then
                ShowMinimapMenu(owner)
            end
        end,
    })
    local settings = MapPinEnhanced:GetVar("minimapButton")
    if type(settings) ~= "table" then
        settings = {}
        MapPinEnhanced:SetVar("minimapButton", settings)
    end
    LibDBIcon:Register(MapPinEnhanced.name, MapPinEnhancedBroker, settings)
    LibDBIcon:AddButtonToCompartment(MapPinEnhanced.name, customLogoPath)
    init = true
    -- Subscribe after registration so both the initial value and later changes have a button to style.
    Options:SubscribeToOptionChanges("General.Minimap.CustomButton", ApplyCustomMinimapButton)
    Options:SubscribeToOptionChanges(SHOW_BUTTON_OPTION, ApplyMinimapButtonVisibility)
end

MapPinEnhanced:AddSlashCommand("minimap", function()
    Options:SetOptionValue(SHOW_BUTTON_OPTION, not Options:GetOptionValue(SHOW_BUTTON_OPTION))
end, L["Toggle the minimap button visibility."])

MapPinEnhanced:OnLoad(InitMinimapIcon)
