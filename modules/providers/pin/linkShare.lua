---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")

local MAP_PIN_PATTERN = "|cffffff00|Hworldmap:%d:%d:%d|h[%s]|h|r"
local MAP_PIN_HYPERLINK = "|A:Waypoint-MapPin-ChatIcon:13:13:0:0|a Map Pin Location"

---@param x number
---@param y number
---@param mapID number
---@param title string?
function Providers:LinkToChat(x, y, mapID, title)
    if not x or not y or not mapID then return end
    ---@type string
    local waypointLink = (MAP_PIN_PATTERN):format(mapID, x * 10000, y * 10000, MAP_PIN_HYPERLINK)
    if title and title ~= "" then
        waypointLink = string.format("%s (%s)", waypointLink, title)
    end
    ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
    ChatEdit_InsertLink(waypointLink)
end
