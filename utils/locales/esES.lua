---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "esES" and LOCALE ~= "esMX" then return end



---@type Locale
local L = {
    ["Congratulations"] = "Enhorabuena",
    ["Excuse me"] = "Perdón",
    ["Goodbye!"] = "¡Adiós!",
    ["Goodbye"] = "Adiós",
    ["Hello!"] = "¡Hola!",
    ["Help"] = "Ayuda",
    ["No"] = "No",
    ["Please"] = "Por favor",
    ["Sorry"] = "Lo siento",
    ["Thank you"] = "Gracias",
    ["Welcome"] = "Bienvenido",
    ["World"] = "Mundo",
    ["Yes"] = "Sí",
}

MapPinEnhanced.L = L
