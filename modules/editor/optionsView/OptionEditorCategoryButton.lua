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
    self.highlight:Show()
    self.isActive = true
end

function MapPinEnhancedOptionEditorViewCategoryButtonMixin:OnEnter()
    self.highlight:Show()
end

function MapPinEnhancedOptionEditorViewCategoryButtonMixin:OnLeave()
    if self.isActive then return end
    self.highlight:Hide()
end

function MapPinEnhancedOptionEditorViewCategoryButtonMixin:SetInactive()
    if not self.isActive then return end
    self.highlight:Hide()
    self.isActive = false
end
