---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedGroupMixin
MapPinEnhancedGroupPinEditingMixin = {}

---@param pinIDs UUID[]
---@return boolean
function MapPinEnhancedGroupPinEditingMixin:ReorderPins(pinIDs)
    assert(type(pinIDs) == "table", "MapPinEnhancedGroupMixin:ReorderPins: pinIDs must be a table")
    if not self.pinState:Reorder(pinIDs) then return false end
    self:PersistPinChanges()
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, self)
    return true
end

---@param group MapPinEnhancedGroupMixin
---@param pinID UUID
---@param update fun(data: SaveablePinData)
---@return boolean
local function UpdateArchived(group, pinID, update)
    if not group.pinState:UpdateArchived(pinID, update) then return false end
    group:PersistPinChanges()
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, group)
    return true
end

---@param pinID UUID
---@param color PinColor?
---@return boolean
function MapPinEnhancedGroupPinEditingMixin:SetPinColor(pinID, color)
    local pin = self:GetPinByID(pinID)
    if pin then
        pin:SetColor(color)
        return true
    end
    return UpdateArchived(self, pinID, function(data)
        data.color, data.texture, data.usesAtlas = color, nil, nil
    end)
end

---@param pinID UUID
---@param icon string|number?
---@param usesAtlas boolean?
---@return boolean
function MapPinEnhancedGroupPinEditingMixin:SetPinIcon(pinID, icon, usesAtlas)
    local pin = self:GetPinByID(pinID)
    if pin then
        pin:SetIcon(icon, usesAtlas)
        return true
    end
    return UpdateArchived(self, pinID, function(data)
        if icon then
            data.texture, data.usesAtlas, data.color = icon, usesAtlas, nil
        else
            data.texture, data.usesAtlas, data.color = nil, nil, Pins.DEFAULT_COLOR
        end
    end)
end

---@param pinID UUID
---@param mapID number
---@param x number
---@param y number
---@return boolean
function MapPinEnhancedGroupPinEditingMixin:SetPinPosition(pinID, mapID, x, y)
    assert(type(mapID) == "number", "MapPinEnhancedGroupMixin:SetPinPosition: mapID must be a number")
    assert(type(x) == "number", "MapPinEnhancedGroupMixin:SetPinPosition: x must be a number")
    assert(type(y) == "number", "MapPinEnhancedGroupMixin:SetPinPosition: y must be a number")
    x, y = Pins:ConvertPercentCoordinate(x), Pins:ConvertPercentCoordinate(y)
    local pin = self:GetPinByID(pinID)
    if pin then
        pin:SetPinPosition(mapID, x, y)
        return true
    end
    return UpdateArchived(self, pinID, function(data)
        data.mapID, data.x, data.y = mapID, x, y
    end)
end

---@param pinID UUID
---@param title string
---@return boolean
function MapPinEnhancedGroupPinEditingMixin:SetPinTitle(pinID, title)
    assert(type(title) == "string", "MapPinEnhancedGroupMixin:SetPinTitle: title must be a string")
    local pin = self:GetPinByID(pinID)
    if pin then
        pin:SetTitle(title)
        return true
    end
    return UpdateArchived(self, pinID, function(data)
        data.title = title
        if data.tooltip then data.tooltip.title = title end
    end)
end

---@param pinID UUID
---@param locked boolean?
---@return boolean
function MapPinEnhancedGroupPinEditingMixin:SetPinLock(pinID, locked)
    local pin = self:GetPinByID(pinID)
    if pin then
        pin:SetLock(locked)
        return true
    end
    return UpdateArchived(self, pinID, function(data)
        data.lock = locked
    end)
end
