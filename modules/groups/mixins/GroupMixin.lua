---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class GroupInfo
---@field groupID UUID? stable group identifier
---@field name string the name of the group
---@field source string the name of the addon which is registering the group, used to identify the group.
---@field icon string? the icon of the group, used to display the group on the map
---@field order number? the order of the group in the tracker, lower numbers are higher in the list
---@field hidden boolean? true if this group is stored away and has no active map pins
---@field groupType "ungrouped"|"wayBack"? protected system group type
---@field trackingMode GroupTrackingMode? controls how the next tracked pin is selected

---@class ArchivedPinData
---@field state "reached"|"hidden"
---@field data SaveablePinData
---@field order number

---@class MapPinEnhancedGroupMixin
---@field classification 'group'
---@field groupID UUID
---@field pins table<UUID, MapPinEnhancedPinMixin> active pins that are currently on the map
---@field pinOrder table<UUID, number> tracker order for active pins by pinID
---@field pinArchive table<UUID, ArchivedPinData> non-live pin data for reached or hidden pins
---@field name string
---@field source string
---@field icon string?
---@field order number
---@field hidden boolean
---@field groupType "ungrouped"|"wayBack"|nil
---@field protected boolean
---@field count number active pin count
---@field trackingMode GroupTrackingMode
---@field trackingCursorOrder number? runtime-only order cursor used for ordered tracking
MapPinEnhancedGroupMixin = CreateFromMixins(
    { classification = "group" },
    MapPinEnhancedGroupTrackingMixin
)

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")
local Pins = MapPinEnhanced:GetModule("Pins")

local ARCHIVE_STATE_REACHED = "reached"
local ARCHIVE_STATE_HIDDEN = "hidden"

local function GetSaveablePinData(pinData, pinID)
    ---@type SaveablePinData
    local saveablePinData = CopyTable(pinData)
    saveablePinData.pinID = pinID or saveablePinData.pinID or MapPinEnhanced:GenerateUUID("pin")
    saveablePinData.setTracked = nil
    return saveablePinData
end

---@param group MapPinEnhancedGroupMixin
---@return number
local function GetNextPinOrder(group)
    ---@type number?
    local maxOrder
    for _, order in pairs(group.pinOrder or {}) do
        if type(order) == "number" and (not maxOrder or order > maxOrder) then
            maxOrder = order
        end
    end
    for _, archivedPin in pairs(group.pinArchive or {}) do
        local order = archivedPin.order
        if type(order) == "number" and (not maxOrder or order > maxOrder) then
            maxOrder = order
        end
    end

    if maxOrder then
        return maxOrder + 1
    end
    return GetTime()
end

function MapPinEnhancedGroupMixin:Init()
    self.groupID = nil
    self.pins = {}
    self.pinOrder = {}
    self.pinArchive = {}
    self.count = 0
    self.order = GetTime()
    self.hidden = false
    self.trackingMode = Groups:GetDefaultTrackingMode()
    self.trackingCursorOrder = nil
    self.protected = false
    self.isDeleting = false
end

function MapPinEnhancedGroupMixin:Reset()
    for pinID in pairs(self.pins or {}) do
        Pins:ReleasePin(pinID)
    end

    self.groupID = nil
    self.pins = {}
    self.pinOrder = {}
    self.pinArchive = {}
    self.name = nil
    self.source = nil
    self.icon = nil
    self.count = 0
    self.order = 0
    self.hidden = false
    self.groupType = nil
    self.trackingMode = nil
    self.trackingCursorOrder = nil
    self.protected = false
    self.isDeleting = false
end

