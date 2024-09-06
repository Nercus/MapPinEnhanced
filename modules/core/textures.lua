---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Textures
local Textures = MapPinEnhanced:GetModule("Textures")


---@enum (key) MapPinEnhancedTextures
local TEXTURES = {
    ["Icon"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedYellow.png",
    ["IconCross_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconCross_Dark.png",
    ["IconCross_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconCross_Yellow.png",
    ["IconDuplicate_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconDuplicate_Dark.png",
    ["IconDuplicate_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconDuplicate_Yellow.png",
    ["IconEdit_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEdit_Dark.png",
    ["IconEdit_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEdit_Yellow.png",
    ["IconEditor_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEditor_Dark.png",
    ["IconEditor_Yellow_Grey"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEditor_Yellow_Grey.png",
    ["IconEditor_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconEditor_Yellow.png",
    ["IconExport_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconExport_Dark.png",
    ["IconExport_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconExport_Yellow.png",
    ["IconImport_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconImport_Dark.png",
    ["IconImport_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconImport_Yellow.png",
    ["IconLock_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconLock_Dark.png",
    ["IconLock_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconLock_Yellow.png",
    ["IconMap_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconMap_Dark.png",
    ["IconMap_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconMap_Yellow.png",
    ["IconPIn_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconPIn_Dark.png",
    ["IconPIn_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconPIn_Yellow.png",
    ["IconPlus_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconPlus_Dark.png",
    ["IconPlus_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconPlus_Yellow.png",
    ["IconSearch_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSearch_Dark.png",
    ["IconSearch_Yellow_Grey"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSearch_Yellow_Grey.png",
    ["IconSearch_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSearch_Yellow.png",
    ["IconSets_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSets_Dark.png",
    ["IconSets_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSets_Yellow.png",
    ["IconSettings_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSettings_Dark.png",
    ["IconSettings_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconSettings_Yellow.png",
    ["IconTick_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconTick_Dark.png",
    ["IconTick_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconTick_Yellow.png",
    ["IconTrash_Dark"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconTrash_Dark.png",
    ["IconTrash_Yellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\icons\\IconTrash_Yellow.png",
    ["PinBackground"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinBackground.png",
    ["PinHighlight"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinHighlight.png",
    ["PinMask"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinMask.png",
    ["PinShadow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinShadow.png",
    ["PinTrackedCustom"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedCustom.png",
    ["PinTrackedDarkBlue"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedDarkBlue.png",
    ["PinTrackedGreen"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedGreen.png",
    ["PinTrackedLightBlue"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedLightBlue.png",
    ["PinTrackedOrange"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedOrange.png",
    ["PinTrackedPale"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedPale.png",
    ["PinTrackedPink"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedPink.png",
    ["PinTrackedPurple"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedPurple.png",
    ["PinTrackedRed"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedRed.png",
    ["PinTrackedYellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinTrackedYellow.png",
    ["PinUntrackedCustom"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedCustom.png",
    ["PinUntrackedDarkBlue"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedDarkBlue.png",
    ["PinUntrackedGreen"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedGreen.png",
    ["PinUntrackedLightBlue"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedLightBlue.png",
    ["PinUntrackedOrange"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedOrange.png",
    ["PinUntrackedPale"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedPale.png",
    ["PinUntrackedPink"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedPink.png",
    ["PinUntrackedPurple"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedPurple.png",
    ["PinUntrackedRed"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedRed.png",
    ["PinUntrackedYellow"] = "Interface\\AddOns\\MapPinEnhanced\\assets\\pins\\PinUntrackedYellow.png",
}

---Get the texture path for a texture. If the texture is not found, an error is thrown.
---@param textureName MapPinEnhancedTextures
---@return string
function Textures:GetTexture(textureName)
    assert(TEXTURES[textureName], "Texture not found: " .. textureName)
    return TEXTURES[textureName]
end
