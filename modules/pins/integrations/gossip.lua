---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")
local Groups = MapPinEnhanced:GetModule("Groups")

---@type UUID?
local lastPinID

MapPinEnhanced:RegisterEvent("GOSSIP_SHOW", function()
    lastPinID = nil
end)

MapPinEnhanced:RegisterEvent("DYNAMIC_GOSSIP_POI_UPDATED", function()
    local data = Providers:GetGuardPinData()
    if not data then return end
    local group = Groups:GetUngroupedGroup()
    if not group then return end
    local previous = lastPinID and group:GetPinByID(lastPinID)
    local previousData = previous and previous.pinData
    -- Repeated updates for the same live marker must not add duplicate pins.
    if previousData and previousData.mapID == data.mapID and previousData.x == data.x and
        previousData.y == data.y and previousData.title == data.title then
        return
    end
    data.setTracked = not C_SuperTrack.IsSuperTrackingCorpse()
    local _, pinID = group:AddPin(data)
    if pinID then
        lastPinID = pinID
        MapPinEnhanced:GetModule("Tracker"):OnUserPinsAdded()
    end
end)
