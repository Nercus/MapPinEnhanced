---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class SetInfo
---@field name string the name of the set
---@field pins pinData[] a table of pins that belong to this set
---@field count number the number of pins in this set
---@field icon string? the icon of the set, if any

---@class MapPinEnhancedPinSetMixin
---@field trackerEntry MapPinEnhancedTrackerSetMixin?
---@field name string the name of the set
---@field pins pinData[] a table of pins that belong to this set
---@field count number the number of pins in this set
---@field icon string? the icon of the set, if any
MapPinEnhancedPinSetMixin = CreateFromMixins(MapPinEnhancedPinSetShareMixin)


---@class Sets
local Sets = MapPinEnhanced:GetModule("Sets")
local Groups = MapPinEnhanced:GetModule("Groups")

local function CreateGroupObject()
    return CreateFromMixins(MapPinEnhancedTrackerSetMixin)
end

---@param trackerEntry MapPinEnhancedTrackerGroupMixin
local function ResetGroupObject(_, trackerEntry)
    trackerEntry:Reset()
end


function Sets:GetTrackerObjectPool()
    if not self.trackerObjectPool then
        self.trackerObjectPool = CreateObjectPool(CreateGroupObject, ResetGroupObject)
    end

    return self.trackerObjectPool
end

function MapPinEnhancedPinSetMixin:Init()
    self.pins = {}
    self.name = nil
    self.icon = nil
    self.count = 0

    local trackerObjectPool = Sets:GetTrackerObjectPool()
    self.trackerEntry = trackerObjectPool:Acquire()
end

function MapPinEnhancedPinSetMixin:Reset()
    self.pins = {}
    self.name = nil
    self.count = 0
    self.icon = nil

    local trackerObjectPool = Sets:GetTrackerObjectPool()
    trackerObjectPool:Release(self.trackerEntry)
end

function MapPinEnhancedPinSetMixin:SetName(name)
    assert(name, "MapPinEnhancedPinSetMixin:SetName: name is nil")
    assert(type(name) == "string", "MapPinEnhancedPinSetMixin:SetName: name must be a string")
    self.name = name
    Sets:PersistSet(self)
end

---@return string
function MapPinEnhancedPinSetMixin:GetName()
    return self.name
end

---@param icon string
function MapPinEnhancedPinSetMixin:SetIcon(icon)
    assert(icon, "MapPinEnhancedPinSetMixin:SetIcon: icon is nil")
    assert(type(icon) == "string", "MapPinEnhancedPinSetMixin:SetIcon: icon must be a string")
    self.icon = icon
    Sets:PersistSet(self)
end

---@return string?
function MapPinEnhancedPinSetMixin:GetIcon()
    return self.icon
end

function MapPinEnhancedPinSetMixin:LoadSet()
    local group = Groups:RegisterPinGroup({
        name = self.name,
        source = MapPinEnhanced.name,
    })
    if not group then
        error("MapPinEnhancedPinSetMixin:LoadSet: Group not found for set name: " .. tostring(self.name))
    end
    for _, pinData in ipairs(self.pins) do
        group:AddPin(pinData)
    end
end

function MapPinEnhancedPinSetMixin:AddPin(pinData)
    assert(pinData, "MapPinEnhancedPinSetMixin:AddPin: pinData is nil")
    assert(type(pinData) == "table", "MapPinEnhancedPinSetMixin:AddPin: pinData must be a table")

    table.insert(self.pins, pinData)
    self.count = self.count + 1

    Sets:PersistSet(self)
end

function MapPinEnhancedPinSetMixin:RemovePin(pinIndex)
    assert(pinIndex, "MapPinEnhancedPinSetMixin:RemovePin: pinIndex is nil")
    assert(type(pinIndex) == "number", "MapPinEnhancedPinSetMixin:RemovePin: pinIndex must be a number")

    if pinIndex < 1 or pinIndex > #self.pins then
        error("MapPinEnhancedPinSetMixin:RemovePin: pinIndex out of bounds")
    end

    table.remove(self.pins, pinIndex)
    self.count = self.count - 1

    Sets:PersistSet(self)
end

function MapPinEnhancedPinSetMixin:GetPinIndexByPindata(pinData)
    assert(pinData, "MapPinEnhancedPinSetMixin:GetPinIndexByPindata: pinData is nil")
    assert(type(pinData) == "table", "MapPinEnhancedPinSetMixin:GetPinIndexByPindata: pinData must be a table")

    for index, pin in ipairs(self.pins) do
        if pin == pinData then
            return index
        end
    end

    return nil
end

---@return SetInfo
function MapPinEnhancedPinSetMixin:GetSaveableData()
    return {
        name = self.name,
        pins = self.pins, -- NOTE: this can be changed to a compressed format in the future when needed
        count = self.count,
        icon = self.icon,
    }
end
