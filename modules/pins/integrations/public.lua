---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Pins = MapPinEnhanced:GetModule("Pins")
local Groups = MapPinEnhanced:GetModule("Groups")
---@type table<string, function>
local publicAPI = _G[MapPinEnhanced.name]

-- Both AddPin(data)/AddWaypoint(data) and their colon forms use this boundary.
---@param pinData pinData
---@param colonPinData pinData?
---@overload fun(receiver: table, pinData: pinData): UUID?
---@return UUID?
local function AddPin(pinData, colonPinData)
    if pinData == publicAPI then
        pinData = colonPinData
    end
    assert(type(pinData) == "table", "MapPinEnhanced.AddPin/AddWaypoint: pinData must be a table")

    local uncategorizedSection = Groups:GetUngroupedGroup()
    if not uncategorizedSection then return end
    local _, pinID = uncategorizedSection:AddPin(pinData)
    return pinID
end

MapPinEnhanced:RegisterGlobalAPI("AddPin", AddPin)
MapPinEnhanced:RegisterGlobalAPI("AddWaypoint", AddPin)
