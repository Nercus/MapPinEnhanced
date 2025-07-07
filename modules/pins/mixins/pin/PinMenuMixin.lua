---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinMenuMixin = {}

local L = MapPinEnhanced.L

local MENU_COLOR_BUTTON_PATTERN =
"|TInterface\\AddOns\\MapPinEnhanced\\assets\\forms\\ColourPicker_Body.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t"
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

---@param parent MapPinEnhancedWorldmapPinTemplate -- TODO: complete the annotation with the tracker entry
function MapPinEnhancedPinMenuMixin:ShowMenu(parent)
    local menu = {
        {
            type = "title",
            label = self.pinData.title,
        },
        {
            type = "divider",
        }
    }

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
        table.insert(menu, {
            type = "submenu",
            label = L["Change Color"],
            submenu = colorMenu
        })
    end

    table.insert(menu, {
        type = "button",
        label = MapPinEnhanced.L["Show on Map"],
        onClick = function()
            self:ShowOnMap()
        end
    })

    table.insert(menu, {
        type = "button",
        label = MapPinEnhanced.L["Share to Chat"],
        onClick = function()
            self:SharePin()
        end
    })

    MapPinEnhanced:GenerateMenu(parent, menu)
end
