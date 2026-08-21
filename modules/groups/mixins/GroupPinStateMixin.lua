---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedGroupPinStateMixin
---@field group MapPinEnhancedGroupMixin
---@field pins table<UUID, MapPinEnhancedPinMixin>
---@field orders table<UUID, number>
---@field archive table<UUID, ArchivedPinData>
---@field count number
---@field revision number
MapPinEnhancedGroupPinStateMixin = CreateFromMixins(MapPinEnhancedGroupPinStateReadMixin)

---@param pinData pinData|SaveablePinData
---@param pinID UUID?
---@return SaveablePinData
local function GetSaveablePinData(pinData, pinID)
    ---@type SaveablePinData
    local data = CopyTable(pinData)
    data.pinID = pinID or data.pinID or MapPinEnhanced:GenerateUUID("pin")
    data.setTracked = nil
    return data
end

---@param group MapPinEnhancedGroupMixin
function MapPinEnhancedGroupPinStateMixin:Init(group)
    self.group = group
    self.pins = {}
    self.orders = {}
    self.archive = {}
    self.count = 0
    self.revision = 0
end

function MapPinEnhancedGroupPinStateMixin:Reset()
    local pins = self.pins
    self.pins = {}
    self.orders = {}
    self.archive = {}
    self.count = 0
    self.revision = self.revision + 1
    for pinID, pin in pairs(pins) do
        pin.suppressPersistence = true
        Pins:ReleasePin(pinID)
    end
end

function MapPinEnhancedGroupPinStateMixin:AssertInvariants()
    local count = 0
    for pinID in pairs(self.pins) do
        assert(not self.archive[pinID],
            "MapPinEnhancedGroupPinStateMixin: pin exists in active and archived state")
        assert(type(self.orders[pinID]) == "number",
            "MapPinEnhancedGroupPinStateMixin: active pin has no numeric order")
        count = count + 1
    end
    for pinID in pairs(self.orders) do
        assert(self.pins[pinID],
            "MapPinEnhancedGroupPinStateMixin: active order has no active pin")
    end
    for pinID, archivedPin in pairs(self.archive) do
        assert(not self.pins[pinID],
            "MapPinEnhancedGroupPinStateMixin: pin exists in archived and active state")
        assert(self.orders[pinID] == nil,
            "MapPinEnhancedGroupPinStateMixin: archived pin has an active order")
        assert(type(archivedPin.order) == "number",
            "MapPinEnhancedGroupPinStateMixin: archived pin has no numeric order")
        assert(archivedPin.state == "reached" or archivedPin.state == "hidden",
            "MapPinEnhancedGroupPinStateMixin: archived pin has an invalid state")
        assert(archivedPin.data.pinID == pinID,
            "MapPinEnhancedGroupPinStateMixin: archived pin ID does not match its key")
    end
    assert(count == self.count,
        "MapPinEnhancedGroupPinStateMixin: active pin count does not match membership")
end

---@return number
function MapPinEnhancedGroupPinStateMixin:GetNextOrder()
    ---@type number?
    local maxOrder
    for _, order in pairs(self.orders) do
        if not maxOrder or order > maxOrder then
            maxOrder = order
        end
    end
    for _, archivedPin in pairs(self.archive) do
        if not maxOrder or archivedPin.order > maxOrder then
            maxOrder = archivedPin.order
        end
    end
    return maxOrder and maxOrder + 1 or GetTime()
end

