---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionRadiogroupTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedRadioGroupTemplate
MapPinEnhancedOptionRadiogroupMixin = {}

---@class Options
local Options = MapPinEnhanced:GetModule("Options")

function MapPinEnhancedOptionRadiogroupMixin:GetValue()
    return self.child.activeOption
end

---@param value any
function MapPinEnhancedOptionRadiogroupMixin:SetValue(value)
    self.child:SetValue(value, false)
end

---@param initValue any
function MapPinEnhancedOptionRadiogroupMixin:Setup(initValue)
    local options = Options.OPTIONS_CONFIG[self.key]
    assert(options, "No options found for key: " .. tostring(self.key))
    assert(initValue ~= nil, "Initial value for radiogroup cannot be nil")
    self.child:Setup({
        orientation = self.orientation or "vertical",
        onChange = function(value)
            self:NotifyChange(value)
        end,
        options = options,
        init = function() return initValue end,
    })
    self:UpdateHeight()
end
