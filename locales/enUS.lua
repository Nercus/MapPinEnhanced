---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "enUS" then return end

---@class Locale : table<string, string>
local L = {
    ["Congratulations"] = "Congratulations",
    ["Excuse me"] = "Excuse me",
    ["Goodbye!"] = "Goodbye!",
    ["Hello!"] = "Hello!",
    ["Help"] = "Help",
    ["No"] = "No",
    ["Please"] = "Please",
    ["Sorry"] = "Sorry",
    ["Thank you"] = "Thank you",
    ["Welcome"] = "Welcome",
    ["World"] = "World",
    ["Yes"] = "Yes",
}

MapPinEnhanced.L = L
