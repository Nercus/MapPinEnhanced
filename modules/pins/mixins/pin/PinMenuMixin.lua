---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinMenuMixin = {}

local L = MapPinEnhanced.L

local MENU_COLOR_BUTTON_PATTERN =
"|TInterface\\AddOns\\MapPinEnhanced\\assets\\forms\\colorpicker\\body.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t"
local PIN_COLORS_BY_NAME = {
    ["Yellow"] = CreateColorFromBytes(237, 179, 20, 1),
    ["Green"] = CreateColorFromBytes(96, 236, 29, 1),
    ["LightBlue"] = CreateColorFromBytes(132, 196, 237, 1),
    ["DarkBlue"] = CreateColorFromBytes(42, 93, 237, 1),
    ["Purple"] = CreateColorFromBytes(190, 139, 237, 1),
    ["Pink"] = CreateColorFromBytes(251, 109, 197, 1),
    ["Red"] = CreateColorFromBytes(235, 15, 14, 1),
    ["Orange"] = CreateColorFromBytes(237, 114, 63, 1),
    ["Pale"] = CreateColorFromBytes(235, 183, 139, 1),
}


local MENU_ICON_BUTTON_PATTERN = "|A:%s:19:19|a"
local PIN_ICONS = {
    "poi-bountyplayer-alliance",
    "poi-bountyplayer-horde",
    "Auctioneer",
    "Banker",
    "Map-MarkedDefeated",
    "Tormentors-Boss",
    "QuestNormal",
    "QuestTurnin",
    "DungeonSkull"
}
local PIN_ICON_MENU_COLUMNS = Round(math.sqrt(#PIN_ICONS) - 0.5)


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
                        isSelected = function()
                            return self:PinHasColor(colorName)
                        end,
                        setSelected = function()
                            self:SetPinColor(colorName)
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
                for _, icon in ipairs(PIN_ICONS) do
                    table.insert(iconMenu, {
                        type = "radio",
                        label = string.format(MENU_ICON_BUTTON_PATTERN, icon),
                        isSelected = function()
                            return self.pinData.texture == icon
                        end,
                        setSelected = function()
                            self:SetPinIcon(icon, true)
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
