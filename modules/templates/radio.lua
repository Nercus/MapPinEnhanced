---@class MapPinEnhanced : NercUtilsAddon
local MapPinEnhanced = LibStub("NercUtils"):GetAddon(...)

---@class MapPinEnhancedRadioButtonTemplate : CheckButton
---@field value any
---@field text FontString
MapPinEnhancedRadioButtonMixin = {}

---@class MapPinEnhancedRadioGroupTemplate : Frame
---@field options {label: string, value: any, onValueChanged: function}[]
---@field activeOption any
MapPinEnhancedRadioGroupMixin = {}

--- Sets the selected radio button by value.
---@param value any
function MapPinEnhancedRadioGroupMixin:SetActiveOption(value)
    assert(self.options, "RadioGroupMixin requires 'options' table to be defined.")
    self.activeOption = value

    ---@param button MapPinEnhancedRadioButtonTemplate
    for button in self.pool:EnumerateActive() do
        MapPinEnhanced:Debug(button, "Checking button for value:", value)
        button:SetChecked(button.value == value)
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
            option.onValueChanged(button:GetChecked())
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
---@param options {label: string, value: any, onValueChanged: function}[]
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
