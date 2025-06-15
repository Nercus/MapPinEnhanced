---@class GuildBankLayouts : NercUtilsAddon
local GuildBankLayouts = LibStub("NercUtils"):GetAddon(...)

---@class MapPinEnhancedThemeableMixin
---@field textures table<AVAILABLE_THEMES, table<Texture, table<string, string>>>
MapPinEnhancedThemeableMixin = {}

local Theme = GuildBankLayouts:GetModule("Theme")

---@enum (key) AVAILABLE_THEMES
local AVAILABLE_THEMES = {
    Default = {},
    ElvUI = {}
}


function MapPinEnhancedThemeableMixin:UpdateAllRegions()
    if not self.textures then return end
    local theme = Theme:GetActiveTheme()
    if not self.textures[theme] then return end

    for region, textures in pairs(self.textures[theme]) do
        for textureKey, _ in pairs(textures) do
            self:SetTextureForRegion(region, textureKey)
        end
    end
end

---Get the defined texture for the currently active theme
---@param region Texture
---@param textureKey string
---@return string? texture
function MapPinEnhancedThemeableMixin:GetTextureForRegion(region, textureKey)
    local theme = Theme:GetActiveTheme()
    if not self.textures or not self.textures[theme] or not self.textures[theme][region] then
        return
    end
    return self.textures[theme][region][textureKey]
end

---Set the defined texture for the currently active theme
---@param region Texture
---@param textureKey string
function MapPinEnhancedThemeableMixin:SetTextureForRegion(region, textureKey)
    local texture = self:GetTextureForRegion(region, textureKey)
    if not texture then return end
    region:SetTexture(texture)
end

---Define an element to be a themeable region and set its texture for the theme
---@param region Texture
---@param textureKey string
---@param texture string
---@param theme AVAILABLE_THEMES
function MapPinEnhancedThemeableMixin:DefineTexture(region, textureKey, texture, theme)
    assert(AVAILABLE_THEMES[theme], "Theme not found: " .. theme)
    if not self.textures then
        self.textures = {}
    end
    if not self.textures[theme] then
        self.textures[theme] = {}
    end
    if not self.textures[theme][region] then
        self.textures[theme][region] = {}
    end
    self.textures[theme][region][textureKey] = texture
    self:SetTextureForRegion(region, textureKey)


    if not self.themeChangeHooked then
        Theme:OnThemeChanged(function()
            self:UpdateAllRegions()
        end)
        self.themeChangeHooked = true
    end
end
