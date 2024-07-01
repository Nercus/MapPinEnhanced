---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@type table<string, string>
local TEXTURES = {
    ["Icon"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTracked.blp",
    ["TrackedPin"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTracked.blp",
    ["UntrackedPin"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\nocolour.blp",
    ["PinHighlight"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinHighlight.blp",
}

---@type table<string, any>
local ATLAS = {
    ["shadowBox"] = { "atlasTextureFile", 47, 413, 0.09765625, 0.904296875, 0.0341796875, 0.080078125, false, false }, --Note: This is a test value
}

---Get the texture path for a texture. If the texture is not found, an error is thrown.
---@param textureName string
---@return string | nil
function MapPinEnhanced:GetTexture(textureName)
    if (TEXTURES[textureName]) then
        return TEXTURES[textureName]
    end
    assert(false, "Texture not found: " .. textureName)
end

---Use the custom atlas system to apply a custom texture file to a texture.
---@param texture Texture
---@param atlasName string
function MapPinEnhanced:ApplyCustomAtlasToTexture(texture, atlasName)
    local atlasData = ATLAS[atlasName]
    local texturePath = self:GetTexture(atlasData[1])
    texture:SetSize(atlasData[3], atlasData[2])
    texture:SetTexture(texturePath)
    texture:SetTexCoord(atlasData[4], atlasData[5], atlasData[6], atlasData[7])
end
