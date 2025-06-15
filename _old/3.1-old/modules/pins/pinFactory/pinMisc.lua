---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinFactory
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
local PinSections = MapPinEnhanced:GetModule("PinSections")
local Blizzard = MapPinEnhanced:GetModule("Blizzard")
local Notify = MapPinEnhanced:GetModule("Notify")

local L = MapPinEnhanced.L

---@class PinObject
---@field ChangeTitle fun(_, text: string)
---@field SharePin fun(_)
---@field ShowOnMap fun(_)

---@param pin PinObject
function PinFactory:HandleMisc(pin)
    function pin:ChangeTitle(text)
        self.pinData.title = text
        self.worldmapPin:SetTitle(text)
        self.minimapPin:SetTitle(text)
        self.trackerPinEntry:SetTitle(text)
        self.superTrackedPin:SetTitle(text)
        PinSections:PersistSections(self.section.name, self.pinID)
    end

    function pin:SharePin()
        local x, y, mapID = self.pinData.x, self.pinData.y, self.pinData.mapID
        if x and y and mapID then
            Blizzard:InsertWaypointLinkToChat(x, y, mapID)
        end
    end

    function pin:ShowOnMap()
        if InCombatLockdown() then
            Notify:Error(L["Can't Show on Map in Combat"])
            return
        end
        local mapID = self.pinData.mapID
        OpenWorldMap(mapID);
        self.worldmapPin:ShowPulseForSeconds(3)
    end
end
