---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "frFR" then return end


---@type Locale
local L = {
    ["Congratulations"] = "Félicitations",
    ["Excuse me"] = "Excusez-moi",
    ["Goodbye!"] = "Au revoir!",
    ["Goodbye"] = "Au revoir",
    ["Hello!"] = "Bonjour!",
    ["Help"] = "Aide",
    ["No"] = "Non",
    ["Please"] = "S'il vous plaît",
    ["Sorry"] = "Désolé",
    ["Thank you"] = "Merci",
    ["Welcome"] = "Bienvenue",
    ["World"] = "Monde",
    ["Yes"] = "Oui",
}

MapPinEnhanced.L = L
