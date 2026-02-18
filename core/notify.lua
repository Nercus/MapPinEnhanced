---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@enum NotifyLevel
local NOTIFIY_LEVELS = {
    DEFAULT = "DEFAULT",
    ERROR = "ERROR",
}

local NOTIFY_LEVEL_COLOR = {
    [NOTIFIY_LEVELS.DEFAULT] = CreateColor(1, 1, 1, 1),
    [NOTIFIY_LEVELS.ERROR] = CreateColor(1, 0, 0, 1),
}

---@param message string
---@param level NotifyLevel?
function MapPinEnhanced:Notify(message, level)
    if not level then
        level = NOTIFIY_LEVELS.DEFAULT
    end
    local color = NOTIFY_LEVEL_COLOR[level]
    UIErrorsFrame:AddMessage(message, color.r, color.g, color.b, color.a)
end
