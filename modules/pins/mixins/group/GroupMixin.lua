---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinGroupMixin
---@field name string the name of the group
---@field source string the addon which is registering the group, used to identify the group.
---@field icon string? the icon of the group, used to display the group on the map
---@field pins table<UUID, MapPinEnhancedPinMixin> a table of pins that belong to this
---@field trackerEntry MapPinEnhancedTrackerGroupMixin? the tracker entry for this group, if any
MapPinEnhancedPinGroupMixin = {}

---@class Groups
---@field trackerObjectPool ObjectPool<MapPinEnhancedTrackerGroupMixin>
---@field framePool FramePoolCollection<MapPinEnhancedTrackerGroupEntryTemplate>
local Groups = MapPinEnhanced:GetModule("Groups")
local Pins = MapPinEnhanced:GetModule("Pins")
local Tracker = MapPinEnhanced:GetModule("Tracker")

local function CreateGroupObject()
    return CreateFromMixins(MapPinEnhancedTrackerGroupMixin)
end

---@param trackerEntry MapPinEnhancedTrackerGroupMixin
local function ResetGroupObject(_, trackerEntry)
    trackerEntry:Reset()
end

function Groups:GetTrackerObjectPool()
    if not self.trackerObjectPool then
        self.trackerObjectPool = CreateObjectPool(CreateGroupObject, ResetGroupObject)
    end

    return self.trackerObjectPool
end

function MapPinEnhancedPinGroupMixin:Init()
    self.pins = {}
    self.count = 0

    local trackerObjectPool = Groups:GetTrackerObjectPool()
    self.trackerEntry = trackerObjectPool:Acquire()
end

function MapPinEnhancedPinGroupMixin:Reset()
    self.pins = {}
    self.name = nil
    self.source = nil
    self.icon = nil
    self.count = 0

    local trackerObjectPool = Groups:GetTrackerObjectPool()
    trackerObjectPool:Release(self.trackerEntry)
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
---@param overridePinID UUID? if provided, the pin will be created with this ID instead of a new one
function MapPinEnhancedPinGroupMixin:AddPin(pinData, overridePinID)
    assert(pinData, "MapPinEnhancedPinGroupMixin:AddPin: pinData is nil")
    local treeNode = self.trackerEntry:GetTreeNode()
    if not treeNode then
        -- group is not initialized in the tracker yet
        local groupNode = Tracker:AddGroup(self)
        self.trackerEntry:SetTreeNode(groupNode)
        self:AddPin(pinData, overridePinID) -- retry adding the pin after initializing the group
        return
    end

    local pin = Pins:CreatePin(pinData)
    if overridePinID then
        pin:OverridePinID(overridePinID)
    end
    pin.group = self
    self.pins[pin.pinID] = pin
    self.count = self.count + 1
    self.trackerEntry:AddPin(pin)
    Groups:PersistGroup(self)
end

---@param pinID UUID
function MapPinEnhancedPinGroupMixin:RemovePin(pinID)
    assert(pinID, "MapPinEnhancedPinGroupMixin:AddPin: pinID is nil")
    local pin = self.pins[pinID]
    self.count = self.count - 1
    self.trackerEntry:RemovePin(pin.trackerEntry) -- if this is the last pin, remove the group tracker entry as well
    self.pins[pinID] = nil
    Pins:RemovePin(pinID)
    Groups:PersistGroup(self)

    if self.count == 0 then
        Tracker:RemoveGroup(self.trackerEntry:GetTreeNode())
        self.trackerEntry:Reset() -- reset the tracker entry to avoid memory leaks
    end
end

---@return fun(table: table<UUID, MapPinEnhancedPinMixin>, index?: UUID):UUID, MapPinEnhancedPinMixin
---@return MapPinEnhancedPinMixin
function MapPinEnhancedPinGroupMixin:EnumeratePins()
    return pairs(self.pins)
end

function MapPinEnhancedPinGroupMixin:GetPinByID(pinID)
    assert(pinID, "MapPinEnhancedPinGroupMixin:GetPinByID: pinID is nil")
    assert(type(pinID) == "string", "MapPinEnhancedPinGroupMixin:GetPinByID: pinID must be a string")
    return self.pins[pinID]
end

function MapPinEnhancedPinGroupMixin:GetPinCount()
    return self.count
end

---@class SaveableGroupData : GroupInfo
---@field pins SaveablePinData[] a table of pin data that belongs to this group


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
