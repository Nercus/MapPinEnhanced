---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedIconMixin : Texture
---@field icon MapPinEnhancedIcon
---@field iconColor ColorMixin?
---@field iconDisabled boolean?
MapPinEnhancedIconMixin = {}

local DEFAULT_INLINE_ICON_SIZE = 16
local DEFAULT_ICON_COLOR = CreateColor(1, 0.82, 0)

---@enum (key) MapPinEnhancedIcon
local ICON_TEXTURES = {
    arrowcircle = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconArrowCircle.png",
    arrowdown = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconArrowDown.png",
    arrowleft = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconArrowLeft.png",
    arrowleftright = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconArrowLeftRight.png",
    arrowright = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconArrowRight.png",
    arrowup = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconArrowUp.png",
    close = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconClose.png",
    drag = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconDrag.png",
    duplicate = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconDuplicate.png",
    edit = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEdit.png",
    export = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconExport.png",
    eye = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEye.png",
    eyeslash = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEyeSlash.png",
    import = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconImport.png",
    list = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconList.png",
    lock = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconLock.png",
    map = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconMap.png",
    minus = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconMinus.png",
    more = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEllipsis.png",
    palette = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconPalette.png",
    pin = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconPinLogo.png",
    plus = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconPlus.png",
    rightcaret = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconRightCaret.png",
    route = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconRoute.png",
    search = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSearch.png",
    settings = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSettings.png",
    share = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconShare.png",
    tick = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconCheckMark.png",
    trash = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconDelete.png",
    unlock = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconUnlock.png",
}

---Create text prefixed with a registered inline icon.
---@param icon MapPinEnhancedIcon
---@param text? string
---@param size? integer
---@param color? ColorMixin RGB tint; defaults to gold.
---@return string
function MapPinEnhanced:Iconize(icon, text, size, color)
    local texturePath = assert(ICON_TEXTURES[icon], "MapPinEnhanced:Iconize: Invalid icon name: " .. tostring(icon))
    assert(text == nil or type(text) == "string", "MapPinEnhanced:Iconize: text must be a string or nil")
    assert(size == nil or (type(size) == "number" and size > 0 and size % 1 == 0),
        "MapPinEnhanced:Iconize: size must be a positive integer or nil")

    local r, g, b = (color or DEFAULT_ICON_COLOR):GetRGBAsBytes()
    -- Full texture coordinates keep the tint local to the icon, leaving label colors intact.
    local iconText = string.format("|T%s:%d:%d:0:0:1:1:0:1:0:1:%d:%d:%d|t", texturePath,
        size or DEFAULT_INLINE_ICON_SIZE, size or DEFAULT_INLINE_ICON_SIZE, r, g, b)
    return text and text ~= "" and string.format("%s %s", iconText, text) or iconText
end

---@param icon? MapPinEnhancedIcon
---@param color? ColorMixin RGB tint; omitted colors reset to gold.
function MapPinEnhancedIconMixin:SetIconTexture(icon, color)
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
    self.iconColor = color
    self:SetIconEnabled(not self.iconDisabled)
end

---@param enabled boolean
function MapPinEnhancedIconMixin:SetIconEnabled(enabled)
    self.iconDisabled = not enabled
    self:SetDesaturated(not enabled)
    if enabled then
        self:SetVertexColor((self.iconColor or DEFAULT_ICON_COLOR):GetRGB())
    else
        self:SetVertexColor(0.5, 0.5, 0.5)
    end
end

function MapPinEnhancedIconMixin:OnLoad()
    -- only run on load when the icon is set as a keyvalue
    if not self.icon then return end
    self:SetIconTexture()
end
