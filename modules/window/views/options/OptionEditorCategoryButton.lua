---@class MapPinEnhancedWindowOptionSidebarEntryMixin : Button
---@field label FontString
---@field highlight Texture
---@field isActive boolean
MapPinEnhancedWindowOptionSidebarEntryMixin = {}



function MapPinEnhancedWindowOptionSidebarEntryMixin:SetLabel(label)
    self.label:SetText(label)
end

function MapPinEnhancedWindowOptionSidebarEntryMixin:SetActive()
    if self.isActive then return end
    self.highlight:Show()
    self.isActive = true
end

function MapPinEnhancedWindowOptionSidebarEntryMixin:OnEnter()
    self.highlight:Show()
end

function MapPinEnhancedWindowOptionSidebarEntryMixin:OnLeave()
    if self.isActive then return end
    self.highlight:Hide()
end

function MapPinEnhancedWindowOptionSidebarEntryMixin:SetInactive()
    if not self.isActive then return end
    self.highlight:Hide()
    self.isActive = false
end
