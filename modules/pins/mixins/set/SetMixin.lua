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
    for _, pinData in ipairs(self.pins) do
        group:AddPin(pinData)
    end
end

function MapPinEnhancedSetMixin:AddPin(pinData)
    assert(pinData, "MapPinEnhancedSetMixin:AddPin: pinData is nil")
    assert(type(pinData) == "table", "MapPinEnhancedSetMixin:AddPin: pinData must be a table")

    table.insert(self.pins, pinData)
    self.count = self.count + 1

    Sets:PersistSet(self)
end

function MapPinEnhancedSetMixin:RemovePin(pinIndex)
    assert(pinIndex, "MapPinEnhancedSetMixin:RemovePin: pinIndex is nil")
    assert(type(pinIndex) == "number", "MapPinEnhancedSetMixin:RemovePin: pinIndex must be a number")

    if pinIndex < 1 or pinIndex > #self.pins then
        error("MapPinEnhancedSetMixin:RemovePin: pinIndex out of bounds")
    end

    table.remove(self.pins, pinIndex)
    self.count = self.count - 1

    Sets:PersistSet(self)
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
