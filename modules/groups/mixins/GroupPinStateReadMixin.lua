---@class ArchivedPinData
---@field state "reached"|"hidden"
---@field data SaveablePinData
---@field order number

---@class MapPinEnhancedGroupPinEntry
---@field pinID UUID
---@field state "active"|"reached"|"hidden"
---@field order number
---@field data SaveablePinData
---@field pin MapPinEnhancedPinMixin?

---@class MapPinEnhancedGroupPinStateMixin
MapPinEnhancedGroupPinStateReadMixin = {}

---@param pinID UUID
---@return MapPinEnhancedPinMixin?
function MapPinEnhancedGroupPinStateReadMixin:GetPin(pinID)
    return self.pins[pinID]
end

---@param pinID UUID
---@return ArchivedPinData?
function MapPinEnhancedGroupPinStateReadMixin:GetArchivedCopy(pinID)
    local archivedPin = self.archive[pinID]
    return archivedPin and CopyTable(archivedPin) or nil
end

---@param pinID UUID
---@return number?
function MapPinEnhancedGroupPinStateReadMixin:GetOrder(pinID)
    local archivedPin = self.archive[pinID]
    return self.orders[pinID] or (archivedPin and archivedPin.order or nil)
end

---@param state "reached"|"hidden"?
---@return number
function MapPinEnhancedGroupPinStateReadMixin:GetArchiveCount(state)
    local count = 0
    for _, archivedPin in pairs(self.archive) do
        if not state or archivedPin.state == state then count = count + 1 end
    end
    return count
end

---@return MapPinEnhancedGroupPinEntry[]
function MapPinEnhancedGroupPinStateReadMixin:GetEntries()
    ---@type MapPinEnhancedGroupPinEntry[]
    local entries = {}
    for pinID, pin in pairs(self.pins) do
        entries[#entries + 1] = {
            pinID = pinID,
            state = "active",
            order = self.orders[pinID],
            data = CopyTable(pin:GetSaveableData()),
            pin = pin,
        }
    end
    for pinID, archivedPin in pairs(self.archive) do
        entries[#entries + 1] = {
            pinID = pinID,
            state = archivedPin.state,
            order = archivedPin.order,
            data = CopyTable(archivedPin.data),
        }
    end
    return entries
end

---@return SaveablePinData[], table<UUID, number>, table<UUID, ArchivedPinData>
function MapPinEnhancedGroupPinStateReadMixin:Serialize()
    ---@type SaveablePinData[]
    local pins = {}
    for _, pin in pairs(self.pins) do
        pins[#pins + 1] = CopyTable(pin:GetSaveableData())
    end
    return pins, CopyTable(self.orders), CopyTable(self.archive)
end

---@return fun(table: table<UUID, MapPinEnhancedPinMixin>, index?: UUID): UUID, MapPinEnhancedPinMixin
---@return table<UUID, MapPinEnhancedPinMixin>
---@return nil
function MapPinEnhancedGroupPinStateReadMixin:EnumeratePins()
    return pairs(self.pins)
end

---@return fun(): UUID?, ArchivedPinData?
function MapPinEnhancedGroupPinStateReadMixin:EnumerateArchivedCopies()
    ---@type UUID?
    local pinID
    return function()
        ---@type ArchivedPinData?
        local archivedPin
        pinID, archivedPin = next(self.archive, pinID)
        if pinID then return pinID, CopyTable(archivedPin) end
    end
end
