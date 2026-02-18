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
    MISC = L["Miscellaneous"],
}

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
    for categoryID, categoryName in pairs(CATEGORIES) do
        Options:RegisterCategory(categoryID, categoryName)
    end
end


MapPinEnhanced:OnLoad(function()
    Options:InitOptionsFrame()
end)




-- Example Usage for Tracker Options
Options:RegisterOption("slider", {
    category = "TRACKER",
    label = "Tracker x position",
    description = "Move the tracker left or right.",
    descriptionImage = {
        texture = "delve-entrance-background-zekvirs-lair",
        width = 584,
        height = 384,
    },
    min = 0,
    max = 2000,
    step = 500,
    onChange = function(value)

    end,
    init = function()
        return MapPinEnhanced:GetVar("trackerPosition") and MapPinEnhanced:GetVar("trackerPosition").x or 0
    end,
})


Options:RegisterOption("slider", {
    category = "TRACKER",
    label = "Tracker y position",
    description = "Move the tracker up or down.",
    descriptionImage = {
        texture = "delve-entrance-background-mycomancer-cavern",
        width = 584,
        height = 384,
    },
    min = -1000,
    max = 1000,
    step = 200,
    onChange = function(value)

    end,
    init = function()
        local position = MapPinEnhanced:GetVar("trackerPosition") or { x = 0, y = 0 }
        return position.y
    end,
})


Options:RegisterOption("checkbox", {
    category = "TRACKER",
    label = "Show Tracker",
    description = "Toggle the visibility of the tracker.",
    onChange = function(value)
        if value then
        else
        end
    end,
    init = function()
        return MapPinEnhanced:GetVar("trackerVisible") or false
    end,
})



Options:RegisterOption("input", {
    category = "TRACKER",
    label = "Tracker Max Height",
    description = "Set the maximum height of the tracker in pixels.",
    onChange = function(value)

    end,
    init = function()
        return MapPinEnhanced:GetVar("trackerMaxHeight") or 400
    end,
})


Options:RegisterOption("button", {
    category = "TRACKER",
    label = "Reset Tracker Position",
    description = "Reset the tracker position to the center of the screen.",
    buttonText = {
        icon = "cross",
        label = "Reset Position",
    },
    onChange = function()

    end,
})

Options:RegisterOption("radiogroup", {
    category = "TRACKER",
    label = "Tracker View",
    description = "Select the view mode for the tracker.",
    orientation = "HORIZONTAL",
    options = {
        { label = "Pin View", value = "pin" },
        { label = "Set View", value = "set" },
    },
    onChange = function(value)

    end,
    init = function()

    end,
})


Options:RegisterOption("radiogroup", {
    category = "GENERAL",
    label = "Test Option",
    description = "This is a test option for demonstration purposes.",
    orientation = "HORIZONTAL",
    options = {
        { label = "1", value = "1" },
        { label = "2", value = "2" },
        { label = "3", value = "3" },
    },
    onChange = function(value)
    end,
    init = function()
        return "option1"
    end,
})


Options:RegisterOption("checkboxgroup", {
    category = "GENERAL",
    label = "Auto Hide Tracker in",
    description = "This is a test option for demonstration purposes.",
    orientation = "HORIZONTAL",
    options = {
        { label = "Arena",     value = "Arena" },
        { label = "Instances", value = "Instances" },
    },
    onChange = function(value)
    end,
    init = function()
        return { "option1", "option3" }
    end,
})
