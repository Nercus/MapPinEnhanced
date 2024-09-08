---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinFactory
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
local PinTracking = MapPinEnhanced:GetModule("PinTracking")
local PinSections = MapPinEnhanced:GetModule("PinSections")


---@class PinObject
---@field Track fun(_)
---@field Untrack fun(_)
---@field ToggleTracked fun(_)
---@field IsTracked fun(_): boolean?

---@param pin PinObject
function PinFactory:HandleTracking(pin)
    local isTracked = nil
    function pin:Track()
        local success = PinTracking:SetTrackedPin(pin)
        if not success then return end
        pin.worldmapPin:SetTrackedTexture()
        pin.minimapPin:SetTrackedTexture()
        pin.trackerPinEntry:SetTrackedTexture()
        pin.superTrackedPin:Show()
        pin:EnableDistanceCheck()
        isTracked = true
        PinSections:PersistSections(self.section.name, self.pinID)
    end

    function pin:Untrack()
        if isTracked then
            C_Map.ClearUserWaypoint()
        end
        pin.worldmapPin:SetUntrackedTexture()
        pin.minimapPin:SetUntrackedTexture()
        pin.trackerPinEntry:SetUntrackedTexture()
        pin.superTrackedPin:Hide()
        pin:DisableDistanceCheck()
        isTracked = false
        PinSections:PersistSections(self.section.name, self.pinID)
    end

    function pin:ToggleTracked()
        if isTracked then
            self:Untrack()
        else
            self:Track()
        end
    end

    function pin:IsTracked()
        return isTracked
    end
end
