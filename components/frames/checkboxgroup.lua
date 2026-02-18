---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedCheckboxGroupTemplate : Frame
---@field options MapPinEnhancedCheckboxGroupOption[]
---@field selectedValues table<any, boolean>
---@field onChangeCallback fun(values: any[])
---@field orientation "HORIZONTAL" | "VERTICAL"
MapPinEnhancedCheckboxGroupMixin = {}

---@class MapPinEnhancedCheckboxGroupOption
---@field label string -- The text displayed on the checkbox
---@field value any -- The value associated with the checkbox

--- Checks if a value is currently selected.
---@param value any
---@return boolean
function MapPinEnhancedCheckboxGroupMixin:IsValueSelected(value)
    return self.selectedValues[value] == true
end

--- Toggles a value in the selection.
---@param value any
---@param triggerCallback boolean|nil
function MapPinEnhancedCheckboxGroupMixin:ToggleValue(value, triggerCallback)
    if self:IsValueSelected(value) then
        self.selectedValues[value] = nil
    else
        self.selectedValues[value] = true
    end

    if triggerCallback and self.onChangeCallback then
        self.onChangeCallback(self:GetSelectedValues())
    end
end

--- Returns an array of all selected values.
---@return any[]
function MapPinEnhancedCheckboxGroupMixin:GetSelectedValues()
    local result = {}
    for value in pairs(self.selectedValues) do
        table.insert(result, value)
    end
    return result
end

--- Builds the checkboxes based on the options table.
function MapPinEnhancedCheckboxGroupMixin:BuildCheckboxes()
    assert(self.options, "CheckboxGroupMixin requires 'options' table to be defined.")
    self.pool:ReleaseAll()

    local lastButton = nil
    local isHorizontal = self.orientation == "HORIZONTAL"
    local spacing = isHorizontal and 10 or 5

    for _, option in ipairs(self.options) do
        ---@type MapPinEnhancedCheckboxWithLabelTemplate
        local button = self.pool:Acquire()
        button:SetLabel(option.label)
        button.value = option.value

        local labelWidth = button.text:GetStringWidth()
        button:SetWidth(labelWidth + 30) -- 30 for padding and checkbox

        button:SetParent(self)

        button:SetCallback(function()
            self:ToggleValue(option.value, true)
        end)

        button:SetChecked(self:IsValueSelected(option.value))

        if lastButton then
            if isHorizontal then
                button:SetPoint("TOPLEFT", lastButton, "TOPRIGHT", spacing, 0)
            else
                button:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -spacing)
            end
        else
            button:SetPoint("TOPLEFT", self, "TOPLEFT", 10, -10)
        end

        lastButton = button
        button:Show()
    end

    if isHorizontal then
        local totalWidth = 10
        ---@param button MapPinEnhancedCheckboxWithLabelTemplate
        for button in self.pool:EnumerateActive() do
            totalWidth = totalWidth + button:GetWidth() + spacing
        end
        totalWidth = totalWidth - spacing + 10
        self:SetWidth(totalWidth)
        self:SetHeight(40)
    else
        self:SetHeight(#self.options * 25 + 10)
        self:SetWidth(200)
    end

    self:Show()
end

--- Sets the options for the checkbox group and rebuilds the checkboxes.
---@param options MapPinEnhancedCheckboxGroupOption[]
function MapPinEnhancedCheckboxGroupMixin:SetOptions(options)
    assert(type(options) == "table", "Options must be a table.")
    self.options = options
    self:BuildCheckboxes()
end

--- Gets all currently selected values.
---@return any[]
function MapPinEnhancedCheckboxGroupMixin:GetValue()
    return self:GetSelectedValues()
end

--- Sets the selected values. Pass a table of values to select, or {} to deselect all.
---@param values any[]
---@param triggerCallback boolean|nil
function MapPinEnhancedCheckboxGroupMixin:SetValue(values, triggerCallback)
    assert(type(values) == "table", "Values must be a table.")
    assert(self.options, "CheckboxGroupMixin requires 'options' table to be defined.")

    self.selectedValues = {}

    ---@type table<any, boolean>
    local validValues = {}
    for _, option in ipairs(self.options) do
        validValues[option.value] = true
    end

    for _, value in ipairs(values) do
        if validValues[value] then
            self.selectedValues[value] = true
        end
    end

    ---@param button MapPinEnhancedCheckboxWithLabelTemplate
    for button in self.pool:EnumerateActive() do
        button:SetChecked(self:IsValueSelected(button.value))
    end

    if triggerCallback and self.onChangeCallback then
        self.onChangeCallback(self:GetSelectedValues())
    end
end

---@param callback fun(values: any[])
function MapPinEnhancedCheckboxGroupMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@class CheckboxGroupSetup
---@field options MapPinEnhancedCheckboxGroupOption[]
---@field orientation? "HORIZONTAL" | "VERTICAL"
---@field onChange fun(values: any[])
---@field init? fun(): any[] -- initial selected values, can be empty table

---@param formData CheckboxGroupSetup
function MapPinEnhancedCheckboxGroupMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")

    self.orientation = formData.orientation or "VERTICAL"
    self.selectedValues = {}

    self:SetCallback(formData.onChange)
    self:SetOptions(formData.options or {})

    if formData.init then
        assert(type(formData.init) == "function", "init must be a function")
        local initialValues = formData.init()
        if initialValues and #initialValues > 0 then
            self:SetValue(initialValues, false)
        end
    end
end

--- Initializes the checkbox group.
function MapPinEnhancedCheckboxGroupMixin:OnLoad()
    self.pool = CreateFramePool("CheckButton", self, "MapPinEnhancedCheckboxWithLabelTemplate")
    self.selectedValues = {}
    self.orientation = "VERTICAL"
end
