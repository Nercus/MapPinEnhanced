---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedIconMixin : Texture
---@field icon MapPinEnhancedIcon
MapPinEnhancedIconMixin = {}

local DEFAULT_INLINE_ICON_SIZE = 16

---@enum (key) MapPinEnhancedIcon
local ICON_TEXTURES = {
    cross = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconCross_Yellow.png",
    drag = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconDrag_Yellow.png",
    duplicate = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconDuplicate_Yellow.png",
    edit = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEdit_Yellow.png",
    editor = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEditor_Yellow.png",
    export = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconExport_Yellow.png",
    import = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconImport_Yellow.png",
    lock = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconLock_Yellow.png",
    map = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconMap_Yellow.png",
    minus = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconMinus.png",
    more = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconMore_Yellow.png",
    pin = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconPin_Yellow.png",
    plus = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconPlus.png",
    search = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSearch_Yellow.png",
    settings = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSettings_Yellow.png",
    tick = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconTick_Yellow.png",
    trash = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconTrash_Yellow.png",
}

---@type table<MapPinEnhancedIcon, number>
local ICON_ASPECT_RATIOS = {
    more = 3,
}

---Create text prefixed with a registered inline icon.
---@param icon MapPinEnhancedIcon
---@param text? string
---@param size? integer
---@return string
function MapPinEnhanced:Iconize(icon, text, size)
    local texturePath = assert(ICON_TEXTURES[icon], "MapPinEnhanced:Iconize: Invalid icon name: " .. tostring(icon))
    assert(text == nil or type(text) == "string", "MapPinEnhanced:Iconize: text must be a string or nil")
    assert(size == nil or (type(size) == "number" and size > 0 and size % 1 == 0),
        "MapPinEnhanced:Iconize: size must be a positive integer or nil")

    local iconHeight = size or DEFAULT_INLINE_ICON_SIZE
    local iconWidth = iconHeight * (ICON_ASPECT_RATIOS[icon] or 1)
    local iconText = string.format("|T%s:%d:%d|t", texturePath, iconHeight, iconWidth)
    return text and text ~= "" and string.format("%s %s", iconText, text) or iconText
end

---@param icon? MapPinEnhancedIcon
function MapPinEnhancedIconMixin:SetIconTexture(icon)
    if icon then
        -- Allow setting the icon directly if provided
        self.icon = icon
    end
    assert(self.icon, "MapPinEnhancedIconMixin: SetIconTexture called without icon set")
    local texturePath = ICON_TEXTURES[self.icon]
    if not texturePath then
        error("MapPinEnhancedIconMixin: Invalid icon name: " .. tostring(self.icon))
    end
    self:SetTexture(texturePath)
end

function MapPinEnhancedIconMixin:OnLoad()
    -- only run on load when the icon is set as a keyvalue
    if not self.icon then return end
    self:SetIconTexture()
end
