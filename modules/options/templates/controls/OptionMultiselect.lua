---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Options
local Options = MapPinEnhanced:GetModule("Options")

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
    return self.child:IsValueEqual(value)
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
