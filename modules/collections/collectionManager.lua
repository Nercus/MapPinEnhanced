---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Collections
local Collections = MapPinEnhanced:GetModule("Collections")

local function CreateGroupObject()
    return CreateAndInitFromMixin(MapPinEnhancedCollectionMixin)
end

---@param collection MapPinEnhancedCollectionMixin
local function ResetGroupObject(_, collection)
    collection:Reset()
end

function Collections:GetObjectPool()
    if not self.objectPool then
        self.objectPool = CreateObjectPool(CreateGroupObject, ResetGroupObject)
        self.objectPool.capacity = 100 -- only allow 100 groups at the same time
    end

    return self.objectPool
end

---@param name string
---@return MapPinEnhancedCollectionMixin
function Collections:CreateCollection(name)
    assert(name, "Collections:CreateCollection: name is nil")
    assert(type(name) == "string", "Collections:CreateCollection: name must be a string")

    local collectionsPool = self:GetObjectPool()
    local collection = collectionsPool:Acquire()
    collection:SetName(name)

    return collection
end

function Collections:GetCollectionByName(name)
    assert(name, "Collections:GetCollectionByName: name is nil")
    assert(type(name) == "string", "Collections:GetCollectionByName: name must be a string")

    local collectionsPool = self:GetObjectPool()
    ---@param collection MapPinEnhancedCollectionMixin
    for collection in collectionsPool:EnumerateActive() do
        if collection.name == name then
            return collection
        end
    end

    return nil
end

---@type table<string, function>
local debouncedPersist = {}

---@param collection MapPinEnhancedCollectionMixin
function Collections:PersistCollection(collection)
    assert(collection, "Groups:PersistGroup: group is nil")
    local collectionName = collection:GetName()
    assert(collectionName, "Collections:PersistCollection: collection name is nil")

    if not debouncedPersist[collectionName] then
        debouncedPersist[collectionName] = MapPinEnhanced:DebounceChange(function()
            local data = collection:GetSaveableData()
            assert(data, "Collections:PersistCollection: data is nil")
            if not data or not data.name then return end
            MapPinEnhanced:SetVar("collections", data.name, data)
        end, 0.5)
    end

    debouncedPersist[collectionName]()
end

---@param collectionData CollectionInfo
function Collections:RestoreCollection(collectionData)
    assert(collectionData, "Collections:RestoreCollection: collectionData is nil")
    assert(type(collectionData) == "table", "Collections:RestoreCollection: collectionData must be a table")
    assert(collectionData.name, "Collections:RestoreCollection: collectionData.name is nil")

    local collection = self:GetCollectionByName(collectionData.name)
    if not collection then
        collection = self:CreateCollection(collectionData.name)
    end
    collection:AddMultiplePins(collectionData.pins)
end

function Collections:RestoreAllCollections()
    ---@type CollectionInfo[] | nil
    local collectionsData = MapPinEnhanced:GetVar("collections") or MapPinEnhanced:GetVar("collections")
    if not collectionsData then return end
    for _, collectionData in pairs(collectionsData) do
        self:RestoreCollection(collectionData)
    end
end

function Collections:EnumerateCollections()
    local collectionsPool = self:GetObjectPool()
    return collectionsPool:EnumerateActive()
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    Collections:RestoreAllCollections()
end)
