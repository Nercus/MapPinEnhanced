---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")

---@class GroupInfo
---@field groupID UUID? stable group identifier
---@field name string the name of the group
---@field source string the addon which owns the group
---@field icon string|number? the icon displayed for the group
---@field order number? higher group orders render earlier
---@field hidden boolean? true when the group has no active map pins
---@field groupType "ungrouped"|"way-back"? protected system group type
---@field trackingMode GroupTrackingMode? controls how the next tracked pin is selected

---@class MapPinEnhancedGroupMixin
---@field classification "group"
---@field groupID UUID
---@field pinState MapPinEnhancedGroupPinStateMixin
---@field name string
---@field source string
---@field icon string|number?
---@field order number
---@field hidden boolean
---@field groupType "ungrouped"|"way-back"|nil
---@field protected boolean
---@field trackingMode GroupTrackingMode
---@field trackingCursorOrder number? runtime-only order cursor used for ordered tracking
---@field isDeleting boolean
---@field limitWarningShown boolean
MapPinEnhancedGroupMixin = CreateFromMixins(
    { classification = "group" },
    MapPinEnhancedGroupTrackingMixin,
    MapPinEnhancedGroupPinOperationsMixin,
    MapPinEnhancedGroupPinRestorationMixin,
    MapPinEnhancedGroupPinEditingMixin
)

function MapPinEnhancedGroupMixin:Init()
    self.groupID = nil
    self.pinState = CreateAndInitFromMixin(MapPinEnhancedGroupPinStateMixin, self)
    self.order = GetTime()
    self.hidden = false
    self.trackingMode = Groups:GetDefaultTrackingMode()
    self.trackingCursorOrder = nil
    self.protected = false
    self.isDeleting = false
    self.limitWarningShown = false
end

function MapPinEnhancedGroupMixin:Reset()
    self.pinState:Reset()
    self.groupID = nil
    self.name = nil
    self.source = nil
    self.icon = nil
    self.order = 0
    self.hidden = false
    self.groupType = nil
    self.trackingMode = nil
    self.trackingCursorOrder = nil
    self.protected = false
    self.isDeleting = false
    self.limitWarningShown = false
end

---@param groupInfo GroupInfo
function MapPinEnhancedGroupMixin:ApplyGroupInfo(groupInfo)
    self.groupID = groupInfo.groupID or self.groupID or MapPinEnhanced:GenerateUUID("group")
    self.name = Groups:CleanGroupName(groupInfo.name)
    self.source = groupInfo.source
    self.icon = groupInfo.icon or "Interface\\Icons\\INV_Misc_QuestionMark"
    self.order = groupInfo.order or self.order or GetTime()
    self.groupType = Groups:GetSystemGroupType(self.groupID)
    self.protected = self.groupType ~= nil
    self.hidden = not self.protected and groupInfo.hidden and true or false
    if self.protected then
        self.trackingMode = Groups.TRACKING_MODE_NEAREST
    else
        self.trackingMode = Groups:GetTrackingModeOrDefault(groupInfo.trackingMode or self.trackingMode)
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

    local cleanName = Groups:CleanGroupName(name)
    local existingGroup = Groups:GetGroupByName(cleanName)
    if existingGroup and existingGroup ~= self then return false end

    self.name = cleanName
    self:TouchOrder()
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

---@param icon string|number
function MapPinEnhancedGroupMixin:SetIcon(icon)
    assert(icon, "MapPinEnhancedGroupMixin:SetIcon: icon is nil")
    assert(type(icon) == "string" or type(icon) == "number",
        "MapPinEnhancedGroupMixin:SetIcon: icon must be a string or number")
    self.icon = icon
    self:TouchOrder()
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

---@return fun(table: table<UUID, MapPinEnhancedPinMixin>, index?: UUID): UUID, MapPinEnhancedPinMixin
---@return table<UUID, MapPinEnhancedPinMixin>
---@return nil
function MapPinEnhancedGroupMixin:EnumeratePins()
    return self.pinState:EnumeratePins()
end

---@return fun(): UUID?, ArchivedPinData?
function MapPinEnhancedGroupMixin:EnumerateArchivedPins()
    return self.pinState:EnumerateArchivedCopies()