---@param groupInfo GroupInfo
function MapPinEnhancedGroupMixin:ApplyGroupInfo(groupInfo)
    self.groupID = groupInfo.groupID or self.groupID or MapPinEnhanced:GenerateUUID("group")
    self.name = Groups:NormalizeGroupName(groupInfo.name)
    self.source = groupInfo.source
    self.icon = groupInfo.icon or "Interface\\Icons\\INV_Misc_QuestionMark"
    self.order = groupInfo.order or self.order or GetTime()
    self.hidden = groupInfo.hidden and true or false
    self.groupType = groupInfo.groupType
    self.protected = self.groupType ~= nil
    if self.protected then
        self.trackingMode = Groups.TRACKING_MODE_NEAREST
    else
        self.trackingMode = Groups:NormalizeTrackingMode(groupInfo.trackingMode or self.trackingMode)
    end
end

---@param name string
---@return boolean
function MapPinEnhancedGroupMixin:SetName(name)
    assert(name, "MapPinEnhancedGroupMixin:SetName: name is nil")
    assert(type(name) == "string", "MapPinEnhancedGroupMixin:SetName: name must be a string")
    if self.groupType == "ungrouped" then
        return Groups:CreateGroupFromUngrouped(name) ~= nil
    end
    if self.protected then return false end

    local normalizedName = Groups:NormalizeGroupName(name)
    local existingGroup = Groups:GetGroupByName(normalizedName)
    if existingGroup and existingGroup ~= self then
        return false
    end

    self.name = normalizedName
    Groups:PersistGroup(self)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

function MapPinEnhancedGroupMixin:GetName()
    return self.name
end

function MapPinEnhancedGroupMixin:GetGroupID()
    return self.groupID
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

function MapPinEnhancedGroupMixin:IsHidden()
    return self.hidden
end

function MapPinEnhancedGroupMixin:IsProtected()
    return self.protected
end

---@param pinData pinData|SaveablePinData
---@param state "reached"|"hidden"
---@param order number?
---@return UUID
function MapPinEnhancedGroupMixin:ArchivePinData(pinData, state, order)
    local pinID = pinData.pinID or MapPinEnhanced:GenerateUUID("pin")
    local saveablePinData = GetSaveablePinData(pinData, pinID)
    self.pinArchive[pinID] = {
        state = state,
        data = saveablePinData,
        order = order or GetNextPinOrder(self),
    }
    return pinID
end

---@param pinData pinData
---@param overridePinID UUID? if provided, the pin will be created with this ID instead of a new one
---@param skipPersist boolean? if true, the group will not be persisted after adding the pin, used for batch adding pins
---@param skipCallbacks boolean? if true, callbacks will not be fired, used for batch adding pins
---@return MapPinEnhancedPinMixin?, UUID?
function MapPinEnhancedGroupMixin:AddPin(pinData, overridePinID, skipPersist, skipCallbacks)
    assert(pinData, "MapPinEnhancedGroupMixin:AddPin: pinData is nil")

    if self.hidden then
        local archivePinData = pinData
        if overridePinID then
            archivePinData = CopyTable(pinData)
            archivePinData.pinID = overridePinID
        end
        local pinID = self:ArchivePinData(archivePinData, ARCHIVE_STATE_HIDDEN)
        if not skipPersist then
            Groups:PersistGroup(self)
        end
        if not skipCallbacks then
            MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
        end
        return nil, pinID
    end

    local pin = Pins:CreatePin(pinData, overridePinID, self)

    local currentOrder = self.pinOrder[pin.pinID]
    if not currentOrder then
        currentOrder = GetNextPinOrder(self)
    end
    self.pinOrder[pin.pinID] = currentOrder

    self.pins[pin.pinID] = pin
    self.count = self.count + 1
    if not skipPersist then
        Groups:PersistGroup(self)
    end
    if not skipCallbacks then
        MapPinEnhanced:FireCallback("PIN_ADDED", nil, self, pin)
    end
    return pin, pin.pinID
end

