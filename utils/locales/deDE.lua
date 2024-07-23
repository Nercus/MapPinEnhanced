---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "deDE" then return end


---@type Locale
local L = {
    ["Congratulations"] = "Glückwunsch",
    ["Excuse me"] = "Entschuldigung",
    ["Goodbye!"] = "Auf Wiedersehen",
    ["Goodbye"] = "Auf Wiedersehen",
    ["Hello!"] = "Test",
    ["Help"] = "Hilfe",
    ["No"] = "Nein",
    ["Please"] = "Bitte",
    ["Sorry"] = "Entschuldigung",
    ["Thank you"] = "Danke",
    ["Welcome"] = "Willkommen",
    ["World"] = "Welt",
    ["Yes"] = "Ja",
}

MapPinEnhanced.L = L
