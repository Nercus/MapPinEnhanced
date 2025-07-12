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
    { icon = "poi-bountyplayer-alliance", label = "Bounty Player (Alliance)" },
    { icon = "poi-bountyplayer-horde",    label = "Bounty Player (Horde)" },
    { icon = "poi-door-down",             label = "Door (Down)" },
    { icon = "poi-door-left",             label = "Door (Left)" },
    { icon = "poi-door-right",            label = "Door (Right)" },
    { icon = "poi-door-up",               label = "Door (Up)" },
    { icon = "poi-door",                  label = "Door" },
    { icon = "poi-graveyard-neutral",     label = "Graveyard" },
    { icon = "poi-horde",                 label = "Horde" },
    { icon = "poi-islands-table",         label = "Islands Table" },
    { icon = "poi-majorcity",             label = "Major City" },
    { icon = "poi-rift1",                 label = "Rift 1" },
    { icon = "poi-rift2",                 label = "Rift 2" },
    { icon = "poi-scrapper",              label = "Scrapper" },
    { icon = "poi-town",                  label = "Town" },
    { icon = "poi-transmogrifier",        label = "Transmogrifier" },
    { icon = "poi-workorders",            label = "Work Orders" },
}
local PIN_ICON_MENU_COLUMNS = Round(math.sqrt(#PIN_ICONS) + 0.5)



---@param parent MapPinEnhancedWorldmapPinTemplate -- TODO: complete the annotation with the tracker entry
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
                if self.pinData.color ~= "Custom" then
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
                end
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
                for _, iconName in ipairs(PIN_ICONS) do
                    table.insert(iconMenu, {
                        type = "radio",
                        label = string.format(MENU_ICON_BUTTON_PATTERN, iconName.icon),
                        isSelected = function()
                            return self.pinData.texture == iconName
                        end,
                        setSelected = function()
                            self:SetPinIcon(iconName, true)
                        end,
                        data = iconName
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
