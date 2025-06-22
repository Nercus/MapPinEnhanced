---@class MapPinEnhancedTextareaTemplate : ScrollFrame
---@field editbox EditBox
MapPinEnhancedTextareaMixin = {};


function MapPinEnhancedTextareaMixin:OnSizeChanged()
    local x, y = self:GetSize();
    self.editbox:SetSize(x - 5, y - 5);
end

function MapPinEnhancedTextareaMixin:OnMouseDown()
    self.editbox:SetFocus();
end

function MapPinEnhancedTextareaMixin:OnLoad()

end
