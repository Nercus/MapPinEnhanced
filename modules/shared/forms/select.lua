-- Template: file://./select.xml
---@class MapPinEnhancedSelectMixin : Button,PropagateMouseMotion
---@field onChangeCallback function
MapPinEnhancedSelectMixin = {}


-- NOTE: Use a generator function to wrap the rootdescription and use the same code as context menus

function MapPinEnhancedSelectMixin:SetCallback(callback)
    assert(type(callback) == "function")
    self.onChangeCallback = callback
    -- TODO: register change to menu change
end

---@param optionData OptionObjectVariantsTyped
function MapPinEnhancedSelectMixin:Setup(optionData)
end
