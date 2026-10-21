---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local MORE_ICON_PATH = MapPinEnhanced.basePath .. "\\assets\\icons\\IconEllipsis.png"

---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")
local Transfer = MapPinEnhanced:GetModule("Transfer")

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinMenuMixin = {}

local L = MapPinEnhanced.L

local MENU_COLOR_BUTTON_PATTERN = "|T%s\\assets\\shared\\ColorpickerBody.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t"

local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME
local PIN_ICON_MENU_ICONS = Pins.PIN_ICON_MENU_ICONS
local PIN_ICON_MENU_COLUMNS = 4
local PIN_ICON_MENU_ENTRY_SIZE = 36

---@param colorName PinColor
---@return string
function Pins:GetColorMenuLabel(colorName)
    local color = assert(PIN_COLORS_BY_NAME[colorName], "Pins:GetColorMenuLabel: unknown color " .. tostring(colorName))
    return string.format(MENU_COLOR_BUTTON_PATTERN, MapPinEnhanced.basePath, color:GetRGBAsBytes())
end

-- The menu owns presentation; callers retain live-pin or archived-pin mutations.
---@param owner table Identity used to refresh the icon radio cells
---@param getData fun(): pinData|SaveablePinData
---@param setColor fun(color: PinColor)
---@param setIcon fun(icon: string|number, usesAtlas: boolean)
---@return AnyMenuEntry[]
function Pins:BuildPinStyleMenuEntries(owner, getData, setColor, setIcon)
    return {
        {
            type = "submenu",
            entries = function()
                local colorMenu = {}
                for colorName in pairs(PIN_COLORS_BY_NAME) do
                    local label = Pins:GetColorMenuLabel(colorName)
                    table.insert(colorMenu, {
                        type = "radio",
                        label = label,
                        style = "custom",
                        isSelected = function()
                            return getData().color == colorName
                        end,
                        setSelected = function()
                            setColor(colorName)
                        end,
                        data = colorName
                    })
                end
                return colorMenu
            end,
            entry = {
                type = "button",
                label = MapPinEnhanced:Iconize("palette", L["Change Color"]),
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
                            owner = owner,
                            icon = { path = Pins.PIN_ICONS[iconData].icon, usesAtlas = false },
                            isSelected = function()
                                return Pins:ResolveIcon(getData().texture) == iconData
                            end,
                            onClick = function()
                                setIcon(iconData, true)
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
                        local data = getData()
                        local currentIcon = not data.usesAtlas and data.texture or nil
                        MapPinEnhanced:ShowIconPicker(currentIcon, function(path)
                            setIcon(path, false)
                        end)
                    end,
                    initializer = function(button, _, menu)
                        ---@type Texture
                        local texture = button:AttachTexture()
                        texture:SetSize(18, 18)
                        texture:SetPoint("CENTER")
                        texture:SetTexture(MORE_ICON_PATH)
                        texture:SetVertexColor(1, 0.82, 0)
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
    }
end

---@return AnyMenuEntry[]
function MapPinEnhancedPinMenuMixin:BuildPinMenuEntries()
    local styleEntries = Pins:BuildPinStyleMenuEntries(self,
        function() return self:GetPinData() end,
        function(color) self:SetColor(color) end,
        function(icon, usesAtlas) self:SetIcon(icon, usesAtlas) end)
    local title = self.pinData.title or L["Map Pin"]
    local entries = {
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
        styleEntries[1],
        styleEntries[2],
        {
            type = "button",
            label = MapPinEnhanced:Iconize("map", MapPinEnhanced.L["Show on Map"]),
            onClick = function()
                self:ShowOnMap()
            end
        },
        {
            type = "button",
            label = MapPinEnhanced:Iconize("share", MapPinEnhanced.L["Share to Chat"]),
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
            label = MapPinEnhanced:Iconize("trash", L["Clear Pin"]),
            onClick = function()
                self.group:ClearPin(self.pinID)
            end
        }
    }
    if self:IsLocked() or MapPinEnhanced:GetModule("Options"):GetOptionValue("Pins.Miscellaneous.EnableLockedPins") then
        table.insert(entries, #entries - 1, {
            type = "button",
            label = MapPinEnhanced:Iconize(self:IsLocked() and "unlock" or "lock",
                self:IsLocked() and L["Unlock Pin"] or L["Lock Pin"]),
            onClick = function() self:ToggleLock() end,
        })
    end
    return entries
end

---@param parent MapPinEnhancedWorldmapPinTemplate |MapPinEnhancedTrackerPinEntryTemplate
function MapPinEnhancedPinMenuMixin:ShowMenu(parent)
    local menu = self:BuildPinMenuEntries()
    MapPinEnhanced:GenerateMenu(parent, menu)
end
