---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "ruRU" then return end


---@type Locale
local L = {
    ["Congratulations"] = "Поздравляю",
    ["Excuse me"] = "Извините",
    ["Goodbye!"] = "До свидания!",
    ["Goodbye"] = "До свидания",
    ["Hello!"] = "Привет!",
    ["Help"] = "Помощь",
    ["No"] = "Нет",
    ["Please"] = "Пожалуйста",
    ["Sorry"] = "Извините",
    ["Thank you"] = "Спасибо",
    ["Welcome"] = "Добро пожаловать",
    ["World"] = "Мир",
    ["Yes"] = "Да",
}

MapPinEnhanced.L = L
