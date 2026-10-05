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

---@return number active
---@return number reached
---@return number total
function MapPinEnhancedGroupPinStateReadMixin:GetCounts()
    local reached, total = 0, self.count
    for _, archivedPin in pairs(self.archive) do
        total = total + 1
        if archivedPin.state == "reached" then reached = reached + 1 end
    end
    return self.count, reached, total
end

---@class MapPinEnhancedGroupPinDisplayEntry
---@field pinID UUID
---@field state "active"|"reached"|"hidden"
---@field order number
---@field title string?
---@field pin MapPinEnhancedPinMixin?

---Fresh display metadata keeps title edits current without exposing archive payloads.
---@return MapPinEnhancedGroupPinDisplayEntry[]
function MapPinEnhancedGroupPinStateReadMixin:GetDisplayEntries()
    ---@type MapPinEnhancedGroupPinDisplayEntry[]
    local entries = {}
    for pinID, pin in pairs(self.pins) do
        entries[#entries + 1] = {
            pinID = pinID,
            state = "active",
            order = self.orders[pinID],
            title = pin:GetPinData().title,
            pin = pin,
        }
    end
    for pinID, archivedPin in pairs(self.archive) do
        entries[#entries + 1] = {
            pinID = pinID,
            state = archivedPin.state,
            order = archivedPin.order,
            title = archivedPin.data.title,
        }
    end
    return entries
end

---@param pinID UUID
---@return MapPinEnhancedGroupPinEntry?
function MapPinEnhancedGroupPinStateReadMixin:GetEntryCopy(pinID)
    local pin = self.pins[pinID]
    if pin then
        return {
            pinID = pinID,
            state = "active",
            order = self.orders[pinID],
            data = CopyTable(pin:GetSaveableData()),
            pin = pin,
        }
    end
    local archivedPin = self.archive[pinID]
    if archivedPin then
        return {
            pinID = pinID,
            state = archivedPin.state,
            order = archivedPin.order,
            data = CopyTable(archivedPin.data),
        }
    end
    return nil
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
---@param checkpoint fun()?
function MapPinEnhancedGroupPinStateReadMixin:Serialize(checkpoint)
    ---@type SaveablePinData[]
    local pins = {}
    ---@type table<UUID, number>
    local orders = {}
    ---@type table<UUID, ArchivedPinData>
    local archive = {}
    for pinID, pin in pairs(self.pins) do
        pins[#pins + 1] = CopyTable(pin:GetSaveableData())
        orders[pinID] = self.orders[pinID]
        if checkpoint then checkpoint() end
    end
    for pinID, archivedPin in pairs(self.archive) do
        archive[pinID] = CopyTable(archivedPin)
        if checkpoint then checkpoint() end
    end
    return pins, orders, archive
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
