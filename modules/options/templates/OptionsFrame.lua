---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionsFrameTemplate : TabSystemOwnerMixin, Frame
---@field TabSystem TabSystemTemplate
---@field views table<number, Frame>
---@field optionsView Frame
---@field importView Frame
---@field seteditorView Frame
MapPinEnhancedOptionsFrameMixin = {}


function MapPinEnhancedOptionsFrameMixin:OnLoad()
    TabSystemOwnerMixin.OnLoad(self);
    self:SetTabSystem(self.TabSystem);

    ---@type number
    local optionsTabID = self:AddNamedTab("options", self.optionsView);
    ---@type number
    local importTabID = self:AddNamedTab("import", self.importView);
    ---@type number
    local setEditorTabID = self:AddNamedTab("seteditor", self.seteditorView)
    self.views = {
        [optionsTabID] = self.optionsView,
        [importTabID] = self.importView,
        [setEditorTabID] = self.seteditorView,
    }
end
