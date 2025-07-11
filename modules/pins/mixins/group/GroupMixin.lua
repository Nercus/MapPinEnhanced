---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedPinGroupMixin
---@field name string the name of the group
---@field source string the addon which is registering the group, used to identify the group.
---@field icon string? the icon of the group, used to display the group on the map
---@field pins table<UUID, MapPinEnhancedPinMixin> a table of pins that belong to this
MapPinEnhancedPinGroupMixin = {}


---@class Groups
---@field framePool FramePoolCollection<MapPinEnhancedTrackerGroupEntryTemplate>
local Groups = MapPinEnhanced:GetModule("Groups")

function Groups:GetFramePool()
    if not self.framePool then
        self.framePool = CreateFramePoolCollection()
        self.framePool:CreatePool("Frame", nil, "MapPinEnhancedTrackerGroupEntryTemplate")
    end

    return self.framePool
end

function MapPinEnhancedPinGroupMixin:Init()
    self.pins = {}
    self.count = 0

    local framePool = Groups:GetFramePool()
    self.trackerGroupEntry = framePool:Acquire("MapPinEnhancedTrackerGroupEntryTemplate")
end

function MapPinEnhancedPinGroupMixin:Reset()
    self.pins = {}
    self.name = nil
    self.source = nil
    self.icon = nil
    self.count = 0
    local framePool = Groups:GetFramePool()
    framePool:Release(self.trackerGroupEntry)
end

---@param name string
function MapPinEnhancedPinGroupMixin:SetName(name)
    assert(name, "MapPinEnhancedPinGroupMixin:SetName: name is nil")
    assert(type(name) == "string", "MapPinEnhancedPinGroupMixin:SetName: name must be a string")
    self.name = name
    Groups:PersistGroup(self)
end

function MapPinEnhancedPinGroupMixin:GetName()
    return self.name
end

---@param source string
function MapPinEnhancedPinGroupMixin:SetSource(source)
    assert(source, "MapPinEnhancedPinGroupMixin:SetSource: source is nil")
    assert(type(source) == "string", "MapPinEnhancedPinGroupMixin:SetSource: source must be a string")
    assert(C_AddOns.IsAddOnLoaded(source), "MapPinEnhancedPinGroupMixin:SetSource: source is not a loaded addon")
    self.source = source
    Groups:PersistGroup(self)
end

function MapPinEnhancedPinGroupMixin:GetSource()
    return self.source
end

---@param icon string
function MapPinEnhancedPinGroupMixin:SetIcon(icon)
    assert(icon, "MapPinEnhancedPinGroupMixin:SetIcon: icon is nil")
    assert(type(icon) == "string", "MapPinEnhancedPinGroupMixin:SetIcon: icon must be a string")
    self.icon = icon
    Groups:PersistGroup(self)
end

function MapPinEnhancedPinGroupMixin:GetIcon()
    return self.icon
end

---@param pinData pinData
function MapPinEnhancedPinGroupMixin:AddPin(pinData)
    assert(pinData, "MapPinEnhancedPinGroupMixin:AddPin: pinData is nil")
    local pin = Pins:CreatePin(pinData)
    pin.group = self
    self.pins[pin.pinID] = pin
    self.count = self.count + 1
    Groups:PersistGroup(self)
end

---@param pinID UUID
function MapPinEnhancedPinGroupMixin:RemovePin(pinID)
    assert(pinID, "MapPinEnhancedPinGroupMixin:AddPin: pinID is nil")
    self.pins[pinID] = nil
    Pins:RemovePin(pinID)
    self.count = self.count - 1
    Groups:PersistGroup(self)
end

---@return fun(table: table<UUID, MapPinEnhancedPinMixin>, index?: UUID):UUID, MapPinEnhancedPinMixin
---@return MapPinEnhancedPinMixin
function MapPinEnhancedPinGroupMixin:EnumeratePins()
    return pairs(self.pins)
end

---@class SaveableGroupData : GroupInfo
---@field pins pinData[] a table of pin data that belongs to this group


---@return SaveableGroupData
function MapPinEnhancedPinGroupMixin:GetSaveableData()
    local data = {
        name = self.name,
        source = self.source,
        icon = self.icon,
        pins = {}
    }

    for _, pin in self:EnumeratePins() do
        table.insert(data.pins, pin:GetSaveableData())
    end

    return data
end
