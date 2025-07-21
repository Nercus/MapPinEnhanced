---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionMixin
---@field frame MapPinEnhancedOptionEntryTemplate
---@field category MapPinEnhancedOptionCategoryMixin
---@field optionData AnyOptionData
---@field optionType OptionType
MapPinEnhancedOptionMixin = {}

---@class Options
local Options = MapPinEnhanced:GetModule("Options")

---@param category MapPinEnhancedOptionCategoryMixin
function MapPinEnhancedOptionMixin:SetCategory(category)
    self.category = category
end

function MapPinEnhancedOptionMixin:SetOptionData(optionData)
    self.optionData = optionData
end

function MapPinEnhancedOptionMixin:SetOptionType(optionType)
    self.optionType = optionType
end

---@param entryFrame MapPinEnhancedOptionEntryTemplate
function MapPinEnhancedOptionMixin:SetFrame(entryFrame)
    self.frame = entryFrame
end

function MapPinEnhancedOptionMixin:GetFrame()
    return self.frame
end

function MapPinEnhancedOptionMixin:SetEnabled()
    local frame = self:GetFrame()
    if not frame then
        return
    end
    frame:SetEnabled()
end

function MapPinEnhancedOptionMixin:SetDisabled()
    local frame = self:GetFrame()
    if not frame then
        return
    end
    frame:SetDisabled()
end
