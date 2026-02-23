---@class MapPinEnhancedOptionCheckboxTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedCheckboxTemplate
MapPinEnhancedOptionCheckboxMixin = {}


function MapPinEnhancedOptionCheckboxMixin:OnMouseDown()
    self.child:Click()
end

function MapPinEnhancedOptionCheckboxMixin:GetValue()
    self.child:GetChecked()
end

function MapPinEnhancedOptionCheckboxMixin:SetValue(value)
    self.child:SetChecked(value)
end

---@param initValue boolean
function MapPinEnhancedOptionCheckboxMixin:Setup(initValue)
    self.child:Setup({
        onChange = function(isChecked)
            if not self.callbacks then return end
            for _, cb in ipairs(self.callbacks) do
                cb(isChecked)
            end
        end,
    })
    assert(initValue ~= nil, "Initial value for checkbox must be a boolean")
    self:SetValue(initValue)
end

---@class MapPinEnhancedOptionCheckboxWithLabelTemplate : MapPinEnhancedOptionCheckboxTemplate
---@field child MapPinEnhancedCheckboxWithLabelTemplate
MapPinEnhancedOptionCheckboxWithLabelMixin = CreateFromMixins(MapPinEnhancedOptionCheckboxMixin)


function MapPinEnhancedOptionCheckboxWithLabelMixin:OnLoad()
    MapPinEnhancedFormElementMixin.OnLoad(self)
    self.child:SetLabel(self:GetLabelText())
end
