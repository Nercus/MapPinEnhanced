---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Options
local Options = MapPinEnhanced:GetModule("Options")

local L = MapPinEnhanced.L

---@enum OptionCategories
local CATEGORIES = {
    GENERAL = L["General"],
    PINS = L["Pins"],
    GROUPS = L["Groups"],
    TRACKER = L["Tracker"],
    MAPS = L["Maps"],
    IMPORT_EXPORT = L["Import/Export"],
}


local function CreateObject()
    return CreateAndInitFromMixin(MapPinEnhancedOptionMixin)
end
local function ResetObject(_, object, isNew)
    if not object then return end
    if isNew then return end
    object:Reset()
end

---@type ObjectPool<MapPinEnhancedOptionMixin>
local objectsPool = CreateObjectPool(CreateObject, ResetObject)
objectsPool.capacity = 200 -- only allow 200 objects at the same time


function Options:RegisterOption()
end

---@param category OptionCategories
---@param label string
function Options:GetOption(category, label)
end

function Options:EnableOption(option)
    assert(option, "Options:EnableOption: option is nil")
    assert(type(option) == "table", "Options:EnableOption: option must be a table")
    option:SetEnabled()
end

function Options:DisableOption(option)
    assert(option, "Options:DisableOption: option is nil")
    assert(type(option) == "table", "Options:DisableOption: option must be a table")
    option:SetDisabled()
end
