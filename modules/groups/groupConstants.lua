---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
---@field GROUP_ICON_MENU_ICONS MapPinEnhancedMenuRadioCellIcon[]
local Groups = MapPinEnhanced:GetModule("Groups")

-- Blizzard menu grids populate top-to-bottom, then left-to-right. This order
-- displays the curated categories row-by-row in the four-column icon menu.
Groups.GROUP_ICON_MENU_ICONS = {
    { path = "Interface\\Icons\\inv_12_profession_jewelcrafting_uncommon_gem_cut_blue", usesAtlas = false },
    { path = "Interface\\Icons\\inv_cape_special_treasure_c_01", usesAtlas = false },
    { path = "Interface\\Icons\\achievement_arena_2v2_3", usesAtlas = false },
    { path = "Interface\\Icons\\inv_archaeology_80_witch_book", usesAtlas = false },
    { path = "Interface\\Icons\\inv_12_profession_jewelcrafting_uncommon_gem_cut_green", usesAtlas = false },
    { path = "Interface\\Icons\\inv_misc_bag_09", usesAtlas = false },
    { path = "Interface\\Icons\\achievement_reputation_01", usesAtlas = false },
    { path = "Interface\\Icons\\inv_ability_skyriding_glyph", usesAtlas = false },
    { path = "Interface\\Icons\\inv_12_profession_jewelcrafting_uncommon_gem_cut_red", usesAtlas = false },
    { path = "Interface\\Icons\\inv_misc_coin_02", usesAtlas = false },
    { path = "Interface\\Icons\\achievement_worldevent_brewmaster", usesAtlas = false },
    { path = "Interface\\Icons\\tracking_warboard", usesAtlas = false },
    { path = "Interface\\Icons\\inv_12_profession_jewelcrafting_uncommon_gem_cut_purple", usesAtlas = false },
    { path = "Interface\\Icons\\inv_helm_armor_sugarskull_c_01", usesAtlas = false },
    { path = "Interface\\Icons\\achievement_guildperk_mrpopularity", usesAtlas = false },
}
