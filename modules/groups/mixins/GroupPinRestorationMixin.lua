---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local ARCHIVE_STATE_REACHED = "reached"
local ARCHIVE_STATE_HIDDEN = "hidden"

---@class MapPinEnhancedGroupMixin
MapPinEnhancedGroupPinRestorationMixin = {}

---@param pinData SaveablePinData
---@return SaveablePinData, UUID?
local function NormalizeRestoredPinData(pinData)
    if type(pinData.pinID) == "string" then return pinData, pinData.pinID end
    ---@type SaveablePinData
    local normalized = CopyTable(pinData)
    normalized.pinID = nil
    return normalized, nil
end

---@param groupData SaveableGroupData
function MapPinEnhancedGroupPinRestorationMixin:RestorePinState(groupData)
    self.pinState:Reset()

    local pinArchive = type(groupData.pinArchive) == "table" and groupData.pinArchive or {}
    for pinID, archivedPin in pairs(pinArchive) do
        if type(pinID) == "string" and type(archivedPin) == "table" and
            type(archivedPin.data) == "table" and
            (archivedPin.state == ARCHIVE_STATE_REACHED or archivedPin.state == ARCHIVE_STATE_HIDDEN) then
            local state = self.hidden and ARCHIVE_STATE_HIDDEN or archivedPin.state
            self.pinState:AddArchived(archivedPin.data, state,
                type(archivedPin.order) == "number" and archivedPin.order or nil, pinID)
        end
    end

    local pins = type(groupData.pins) == "table" and groupData.pins or {}
    local pinOrders = type(groupData.pinOrder) == "table" and groupData.pinOrder or nil
    ---@type table<UUID, boolean>
    local retainedIDs = {}
    for _, entry in ipairs(self:GetPinEntries()) do retainedIDs[entry.pinID] = true end

    ---@type SaveablePinData[]
    local activePins = {}
    for _, rawPinData in ipairs(pins) do
        if type(rawPinData) == "table" then
            ---@cast rawPinData SaveablePinData
            local pinData, pinID = NormalizeRestoredPinData(rawPinData)
            if pinID and retainedIDs[pinID] then
                ---@type SaveablePinData
                pinData = CopyTable(pinData)
                pinData.pinID = nil
                pinID = nil
            end
            if self.hidden then
                local restoredID = self.pinState:AddArchived(pinData, ARCHIVE_STATE_HIDDEN,
                    pinID and pinOrders and pinOrders[pinID] or nil, pinID)
                retainedIDs[restoredID] = true
            else
                activePins[#activePins + 1] = pinData
                if pinID then retainedIDs[pinID] = true end
            end
        end
    end

    if not self.hidden and #activePins > 0 then
        self:AddMultiplePins(activePins, true, pinOrders)
        return
    end
    self:PersistPinChanges()
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
end
