---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedDropdownTemplate : WowStyle2DropdownTemplate, DropdownButton
---@field activeValue any
---@field options MapPinEnhancedRadioGroupOption[]?
---@field Text FontString?
MapPinEnhancedDropdownMixin = {}


function MapPinEnhancedDropdownMixin:OnLoad()
    WowStyle2DropdownMixin.OnLoad(self);
end

function MapPinEnhancedDropdownMixin:RefreshSelectedLabel()
    ---@type string?
    local label
    for _, option in ipairs(self.options or {}) do
        if option.value == self.activeValue then
            label = option.label
            break
        end
    end

    label = label or ""
    if self.Text then
        self.Text:SetText(label)
    end
end

function MapPinEnhancedDropdownMixin:SetSelectedValue(value)
    self.activeValue = value
    self:RefreshSelectedLabel()
end

---@class DropdownSetup
---@field options MapPinEnhancedRadioGroupOption[]
---@field onChange fun(value: any)
---@field init? fun(): any -- initial value can be nil if option has never been set before

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
    self.options = options
    for _, option in ipairs(options) do
        table.insert(menuEntries, {
            type = "radio",
            label = option.label,
            isSelected = function()
                return self.activeValue == option.value
            end,
            setSelected = function()
                self:SetSelectedValue(option.value)
                if self.onChangeCallback then
                    self.onChangeCallback(option.value)
                end
            end,
            data = option.value,
        })
    end
    local generatorFunction = MapPinEnhanced:GetGeneratorFunction(menuEntries)
    self:SetupMenu(generatorFunction)
    self:SetCallback(formData.onChange)
    self:RefreshSelectedLabel()
end

---@param callback fun(isChecked: boolean)
function MapPinEnhancedDropdownMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end
