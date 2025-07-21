---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedRadioButtonTemplate : CheckButton
---@field value any
---@field text FontString

---@class MapPinEnhancedRadioGroupTemplate : Frame
---@field options MapPinEnhancedRadioGroupOption[]
---@field activeOption any
MapPinEnhancedRadioGroupMixin = {}


---@class MapPinEnhancedRadioGroupOption
---@field label string -- The text displayed on the radio button
---@field value any -- The value associated with the radio button

--- Sets the selected radio button by value.
---@param value any
function MapPinEnhancedRadioGroupMixin:SetActiveOption(value)
    assert(self.options, "RadioGroupMixin requires 'options' table to be defined.")
    self.activeOption = value

    ---@param button MapPinEnhancedRadioButtonTemplate
    for button in self.pool:EnumerateActive() do
        button:SetChecked(button.value == value)
    end

    if self.onChangeCallback then
        self.onChangeCallback(value)
    end
end

--- Builds the radio buttons based on the options table.
function MapPinEnhancedRadioGroupMixin:BuildRadioButtons()
    assert(self.options, "RadioGroupMixin requires 'options' table to be defined.")
    self.pool:ReleaseAll()

    local lastButton = nil
    for _, option in ipairs(self.options) do
        local button = self.pool:Acquire()
        button.text:SetText(option.label)
        button:SetParent(self)
        button.value = option.value

        button:SetScript("OnClick", function()
            self:SetActiveOption(option.value)
        end)

        if lastButton then
            button:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -5)
        else
            button:SetPoint("TOPLEFT", self, "TOPLEFT", 10, -10)
        end

        lastButton = button
        button:Show()
    end

    self:SetHeight(#self.options * 20) -- Adjust height based on number of options
    self:Show()
end

--- Sets the options for the radio button group and builds the buttons.
---@param options MapPinEnhancedRadioGroupOption[]
function MapPinEnhancedRadioGroupMixin:SetOptions(options)
    assert(type(options) == "table", "Options must be a table.")
    self.options = options
    self:BuildRadioButtons()
end

--- Initializes the radio button group.
function MapPinEnhancedRadioGroupMixin:OnLoad()
    self.pool = CreateFramePool("CheckButton", self, "MapPinEnhancedRadioButtonTemplate")
end

--- Gets the currently selected value.
function MapPinEnhancedRadioGroupMixin:GetValue()
    assert(self.options, "RadioGroupMixin requires 'options' table to be defined.")
    return self.activeOption
end

--- Sets the selected value if it exists in the options.
---@param value any
function MapPinEnhancedRadioGroupMixin:SetValue(value)
    assert(self.options, "RadioGroupMixin requires 'options' table to be defined.")
    for _, option in ipairs(self.options) do
        if option.value == value then
            self:SetActiveOption(value)
            return
        end
    end
    error("Value not found in options: " .. tostring(value))
end

---@param callback fun(isChecked: boolean)
function MapPinEnhancedRadioGroupMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@class RadioGroupSetup
---@field options MapPinEnhancedRadioGroupOption[] -- options for the radio buttons
---@field onChange fun(value: any)
---@field init? fun(): any -- initial value can be nil if option has never been set before

---@param formData RadioGroupSetup
function MapPinEnhancedRadioGroupMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")

    self:SetOptions(formData.options or {})
    if formData.init then
        assert(type(formData.init) == "function", "init must be a function")
        local initialValue = formData.init()
        if initialValue ~= nil then
            self:SetActiveOption(initialValue)
        else
            self:SetActiveOption(self.options[1].value) -- default to first option if init returns nil
        end
    else
        if #self.options > 0 then
            self:SetActiveOption(self.options[1].value) -- default to first option if no init function is provided
        else
            self:SetActiveOption(nil)                   -- no options available
        end
    end

    self:SetCallback(formData.onChange)
end