---@param pinsData pinData[] | SaveablePinData[]
function MapPinEnhancedGroupMixin:AddMultiplePins(pinsData)
    assert(pinsData, "MapPinEnhancedGroupMixin:AddMultiplePins: pinsData is nil")
    assert(type(pinsData) == "table", "MapPinEnhancedGroupMixin:AddMultiplePins: pinsData must be a table")
    local numberOfPins = #pinsData
    if numberOfPins == 0 then return end

    if numberOfPins < 50 then
        for _, pinData in ipairs(pinsData) do
            self:AddPin(pinData, pinData.pinID, true, true)
        end
        Groups:PersistGroup(self)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
        return
    end
    local addingPinsFunctions = {}
    for _, pinData in ipairs(pinsData) do
        table.insert(addingPinsFunctions, function()
            self:AddPin(pinData, pinData.pinID, true, true)
        end)
    end
    local batchSize = math.min(math.max(math.ceil(numberOfPins / 60), 10), 100)
    MapPinEnhanced:BatchExecution(addingPinsFunctions, nil, function()
        Groups:PersistGroup(self)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end, batchSize)
end

---@param pinID UUID
---@param skipPersist boolean?
---@param skipCallbacks boolean?
---@return boolean
function MapPinEnhancedGroupMixin:RemovePin(pinID, skipPersist, skipCallbacks)
    assert(pinID, "MapPinEnhancedGroupMixin:RemovePin: pinID is nil")

    local pin = self.pins[pinID]
    if pin then
        local wasTracked = pin:IsTracked()
        local order = self.pinOrder[pinID]
        local nextOrderedPin = wasTracked and self:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED and
            self:GetOrderedTrackablePin(order) or nil
        self.pins[pinID] = nil
        self.pinOrder[pinID] = nil
        self.count = self.count - 1

        if not skipCallbacks then
            MapPinEnhanced:FireCallback("PIN_REMOVED", nil, self, pin)
        end
        Pins:ReleasePin(pinID)

        if not skipPersist then
            Groups:PersistGroup(self)
        end
        if wasTracked and not skipCallbacks then
            if nextOrderedPin and self.pins[nextOrderedPin.pinID] then
                nextOrderedPin:Track()
            else
                Groups:TrackNextPinAfterGroup(self, order)
            end
        end
        return true
    end

    if self.pinArchive[pinID] then
        self.pinArchive[pinID] = nil
        if not skipPersist then
            Groups:PersistGroup(self)
        end
        if not skipCallbacks then
            MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
        end
        return true
    end

    return false
end

---@param pinID UUID
---@return boolean
function MapPinEnhancedGroupMixin:MarkPinReached(pinID)
    assert(pinID, "MapPinEnhancedGroupMixin:MarkPinReached: pinID is nil")

    local archivedPin = self.pinArchive[pinID]
    if archivedPin then
        return archivedPin.state == ARCHIVE_STATE_REACHED
    end

    local pin = self.pins[pinID]
    if not pin then return false end

    local wasTracked = pin:IsTracked()
    local saveablePinData = GetSaveablePinData(pin:GetSaveableData(), pinID)
    local order = self.pinOrder[pinID] or GetTime()
    local nextOrderedPin = wasTracked and self:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED and
        self:GetOrderedTrackablePin(order) or nil

    self.pins[pinID] = nil
    self.pinOrder[pinID] = nil
    self.count = self.count - 1
    self.pinArchive[pinID] = {
        state = ARCHIVE_STATE_REACHED,
        data = saveablePinData,
        order = order,
    }

    MapPinEnhanced:FireCallback("PIN_REACHED", nil, self, pinID, saveablePinData)
    Pins:ReleasePin(pinID)
    Groups:PersistGroup(self)

    if wasTracked then
        if nextOrderedPin and self.pins[nextOrderedPin.pinID] then
            nextOrderedPin:Track()
        else
            Groups:TrackNextPinAfterGroup(self, order)
        end
    end

    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@param state "reached"|"hidden"?
