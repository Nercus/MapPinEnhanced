---@class MapPinEnhancedOptionCheckboxTemplate : MapPinEnhancedFormElementTemplate
---@field child MapPinEnhancedCheckboxTemplate
MapPinEnhancedOptionCheckboxMixin = {}


function MapPinEnhancedOptionCheckboxMixin:OnMouseDown()
    if not self:IsOptionEnabled() then return end
    self.child:Click()
end

function MapPinEnhancedOptionCheckboxMixin:GetValue()
    return self.child:GetChecked()
end

---@param value boolean
function MapPinEnhancedOptionCheckboxMixin:SetValue(value)
    self.child:SetValue(value, false)
end

---@param initValue boolean
function MapPinEnhancedOptionCheckboxMixin:Setup(initValue)
    assert(type(initValue) == "boolean", "Initial value for checkbox must be a boolean")
    self.child:Setup({
        onChange = function(isChecked)
            self:NotifyChange(isChecked)
        end,
        init = function() return initValue end,
    })
end

---@class MapPinEnhancedOptionCheckboxWithLabelTemplate : MapPinEnhancedOptionCheckboxTemplate
---@field child MapPinEnhancedCheckboxWithLabelTemplate
MapPinEnhancedOptionCheckboxWithLabelMixin = CreateFromMixins(MapPinEnhancedOptionCheckboxMixin)


function MapPinEnhancedOptionCheckboxWithLabelMixin:OnLoad()
    MapPinEnhancedFormElementMixin.OnLoad(self)
    self.child:SetLabel(self:GetLabelText())
end
