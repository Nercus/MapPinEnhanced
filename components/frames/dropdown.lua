---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedDropdownTemplate : DropdownWithSteppersTemplate
---@field Dropdown DropdownButton -- NOTE: the key has to be exactly "Dropdown" for the mixin to work properly
---@field activeValue any
MapPinEnhancedDropdownMixin = {}


function MapPinEnhancedDropdownMixin:OnLoad()
    DropdownWithSteppersMixin.OnLoad(self);


    self.Dropdown:SetScript("Onva")
end

---@class DropdownSetup
---@field options MapPinEnhancedRadioGroupOption[]
---@field onChange fun(value: any)
---@field init? fun(): any -- initial value can be nil if option has never been set before

-- TODO: add line indicator at the bottom with number of options / current selection


---@param formData DropdownSetup
function MapPinEnhancedDropdownMixin:Setup(formData)
    if formData.init then
        assert(type(formData.init) == "function", "init must be a function")
        local initialValue = formData.init()
        self.activeValue = initialValue
    else
        self.activeValue = nil
    end

    local menuEntries = {}
    local options = formData.options
    for _, option in ipairs(options) do
        table.insert(menuEntries, {
            type = "radio",
            label = option.label,
            isSelected = function()
                return self.activeValue == option.value
            end,
            setSelected = function()
                self.activeValue = option.value
                if self.onChangeCallback then
                    self.onChangeCallback(option.value)
                end
            end,
            data = option.value,
        })
    end
    local generatorFunction = MapPinEnhanced:GetGeneratorFunction(options)
    self.Dropdown:SetupMenu(generatorFunction)
    self:SetCallback(formData.onChange)
end

---@param callback fun(isChecked: boolean)
function MapPinEnhancedDropdownMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end
