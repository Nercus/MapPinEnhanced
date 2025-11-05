---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionMixin
---@field frame MapPinEnhancedOptionsEntryTemplate
---@field category MapPinEnhancedOptionCategoryMixin
---@field optionData AnyOptionData
---@field optionType OptionType
---@field template string
MapPinEnhancedOptionMixin = {
    template = "MapPinEnhancedOptionsEntryTemplate"
}

---@class Options
local Options = MapPinEnhanced:GetModule("Options")

---@param category MapPinEnhancedOptionCategoryMixin
function MapPinEnhancedOptionMixin:SetCategory(category)
    self.category = category
end

function MapPinEnhancedOptionMixin:SetOptionData(optionData)
    self.optionData = optionData
end

function MapPinEnhancedOptionMixin:GetOptionData()
    return self.optionData
end

function MapPinEnhancedOptionMixin:SetOptionType(optionType)
    self.optionType = optionType
end

---@param entryFrame MapPinEnhancedOptionsEntryTemplate
function MapPinEnhancedOptionMixin:SetFrame(entryFrame)
    self.frame = entryFrame
end

---@return MapPinEnhancedOptionsEntryTemplate
function MapPinEnhancedOptionMixin:GetFrame()
    return self.frame
end

function MapPinEnhancedOptionMixin:UpdateFrame()
    local frame = self:GetFrame()
    if not frame then
        return
    end
    frame:Update()
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
