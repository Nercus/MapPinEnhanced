-- Template: file://./OptionEditorCategoryButton.xml
---@class MapPinEnhancedOptionEditorViewCategoryButtonMixin : Button
---@field label FontString
MapPinEnhancedOptionEditorViewCategoryButtonMixin = {}



function MapPinEnhancedOptionEditorViewCategoryButtonMixin:SetLabel(label)
    self.label:SetText(label)
end

function MapPinEnhancedOptionEditorViewCategoryButtonMixin:SetActive()
    self.label:SetAlpha(1)
end

function MapPinEnhancedOptionEditorViewCategoryButtonMixin:SetInactive()
    self.label:SetAlpha(0.5)
end
