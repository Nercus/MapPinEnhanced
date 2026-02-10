---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinMenuMixin = {}

local L = MapPinEnhanced.L

local MENU_COLOR_BUTTON_PATTERN = string.format(
    "|T%s\\assets\\forms\\colorpicker\\body.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t", MapPinEnhanced.basePath
)

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
                        type = "template",
                        template = "MapPinEnhancedPinMenuIconButton",
                        data = icon,
                        ---@type MenuDescriptionInitializer
                        initializer = function(frame, description, menu)
                            menu.minimumElementWidth = 20
                            --[[@cast frame CheckButton]]
                            ---@type PinIcon
                            local data = description:GetData()
                            if not data or not data.path then
                                return
                            end
                            local selected = self.pinData.texture == data.path
                            if selected then
                                ---@diagnostic disable-next-line: undefined-field
                                frame.selected:Show()
                            else
                                ---@diagnostic disable-next-line: undefined-field
                                frame.selected:Hide()
                            end

                            description:SetResponder(function()
                                return MenuResponse.Close;
                            end)
                            frame:SetScript("OnClick", function()
                                self:SetIcon(data.path, data.usesAtlas, data.offset, data.scale)
                                description:Pick(MenuInputContext.MouseButton, "LeftButton")
                                PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
                            end)

                            ---@diagnostic disable-next-line: undefined-field, no-unknown
                            local icon = frame.icon
                            icon:SetPoint("CENTER", 0, 0)
                            if data.usesAtlas then
                                icon:SetAtlas(data.path)
                            else
                                icon:SetTexture(data.path)
                            end
                            if data.scale then
                                icon:SetSize(20 * data.scale, 20 * data.scale)
                            else
                                icon:SetSize(20, 20)
                            end
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
    MapPinEnhanced:GenerateMenu(parent, menu)
end
