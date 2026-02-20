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
    GENERAL = { name = L["General"], order = 1 },
    PINS = { name = L["Pins"], order = 2 },
    GROUPS = { name = L["Groups"], order = 3 },
    TRACKER = { name = L["Tracker"], order = 4 },
    MAPS = { name = L["Maps"], order = 5 },
    IMPORT_EXPORT = { name = L["Import/Export"], order = 6 },
    MISC = { name = L["Miscellaneous"], order = 7 },
}
Options.CATEGORIES = CATEGORIES

---@alias OptionType "textarea" | "button" | "checkbox" | "colorpicker" | "input" | "slider" | "radiogroup" | "checkboxgroup"

---@class OptionData
---@field category OptionCategories the category of the option
---@field subCategory string? optional subcategory for visual grouping
---@field label string the label of the option, used to display the option in the UI (unique withing the category)
---@field description string the description of the option, used to display additional information in the UI
---@field descriptionImage {texture: string, width: number, height: number}? reference to an image
---@field triggerChangeOnInit boolean? whether the onChange callback should be triggered when the option is initialized, default is false

---@class TextareaOptionData : OptionData, TextareaSetup

---@class ButtonOptionData : OptionData, ButtonSetup

---@class CheckboxOptionData : OptionData, CheckboxSetup

---@class ColorpickerOptionData : OptionData, ColorPickerSetup

---@class InputOptionData : OptionData, InputSetup

---@class SliderOptionData : OptionData, SliderSetup

---@class RadiogroupOptionData : OptionData, RadioGroupSetup

---@class CheckboxGroupOptionData : OptionData, CheckboxGroupSetup

---@alias AnyOptionData TextareaOptionData | ButtonOptionData | CheckboxOptionData | ColorpickerOptionData | InputOptionData | SliderOptionData | RadiogroupOptionData | CheckboxGroupOptionData

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

function Options:GetCategoryByID(categoryID)
    assert(CATEGORIES[categoryID], "Options:GetOption: categoryName '" .. tostring(categoryID) .. "' is not allowed")
    local categoriesPool = self:GetCategoryObjectPool()
    ---@param categoryObject MapPinEnhancedOptionCategoryMixin
    for categoryObject in categoriesPool:EnumerateActive() do
        if categoryID == categoryObject:GetID() then
            return categoryObject
        end
    end
end

function Options:EnumerateCategories()
    local categoriesPool = self:GetCategoryObjectPool()
    return categoriesPool:EnumerateActive()
end

--- Sets the value of a specific option.
---@param categoryID OptionCategories
---@param label string
---@param value any
---@param triggerCallback boolean|nil
function Options:SetOptionValue(categoryID, label, value, triggerCallback)
    local option = self:GetOption(categoryID, label)
    if option then
        option:SetValue(value, triggerCallback)
    end
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
---@overload fun(self: Options, optionType: "checkboxgroup", optionData: CheckboxGroupOptionData)
function Options:RegisterOption(optionType, optionData)
    local categoryID = optionData.category
    assert(CATEGORIES[categoryID], "Options:GetOption: categoryName '" .. tostring(categoryID) .. "' is not allowed")
    local categoryObject = self:GetCategoryByID(categoryID)
    if not categoryObject then return end
    ---@type string
    local key = categoryID .. ":" .. optionData.label
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

    if optionData.triggerChangeOnInit and optionData.onChange then
        local option = categoryObject:GetOption(optionData.label)
        if option and optionData.init then
            local initialValue = optionData.init()
            optionData.onChange(initialValue)
        end
    end
end

---@param category OptionCategories
---@param label string
---@return MapPinEnhancedOptionMixin?
function Options:GetOption(category, label)
    assert(CATEGORIES[category], "Options:GetOption: category '" .. tostring(category) .. "' is not allowed")
    local categoryObject = self:GetCategoryByID(category)
    if not categoryObject then return end
    return categoryObject:GetOption(label)
end

---@param option MapPinEnhancedOptionMixin
function Options:EnableOption(option)
    assert(option, "Options:EnableOption: option is nil")
    assert(type(option) == "table", "Options:EnableOption: option must be a table")
    option:SetEnabled()
end

---@param option MapPinEnhancedOptionMixin
function Options:DisableOption(option)
    assert(option, "Options:DisableOption: option is nil")
    assert(type(option) == "table", "Options:DisableOption: option must be a table")
    option:SetDisabled()
end

---@param categoryID OptionCategories
---@param categoryName string
function Options:RegisterCategory(categoryID, categoryName)
    local categoriesPool = self:GetCategoryObjectPool()
    local category = categoriesPool:Acquire()
    category:SetID(categoryID)
    category:SetName(categoryName)
end

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

function Options:InitOptionsFrame()
    if self.optionsFrame then return end
    self.optionsFrame = CreateFrame("Frame", nil, nil, "MapPinEnhancedOptionsFrameTemplate")
    ---@type any Settings API is not typed
    local category = Settings.RegisterCanvasLayoutCategory(self.optionsFrame, MapPinEnhanced.name)
    ---@type number
    self.categoryID = category:GetID()
    Settings.RegisterAddOnCategory(category)
    self.optionsFrame:Show()
end

function Options:ToggleOptionsFrame()
    Settings.OpenToCategory(self.categoryID)
end

MapPinEnhanced:AddSlashCommand("options", function()
    Options:ToggleOptionsFrame()
end, "Open the options frame")


do
    for categoryID, categoryInfo in pairs(CATEGORIES) do
        Options:RegisterCategory(categoryID, categoryInfo.name)
    end
end


MapPinEnhanced:OnLoad(function()
    Options:InitOptionsFrame()
end)
