---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "zhTW" then return end

---@class Locale
local L = MapPinEnhanced.L

------------------------------ Dialogs ------------------------------
L["Special thanks to Byyrax and Pamoo for the help with translations"] =
"特別感謝 Byyrax 和 Pamoo 在翻譯方面提供的協助"
