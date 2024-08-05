-- Template: file://./OptionEditorCategoryButton.xml
---@class MapPinEnhancedOptionEditorViewCategoryButtonMixin : Button
---@field label FontString
---@field highlight Texture
MapPinEnhancedOptionEditorViewCategoryButtonMixin = {}



function MapPinEnhancedOptionEditorViewCategoryButtonMixin:SetLabel(label)
    self.label:SetText(label)
end

function MapPinEnhancedOptionEditorViewCategoryButtonMixin:SetActive()
    self.label:SetAlpha(1)
    self:LockHighlight()
end

function MapPinEnhancedOptionEditorViewCategoryButtonMixin:SetInactive()
    self.label:SetAlpha(0.5)
    self:UnlockHighlight()
end
