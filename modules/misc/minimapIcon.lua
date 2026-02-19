---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LibDBIcon = MapPinEnhanced.LDBIcon

local init = false
local logoPath = "Interface\\Addons\\MapPinEnhanced\\assets\\logo_transparent.png"
local function InitMinimapIcon()
    if init then return end
    local MapPinEnhancedBroker = LibStub("LibDataBroker-1.1"):NewDataObject(MapPinEnhanced.name, {
        type = "launcher",
        text = MapPinEnhanced.name,
        icon = logoPath,
        OnClick = function(owner, button)
            if button == "LeftButton" then
                MapPinEnhanced:Debug("Left Clicked")
            elseif button == "RightButton" then
                MapPinEnhanced:Debug("Right Click")
            end
        end,
    })
    -- TODO: add option to not style it
    LibDBIcon:Register(MapPinEnhanced.name, MapPinEnhancedBroker, MapPinEnhancedDB.minimapButton)
    LibDBIcon:RemoveButtonBorder(MapPinEnhanced.name)
    LibDBIcon:RemoveButtonBackground(MapPinEnhanced.name)
    LibDBIcon:SetButtonIcon(MapPinEnhanced.name, logoPath, 42, "CENTER", 0, 0)
    LibDBIcon:SetButtonHighlightTexture(MapPinEnhanced.name, "shop-toast-siderays")
    LibDBIcon:AddButtonToCompartment(MapPinEnhanced.name, logoPath)
    init = true
end


MapPinEnhanced:OnLoad(InitMinimapIcon)