---@param pinData pinData|SaveablePinData
---@param overridePinID UUID?
---@param order number?
---@return MapPinEnhancedPinMixin, boolean shouldTrack
function MapPinEnhancedGroupPinStateMixin:AddActive(pinData, overridePinID, order)
    if overridePinID then
        assert(not self.pins[overridePinID] and not self.archive[overridePinID],
            "MapPinEnhancedGroupPinStateMixin:AddActive: pin ID is already retained by the group")
    end

    local shouldTrack = pinData.setTracked and true or false
    ---@type pinData
    local createData = pinData
    if shouldTrack then
        ---@type pinData
        local copiedData = CopyTable(pinData)
        copiedData.setTracked = nil
        createData = copiedData
    end
    local pin = Pins:CreatePin(createData, overridePinID, self.group, true)
    local pinID = pin.pinID
    assert(not self.pins[pinID] and not self.archive[pinID],
        "MapPinEnhancedGroupPinStateMixin:AddActive: generated pin ID is already retained by the group")
    self.pins[pinID] = pin
    self.orders[pinID] = type(order) == "number" and order or self:GetNextOrder()
    self.count = self.count + 1
    self.revision = self.revision + 1
    return pin, shouldTrack
end

---@param pinData pinData|SaveablePinData
---@param state "reached"|"hidden"
---@param order number?
---@param overridePinID UUID?
---@return UUID
function MapPinEnhancedGroupPinStateMixin:AddArchived(pinData, state, order, overridePinID)
    assert(state == "reached" or state == "hidden",
        "MapPinEnhancedGroupPinStateMixin:AddArchived: invalid archive state")
    local data = GetSaveablePinData(pinData, overridePinID)
    local pinID = data.pinID
    assert(not self.pins[pinID] and not self.archive[pinID],
        "MapPinEnhancedGroupPinStateMixin:AddArchived: pin ID is already retained by the group")
    self.archive[pinID] = {
        state = state,
        data = data,
        order = type(order) == "number" and order or self:GetNextOrder(),
    }
    self.revision = self.revision + 1
    return pinID
end

---@param pinID UUID
---@return MapPinEnhancedPinMixin?, ArchivedPinData?, number?
function MapPinEnhancedGroupPinStateMixin:Remove(pinID)
    local pin = self.pins[pinID]
    if pin then
        local order = self.orders[pinID]
        self.pins[pinID] = nil
        self.orders[pinID] = nil
        self.count = self.count - 1
        self.revision = self.revision + 1
        return pin, nil, order
    end

    local archivedPin = self.archive[pinID]
    if archivedPin then
        self.archive[pinID] = nil
        self.revision = self.revision + 1
        return nil, archivedPin, archivedPin.order
    end
end

---@param pinID UUID
function MapPinEnhancedGroupPinStateMixin:ReleaseDetachedPin(pinID)
    assert(not self.pins[pinID],
        "MapPinEnhancedGroupPinStateMixin:ReleaseDetachedPin: pin is still active")
    local pin = Pins:GetPinByID(pinID)
    if pin then pin.suppressPersistence = true end
    Pins:ReleasePin(pinID)
end

---@param pinID UUID
---@param state "reached"|"hidden"
---@return boolean, SaveablePinData?, boolean?, number?
function MapPinEnhancedGroupPinStateMixin:ArchiveActive(pinID, state)
    assert(state == "reached" or state == "hidden",
        "MapPinEnhancedGroupPinStateMixin:ArchiveActive: invalid archive state")
    local pin = self.pins[pinID]
    if not pin then return false end

    local wasTracked = pin:IsTracked()
    local data = GetSaveablePinData(pin:GetSaveableData(), pinID)
    local order = self.orders[pinID] or GetTime()
    self.pins[pinID] = nil
    self.orders[pinID] = nil
    self.count = self.count - 1
    self.archive[pinID] = { state = state, data = data, order = order }
    self.revision = self.revision + 1
    pin.suppressPersistence = true
    Pins:ReleasePin(pinID)
    return true, data, wasTracked, order
end

