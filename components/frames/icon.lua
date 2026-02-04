---@class MapPinEnhancedIconMixin : Texture
---@field icon MapPinEnhancedIcon
MapPinEnhancedIconMixin = {}

---@enum (key) MapPinEnhancedIcon
local ICON_TEXTURES = {
    cross = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconCross_Yellow.png",
    duplicate = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconDuplicate_Yellow.png",
    edit = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEdit_Yellow.png",
    editor = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEditor_Yellow.png",
    export = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconExport_Yellow.png",
    import = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconImport_Yellow.png",
    lock = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconLock_Yellow.png",
    map = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconMap_Yellow.png",
    plus = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconPlus_Yellow.png",
    search = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSearch_Yellow.png",
    sets = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSets_Yellow.png",
    settings = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSettings_Yellow.png",
    tick = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconTick_Yellow.png",
    trash = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconTrash_Yellow.png",
}

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