end

---@return MapPinEnhancedGroupPinEntry[]
function MapPinEnhancedGroupMixin:GetPinEntries()
    return self.pinState:GetEntries()
end

---@return SaveablePinData[]
function MapPinEnhancedGroupMixin:GetAllPinData()
    ---@type SaveablePinData[]
    local pins = {}
    for _, entry in ipairs(self:GetPinEntries()) do
        pins[#pins + 1] = entry.data
    end
    return pins
end

---@param pinID UUID
---@return MapPinEnhancedPinMixin?
function MapPinEnhancedGroupMixin:GetPinByID(pinID)
    assert(type(pinID) == "string", "MapPinEnhancedGroupMixin:GetPinByID: pinID must be a string")
    return self.pinState:GetPin(pinID)
end

---@param pinID UUID
---@return ArchivedPinData?
function MapPinEnhancedGroupMixin:GetArchivedPinByID(pinID)
    assert(type(pinID) == "string", "MapPinEnhancedGroupMixin:GetArchivedPinByID: pinID must be a string")
    return self.pinState:GetArchivedCopy(pinID)
end

---@return number
function MapPinEnhancedGroupMixin:GetPinCount()
    return self.pinState.count
end

---@param state "reached"|"hidden"?
---@return number
function MapPinEnhancedGroupMixin:GetArchiveCount(state)
    return self.pinState:GetArchiveCount(state)
end

---@return number
function MapPinEnhancedGroupMixin:GetReachedPinCount()
    return self:GetArchiveCount("reached")
end

---@return number
function MapPinEnhancedGroupMixin:GetTotalPinCount()
    return self:GetPinCount() + self:GetArchiveCount()
end

---@param pinID UUID
---@return number
function MapPinEnhancedGroupMixin:GetPinOrder(pinID)
    assert(type(pinID) == "string", "MapPinEnhancedGroupMixin:GetPinOrder: pinID must be a string")
    return assert(self.pinState:GetOrder(pinID),
        "MapPinEnhancedGroupMixin:GetPinOrder: pin is not retained by this group")
end

---@param pinID UUID
---@param order number
---@return boolean
function MapPinEnhancedGroupMixin:SetPinOrder(pinID, order)
    assert(type(pinID) == "string", "MapPinEnhancedGroupMixin:SetPinOrder: pinID must be a string")
    assert(type(order) == "number", "MapPinEnhancedGroupMixin:SetPinOrder: order must be a number")
    if not self.pinState:SetOrder(pinID, order) then return false end
    self:PersistPinChanges()
    return true
end

---@return number
function MapPinEnhancedGroupMixin:GetPinChangeNumber()
    return self.pinState.changeNumber
end

---@param order number
function MapPinEnhancedGroupMixin:SetOrder(order)
    assert(type(order) == "number", "MapPinEnhancedGroupMixin:SetOrder: order must be a number")
    self.order = order
    Groups:PersistGroup(self)
end

function MapPinEnhancedGroupMixin:TouchOrder()
    if self.protected then return end
    self.order = GetTime()
end

---Check the complete pin state, then optionally update group order before scheduling persistence.
---@param updateGroupOrder boolean?
function MapPinEnhancedGroupMixin:PersistPinChanges(updateGroupOrder)
    self.pinState:CheckPinState()
    if updateGroupOrder then self:TouchOrder() end
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
---@field pinOrder table<UUID, number> active pin order values keyed by pinID
---@field pinArchive table<UUID, ArchivedPinData>
---@field trackingMode GroupTrackingMode?

---@return SaveableGroupData
function MapPinEnhancedGroupMixin:GetSaveableData()
    local pins, pinOrder, pinArchive = self.pinState:Serialize()
    local data = {
        groupID = self.groupID,
        name = self.name,
        source = self.source,
        icon = self.icon,
        order = self.order,
        hidden = self.hidden,
        groupType = self.groupType,
        pins = pins,
        pinOrder = pinOrder,
        pinArchive = pinArchive,
    }
    ---@cast data SaveableGroupData
    if not self:IsProtected() then data.trackingMode = self:GetTrackingMode() end
    return data
end
