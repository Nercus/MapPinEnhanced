---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)




---@class MapPinEnhancedOptionMixin
---@field optionEntry MapPinEnhancedOptionEntryTemplate
---@field category OptionCategories the category of the option
---@field label string the label of the option, used to display the option in the UI (unique withing the category)
---@field description string? the description of the option, used to display additional information in the UI
---@field descriptionImage string? reference to an image
MapPinEnhancedOptionMixin = {}

---@class Options
local Options = MapPinEnhanced:GetModule("Options")


function Options:GetFramePool()
    if not self.framePool then
        self.framePool = CreateFramePoolCollection()
        self.framePool:CreatePool("Frame", nil, "MapPinEnhancedOptionEntryTemplate")
    end

    return self.framePool
end

function MapPinEnhancedOptionMixin:Init()
    local framePool = Options:GetFramePool()
    self.optionEntry = framePool:Acquire("MapPinEnhancedOptionEntryTemplate")
end

function MapPinEnhancedOptionMixin:Reset()

end

---@param category  OptionCategories
function MapPinEnhancedOptionMixin:SetCategory(category)
    assert(category, "MapPinEnhancedOptionMixin:SetCategory: category is nil")
    assert(type(category) == "string", "MapPinEnhancedOptionMixin:SetCategory: category must be a string")
    self.category = category
end

function MapPinEnhancedOptionMixin:SetDescription(description)
    assert(description, "MapPinEnhancedOptionMixin:SetDescription: description is nil")
    assert(type(description) == "string", "MapPinEnhancedOptionMixin:SetDescription: description must be a string")
    self.description = description
end

function MapPinEnhancedOptionMixin:SetEnabled()
end

function MapPinEnhancedOptionMixin:SetDisabled()
end
