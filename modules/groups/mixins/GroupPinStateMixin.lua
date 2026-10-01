---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedGroupPinStateMixin
---@field group MapPinEnhancedGroupMixin
---@field pins table<UUID, MapPinEnhancedPinMixin>
---@field orders table<UUID, number>
---@field archive table<UUID, ArchivedPinData>
---@field count number
---@field changeNumber number
---@field maximumOrder number?
---@field orderCacheValid boolean?
MapPinEnhancedGroupPinStateMixin = CreateFromMixins(MapPinEnhancedGroupPinStateReadMixin)

---@param pinData pinData|SaveablePinData
---@param pinID UUID?
---@return SaveablePinData
local function GetSaveablePinData(pinData, pinID)
    ---@type SaveablePinData
    local data = CopyTable(pinData)
    data.pinID = pinID or data.pinID or MapPinEnhanced:GenerateUUID("pin")
    data.setTracked = nil
    data.description = MapPinEnhanced:NormalizeText(data.description)
    rawset(data, "tooltip", nil)
    return data
end

---@param group MapPinEnhancedGroupMixin
function MapPinEnhancedGroupPinStateMixin:Init(group)
    self.group = group
    self.pins = {}
    self.orders = {}
    self.archive = {}
    self.maximumOrder = nil
    self.orderCacheValid = true
    self.count = 0
    self.changeNumber = 0
end

---@param checkpoint fun()?
function MapPinEnhancedGroupPinStateMixin:Reset(checkpoint)
    for pinID, pin in pairs(self.pins) do
        self:Remove(pinID)
        self:ReleaseDetachedPin(pin)
        if checkpoint then checkpoint() end
    end
    for pinID in pairs(self.archive) do
        self:Remove(pinID)
        if checkpoint then checkpoint() end
    end
    self.maximumOrder = nil
    self.orderCacheValid = true
    self.changeNumber = self.changeNumber + 1
end

---@param checkpoint fun()?
function MapPinEnhancedGroupPinStateMixin:CheckPinState(checkpoint)
    local count = 0
    for pinID in pairs(self.pins) do
        assert(not self.archive[pinID],
            "MapPinEnhancedGroupPinStateMixin: pin exists in active and archived state")
        assert(type(self.orders[pinID]) == "number",
            "MapPinEnhancedGroupPinStateMixin: active pin has no numeric order")
        count = count + 1
        if checkpoint then checkpoint() end
    end
    for pinID in pairs(self.orders) do
        assert(self.pins[pinID],
            "MapPinEnhancedGroupPinStateMixin: active order has no active pin")
        if checkpoint then checkpoint() end
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
        if checkpoint then checkpoint() end
    end
    assert(count == self.count,
        "MapPinEnhancedGroupPinStateMixin: active pin count does not match membership")
end

---@return number
function MapPinEnhancedGroupPinStateMixin:GetNextOrder()
    if not self.orderCacheValid then
        ---@type number?
        local maximumOrder
        for _, order in pairs(self.orders) do
            maximumOrder = maximumOrder and math.max(maximumOrder, order) or order
        end
        for _, archivedPin in pairs(self.archive) do
            maximumOrder = maximumOrder and math.max(maximumOrder, archivedPin.order) or archivedPin.order
        end
        self.maximumOrder = maximumOrder
        self.orderCacheValid = true
    end
    return self.maximumOrder and self.maximumOrder + 1 or GetTime()
end

---@param pinData pinData|SaveablePinData
---@param overridePinID UUID?
---@param order number?
---@return MapPinEnhancedPinMixin?, boolean shouldTrack
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
    local groupID, lifetimeChangeNumber = self.group:GetGroupID(), self.group.lifetimeChangeNumber
    local cancelBatch = self.group.cancelBatch
    local pin = Pins:CreatePin(createData, overridePinID, self.group, true)
    if not pin then return nil, false end
    if self.group.cancelBatch ~= cancelBatch or self.group.isDeleting or self.group:GetGroupID() ~= groupID or
        self.group.lifetimeChangeNumber ~= lifetimeChangeNumber then
        pin.suppressPersistence = true
        Pins:ReleasePin(pin.pinID)
        return nil, false
    end
    local pinID = pin.pinID
    assert(not self.pins[pinID] and not self.archive[pinID],
        "MapPinEnhancedGroupPinStateMixin:AddActive: generated pin ID is already retained by the group")
    assert(Pins:GetPinByID(pinID) == pin,
        "MapPinEnhancedGroupPinStateMixin:AddActive: pin is not indexed by Pins")
    self.pins[pinID] = pin
    local nextOrder = self:GetNextOrder()
    self.orders[pinID] = type(order) == "number" and order or nextOrder
    self.maximumOrder = math.max(self.maximumOrder or self.orders[pinID], self.orders[pinID])
    self.count = self.count + 1
    self.changeNumber = self.changeNumber + 1
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
    local nextOrder = self:GetNextOrder()
    self.archive[pinID] = {
        state = state,
        data = data,
        order = type(order) == "number" and order or nextOrder,
    }
    self.maximumOrder = math.max(self.maximumOrder or self.archive[pinID].order, self.archive[pinID].order)
    self.changeNumber = self.changeNumber + 1
    return pinID
