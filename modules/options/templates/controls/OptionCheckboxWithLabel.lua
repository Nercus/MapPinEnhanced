---@class MapPinEnhancedOptionCheckboxWithLabelTemplate : MapPinEnhancedOptionCheckboxTemplate
---@field child MapPinEnhancedCheckboxWithLabelTemplate
MapPinEnhancedOptionCheckboxWithLabelMixin = CreateFromMixins(MapPinEnhancedOptionCheckboxMixin)


function MapPinEnhancedOptionCheckboxWithLabelMixin:OnLoad()
    MapPinEnhancedFormElementMixin.OnLoad(self)
    self.child:SetLabel(self:GetLabelText())
end
