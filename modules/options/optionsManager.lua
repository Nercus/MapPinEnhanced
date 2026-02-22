---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Options
---@field options table<string, Frame> A table mapping option keys to their corresponding frames.
local Options = MapPinEnhanced:GetModule("Options")
Options.options = {}

---@param optionKey string The unique key for the option, used for saving values. Is of the format "category.optionName", e.g. "general.showMinimapPin".
---@param frame Frame
function Options:RegisterOption(optionKey, frame)
    self.options[optionKey] = frame
end

function Options:SetOptionValue(optionKey, value)
    local frame = self.options[optionKey]
    if not frame then
        error("Option with key " .. optionKey .. " not found")
    end
    assert(frame.Set, "Option frame must have a Set method")
    frame:Set(value)
end

function Options:GetOptionValue(optionKey)
    local frame = self.options[optionKey]
    if not frame then
        error("Option with key " .. optionKey .. " not found")
    end
    assert(frame.Get, "Option frame must have a Get method")
    return frame:Get()
end

function Options:SubscribeToOptionChanges(optionKey, callback)
    local frame = self.options[optionKey]
    if not frame then
        error("Option with key " .. optionKey .. " not found")
    end
    assert(frame.Subscribe, "Option frame must have a Subscribe method")
    frame:Subscribe(callback)
end

-- TODO: the controls contain these elements and wrap them inside a formElement Frame -> formElement has Get, Set and Subscribe methods
-- checkbox
-- toggle -> new element needs to be added
-- colorpicker
-- input
-- radiogroup
-- slider -> needs touch ups looks a but clunky right now
