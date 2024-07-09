---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@type table<string, string>
local TEXTURES = {
    ["Icon"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTrackedYellow.png",
    ["PinMask"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinMask.png",
    ["PinHighlight"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinHighlight.png",
    ["PinShadow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinShadow.png",
    ["PinBackground"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinBackground.png",
    ["PinTrackedDarkBlue"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTrackedDarkBlue.png",
    ["PinTrackedGreen"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTrackedGreen.png",
    ["PinTrackedLightBlue"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTrackedLightBlue.png",
    ["PinTrackedOrange"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTrackedOrange.png",
    ["PinTrackedPale"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTrackedPale.png",
    ["PinTrackedPink"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTrackedPink.png",
    ["PinTrackedPurple"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTrackedPurple.png",
    ["PinTrackedRed"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTrackedRed.png",
    ["PinTrackedYellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTrackedYellow.png",
    ["PinTrackedCustom"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinTrackedCustom.png",
    ["PinUntrackedDarkBlue"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinUntrackedDarkBlue.png",
    ["PinUntrackedGreen"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinUntrackedGreen.png",
    ["PinUntrackedLightBlue"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinUntrackedLightBlue.png",
    ["PinUntrackedOrange"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinUntrackedOrange.png",
    ["PinUntrackedPale"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinUntrackedPale.png",
    ["PinUntrackedPink"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinUntrackedPink.png",
    ["PinUntrackedPurple"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinUntrackedPurple.png",
    ["PinUntrackedRed"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinUntrackedRed.png",
    ["PinUntrackedYellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinUntrackedYellow.png",
    ["PinUntrackedCustom"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\PinUntrackedCustom.png",
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
