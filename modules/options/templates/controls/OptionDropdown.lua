---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedOptionDropdownTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedDropdownTemplate
MapPinEnhancedOptionDropdownMixin = {}

function MapPinEnhancedOptionDropdownMixin:GetValue()
    return self.child.activeValue
end

---@param value any
function MapPinEnhancedOptionDropdownMixin:SetValue(value)
    self.child:SetSelectedValue(value)
end

---@param initValue any
function MapPinEnhancedOptionDropdownMixin:Setup(initValue)
    local options = Options.OPTIONS_CONFIG[self.key]
    assert(options, "MapPinEnhancedOptionDropdownMixin:Setup: no options for " .. tostring(self.key))
    self.child:Setup({
        options = options,
        init = function() return initValue end,
        onChange = function(value) self:NotifyChange(value) end,
    })
    self:UpdateHeight()
end
