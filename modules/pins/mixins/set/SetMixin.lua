---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class SetInfo
---@field name string the name of the set
---@field pins pinData[] a table of pins that belong to this set
---@field count number the number of pins in this set
---@field icon string? the icon of the set, if any

---@class MapPinEnhancedSetMixin
---@field classification 'set'
---@field name string the name of the set
---@field pins pinData[] a table of pins that belong to this set
---@field count number the number of pins in this set
---@field icon string? the icon of the set, if any
MapPinEnhancedSetMixin = CreateFromMixins(
    { classification = "set" },
    MapPinEnhancedSetShareMixin
)


---@class Sets
local Sets = MapPinEnhanced:GetModule("Sets")
local Groups = MapPinEnhanced:GetModule("Groups")


function MapPinEnhancedSetMixin:Init()
    self.pins = {}
    self.name = nil
    self.icon = nil
    self.count = 0
end

function MapPinEnhancedSetMixin:Reset()
    self.pins = {}
    self.name = nil
    self.count = 0
    self.icon = nil
end

function MapPinEnhancedSetMixin:SetName(name)
    assert(name, "MapPinEnhancedSetMixin:SetName: name is nil")
    assert(type(name) == "string", "MapPinEnhancedSetMixin:SetName: name must be a string")
    self.name = name
    Sets:PersistSet(self)
end

---@return string
function MapPinEnhancedSetMixin:GetName()
    return self.name
end

---@param icon string
function MapPinEnhancedSetMixin:SetIcon(icon)
    assert(icon, "MapPinEnhancedSetMixin:SetIcon: icon is nil")
    assert(type(icon) == "string", "MapPinEnhancedSetMixin:SetIcon: icon must be a string")
    self.icon = icon
    Sets:PersistSet(self)
end

---@return string?
function MapPinEnhancedSetMixin:GetIcon()
    return self.icon
end

function MapPinEnhancedSetMixin:LoadSet()
    local group = Groups:RegisterGroup({
        name = self.name,
        source = MapPinEnhanced.name,
    })
    if not group then
        error("MapPinEnhancedSetMixin:LoadSet: Group not found for set name: " .. tostring(self.name))
    end
    group:AddMultiplePins(self.pins)
end

---@param pinData pinData the pinData of the pin to add to the set
---@param skipPersist boolean? if true, the set will not be persisted after adding the pin, used for batch adding pins
function MapPinEnhancedSetMixin:AddPin(pinData, skipPersist)
    assert(pinData, "MapPinEnhancedSetMixin:AddPin: pinData is nil")
    assert(type(pinData) == "table", "MapPinEnhancedSetMixin:AddPin: pinData must be a table")

    table.insert(self.pins, pinData)
    self.count = self.count + 1

    if not skipPersist then
        Sets:PersistSet(self)
    end
end

---@param pinsData pinData[]
function MapPinEnhancedSetMixin:AddMultiplePins(pinsData)
    assert(pinsData, "MapPinEnhancedSetMixin:AddMultiplePins: pinsData is nil")
    assert(type(pinsData) == "table", "MapPinEnhancedSetMixin:AddMultiplePins: pinsData must be a table")

    local numberOfPins = #pinsData
    if numberOfPins < 50 then
        for _, pinData in ipairs(pinsData) do
            self:AddPin(pinData, true)
        end
        Sets:PersistSet(self)
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
        Sets:PersistSet(self)
    end, batchSize)
end

---@param pinIndex number the index of the pin to remove from the set
---@param skipPersist boolean? if true, the set will not be persisted after removing the pin, used for batch removing pins
function MapPinEnhancedSetMixin:RemovePin(pinIndex, skipPersist)
    assert(pinIndex, "MapPinEnhancedSetMixin:RemovePin: pinIndex is nil")
    assert(type(pinIndex) == "number", "MapPinEnhancedSetMixin:RemovePin: pinIndex must be a number")

    if pinIndex < 1 or pinIndex > #self.pins then
        error("MapPinEnhancedSetMixin:RemovePin: pinIndex out of bounds")
    end

    table.remove(self.pins, pinIndex)
    self.count = self.count - 1

    if not skipPersist then
        Sets:PersistSet(self)
    end
end

---@param pinIndices number[] the indices of the pins to remove from the set
function MapPinEnhancedSetMixin:RemoveMultiplePins(pinIndices)
    assert(pinIndices, "MapPinEnhancedSetMixin:RemoveMultiplePins: pinIndices is nil")
    assert(type(pinIndices) == "table", "MapPinEnhancedSetMixin:RemoveMultiplePins: pinIndices must be a table")

    local numberOfPins = #pinIndices
    if numberOfPins == 0 then return end

    table.sort(pinIndices, function(a, b) return a > b end)

    if numberOfPins < 50 then
        for _, pinIndex in ipairs(pinIndices) do
            self:RemovePin(pinIndex, true)
        end
        Sets:PersistSet(self)
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
        Sets:PersistSet(self)
    end, batchSize)
end

function MapPinEnhancedSetMixin:GetPinIndexByPindata(pinData)
    assert(pinData, "MapPinEnhancedSetMixin:GetPinIndexByPindata: pinData is nil")
    assert(type(pinData) == "table", "MapPinEnhancedSetMixin:GetPinIndexByPindata: pinData must be a table")

    for index, pin in ipairs(self.pins) do
        if pin == pinData then
            return index
        end
    end

    return nil
end

---@return SetInfo
function MapPinEnhancedSetMixin:GetSaveableData()
    return {
        name = self.name,
        pins = self.pins, -- NOTE: this can be changed to a compressed format in the future when needed
        count = self.count,
        icon = self.icon,
    }
end
