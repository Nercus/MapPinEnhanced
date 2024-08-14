---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@type table<string, string>
local TEXTURES = {
    ["Icon"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedYellow.png",
    ["PinMask"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinMask.png",
    ["PinHighlight"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinHighlight.png",
    ["PinShadow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinShadow.png",
    ["PinBackground"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinBackground.png",
    ["PinTrackedDarkBlue"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedDarkBlue.png",
    ["PinTrackedGreen"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedGreen.png",
    ["PinTrackedLightBlue"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedLightBlue.png",
    ["PinTrackedOrange"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedOrange.png",
    ["PinTrackedPale"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedPale.png",
    ["PinTrackedPink"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedPink.png",
    ["PinTrackedPurple"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedPurple.png",
    ["PinTrackedRed"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedRed.png",
    ["PinTrackedYellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedYellow.png",
    ["PinTrackedCustom"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedCustom.png",
    ["PinUntrackedDarkBlue"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedDarkBlue.png",
    ["PinUntrackedGreen"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedGreen.png",
    ["PinUntrackedLightBlue"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedLightBlue.png",
    ["PinUntrackedOrange"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedOrange.png",
    ["PinUntrackedPale"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedPale.png",
    ["PinUntrackedPink"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedPink.png",
    ["PinUntrackedPurple"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedPurple.png",
    ["PinUntrackedRed"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedRed.png",
    ["PinUntrackedYellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedYellow.png",
    ["PinUntrackedCustom"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedCustom.png",
}

---@type table<string, any>
local ATLAS = {}

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
