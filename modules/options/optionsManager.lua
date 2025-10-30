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
---@field description string the description of the option, used to display additional information in the UI
---@field descriptionImage {texture: string, width: number, height: number}? reference to an image

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

function Options:GetCategoryByName(categoryID)
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

---@param categoryID OptionCategories
---@param categoryName string
function Options:RegisterCategory(categoryID, categoryName)
    local categoriesPool = self:GetCategoryObjectPool()
    local category = categoriesPool:Acquire()
    category:SetID(categoryID)
    category:SetName(categoryName)
end

function Options:InitializeCategories()
    for categoryID, categoryName in pairs(CATEGORIES) do
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

function Options:InitOptionsFrame()
    if self.optionsFrame then return end
    self.optionsFrame = CreateFrame("Frame", nil, nil, "MapPinEnhancedOptionsFrameTemplate")
    ---@type any Settings API is not typed
    local category = Settings.RegisterCanvasLayoutCategory(self.optionsFrame, MapPinEnhanced.name)
    category.ID = MapPinEnhanced.name
    Settings.RegisterAddOnCategory(category)
    self.optionsFrame:Show()
end

function Options:ToggleOptionsFrame()
    Settings.OpenToCategory(MapPinEnhanced.name)
end

MapPinEnhanced:AddSlashCommand("options", function()
    Options:ToggleOptionsFrame()
end, "Open the options frame")

Options:InitOptionsFrame()


-- Example Usage for Tracker Options
-- Options:RegisterOption("slider", {
--     category = "TRACKER",
--     label = "Tracker x position",
--     description = "Move the tracker left or right.",
--     descriptionImage = {
--         texture = "delve-entrance-background-zekvirs-lair",
--         width = 584,
--         height = 384,
--     },
--     min = 0,
--     max = 2000,
--     step = 500,
--     onChange = function(value)
--         local trackerFrame = Tracker:GetTrackerFrame()
--         if trackerFrame:IsShown() then
--             local position = MapPinEnhanced:GetVar("trackerPosition") or { x = 0, y = 0 }
--             position.x = value
--             MapPinEnhanced:SetVar("trackerPosition", position)
--             trackerFrame:ClearAllPoints()
--             trackerFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", position.x, position.y)
--         end
--     end,
--     init = function()
--         local position = MapPinEnhanced:GetVar("trackerPosition") or { x = 0, y = 0 }
--         return position.x
--     end,
-- })


-- Options:RegisterOption("slider", {
--     category = "TRACKER",
--     label = "Tracker y position",
--     description = "Move the tracker up or down.",
--     descriptionImage = {
--         texture = "delve-entrance-background-mycomancer-cavern",
--         width = 584,
--         height = 384,
--     },
--     min = -1000,
--     max = 1000,
--     step = 200,
--     onChange = function(value)
--         local trackerFrame = Tracker:GetTrackerFrame()
--         if trackerFrame:IsShown() then
--             local position = MapPinEnhanced:GetVar("trackerPosition") or { x = 0, y = 0 }
--             position.y = value
--             MapPinEnhanced:SetVar("trackerPosition", position)
--             trackerFrame:ClearAllPoints()
--             trackerFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", position.x, position.y)
--         end
--     end,
--     init = function()
--         local position = MapPinEnhanced:GetVar("trackerPosition") or { x = 0, y = 0 }
--         return position.y
--     end,
-- })


-- Options:RegisterOption("checkbox", {
--     category = "TRACKER",
--     label = "Show Tracker",
--     description = "Toggle the visibility of the tracker.",
--     onChange = function(value)
--         if value then
--             Tracker:ShowTracker()
--         else
--             Tracker:HideTracker()
--         end
--     end,
--     init = function()
--         return MapPinEnhanced:GetVar("trackerVisible") or false
--     end,
-- })


-- Options:RegisterOption("colorpicker", {
--     category = "TRACKER",
--     label = "Tracker Header Color",
--     description = "Change the color of the tracker header.",
--     onChange = function(r, g, b, a)
--         local trackerFrame = Tracker:GetTrackerFrame()
--         trackerFrame.header.headerTexture:SetVertexColor(r, g, b, a)
--     end,
--     init = function()
--         local trackerFrame = Tracker:GetTrackerFrame()
--         local r, g, b, a = trackerFrame.header.headerTexture:GetVertexColor()
--         return {
--             r = r,
--             g = g,
--             b = b,
--             a = a,
--         }
--     end,
-- })


-- Options:RegisterOption("input", {
--     category = "TRACKER",
--     label = "Tracker Max Height",
--     description = "Set the maximum height of the tracker in pixels.",
--     onChange = function(value)
--         local trackerFrame = Tracker:GetTrackerFrame()
--         trackerFrame:SetMaxHeight(tonumber(value) or 400)
--     end,
--     init = function()
--         local trackerFrame = Tracker:GetTrackerFrame()
--         return tostring(trackerFrame.maxHeight or 400)
--     end,
-- })


-- Options:RegisterOption("button", {
--     category = "TRACKER",
--     label = "Reset Tracker Position",
--     description = "Reset the tracker position to the center of the screen.",
--     buttonText = {
--         icon = "cross",
--         label = "Reset Position",
--     },
--     onChange = function()
--         MapPinEnhanced:SetVar("trackerPosition", nil)
--         local trackerFrame = Tracker:GetTrackerFrame()
--         if trackerFrame:IsShown() then
--             trackerFrame:ClearAllPoints()
--             trackerFrame:SetPoint("CENTER", UIParent, "CENTER")
--         end
--     end,
-- })

-- Options:RegisterOption("radiogroup", {
--     category = "TRACKER",
--     label = "Tracker View",
--     description = "Select the view mode for the tracker.",
--     orientation = "HORIZONTAL",
--     options = {
--         { label = "Pin View", value = "pin" },
--         { label = "Set View", value = "set" },
--     },
--     onChange = function(value)
--         local trackerFrame = Tracker:GetTrackerFrame()
--         if trackerFrame:IsShown() then
--             trackerFrame:SetActiveView(value)
--         end
--     end,
--     init = function()
--         local trackerFrame = Tracker:GetTrackerFrame()
--         return trackerFrame.activeView or "pin"
--     end,
-- })


-- Options:RegisterOption("radiogroup", {
--     category = "GENERAL",
--     label = "Test Option",
--     description = "This is a test option for demonstration purposes.",
--     orientation = "HORIZONTAL",
--     options = {
--         { label = "1", value = "1" },
--         { label = "2", value = "2" },
--         { label = "3", value = "3" },
--     },
--     onChange = function(value)
--         error("Selected value:", value)
--     end,
--     init = function()
--         return "option1"
--     end,
-- })
