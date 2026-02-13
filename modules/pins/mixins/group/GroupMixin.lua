---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class GroupInfo
---@field name string the name of the group
---@field source string the name of the addon which is registering the group, used to identify the group.
---@field icon string? the icon of the group, used to display the group on the map


---@class MapPinEnhancedGroupMixin
---@field classification 'group'
---@field pins table<UUID, MapPinEnhancedPinMixin> a table of pins that belong to this
---@field name string the name of the group
---@field source string the name of the addon which is registering the group, used to identify the group.
---@field icon string? the icon of the group, used to display the group on the map
MapPinEnhancedGroupMixin = CreateFromMixins(
    { classification = "group" },
    MapPinEnhancedGroupProxyMixin
)

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")
local Pins = MapPinEnhanced:GetModule("Pins")

function MapPinEnhancedGroupMixin:Init()
    self.pins = {}
    self.count = 0
end

function MapPinEnhancedGroupMixin:Reset()
    self.pins = {}
    self.name = nil
    self.source = nil
    self.icon = nil
    self.count = 0
end

---@param name string
function MapPinEnhancedGroupMixin:SetName(name)
    assert(name, "MapPinEnhancedGroupMixin:SetName: name is nil")
    assert(type(name) == "string", "MapPinEnhancedGroupMixin:SetName: name must be a string")
    self.name = name
    Groups:PersistGroup(self)
end

function MapPinEnhancedGroupMixin:GetName()
    return self.name
end

---@param source string
function MapPinEnhancedGroupMixin:SetSource(source)
    assert(source, "MapPinEnhancedGroupMixin:SetSource: source is nil")
    assert(type(source) == "string", "MapPinEnhancedGroupMixin:SetSource: source must be a string")
    assert(C_AddOns.IsAddOnLoaded(source), "MapPinEnhancedGroupMixin:SetSource: source is not a loaded addon")
    self.source = source
    Groups:PersistGroup(self)
end

function MapPinEnhancedGroupMixin:GetSource()
    return self.source
end

---@param icon string
function MapPinEnhancedGroupMixin:SetIcon(icon)
    assert(icon, "MapPinEnhancedGroupMixin:SetIcon: icon is nil")
    assert(type(icon) == "string", "MapPinEnhancedGroupMixin:SetIcon: icon must be a string")
    self.icon = icon
    Groups:PersistGroup(self)
end

function MapPinEnhancedGroupMixin:GetIcon()
    return self.icon
end

---@param pinData pinData
---@param overridePinID UUID? if provided, the pin will be created with this ID instead of a new one
---@param skipPersist boolean? if true, the group will not be persisted after adding the pin, used for batch adding pins
---@param skipCallbacks boolean? if true, callbacks will not be fired, used for batch adding pins
---@return MapPinEnhancedPinMixin?
function MapPinEnhancedGroupMixin:AddPin(pinData, overridePinID, skipPersist, skipCallbacks)
    assert(pinData, "MapPinEnhancedGroupMixin:AddPin: pinData is nil")
    local pin = Pins:CreatePin(pinData)
    if overridePinID then
        pin:OverridePinID(overridePinID)
    end
    pin.group = self
    self.pins[pin.pinID] = pin
    self.count = self.count + 1
    if not skipPersist then
        Groups:PersistGroup(self)
    end
    if not skipCallbacks then
        MapPinEnhanced:FireCallback("PIN_ADDED", nil, self, pin)
    end
    return pin
end

--- To add multiple pins at once including batched execution
---@param pinsData pinData[] | SaveablePinData[]
function MapPinEnhancedGroupMixin:AddMultiplePins(pinsData)
    assert(pinsData, "MapPinEnhancedGroupMixin:AddMultiplePins: pinsData is nil")
    assert(type(pinsData) == "table", "MapPinEnhancedGroupMixin:AddMultiplePins: pinsData must be a table")
    local numberOfPins = #pinsData
    if numberOfPins == 0 then return end

    if numberOfPins < 50 then
        for _, pinData in ipairs(pinsData) do
            self:AddPin(pinData, pinData.pinID, true)
        end
        Groups:PersistGroup(self)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
        return
    end
    local addingPinsFunctions = {}
    for _, pinData in ipairs(pinsData) do
        table.insert(addingPinsFunctions, function()
            self:AddPin(pinData, pinData.pinID, true)
        end)
    end
    local batchSize = math.min(math.max(math.ceil(numberOfPins / 60), 10), 100)
    MapPinEnhanced:BatchExecution(addingPinsFunctions, nil, function()
        Groups:PersistGroup(self)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end, batchSize)
end

---@param pinID UUID
---@param skipPersist boolean? if true, the group will not be persisted after removing the pin, used for batch removing pins
---@param skipCallbacks boolean? if true, callbacks will not be fired, used for batch removing pins
function MapPinEnhancedGroupMixin:RemovePin(pinID, skipPersist, skipCallbacks)
    assert(pinID, "MapPinEnhancedGroupMixin:AddPin: pinID is nil")
    local pin = self.pins[pinID]
    if not pin then return end

    self.pins[pinID] = nil
    self.count = self.count - 1

    if not skipPersist then
        Groups:PersistGroup(self)
    end
    Pins:ReleasePin(pinID)

    if not skipCallbacks then
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end
end

---Removes multiple pins at once including batched execution
---@param pinIDs UUID[]
function MapPinEnhancedGroupMixin:RemoveMultiplePins(pinIDs)
    assert(pinIDs, "MapPinEnhancedGroupMixin:RemoveMultiplePins: pinIDs is nil")
    assert(type(pinIDs) == "table", "MapPinEnhancedGroupMixin:RemoveMultiplePins: pinIDs must be a table")
    local numberOfPins = #pinIDs
    if numberOfPins == 0 then return end

    if numberOfPins < 50 then
        for _, pinID in ipairs(pinIDs) do
            self:RemovePin(pinID, true)
        end
        Groups:PersistGroup(self)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
        return
    end
    local removingPinsFunctions = {}
    for _, pinID in ipairs(pinIDs) do
        table.insert(removingPinsFunctions, function()
            self:RemovePin(pinID, true)
        end)
    end
    local batchSize = math.min(math.max(math.ceil(numberOfPins / 60), 10), 100)
    MapPinEnhanced:BatchExecution(removingPinsFunctions, nil, function()
        Groups:PersistGroup(self)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end, batchSize)
end

---@return fun(table: table<UUID, MapPinEnhancedPinMixin>, index?: UUID):UUID, MapPinEnhancedPinMixin
---@return MapPinEnhancedPinMixin
function MapPinEnhancedGroupMixin:EnumeratePins()
    return pairs(self.pins)
end

function MapPinEnhancedGroupMixin:GetPinByID(pinID)
    assert(pinID, "MapPinEnhancedGroupMixin:GetPinByID: pinID is nil")
    assert(type(pinID) == "string", "MapPinEnhancedGroupMixin:GetPinByID: pinID must be a string")
    return self.pins[pinID]
end

function MapPinEnhancedGroupMixin:GetPinCount()
    return self.count
end

---@class SaveableGroupData : GroupInfo
---@field pins SaveablePinData[] a table of pin data that belongs to this group


---@return SaveableGroupData
function MapPinEnhancedGroupMixin:GetSaveableData()
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
