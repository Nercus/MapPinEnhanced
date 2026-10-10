---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinUtilsMixin = {}


local L = MapPinEnhanced.L

function MapPinEnhancedPinUtilsMixin:SharePin()
    local x, y, mapID = self.pinData.x, self.pinData.y, self.pinData.mapID
    if x and y and mapID then
        Pins:LinkToChat(x, y, mapID)
    end
end

function MapPinEnhancedPinUtilsMixin:ShowOnMap()
    if InCombatLockdown() then
        MapPinEnhanced:Print(L["Can't Show on Map in Combat"])
        return
    end
    local mapID = self.pinData.mapID
    MapPinEnhanced:CallRestricted(function()
        C_Map.OpenWorldMap(mapID)
        self.worldmapPin:ShowPulseLoops(3)
    end, L["The world map cannot be opened automatically during combat. It will open after combat ends."])
end

---@param title string
function MapPinEnhancedPinUtilsMixin:SetTitle(title)
    if not self:CanApplyChanges() then return end
    self.pinData.title = title
    self:PersistPin()
    if not self.groupIsAddingPin then
        MapPinEnhanced:FireCallback("PIN_UPDATED_TITLE", self.pinID, title)
    end
end
