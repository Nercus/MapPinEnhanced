---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinMenuMixin = {}

local L = MapPinEnhanced.L

local MENU_COLOR_BUTTON_PATTERN =
"|TInterface\\AddOns\\MapPinEnhanced\\assets\\forms\\colorpicker\\body.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t"
local MENU_ICON_BUTTON_PATTERN = "|A:%s:19:19|a"


local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME
local PIN_ICONS = Pins.PIN_ICONS
local PIN_ICON_MENU_COLUMNS = 3


---@param parent MapPinEnhancedWorldmapPinTemplate |MapPinEnhancedTrackerPinEntryTemplate
function MapPinEnhancedPinMenuMixin:ShowMenu(parent)
    local menu = {
        {
            type = "title",
            label = self.pinData.title,
        },
        {
            type = "divider",
        },
        {
            type = "submenu",
            entries = function()
                local colorMenu = {}
                for colorName, colorData in pairs(PIN_COLORS_BY_NAME) do
                    local label = string.format(MENU_COLOR_BUTTON_PATTERN, colorData:GetRGBAsBytes())
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
                    table.insert(iconMenu, {
                        type = "radio",
                        label = string.format(MENU_ICON_BUTTON_PATTERN, icon.path),
                        isSelected = function()
                            return self.pinData.texture == icon.path
                        end,
                        setSelected = function()
                            self:SetIcon(icon.path, icon.usesAtlas, icon.offset, icon.scale)
                        end,
                        data = icon
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
    MapPinEnhanced:GenerateMenu(parent, menu)
end
