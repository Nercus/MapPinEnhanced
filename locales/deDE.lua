---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "deDE" then return end

---@class Locale
local L = MapPinEnhanced.L
--@localization(locale="deDE", format="lua_additive_table")@
-- If you want to help translate MapPinEnhanced into your language, please go to the following link: https://legacy.curseforge.com/wow/addons/mappinenhanced/localization