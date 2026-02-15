---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Sets
local Sets = MapPinEnhanced:GetModule("Sets")

local function CreateGroupObject()
    return CreateAndInitFromMixin(MapPinEnhancedSetMixin)
end

---@param group MapPinEnhancedGroupMixin
local function ResetGroupObject(_, group)
    group:Reset()
end

function Sets:GetObjectPool()
    if not self.objectPool then
        self.objectPool = CreateObjectPool(CreateGroupObject, ResetGroupObject)
        self.objectPool.capacity = 100 -- only allow 100 groups at the same time
    end

    return self.objectPool
end

function Sets:CreateSet(name)
    assert(name, "Sets:CreateSet: name is nil")
    assert(type(name) == "string", "Sets:CreateSet: name must be a string")

    local setsPool = self:GetObjectPool()
    local set = setsPool:Acquire()
    set:SetName(name)

    return set
end

function Sets:GetSetByName(name)
    assert(name, "Sets:GetSetByName: name is nil")
    assert(type(name) == "string", "Sets:GetSetByName: name must be a string")

    local setsPool = self:GetObjectPool()
    ---@param set MapPinEnhancedSetMixin
    for set in setsPool:EnumerateActive() do
        if set.name == name then
            return set
        end
    end

    return nil
end

---@type table<string, function>
local debouncedPersist = {}

---@param set MapPinEnhancedSetMixin
function Sets:PersistSet(set)
    assert(set, "Groups:PersistGroup: group is nil")
    local setName = set:GetName()
    assert(setName, "Sets:PersistSet: set name is nil")

    -- Persisting the data for a set is debounced to avoid excessive calls of the function on a half second delay
    if not debouncedPersist[setName] then
        debouncedPersist[setName] = MapPinEnhanced:DebounceChange(function()
            local data = set:GetSaveableData()
            assert(data, "Sets:PersistSet: data is nil")
            if not data or not data.name then return end
            MapPinEnhanced:SetVar("sets", data.name, data)
        end, 0.5)
    end

    debouncedPersist[setName]()
end

---@param setData SetInfo
function Sets:RestoreSet(setData)
    assert(setData, "Sets:RestoreSet: setData is nil")
    assert(type(setData) == "table", "Sets:RestoreSet: setData must be a table")
    assert(setData.name, "Sets:RestoreSet: setData.name is nil")

    local set = self:GetSetByName(setData.name)
    if not set then
        set = self:CreateSet(setData.name)
    end
    set:AddMultiplePins(setData.pins)
end

function Sets:RestoreAllSets()
    ---@type SetInfo[] | nil
    local setsData = MapPinEnhanced:GetVar("sets")
    if not setsData then return end
    for _, setData in pairs(setsData) do
        self:RestoreSet(setData)
    end
end

function Sets:EnumerateSets()
    local setsPool = self:GetObjectPool()
    return setsPool:EnumerateActive()
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    Sets:RestoreAllSets()
end)
