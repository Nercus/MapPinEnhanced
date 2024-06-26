---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


local defaultColor = ConsoleGetColorFromType(1)
local prefix = MapPinEnhanced:WrapTextInColor(MapPinEnhanced.addonName .. ": ", defaultColor)


---Print a styled message to the chat
---@param ... string
function MapPinEnhanced:Print(...)
    local str = select(1, ...)
    local args = select(2, ...)
    if args then
        str = string.format(str, args) ---@type string
    end
    print(prefix .. str)
end
