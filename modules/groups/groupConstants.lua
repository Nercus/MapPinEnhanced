---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
---@field GROUP_ICON_MENU_ICONS MapPinEnhancedMenuRadioCellIcon[]
local Groups = MapPinEnhanced:GetModule("Groups")

-- Blizzard menu grids populate top-to-bottom, then left-to-right. This order
-- displays the curated categories row-by-row in the four-column icon menu.
Groups.GROUP_ICON_MENU_ICONS = {
    { path = "Interface\\Icons\\Ability_DualWield",         usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_Coin_01",          usesAtlas = false },
    { path = "Interface\\Icons\\Trade_BlackSmithing",       usesAtlas = false },
    { path = "Interface\\Icons\\INV_Pick_02",               usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_Note_01",          usesAtlas = false },
    { path = "Interface\\Icons\\Ability_Mount_Wyvern_01",   usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_Herb_07",          usesAtlas = false },
    { path = "Interface\\Icons\\inv_misc_treasurechest01b", usesAtlas = false },
    { path = "Interface\\Icons\\Ability_Mount_Gryphon_01",  usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_Fish_02",          usesAtlas = false },
    { path = "Interface\\Icons\\INV_Drink_05",              usesAtlas = false },
}
