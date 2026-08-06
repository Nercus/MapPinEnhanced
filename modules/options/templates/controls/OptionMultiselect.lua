---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Options
local Options = MapPinEnhanced:GetModule("Options")

---@param value MapPinEnhancedMultiselectValue?
---@return MapPinEnhancedMultiselectValue
local function CopySet(value)
    ---@type MapPinEnhancedMultiselectValue
    local result = {}
    if type(value) ~= "table" then return result end
    for key, selected in pairs(value) do
        if selected then result[key] = true end
    end
    return result
end

---@param left MapPinEnhancedMultiselectValue?
---@param right MapPinEnhancedMultiselectValue?
---@return boolean
local function SetsEqual(left, right)
    left, right = CopySet(left), CopySet(right)
    for key in pairs(left) do if not right[key] then return false end end
    for key in pairs(right) do if not left[key] then return false end end
    return true
end

---@class MapPinEnhancedOptionMultiselectTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedMultiselectTemplate
MapPinEnhancedOptionMultiselectMixin = {}

---@return MapPinEnhancedMultiselectValue
function MapPinEnhancedOptionMultiselectMixin:GetValue()
    return self.child:GetValue()
end

---@param value MapPinEnhancedMultiselectValue?
function MapPinEnhancedOptionMultiselectMixin:SetValue(value)
    self.child:SetValue(value)
end

---@param value MapPinEnhancedMultiselectValue?
---@return boolean
function MapPinEnhancedOptionMultiselectMixin:IsValueEqual(value)
    return SetsEqual(self:GetValue(), value)
end

---@param initValue MapPinEnhancedMultiselectValue
function MapPinEnhancedOptionMultiselectMixin:Setup(initValue)
    local options = Options.OPTIONS_CONFIG[self.key]
    assert(options, "No multiselect options found for key: " .. tostring(self.key))
    ---@cast options MapPinEnhancedMultiselectOption[]
    self.child:Setup(options, function(value) self:NotifyChange(value) end)
    self:SetValue(initValue)
    self:UpdateHeight()
end
