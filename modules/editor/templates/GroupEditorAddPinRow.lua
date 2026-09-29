---@class MapPinEnhancedGroupEditorAddPinRow : Frame
---@field button MapPinEnhancedButtonTemplate
MapPinEnhancedGroupEditorAddPinRowMixin = {}

---@param content MapPinEnhancedGroupEditorContentTemplate
function MapPinEnhancedGroupEditorAddPinRowMixin:Init(content)
    local group = content.group
    self.button:SetEnabled(group ~= nil and
        (not group:IsProtected() or group.groupType == "ungrouped"))
    self.button:SetScript("OnClick", function() content:AddPin() end)
end

function MapPinEnhancedGroupEditorAddPinRowMixin:Reset()
    self.button:SetScript("OnClick", nil)
    self.button:Disable()
end
