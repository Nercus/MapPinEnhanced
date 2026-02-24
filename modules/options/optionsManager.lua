---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Options
---@field options table<string, MapPinEnhancedFormElementTemplate> A table mapping option keys to their corresponding frames.
local Options = MapPinEnhanced:GetModule("Options")
Options.options = {}

function Options:GetDefaultValue(key)
    ---@type number | string | boolean
    local default = self.DEFAULTS[key]
    assert(default ~= nil, "No default value found for key: " .. tostring(key))
    return default
end

function Options:GetOptionInitValue(key)
    local savedValue = MapPinEnhanced:GetVar("options", key)
    if savedValue ~= nil then
        return savedValue
    end
    return self:GetDefaultValue(key)
end

function Options:SaveOptionValue(key, value)
    MapPinEnhanced:SetVar("options", key, value)
end

---@param key string The unique key for the option, used for saving values. Is of the format "category.optionName", e.g. "general.showMinimapPin".
---@param frame MapPinEnhancedFormElementTemplate
function Options:RegisterOption(key, frame)
    assert(self.options[key] == nil, "Option with key " .. key .. " is already registered")
    self.options[key] = frame
    frame:Setup(self:GetOptionInitValue(key))
    self:SubscribeToOptionChanges(key, function(value)
        self:SaveOptionValue(key, value)
    end)
end

function Options:SetOptionValue(key, value)
    local frame = self.options[key]
    if not frame then
        error("Option with key " .. key .. " not found")
    end
    assert(frame.SetValue, "Option frame must have a SetValue method")
    self:SaveOptionValue(key, value)
    frame:SetValue(value)
end

function Options:GetOptionValue(key)
    local frame = self.options[key]
    if not frame then
        error("Option with key " .. key .. " not found")
    end
    assert(frame.GetValue, "Option frame must have a Get method")
    return frame:GetValue()
end

--TODO: this should also be called on load
function Options:SubscribeToOptionChanges(key, callback)
    local frame = self.options[key]
    if not frame then
        error("Option with key " .. key .. " not found")
    end
    assert(frame.OnChange, "Option frame must have a OnChange method")
    frame:OnChange(callback)
end

function Options:ScrollToOption(key)
    local frame = self.options[key]
    if not frame then
        error("Option with key " .. key .. " not found")
    end
    assert(frame.ScrollToOption, "Option frame must have a ScrollToOption method")
    frame:ScrollToOption()
end