---@return number
function MapPinEnhancedGroupMixin:GetArchiveCount(state)
    local count = 0
    for _, archivedPin in pairs(self.pinArchive) do
        if not state or archivedPin.state == state then
            count = count + 1
        end
    end
    return count
end

function MapPinEnhancedGroupMixin:GetReachedPinCount()
    return self:GetArchiveCount(ARCHIVE_STATE_REACHED)
end

function MapPinEnhancedGroupMixin:GetTotalPinCount()
    return self.count + self:GetArchiveCount()
end

---@return boolean
function MapPinEnhancedGroupMixin:RestoreReachedPins()
    if self.hidden then return false end

    local restored = false
    for pinID, archivedPin in pairs(self.pinArchive) do
        if archivedPin.state == ARCHIVE_STATE_REACHED then
            self.pinOrder[pinID] = archivedPin.order or GetTime()
            self.pinArchive[pinID] = nil
            self:AddPin(archivedPin.data, pinID, true, true)
            restored = true
        end
    end

    if restored then
        Groups:PersistGroup(self)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    end
    return restored
end

---@return boolean
function MapPinEnhancedGroupMixin:HideGroup()
    if self.protected or self.hidden then return false end

    local hadTrackedPin = false
    for pinID, pin in pairs(self.pins) do
        if pin:IsTracked() then
            hadTrackedPin = true
        end
        local saveablePinData = GetSaveablePinData(pin:GetSaveableData(), pinID)
        self.pinArchive[pinID] = {
            state = ARCHIVE_STATE_HIDDEN,
            data = saveablePinData,
            order = self.pinOrder[pinID] or GetTime(),
        }
        Pins:ReleasePin(pinID)
    end

    for _, archivedPin in pairs(self.pinArchive) do
        archivedPin.state = ARCHIVE_STATE_HIDDEN
    end

    self.pins = {}
    self.pinOrder = {}
    self.count = 0
    self.hidden = true

    Groups:PersistGroup(self)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    if hadTrackedPin then
        Groups:TrackNextPinAfterGroup(self)
    end
    return true
end

---@return boolean
function MapPinEnhancedGroupMixin:ShowGroup()
    if not self.hidden then return false end

    self.hidden = false
    for pinID, archivedPin in pairs(self.pinArchive) do
        self.pinOrder[pinID] = archivedPin.order or GetTime()
        self.pinArchive[pinID] = nil
        self:AddPin(archivedPin.data, pinID, true, true)
    end

    Groups:PersistGroup(self)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@return boolean
function MapPinEnhancedGroupMixin:ClearGroup()
    if not self.protected then return false end

    for pinID in pairs(self.pins) do
        Pins:ReleasePin(pinID)
    end
    self.pins = {}
    self.pinOrder = {}
    self.pinArchive = {}
    self.count = 0

    Groups:PersistGroup(self)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@param pinIDs UUID[]
