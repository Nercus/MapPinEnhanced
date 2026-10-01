---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Groups = MapPinEnhanced:GetModule("Groups")
local ARCHIVE_STATE_HIDDEN = "hidden"

---@class MapPinEnhancedGroupMixin
MapPinEnhancedGroupPinAddingMixin = {}

---@param pinData pinData|SaveablePinData
---@param overridePinID UUID?
---@param order number?
---@return MapPinEnhancedPinMixin?, UUID?, boolean replacedWayBackPin, boolean shouldTrack
function MapPinEnhancedGroupPinAddingMixin:AddBeforePersist(pinData, overridePinID, order)
    local group = self
    local groupID, lifetimeChangeNumber = group:GetGroupID(), group.lifetimeChangeNumber
    local replacedWayBackPin = false
    if group.groupType == "way-back" and group:GetTotalPinCount() > 0 then
        group.pinState:Reset()
        replacedWayBackPin = true
        if group.isDeleting or group:GetGroupID() ~= groupID or
            group.lifetimeChangeNumber ~= lifetimeChangeNumber then return nil, nil, true, false end
    end

    if group.hidden then
        local pinID = group.pinState:AddArchived(pinData, ARCHIVE_STATE_HIDDEN, order, overridePinID)
        return nil, pinID, replacedWayBackPin, false
    end

    local pin, shouldTrack = group.pinState:AddActive(pinData, overridePinID, order)
    return pin, pin and pin.pinID or nil, replacedWayBackPin, shouldTrack
end

---@param pinData pinData
---@param overridePinID UUID?
---@return MapPinEnhancedPinMixin?, UUID?
function MapPinEnhancedGroupPinAddingMixin:AddPin(pinData, overridePinID)
    self:CancelBatch()
    assert(pinData, "MapPinEnhancedGroupMixin:AddPin: pinData is nil")

    local pin, pinID, replacedWayBackPin, shouldTrack = self:AddBeforePersist(pinData, overridePinID)
    if not pinID then return nil, nil end
    self:PruneOldestReachedPins()
    self:PersistPinChanges(true)
    if shouldTrack and pin then pin:TrackWithoutPersisting() end
    if pin then
        MapPinEnhanced:FireCallback("PIN_ADDED", nil, self, pin)
    else
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end
    if replacedWayBackPin and pin then
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end
    return pin, pinID
end

---@param pinsData pinData[]|SaveablePinData[]
---@param preserveGroupOrder boolean?
---@param pinOrders table<UUID, number>?
function MapPinEnhancedGroupPinAddingMixin:AddMultiplePins(pinsData, preserveGroupOrder, pinOrders)
    self:CancelBatch()
    assert(type(pinsData) == "table", "MapPinEnhancedGroupMixin:AddMultiplePins: pinsData must be a table")
    if #pinsData == 0 then return end

    local groupID, lifetimeChangeNumber = self:GetGroupID(), self.lifetimeChangeNumber
    local completed, finished = 0, false
    ---@type fun()?
    local cancelExecution
    ---@type fun()
    local cancelBatch
    ---@type MapPinEnhancedPinMixin?
    local trackedPin

    local function finish(status)
        if finished then return end
        finished = true
        if cancelExecution then cancelExecution() end
        cancelExecution = nil
        if self.cancelBatch == cancelBatch then self.cancelBatch = nil end
        if not self:IsSameGroup(groupID, lifetimeChangeNumber) then return end
        self:PruneOldestReachedPins()
        self:PersistPinChanges(not preserveGroupOrder)
        if trackedPin and trackedPin.group == self and self:GetPinByID(trackedPin.pinID) == trackedPin then
            trackedPin:TrackWithoutPersisting()
        end
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
        if status ~= "complete" then Groups:ReportStoppedPinOperation(completed, #pinsData) end
    end

    local function onError(message)
        finish("stopped")
        geterrorhandler()(message)
    end

    cancelBatch = function() finish("stopped") end
    self.cancelBatch = cancelBatch

    ---@param pinData pinData|SaveablePinData
    ---@return boolean
    local function addPin(pinData)
        if finished or not self:IsSameGroup(groupID, lifetimeChangeNumber) then return false end
        local pinID = pinData.pinID
        local pin, addedPinID, _, shouldTrack = self:AddBeforePersist(pinData, pinID,
            pinID and pinOrders and pinOrders[pinID] or nil)
        if not addedPinID then return false end
        completed = completed + 1
        if shouldTrack then trackedPin = pin end
        return not finished and self:IsSameGroup(groupID, lifetimeChangeNumber)
    end

    if #pinsData < 50 then
        for _, pinData in ipairs(pinsData) do
            local success, added = pcall(addPin, pinData)
            if not success then
                onError(tostring(added))
                return
            end
            if not added then
                finish("stopped")
                return
            end
        end
        finish("complete")
        return
    end

    ---@type (fun(): boolean?)[]
    local tasks = {}
    for _, pinData in ipairs(pinsData) do
        local data = pinData
        tasks[#tasks + 1] = function() return addPin(data) end
    end
    local batchSize = math.min(math.max(math.ceil(#pinsData / 60), 10), 100)
    cancelExecution = MapPinEnhanced:BatchExecution(tasks, nil, finish, batchSize, onError)
end
