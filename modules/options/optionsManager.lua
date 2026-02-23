---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Options
---@field options table<string, MapPinEnhancedFormElementTemplate> A table mapping option keys to their corresponding frames.
local Options = MapPinEnhanced:GetModule("Options")
Options.options = {}

---@param optionKey string The unique key for the option, used for saving values. Is of the format "category.optionName", e.g. "general.showMinimapPin".
---@param frame MapPinEnhancedFormElementTemplate
function Options:RegisterOption(optionKey, frame)
    self.options[optionKey] = frame
    -- this should pass the setup?
end

function Options:SetOptionValue(optionKey, value)
    local frame = self.options[optionKey]
    if not frame then
        error("Option with key " .. optionKey .. " not found")
    end
    assert(frame.SetValue, "Option frame must have a SetValue method")
    frame:SetValue(value)
end

function Options:GetOptionValue(optionKey)
    local frame = self.options[optionKey]
    if not frame then
        error("Option with key " .. optionKey .. " not found")
    end
    assert(frame.GetValue, "Option frame must have a Get method")
    return frame:GetValue()
end

function Options:SubscribeToOptionChanges(optionKey, callback)
    local frame = self.options[optionKey]
    if not frame then
        error("Option with key " .. optionKey .. " not found")
    end
    assert(frame.OnChange, "Option frame must have a OnChange method")
    frame:OnChange(callback)
end