function MapPinEnhancedGroupMixin:RemoveMultiplePins(pinIDs)
    assert(pinIDs, "MapPinEnhancedGroupMixin:RemoveMultiplePins: pinIDs is nil")
    assert(type(pinIDs) == "table", "MapPinEnhancedGroupMixin:RemoveMultiplePins: pinIDs must be a table")
    local numberOfPins = #pinIDs
    if numberOfPins == 0 then return end

    if numberOfPins < 50 then
        for _, pinID in ipairs(pinIDs) do
            self:RemovePin(pinID, true, true)
        end
        Groups:PersistGroup(self)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
        return
    end
    local removingPinsFunctions = {}
    for _, pinID in ipairs(pinIDs) do
        table.insert(removingPinsFunctions, function()
            self:RemovePin(pinID, true, true)
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

function MapPinEnhancedGroupMixin:EnumerateArchivedPins()
    return pairs(self.pinArchive)
end

---@return SaveablePinData[]
function MapPinEnhancedGroupMixin:GetAllPinData()
    local pins = {}
    for _, pin in self:EnumeratePins() do
        table.insert(pins, pin:GetSaveableData())
    end
    for _, archivedPin in self:EnumerateArchivedPins() do
        table.insert(pins, archivedPin.data)
    end
    return pins
end

function MapPinEnhancedGroupMixin:GetPinByID(pinID)
    assert(pinID, "MapPinEnhancedGroupMixin:GetPinByID: pinID is nil")
    assert(type(pinID) == "string", "MapPinEnhancedGroupMixin:GetPinByID: pinID must be a string")
    return self.pins[pinID]
end

function MapPinEnhancedGroupMixin:GetArchivedPinByID(pinID)
    assert(pinID, "MapPinEnhancedGroupMixin:GetArchivedPinByID: pinID is nil")
    assert(type(pinID) == "string", "MapPinEnhancedGroupMixin:GetArchivedPinByID: pinID must be a string")
    return self.pinArchive[pinID]
end

function MapPinEnhancedGroupMixin:GetPinCount()
    return self.count
end

---@param pinID UUID
---@return number
function MapPinEnhancedGroupMixin:GetPinOrder(pinID)
    assert(pinID, "MapPinEnhancedGroupMixin:GetPinOrder: pinID is nil")
    assert(type(pinID) == "string", "MapPinEnhancedGroupMixin:GetPinOrder: pinID must be a string")

    local order = self.pinOrder[pinID]
    if not order then
        order = GetTime()
        self.pinOrder[pinID] = order
    end
    return order
end

---@param pinID UUID
---@param order number
---@param skipPersist boolean? if true, the group will not be persisted after setting the order
function MapPinEnhancedGroupMixin:SetPinOrder(pinID, order, skipPersist)
    assert(pinID, "MapPinEnhancedGroupMixin:SetPinOrder: pinID is nil")
    assert(type(pinID) == "string", "MapPinEnhancedGroupMixin:SetPinOrder: pinID must be a string")
    assert(order, "MapPinEnhancedGroupMixin:SetPinOrder: order is nil")
    assert(type(order) == "number", "MapPinEnhancedGroupMixin:SetPinOrder: order must be a number")

    self.pinOrder[pinID] = order
    if not skipPersist then
        Groups:PersistGroup(self)
    end
end

---@param order number
function MapPinEnhancedGroupMixin:SetOrder(order)
    assert(order, "MapPinEnhancedGroupMixin:SetOrder: order is nil")
    assert(type(order) == "number", "MapPinEnhancedGroupMixin:SetOrder: order must be a number")
    self.order = order
    Groups:PersistGroup(self)
end

---@return number
function MapPinEnhancedGroupMixin:GetOrder()
    return self.order
end

---@class SaveableGroupData : GroupInfo
---@field groupID UUID
---@field hidden boolean
---@field pins SaveablePinData[] active pin data that belongs to this group
---@field pinOrder table<UUID, number> a table of active pin order values keyed by pinID
---@field pinArchive table<UUID, ArchivedPinData>
---@field trackingMode GroupTrackingMode?

---@return SaveableGroupData
function MapPinEnhancedGroupMixin:GetSaveableData()
    local data = {
        groupID = self.groupID,
        name = self.name,
        source = self.source,
        icon = self.icon,
        order = self.order,
        hidden = self.hidden,
        groupType = self.groupType,
        pins = {},
        pinOrder = {},
        pinArchive = {},
    }
    ---@cast data SaveableGroupData

    if not self:IsProtected() then
        data.trackingMode = self:GetTrackingMode()
    end

    for pinID, savedOrder in pairs(self.pinOrder) do
        data.pinOrder[pinID] = savedOrder
    end

    for pinID, archivedPin in pairs(self.pinArchive) do
        data.pinArchive[pinID] = CopyTable(archivedPin)
    end

    for _, pin in self:EnumeratePins() do
        table.insert(data.pins, pin:GetSaveableData())
    end

    return data
end
