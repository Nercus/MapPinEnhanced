---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)




---@enum NotifyLevel
local NOTIFIY_LEVELS = {
    INFO = "INFO",
    WARNING = "WARNING",
    ERROR = "ERROR",
}

local NOTIFY_LEVEL_COLOR = {
    [NOTIFIY_LEVELS.INFO] = CreateColor(1, 1, 1, 1),
    [NOTIFIY_LEVELS.WARNING] = CreateColor(1, 0.82, 0, 1),
    [NOTIFIY_LEVELS.ERROR] = CreateColor(1, 0, 0, 1),
}

local prefix = "|TInterface\\AddOns\\MapPinEnhanced\\assets\\logo.png:16:16:0:0|t"
local NOTIFY_PATTERN = prefix .. " %s"

---@param text string
---@param level NotifyLevel?
function MapPinEnhanced:Notify(text, level)
    if not level then
        level = NOTIFIY_LEVELS.INFO
    end
    local color = NOTIFY_LEVEL_COLOR[level]
    local message = string.format(NOTIFY_PATTERN, text)
    UIErrorsFrame:AddMessage(message, color.r, color.g, color.b, color.a)
end
