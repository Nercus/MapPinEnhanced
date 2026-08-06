---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class MapPinEnhancedMultiselectOption
---@field label string
---@field value string

---@alias MapPinEnhancedMultiselectValue table<string, boolean>

---@class MapPinEnhancedMultiselectTemplate : WowStyle2DropdownTemplate, DropdownButton
---@field options MapPinEnhancedMultiselectOption[]
---@field selected MapPinEnhancedMultiselectValue
---@field Text FontString?
MapPinEnhancedMultiselectMixin = {}

---@param value MapPinEnhancedMultiselectValue?
---@return MapPinEnhancedMultiselectValue
local function CopySet(value)
    ---@type MapPinEnhancedMultiselectValue
    local result = {}
    if type(value) ~= "table" then return result end
    for key, selected in pairs(value) do
        if selected then result[key] = true end
    end
    return result
end

function MapPinEnhancedMultiselectMixin:OnLoad()
    WowStyle2DropdownMixin.OnLoad(self)
end

function MapPinEnhancedMultiselectMixin:RefreshSelectedLabel()
    local labels = {}
    for _, option in ipairs(self.options or {}) do
        if self.selected[option.value] then table.insert(labels, option.label) end
    end
    local label = #labels > 0 and table.concat(labels, ", ") or L["None"]
    if self.Text then self.Text:SetText(label) end
end

---@param value MapPinEnhancedMultiselectValue?
function MapPinEnhancedMultiselectMixin:SetValue(value)
    self.selected = CopySet(value)
    self:RefreshSelectedLabel()
end

---@return MapPinEnhancedMultiselectValue
function MapPinEnhancedMultiselectMixin:GetValue()
    return CopySet(self.selected)
end

---@param options MapPinEnhancedMultiselectOption[]
---@param onChange fun(value: MapPinEnhancedMultiselectValue)
function MapPinEnhancedMultiselectMixin:Setup(options, onChange)
    assert(type(options) == "table", "Multiselect options must be a table")
    assert(type(onChange) == "function", "Multiselect onChange must be a function")

    self.options = options
    self.selected = self.selected or {}
    ---@type AnyMenuEntry[]
    local entries = {}
    for _, option in ipairs(options) do
        table.insert(entries, {
            type = "checkbox",
            label = option.label,
            isSelected = function() return self.selected[option.value] == true end,
            setSelected = function()
                self.selected[option.value] = not self.selected[option.value] or nil
                self:RefreshSelectedLabel()
                onChange(self:GetValue())
            end,
            data = option.value,
        })
    end
    self:SetupMenu(MapPinEnhanced:GetGeneratorFunction(entries))
    self:RefreshSelectedLabel()
end
