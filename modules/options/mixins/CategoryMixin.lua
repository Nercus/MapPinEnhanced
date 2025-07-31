---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedOptionCategoryMixin
---@field name string
---@field id OptionCategories
---@field options table<string, MapPinEnhancedOptionMixin>
MapPinEnhancedOptionCategoryMixin = {}


---@class Options
---@field optionObjectPool ObjectPool<MapPinEnhancedOptionMixin>
local Options = MapPinEnhanced:GetModule("Options")

local function CreateObject()
    return CreateFromMixins(MapPinEnhancedOptionMixin)
end

local function ResetObject(_, object, isNew)
    if not object then return end
    if isNew then return end
    object:Reset()
end

function Options:GetOptionObjectPool()
    if not self.optionObjectPool then
        self.optionObjectPool = CreateObjectPool(CreateObject, ResetObject)
        self.optionObjectPool.capacity = 200
    end
    return self.optionObjectPool
end

function MapPinEnhancedOptionCategoryMixin:Init()
    self.name = nil
    self.options = {}
end

function MapPinEnhancedOptionCategoryMixin:Reset()
    self.name = nil
    self.options = {}
end

---@param name string
function MapPinEnhancedOptionCategoryMixin:SetName(name)
    self.name = name
end

function MapPinEnhancedOptionCategoryMixin:GetName()
    return self.name
end

---@param id string
function MapPinEnhancedOptionCategoryMixin:SetID(id)
    self.id = id
end

function MapPinEnhancedOptionCategoryMixin:GetID()
    return self.id
end

---@param optionType OptionType
---@param optionData OptionData
function MapPinEnhancedOptionCategoryMixin:AddOption(optionType, optionData)
    local optionPool = Options:GetOptionObjectPool()
    local optionElement = optionPool:Acquire()
    optionElement:SetCategory(self)
    optionElement:SetOptionData(optionData)
    optionElement:SetOptionType(optionType)
    table.insert(self.options, optionElement)
end

---@param label string
---@return MapPinEnhancedOptionMixin
function MapPinEnhancedOptionCategoryMixin:GetOption(label)
    return self.options[label]
end

function MapPinEnhancedOptionCategoryMixin:EnumerateOptions()
    return pairs(self.options)
end
