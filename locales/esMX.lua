---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

if MapPinEnhanced.locale ~= "esMX" then return end

---@class Locale
local L = MapPinEnhanced.L
-- Share the existing Spanish translations with esES.
--@localization(locale="esES", format="lua_additive_table")@
