---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "ptBR" then return end

---@class Locale
local L = MapPinEnhanced.L

------------------------------ Dialogs ------------------------------
L["Special thanks to Byyrax and Pamoo for the help with translations"] =
"Agradecimentos especiais a Byyrax e Pamoo pela ajuda com as traduções"
