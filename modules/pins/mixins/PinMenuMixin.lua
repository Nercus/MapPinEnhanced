---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")
---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinMenuMixin = {}

local L = MapPinEnhanced.L

local MENU_COLOR_BUTTON_PATTERN = "|T%s\\assets\\forms\\colorpicker\\body.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t"

local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME
local PIN_ICONS = Pins.PIN_ICONS
local PIN_ICON_MENU_COLUMNS = 3
local PIN_ICON_MENU_ICON_SIZE = 22
local PIN_ICON_MENU_ENTRY_WIDTH = 32
local PIN_ICON_MENU_ENTRY_HEIGHT = 32


---@param icon PinIcon
---@return string
local function GetIconLabel(icon)
    local size = math.floor((icon.scale or 1) * PIN_ICON_MENU_ICON_SIZE + 0.5)
    if icon.usesAtlas then
        return string.format("|A:%s:%d:%d|a", icon.path, size, size)
    end
    return string.format("|T%s:%d:%d|t", icon.path, size, size)
end

---@return AnyMenuEntry[]
function MapPinEnhancedPinMenuMixin:BuildPinMenuEntries()
    local title = self.pinData.title or L["Map Pin"]
    return {
        {
            type = "template",
            template = "MapPinEnhancedMenuTitleActionTemplate",
            data = {
                label = title,
                icon = "edit",
                onClick = function()
                    Dialogs:ShowRenamePinDialog(self)
                end,
            },
        },
        {
            type = "divider",
        },
        {
            type = "submenu",
            entries = function()
                local colorMenu = {}
                for colorName, colorData in pairs(PIN_COLORS_BY_NAME) do
                    local label = string.format(MENU_COLOR_BUTTON_PATTERN, MapPinEnhanced.basePath,
                        colorData:GetRGBAsBytes())
                    table.insert(colorMenu, {
                        type = "radio",
                        label = label,
                        style = "custom",
                        isSelected = function()
                            return self:HasColor(colorName)
                        end,
                        setSelected = function()
                            self:SetColor(colorName)
                        end,
                        data = colorName
                    })
                end
                return colorMenu
            end,
            entry = {
                type = "button",
                label = L["Change Color"],
            }
        },
        {
            type = "submenu",
            entries = function()
                local iconMenu = {}
                for _, icon in pairs(PIN_ICONS) do
                    local iconData = icon
                    table.insert(iconMenu, {
                        type = "radio",
                        label = GetIconLabel(iconData),
                        isSelected = function()
                            return self.pinData.texture == iconData.path
                        end,
                        setSelected = function()
                            self:SetIcon(iconData.path, iconData.usesAtlas)
                        end,
                        data = iconData,
                        initializer = function(_, _, menu)
                            menu.minimumElementWidth = PIN_ICON_MENU_ENTRY_WIDTH
                            return PIN_ICON_MENU_ENTRY_WIDTH, PIN_ICON_MENU_ENTRY_HEIGHT
                        end
                    })
                end
                return iconMenu
            end,
            entry = {
                type = "button",
                label = L["Change Icon"],
            },
            options = {
                gridModeColumns = PIN_ICON_MENU_COLUMNS
            }
        },
        {
            type = "button",
            label = MapPinEnhanced.L["Show on Map"],
            onClick = function()
                self:ShowOnMap()
            end
        },
        {
            type = "button",
            label = MapPinEnhanced.L["Share to Chat"],
            onClick = function()
                self:SharePin()
            end
        }
    }
end

---@param parent MapPinEnhancedWorldmapPinTemplate |MapPinEnhancedTrackerPinEntryTemplate
function MapPinEnhancedPinMenuMixin:ShowMenu(parent)
    local menu = self:BuildPinMenuEntries()
    MapPinEnhanced:GenerateMenu(parent, menu)
end
