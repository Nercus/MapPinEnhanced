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

function MapPinEnhancedOptionRadiogroupMixin:SetValue(value)
    self.child:SetActiveOption(value)
end

---@param initValue any
function MapPinEnhancedOptionRadiogroupMixin:Setup(initValue)
    local options = Options.OPTIONS_CONFIG[self.key]
    assert(options, "No options found for key: " .. tostring(self.key))
    self.child:Setup({
        onChange = function(value)
            if not self.callbacks then return end
            for _, cb in ipairs(self.callbacks) do
                cb(value)
            end
        end,
        options = Options.OPTIONS_CONFIG[self.key]
    })
    self:UpdateHeight()
    assert(initValue ~= nil, "Initial value for radiogroup cannot be nil")
    self:SetValue(initValue)
end
