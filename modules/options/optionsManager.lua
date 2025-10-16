---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Options
---@field categoryObjectPool ObjectPool<MapPinEnhancedOptionCategoryMixin>
---@field onChangeCallbacks table<string, fun(option: MapPinEnhancedOptionMixin, ... )[]>
local Options = MapPinEnhanced:GetModule("Options")

Options.onChangeCallbacks = Options.onChangeCallbacks or {}

local L = MapPinEnhanced.L

---@enum (key) OptionCategories
local CATEGORIES = {
    GENERAL = L["General"],
    PINS = L["Pins"],
    GROUPS = L["Groups"],
    TRACKER = L["Tracker"],
    MAPS = L["Maps"],
    IMPORT_EXPORT = L["Import/Export"],
}

---@alias OptionType "textarea" | "button" | "checkbox" | "colorpicker" | "input" | "slider" | "radiogroup"

---@class OptionData
---@field category OptionCategories the category of the option
---@field label string the label of the option, used to display the option in the UI (unique withing the category)
---@field description string? the description of the option, used to display additional information in the UI
---@field descriptionImage string? reference to an image

---@class TextareaOptionData : OptionData, TextareaSetup

---@class ButtonOptionData : OptionData, ButtonSetup

---@class CheckboxOptionData : OptionData, CheckboxSetup

---@class ColorpickerOptionData : OptionData, ColorPickerSetup

---@class InputOptionData : OptionData, InputSetup

---@class SliderOptionData : OptionData, SliderSetup

---@class RadiogroupOptionData : OptionData, RadioGroupSetup

---@alias AnyOptionData TextareaOptionData | ButtonOptionData | CheckboxOptionData | ColorpickerOptionData | InputOptionData | SliderOptionData | RadiogroupOptionData

local function CreateObject()
    return CreateAndInitFromMixin(MapPinEnhancedOptionCategoryMixin)
end

local function ResetObject(_, object, isNew)
    if not object then return end
    if isNew then return end
    object:Reset()
end

function Options:GetCategoryObjectPool()
    if not self.categoryObjectPool then
        self.categoryObjectPool = CreateObjectPool(CreateObject, ResetObject)
        self.categoryObjectPool.capacity = 20
    end
    return self.categoryObjectPool
end

function Options:GetCategoryByName(categoryName)
    assert(CATEGORIES[categoryName], "Options:GetOption: categoryName '" .. tostring(categoryName) .. "' is not allowed")
    local categoriesPool = self:GetCategoryObjectPool()
    ---@param categoryObject MapPinEnhancedOptionCategoryMixin
    for categoryObject in categoriesPool:EnumerateActive() do
        if categoryName == categoryObject:GetName() then
            return categoryObject
        end
    end
end

function Options:EnumerateCategories()
    local categoriesPool = self:GetCategoryObjectPool()
    return categoriesPool:EnumerateActive()
end

---@param optionType OptionType
---@param optionData AnyOptionData
---@overload fun(self: Options, optionType: "textarea", optionData: TextareaOptionData)
---@overload fun(self: Options, optionType: "button", optionData: ButtonOptionData)
---@overload fun(self: Options, optionType: "checkbox", optionData: CheckboxOptionData)
---@overload fun(self: Options, optionType: "colorpicker", optionData: ColorpickerOptionData)
---@overload fun(self: Options, optionType: "input", optionData: InputOptionData)
---@overload fun(self: Options, optionType: "slider", optionData: SliderOptionData)
---@overload fun(self: Options, optionType: "radiogroup", optionData: RadiogroupOptionData)
function Options:RegisterOption(optionType, optionData)
    local categoryName = optionData.category
    assert(CATEGORIES[categoryName], "Options:GetOption: categoryName '" .. tostring(categoryName) .. "' is not allowed")
    local categoryObject = self:GetCategoryByName(categoryName)
    if not categoryObject then return end
    ---@type string
    local key = categoryName .. ":" .. optionData.label
    if self.onChangeCallbacks and self.onChangeCallbacks[key] then
        local previousOnChange = optionData.onChange
        optionData.onChange = function(option, ...)
            for _, callback in ipairs(self.onChangeCallbacks[key]) do
                callback(option, ...)
            end
            if previousOnChange then
                previousOnChange(option, ...)
            end
        end
    end
    categoryObject:AddOption(optionType, optionData)
end

---@param category OptionCategories
---@param label string
---@return MapPinEnhancedOptionMixin?
function Options:GetOption(category, label)
    assert(CATEGORIES[category], "Options:GetOption: category '" .. tostring(category) .. "' is not allowed")
    local categoryObject = self:GetCategoryByName(category)
    if not categoryObject then return end
    return categoryObject:GetOption(label)
end

function Options:EnableOption(option)
    assert(option, "Options:EnableOption: option is nil")
    assert(type(option) == "table", "Options:EnableOption: option must be a table")
    option:SetEnabled()
end

function Options:DisableOption(option)
    assert(option, "Options:DisableOption: option is nil")
    assert(type(option) == "table", "Options:DisableOption: option must be a table")
    option:SetDisabled()
end

function Options:RegisterCategory(categoryID, categoryName)
    local categoriesPool = self:GetCategoryObjectPool()
    local category = categoriesPool:Acquire()
    category:SetName(categoryName)
end

function Options:InitializeCategories()
    for categoryName, categoryID in pairs(CATEGORIES) do
        self:RegisterCategory(categoryID, categoryName)
    end
end

Options:InitializeCategories()


--- Registers an additional onChange callback for a specific option.
---@param category OptionCategories
---@param label string
---@param callback fun(option: MapPinEnhancedOptionMixin, ...)
function Options:RegisterOnChangeCallback(category, label, callback)
    assert(type(callback) == "function", "Options:RegisterOptionOnChange: callback must be a function")
    ---@type string
    local key = category .. ":" .. label
    self.onChangeCallbacks[key] = self.onChangeCallbacks[key] or {}
    table.insert(self.onChangeCallbacks[key], callback)

    -- If the option is already registered, attach immediately
    local option = self:GetOption(category, label)
    if option then
        local optionData = option:GetOptionData()
        local previousOnChange = optionData.onChange
        optionData.onChange = function(opt, ...)
            for _, cb in ipairs(self.onChangeCallbacks[key]) do
                cb(opt, ...)
            end
            if previousOnChange then
                previousOnChange(opt, ...)
            end
        end
        option:SetOptionData(optionData) -- Update the option data with the new onChange
    end
end

function Options:GetOptionsFrame()
    if not self.optionsFrame then
        self.optionsFrame = CreateFrame("Frame", "MapPinEnhancedOptionsView", UIParent,
            "MapPinEnhancedOptionsViewTemplate")
    end
    return self.optionsFrame
end

function Options:ToggleOptionsFrame()
    local frame = self:GetOptionsFrame()
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end

MapPinEnhanced:AddSlashCommand("options", function()
    Options:ToggleOptionsFrame()
end, "Open the options frame")
