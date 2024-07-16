---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedMapIDEditBox : MapPinEnhancedInputMixin
---@field mapSelection Button


---@class MapPinEnhancedSetEditorPinEntryMixin : Frame
---@field Pin MapPinEnhancedBasePinMixin
---@field currentFocus number
---@field mapID MapPinEnhancedMapIDEditBox
---@field xCoord MapPinEnhancedInputMixin
---@field yCoord MapPinEnhancedInputMixin
---@field title MapPinEnhancedInputMixin
---@field pinOptions MapPinEnhancedSelectMixin
MapPinEnhancedSetEditorPinEntryMixin = {}

-- local order = {
--     "mapID",
--     "xCoord",
--     "yCoord",
--     "title",
-- }
-- local orderCount = #order


-- function MapPinEnhancedSetEditorPinEntryMixin:IsFocusingInput()
--     if self.mapID:HasFocus() then return true end
--     if self.xCoord:HasFocus() then return true end
--     if self.yCoord:HasFocus() then return true end
--     if self.title:HasFocus() then return true end
--     return false
-- end

-- function MapPinEnhancedSetEditorPinEntryMixin:SetEditBoxPropagation(propagation)
--     self.mapID:SetPropagateKeyboardInput(propagation)
--     self.xCoord:SetPropagateKeyboardInput(propagation)
--     self.yCoord:SetPropagateKeyboardInput(propagation)
--     self.title:SetPropagateKeyboardInput(propagation)
-- end

-- function MapPinEnhancedSetEditorPinEntryMixin:CycleEditboxes()
--     if not self.currentFocus or self.currentFocus > orderCount then
--         self.currentFocus = 0
--     end
--     self.currentFocus = self.currentFocus + 1
--     ---@type "mapID" | "xCoord" | "yCoord" | "title" | nil
--     local nextFocus = order[self.currentFocus]
--     if not nextFocus then
--         self:CycleEditboxes()
--         return
--     end
--     self[nextFocus]:SetFocus()
-- end

-- function MapPinEnhancedSetEditorPinEntryMixin:OnKeyDown(key)
--     if key ~= "TAB" then return end
--     self:CycleEditboxes()
-- end
