---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinUtilsMixin = {}

local MAP_PIN_HYPERLINK = "|A:Waypoint-MapPin-ChatIcon:13:13:0:0|a Map Pin Location"
local MAP_PIN_PATTERN = "|cffffff00|Hworldmap:%d:%d:%d|h[%s]|h|r"
local L = MapPinEnhanced.L

function MapPinEnhancedPinUtilsMixin:SharePin()
    local x, y, mapID = self.pinData.x, self.pinData.y, self.pinData.mapID
    if x and y and mapID then
        local waypointLink = (MAP_PIN_PATTERN):format(mapID, x * 10000, y * 10000, MAP_PIN_HYPERLINK)
        ChatEdit_ActivateChat(DEFAULT_CHAT_FRAME.editBox)
        ChatEdit_InsertLink(waypointLink)
    end
end

function MapPinEnhancedPinUtilsMixin:ShowOnMap()
    if InCombatLockdown() then
        MapPinEnhanced:Print(L["Can't Show on Map in Combat"])
        return
    end
    local mapID = self.pinData.mapID
    OpenWorldMap(mapID)
    self.worldmapPin:ShowPulse()
    C_Timer.Afterr(3, function()
        self.worldmapPin:HidePulse()
    end)
end
