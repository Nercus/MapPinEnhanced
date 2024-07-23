---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local LOCALE = MapPinEnhanced.locale

if LOCALE ~= "zhCN" and LOCALE ~= "zhTW" then return end


---@type Locale
local L = {
    ["Congratulations"] = "恭喜",
    ["Excuse me"] = "对不起",
    ["Goodbye!"] = "再见!",
    ["Goodbye"] = "再见",
    ["Hello!"] = "你好!",
    ["Help"] = "帮助",
    ["No"] = "不",
    ["Please"] = "请",
    ["Sorry"] = "抱歉",
    ["Thank you"] = "谢谢",
    ["Welcome"] = "欢迎",
    ["World"] = "世界",
    ["Yes"] = "是",
}

MapPinEnhanced.L = L
