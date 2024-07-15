---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


-- *** Using Phanx's method to localize strings ***
-- You can find the original code here: https://phanx.net/addons/tutorials/localize
local L = setmetatable({}, {
    __index = function(t, k)
        local v = tostring(k)
        rawset(t, k, v)
        return v
    end
})

MapPinEnhanced.L = L

local LOCALE = GetLocale()

if LOCALE == "enUS" then
    -- The EU English game client also
    -- uses the US English locale code.
    return
end

if LOCALE == "deDE" then
    -- German translations go here
    L["Hello!"] = "Hallo!"
    return
end

if LOCALE == "frFR" then
    -- French translations go here
    L["Hello!"] = "Bonjour!"
    return
end

if LOCALE == "esES" or LOCALE == "esMX" then
    -- Spanish translations go here
    L["Hello!"] = "¡Hola!"
    return
end

if LOCALE == "ptBR" then
    -- Brazilian Portuguese translations go here
    L["Hello!"] = "Olá!"
    -- Note that the EU Portuguese WoW client also
    -- uses the Brazilian Portuguese locale code.
    return
end

if LOCALE == "ruRU" then
    -- Russian translations go here
    L["Hello!"] = "Привет!"
    return
end

if LOCALE == "koKR" then
    -- Korean translations go here
    L["Hello!"] = "안녕하세요!"
    return
end

if LOCALE == "zhCN" then
    -- Simplified Chinese translations go here
    L["Hello!"] = "您好!"
    return
end

if LOCALE == "zhTW" then
    -- Traditional Chinese translations go here
    L["Hello!"] = "您好!"
    return
end
