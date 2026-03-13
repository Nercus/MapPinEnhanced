---@meta

---@class PinTooltip
---@field title string? the title of the tooltip
---@field text string? the text of the tooltip

---@class pinData
---@field mapID number UIMapID of the zone
---@field x number x coordinate between 0 and 1
---@field y number y coordinate between 0 and 1
---@field setTracked boolean? set to true to auto-track this pin on creation
---@field title string? title of the pin
---@field texture string? an optional texture to use for the pin this will override the color
---@field usesAtlas boolean? if true, the texture is an atlas, otherwise it is a file path
---@field color string? the color of the pin, if texture is set, this will be ignored -> the colors are predefined names in CONSTANTS.PIN_COLORS
---@field lock boolean? if true, the pin will be not be removed automatically when it has been reached
---@field tooltip PinTooltip? the tooltip of the pin, if not set, the default tooltip will be used
