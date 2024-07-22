---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "ptBR" then return end


---@type Locale
local L = {
    ["Congratulations"] = "Parabéns",
    ["Excuse me"] = "Com licença",
    ["Goodbye!"] = "Tchau!",
    ["Goodbye"] = "Tchau",
    ["Hello!"] = "Olá!",
    ["Help"] = "Ajuda",
    ["No"] = "Não",
    ["Please"] = "Por favor",
    ["Sorry"] = "Desculpe",
    ["Thank you"] = "Obrigado",
    ["Welcome"] = "Bem-vindo",
    ["World"] = "Mundo",
    ["Yes"] = "Sim",
}

MapPinEnhanced.L = L
