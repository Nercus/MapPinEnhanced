---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "zhCN" then return end

---@class Locale
local L = MapPinEnhanced.L

------------------------------ Dialogs ------------------------------
L["Special thanks to Byyrax and Pamoo for the help with translations"] =
"特别感谢 Byyrax 和 Pamoo 在翻译方面提供的帮助"
