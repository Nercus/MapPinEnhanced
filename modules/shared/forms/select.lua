-- Template: file://./select.xml
---@class MapPinEnhancedSelectMixin : Button,PropagateMouseMotion
---@field onChangeCallback function
---@field Dropdown DropdownButton
MapPinEnhancedSelectMixin = {}

function MapPinEnhancedSelectMixin:SetCallback(callback)
    assert(type(callback) == "function")
    self.onChangeCallback = callback
end

---@param optionData OptionObjectVariantsTyped
function MapPinEnhancedSelectMixin:Setup(optionData)
    self:SetCallback(optionData.onChange)
    self.currentValue = optionData.init
    local function IsSelected(index)
        local option = optionData.options[index]
        return option.value == self.currentValue
    end

    local function SetSelected(index)
        local option = optionData.options[index]
        self.currentValue = option.value
        if not self.onChangeCallback then return end
        self.onChangeCallback(option.value)
    end

    local function GeneratorFunction(owner, rootDescription)
        ---@type SubMenuUtil
        local rootDescription = rootDescription

        for index, option in ipairs(optionData.options) do
            rootDescription:CreateRadio(option.label, IsSelected, SetSelected, index)
        end
    end
    self.Dropdown:SetupMenu(GeneratorFunction)
end
