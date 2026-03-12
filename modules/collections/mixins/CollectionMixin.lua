---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class CollectionInfo
---@field name string the name of the collection
---@field pins pinData[] a table of pins that belong to this collection
---@field count number the number of pins in this collection
---@field icon string? the icon of the collection, if any

---@class MapPinEnhancedCollectionMixin
---@field classification 'collection'
---@field name string the name of the collection
---@field pins pinData[] a table of pins that belong to this collection
---@field count number the number of pins in this collection
---@field icon string? the icon of the collection, if any
MapPinEnhancedCollectionMixin = CreateFromMixins(
    { classification = "collection" },
    MapPinEnhancedCollectionShareMixin
)


---@class Collections
local Collections = MapPinEnhanced:GetModule("Collections")
local Groups = MapPinEnhanced:GetModule("Groups")


function MapPinEnhancedCollectionMixin:Init()
    self.pins = {}
    self.name = nil
    self.icon = nil
    self.count = 0
end

function MapPinEnhancedCollectionMixin:Reset()
    self.pins = {}
    self.name = nil
    self.count = 0
    self.icon = nil
end

function MapPinEnhancedCollectionMixin:SetName(name)
    assert(name, "MapPinEnhancedCollectionMixin:SetName: name is nil")
    assert(type(name) == "string", "MapPinEnhancedCollectionMixin:SetName: name must be a string")
    self.name = name
    Collections:PersistCollection(self)
end

---@return string
function MapPinEnhancedCollectionMixin:GetName()
    return self.name
end

---@param icon string
function MapPinEnhancedCollectionMixin:SetIcon(icon)
    assert(icon, "MapPinEnhancedCollectionMixin:SetIcon: icon is nil")
    assert(type(icon) == "string", "MapPinEnhancedCollectionMixin:SetIcon: icon must be a string")
    self.icon = icon
    Collections:PersistCollection(self)
end

---@return string?
function MapPinEnhancedCollectionMixin:GetIcon()
    return self.icon
end

function MapPinEnhancedCollectionMixin:LoadCollection()
    local group = Groups:RegisterGroup({
        name = self.name,
        source = MapPinEnhanced.name,
        order = GetTime(),
        icon = self.icon or "Interface\\Icons\\inv_misc_map08"
    })
    if not group then
        error("MapPinEnhancedCollectionMixin:LoadCollection: Group not found for collection name: " ..
            tostring(self.name))
    end
    group:AddMultiplePins(self.pins)
end

---@param pinData pinData the pinData of the pin to add to the collection
---@param skipPersist boolean? if true, the collection will not be persisted after adding the pin, used for batch adding pins
function MapPinEnhancedCollectionMixin:AddPin(pinData, skipPersist)
    assert(pinData, "MapPinEnhancedCollectionMixin:AddPin: pinData is nil")
    assert(type(pinData) == "table", "MapPinEnhancedCollectionMixin:AddPin: pinData must be a table")

    table.insert(self.pins, pinData)
    self.count = self.count + 1

    if not skipPersist then
        Collections:PersistCollection(self)
    end
end

---@param pinsData pinData[]
function MapPinEnhancedCollectionMixin:AddMultiplePins(pinsData)
    assert(pinsData, "MapPinEnhancedCollectionMixin:AddMultiplePins: pinsData is nil")
    assert(type(pinsData) == "table", "MapPinEnhancedCollectionMixin:AddMultiplePins: pinsData must be a table")

    local numberOfPins = #pinsData
    if numberOfPins < 50 then
        for _, pinData in ipairs(pinsData) do
            self:AddPin(pinData, true)
        end
        Collections:PersistCollection(self)
        return
    end
    local addingPinsFunctions = {}
    for _, pinData in ipairs(pinsData) do
        table.insert(addingPinsFunctions, function()
            self:AddPin(pinData, true)
        end)
    end
    local batchSize = math.min(math.max(math.ceil(numberOfPins / 60), 10), 100)
    MapPinEnhanced:BatchExecution(addingPinsFunctions, nil, function()
        Collections:PersistCollection(self)
    end, batchSize)
end

---@param pinIndex number the index of the pin to remove from the collection
---@param skipPersist boolean? if true, the collection will not be persisted after removing the pin, used for batch removing pins
function MapPinEnhancedCollectionMixin:RemovePin(pinIndex, skipPersist)
    assert(pinIndex, "MapPinEnhancedCollectionMixin:RemovePin: pinIndex is nil")
    assert(type(pinIndex) == "number", "MapPinEnhancedCollectionMixin:RemovePin: pinIndex must be a number")

    if pinIndex < 1 or pinIndex > #self.pins then
        error("MapPinEnhancedCollectionMixin:RemovePin: pinIndex out of bounds")
    end

    table.remove(self.pins, pinIndex)
    self.count = self.count - 1

    if not skipPersist then
        Collections:PersistCollection(self)
    end
end

---@param pinIndices number[] the indices of the pins to remove from the collection
function MapPinEnhancedCollectionMixin:RemoveMultiplePins(pinIndices)
    assert(pinIndices, "MapPinEnhancedCollectionMixin:RemoveMultiplePins: pinIndices is nil")
    assert(type(pinIndices) == "table", "MapPinEnhancedCollectionMixin:RemoveMultiplePins: pinIndices must be a table")

    local numberOfPins = #pinIndices
    if numberOfPins == 0 then return end

    table.sort(pinIndices, function(a, b) return a > b end)

    if numberOfPins < 50 then
        for _, pinIndex in ipairs(pinIndices) do
            self:RemovePin(pinIndex, true)
        end
        Collections:PersistCollection(self)
        return
    end
    local removingPinsFunctions = {}
    for _, pinIndex in ipairs(pinIndices) do
        table.insert(removingPinsFunctions, function()
            self:RemovePin(pinIndex, true)
        end)
    end
    local batchSize = math.min(math.max(math.ceil(numberOfPins / 60), 10), 100)
    MapPinEnhanced:BatchExecution(removingPinsFunctions, nil, function()
        Collections:PersistCollection(self)
    end, batchSize)
end

function MapPinEnhancedCollectionMixin:GetPinIndexByPindata(pinData)
    assert(pinData, "MapPinEnhancedCollectionMixin:GetPinIndexByPindata: pinData is nil")
    assert(type(pinData) == "table", "MapPinEnhancedCollectionMixin:GetPinIndexByPindata: pinData must be a table")

    for index, pin in ipairs(self.pins) do
        if pin == pinData then
            return index
        end
    end

    return nil
end

---@return CollectionInfo
function MapPinEnhancedCollectionMixin:GetSaveableData()
    return {
        name = self.name,
        pins = self.pins,
        count = self.count,
        icon = self.icon,
    }
end