end

---@param pinID UUID
---@return MapPinEnhancedPinMixin?, ArchivedPinData?, number?
function MapPinEnhancedGroupPinStateMixin:Remove(pinID)
    if self:GetOrder(pinID) == self.maximumOrder then self.orderCacheValid = false end
    local pin = self.pins[pinID]
    if pin then
        local order = self.orders[pinID]
        self.pins[pinID] = nil
        self.orders[pinID] = nil
        self.count = self.count - 1
        self.changeNumber = self.changeNumber + 1
        return pin, nil, order
    end

    local archivedPin = self.archive[pinID]
    if archivedPin then
        self.archive[pinID] = nil
        self.changeNumber = self.changeNumber + 1
        return nil, archivedPin, archivedPin.order
    end
end

---@param pin MapPinEnhancedPinMixin
function MapPinEnhancedGroupPinStateMixin:ReleaseDetachedPin(pin)
    assert(not self.pins[pin.pinID],
        "MapPinEnhancedGroupPinStateMixin:ReleaseDetachedPin: pin is still active")
    pin.suppressPersistence = true
    Pins:ReleasePin(pin)
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
    self.changeNumber = self.changeNumber + 1
    pin.suppressPersistence = true
    Pins:ReleasePin(pin)
    return true, data, wasTracked, order
end

---@param pinID UUID
---@return boolean
function MapPinEnhancedGroupPinStateMixin:RestoreArchivedPin(pinID)
    local archivedPin = self.archive[pinID]
    if not archivedPin then return false end
    -- Setup may fail or normalize its input. Keep the original archive until it succeeds.
    local groupID, lifetimeChangeNumber = self.group:GetGroupID(), self.group.lifetimeChangeNumber
    local cancelBatch = self.group.cancelBatch
    local pin = Pins:CreatePin(CopyTable(archivedPin.data), pinID, self.group, true)
    if not pin then return false end
    if self.group.cancelBatch ~= cancelBatch or self.group.isDeleting or self.group:GetGroupID() ~= groupID or
        self.group.lifetimeChangeNumber ~= lifetimeChangeNumber then
        pin.suppressPersistence = true
        Pins:ReleasePin(pin.pinID)
        return false
    end
    self.archive[pinID] = nil
    self.pins[pinID] = pin
    self.orders[pinID] = archivedPin.order
    self.count = self.count + 1
    self.changeNumber = self.changeNumber + 1
    return true
end

---@param pinID UUID
---@param order number
---@return boolean
function MapPinEnhancedGroupPinStateMixin:SetOrder(pinID, order)
    self.orderCacheValid = false
    local archivedPin = self.archive[pinID]
    if archivedPin then
        archivedPin.order = order
    elseif self.pins[pinID] then
        self.orders[pinID] = order
    else
        return false
    end
    self.changeNumber = self.changeNumber + 1
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
    self.maximumOrder = count > 0 and count or nil
    self.orderCacheValid = true
    for index, pinID in ipairs(pinIDs) do
        local order = count - index + 1
        local archivedPin = self.archive[pinID]
        if archivedPin then
            archivedPin.order = order
        else
            self.orders[pinID] = order
        end
    end
    self.changeNumber = self.changeNumber + 1
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
    self.changeNumber = self.changeNumber + 1
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
    if removeCount > 0 then
        self.orderCacheValid = false
        self.changeNumber = self.changeNumber + 1
    end
    return removeCount
end
