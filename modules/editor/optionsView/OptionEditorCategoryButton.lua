-- Template: file://./OptionEditorCategoryButton.xml
---@class MapPinEnhancedOptionEditorViewCategoryButtonMixin : Button
---@field label FontString
---@field highlight Texture
---@field isActive boolean
MapPinEnhancedOptionEditorViewCategoryButtonMixin = {}



function MapPinEnhancedOptionEditorViewCategoryButtonMixin:SetLabel(label)
    self.label:SetText(label)
end

function MapPinEnhancedOptionEditorViewCategoryButtonMixin:SetActive()
    if self.isActive then return end
    self.label:SetAlpha(1)
    self:LockHighlight()
    self.isActive = true
end

function MapPinEnhancedOptionEditorViewCategoryButtonMixin:SetInactive()
    if not self.isActive then return end
    self.label:SetAlpha(0.5)
    self:UnlockHighlight()
    self.isActive = false
end
