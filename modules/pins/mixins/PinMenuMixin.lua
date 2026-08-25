---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local MORE_ICON_PATH = MapPinEnhanced.basePath .. "\\assets\\icons\\IconMore_Yellow.png"

---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")
local Transfer = MapPinEnhanced:GetModule("Transfer")

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinMenuMixin = {}

local L = MapPinEnhanced.L

local MENU_COLOR_BUTTON_PATTERN = "|T%s\\assets\\shared\\ColorpickerBody.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t"

local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME
local PIN_ICON_MENU_ICONS = Pins.PIN_ICON_MENU_ICONS
local PIN_ICON_MENU_COLUMNS = 3
local PIN_ICON_MENU_ENTRY_SIZE = 36

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
                    MapPinEnhanced:ShowRenamePinDialog(self)
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
                -- TODO: Replace the placeholder pin with a color icon.
                label = MapPinEnhanced:Iconize("pin", L["Change Color"]),
            }
        },
        {
            type = "submenu",
            entries = function()
                local iconMenu = {}
                for _, icon in ipairs(PIN_ICON_MENU_ICONS) do
                    local iconData = icon
                    table.insert(iconMenu, {
                        type = "template",
                        template = "MapPinEnhancedMenuRadioCellTemplate",
                        data = {
                            owner = self,
                            icon = iconData,
                            isSelected = function()
                                return self.pinData.texture == iconData.path
                            end,
                            onClick = function()
                                self:SetIcon(iconData.path, iconData.usesAtlas)
                            end,
                        },
                        initializer = function(_, _, menu)
                            menu.minimumElementWidth = PIN_ICON_MENU_ENTRY_SIZE
                            return PIN_ICON_MENU_ENTRY_SIZE, PIN_ICON_MENU_ENTRY_SIZE
                        end
                    })
                end
                table.insert(iconMenu, {
                    type = "button",
                    label = "",
                    onClick = function()
                        local currentIcon = not self.pinData.usesAtlas and self.pinData.texture or nil
                        MapPinEnhanced:ShowIconPicker(currentIcon, function(path)
                            self:SetIcon(path, false)
                        end)
                    end,
                    initializer = function(button, _, menu)
                        local texture = button:AttachTexture()
                        texture:SetSize(18, 6)
                        texture:SetPoint("CENTER")
                        texture:SetTexture(MORE_ICON_PATH)
                        button.fontString:Hide()
                        menu.minimumElementWidth = PIN_ICON_MENU_ENTRY_SIZE
                        return PIN_ICON_MENU_ENTRY_SIZE, PIN_ICON_MENU_ENTRY_SIZE
                    end,
                })
                return iconMenu
            end,
            entry = {
                type = "button",
                label = MapPinEnhanced:Iconize("edit", L["Change Icon"]),
            },
            options = {
                gridModeColumns = PIN_ICON_MENU_COLUMNS
            }
        },
        {
            type = "button",
            label = MapPinEnhanced:Iconize("map", MapPinEnhanced.L["Show on Map"]),
            onClick = function()
                self:ShowOnMap()
            end
        },
        {
            type = "button",
            label = MapPinEnhanced:Iconize("tick", L["Mark Reached"]),
            onClick = function()
                self.group:MarkPinReached(self.pinID)
            end
        },
        {
            type = "button",
            -- TODO: Replace the placeholder pin with a share icon.
            label = MapPinEnhanced:Iconize("pin", MapPinEnhanced.L["Share to Chat"]),
            onClick = function()
                self:SharePin()
            end
        },
        {
            type = "button",
            label = MapPinEnhanced:Iconize("export", L["Export"]),
            onClick = function()
                Transfer:ShowExportWindow(self)
            end
        },
        {
            type = "divider",
        },
        {
            type = "button",
            label = MapPinEnhanced:Iconize("trash", L["Delete Pin"]),
            onClick = function()
                self.group:RemovePin(self.pinID)
            end
        }
    }
end

---@param parent MapPinEnhancedWorldmapPinTemplate |MapPinEnhancedTrackerPinEntryTemplate
function MapPinEnhancedPinMenuMixin:ShowMenu(parent)
    local menu = self:BuildPinMenuEntries()
    MapPinEnhanced:GenerateMenu(parent, menu)
end