---@param state "reached"|"hidden"
---@return boolean
function MapPinEnhancedGroupPinStateMixin:ArchiveAll(state)
    assert(state == "reached" or state == "hidden",
        "MapPinEnhancedGroupPinStateMixin:ArchiveAll: invalid archive state")
    local hadTrackedPin = false
    ---@type UUID[]
    local pinIDs = {}
    for pinID in pairs(self.pins) do
        pinIDs[#pinIDs + 1] = pinID
    end
    for _, pinID in ipairs(pinIDs) do
        local pin = self.pins[pinID]
        hadTrackedPin = hadTrackedPin or pin:IsTracked()
        local data = GetSaveablePinData(pin:GetSaveableData(), pinID)
        self.archive[pinID] = {
            state = state,
            data = data,
            order = self.orders[pinID] or GetTime(),
        }
    end
    for _, archivedPin in pairs(self.archive) do
        archivedPin.state = state
    end
    self.pins = {}
    self.orders = {}
    self.count = 0
    self.revision = self.revision + 1
    for _, pinID in ipairs(pinIDs) do
        local pin = Pins:GetPinByID(pinID)
        if pin then pin.suppressPersistence = true end
        Pins:ReleasePin(pinID)
    end
    return hadTrackedPin
end

---@param state "reached"|"hidden"?
---@return number
function MapPinEnhancedGroupPinStateMixin:RestoreArchived(state)
    ---@type UUID[]
    local pinIDs = {}
    for pinID, archivedPin in pairs(self.archive) do
        if not state or archivedPin.state == state then
            pinIDs[#pinIDs + 1] = pinID
        end
    end
    for _, pinID in ipairs(pinIDs) do
        local archivedPin = self.archive[pinID]
        self.archive[pinID] = nil
        self:AddActive(archivedPin.data, pinID, archivedPin.order)
    end
    return #pinIDs
end

---@param pinID UUID
---@param order number
---@return boolean
function MapPinEnhancedGroupPinStateMixin:SetOrder(pinID, order)
    local archivedPin = self.archive[pinID]
    if archivedPin then
        archivedPin.order = order
    elseif self.pins[pinID] then
        self.orders[pinID] = order
    else
        return false
    end
    self.revision = self.revision + 1
    return true
end

---@param pinIDs UUID[]
---@return boolean
function MapPinEnhancedGroupPinStateMixin:Reorder(pinIDs)
    if #pinIDs ~= self.count + self:GetArchiveCount() then return false end
    ---@type table<UUID, boolean>
    local seen = {}
    for _, pinID in ipairs(pinIDs) do
        if seen[pinID] or (not self.pins[pinID] and not self.archive[pinID]) then return false end
        seen[pinID] = true
    end

    local count = #pinIDs
    for index, pinID in ipairs(pinIDs) do
        local order = count - index + 1
        local archivedPin = self.archive[pinID]
        if archivedPin then
            archivedPin.order = order
        else
            self.orders[pinID] = order
        end
    end
    self.revision = self.revision + 1
    return true
end

---@param pinID UUID
---@param update fun(data: SaveablePinData)
---@return boolean
function MapPinEnhancedGroupPinStateMixin:UpdateArchived(pinID, update)
    local archivedPin = self.archive[pinID]
    if not archivedPin then return false end
    update(archivedPin.data)
    archivedPin.data.pinID = pinID
    archivedPin.data.setTracked = nil
    self.revision = self.revision + 1
    return true
end

---@param keepCount number
---@return number
function MapPinEnhancedGroupPinStateMixin:PruneOldestReached(keepCount)
    ---@type {pinID: UUID, order: number}[]
    local reachedPins = {}
    for pinID, archivedPin in pairs(self.archive) do
        if archivedPin.state == "reached" then
            reachedPins[#reachedPins + 1] = { pinID = pinID, order = archivedPin.order }
        end
    end
    table.sort(reachedPins, function(left, right)
        if left.order ~= right.order then return left.order < right.order end
        return left.pinID < right.pinID
    end)

    local removeCount = math.min(self.count + self:GetArchiveCount() - keepCount, #reachedPins)
    for index = 1, removeCount do
        self.archive[reachedPins[index].pinID] = nil
    end
    if removeCount > 0 then self.revision = self.revision + 1 end
    return removeCount
end
