---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "itIT" then return end


---@type Locale
local L = {
    ["Congratulations"] = "Congratulazioni",
    ["Excuse me"] = "Scusami",
    ["Goodbye!"] = "Arrivederci!",
    ["Goodbye"] = "Arrivederci",
    ["Hello!"] = "Ciao!",
    ["Help"] = "Aiuto",
    ["No"] = "No",
    ["Please"] = "Per favore",
    ["Sorry"] = "Scusa",
    ["Thank you"] = "Grazie",
    ["Welcome"] = "Benvenuto",
    ["World"] = "Mondo",
    ["Yes"] = "Sì",
}

MapPinEnhanced.L = L
