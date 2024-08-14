---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Options : Module
---@field options table<OPTIONCATEGORY, OptionObjectVariantsTyped[]> | nil#
---@field OptionBody MapPinEnhancedOptionEditorViewBodyMixin | nil#
local Options = MapPinEnhanced:CreateModule("Options")
Options.options = {}

---@enum OPTIONCATEGORY
local OptionCategories = {
    General = "General",
    Tracker = "Tracker",
    FloatingPin = "Floating Pin"
}


local CATEGORY_ORDER = {
    OptionCategories.General,
    OptionCategories.Tracker,
    OptionCategories.FloatingPin
}


local function CheckForDuplicateOption(label, category, options)
    if not options then return end
    if not options[category] then return end
    ---@type OptionObjectVariants[]
    local categoryOptions = options[category]
    for _, option in ipairs(categoryOptions) do
        if option.label == label then
            error(("Option with label %s already exists in category %s"):format(label, category))
        end
    end
end

---@param optionType FormType
---@param option OptionObjectVariants
function Options:RegisterOption(optionType, option)
    assert(option.category, "Option must have a category")
    assert(option.label, "Option must have a label")
    if optionType ~= "button" then
        assert(option.default ~= nil, "Option must have a default value")
    end
    assert(optionType, "Option must have a type")


    if not self.options then
        self.options = {}
    end
    if not self.options[option.category] then
        self.options[option.category] = {}
    end

    CheckForDuplicateOption(option.label, option.category, self.options)
    local optionTyped = option --[[@as OptionObjectVariantsTyped]]
    optionTyped.type = optionType
    if optionTyped.init == nil then
        optionTyped.init = optionTyped.default -- set init to default if not set
    end
    if optionTyped.onChange and not optionTyped.blockOnCreationInit then
        assert(type(optionTyped.onChange) == "function", "onChange must be a function")
        optionTyped.onChange(optionTyped.init)
    end
    table.insert(self.options[option.category], option)
end

---get a list of all used categories in the correct order
---@return string[]
function Options:GetCategories()
    -- dont return empty categories
    local categories = {}
    for _, category in ipairs(CATEGORY_ORDER) do
        if self.options[category] then
            table.insert(categories, category)
        end
    end
    return categories
end

function Options:GetOptionsForCategory(category)
    return self.options[category]
end

---@param category OPTIONCATEGORY
---@param label string
---@return OptionObjectVariantsTyped | nil
function Options:GetOptionElement(category, label)
    local categoryOptions = self.options[category]
    for _, option in ipairs(categoryOptions) do
        if option and option.label == label then
            return option
        end
    end
    return nil
end

---@param category OPTIONCATEGORY
---@param label string
---@param disabledState boolean
function Options:SetOptionDisabledState(category, label, disabledState)
    local option = self:GetOptionElement(category, label)
    if option then
        option.disabledState = disabledState
        if self.OptionBody then
            self.OptionBody:Update(category, label)
        end
        return
    end
    error(("Option with label %s does not exist in category %s"):format(label, category))
end

---@param oldVersion number
function Options:MigrateOptionByVersion(oldVersion)
    if oldVersion < 300 then -- versions before 3.0.0
        if MapPinEnhancedDB.global and MapPinEnhancedDB.global.options.autoOpenTracker ~= nil then
            ---@type boolean
            local value = MapPinEnhancedDB.global.options.autoOpenTracker
            MapPinEnhanced:SaveVar("tracker", "autoVisibility", value and "both" or "none")
        end
        if MapPinEnhancedDB.global and MapPinEnhancedDB.global.options.showInfoOnSuperTrackedFrame ~= nil then
            ---@type boolean
            local value = MapPinEnhancedDB.global.options.showInfoOnSuperTrackedFrame
            MapPinEnhanced:SaveVar("floatingPin", "showTitle", value)
        end
        if MapPinEnhancedDB.global and MapPinEnhancedDB.global.options.showTimeOnSuperTrackedFrame ~= nil then
            ---@type boolean
            local value = MapPinEnhancedDB.global.options.showTimeOnSuperTrackedFrame
            MapPinEnhanced:SaveVar("floatingPin", "showEstimatedTime", value)
        end
        if MapPinEnhancedDB.global and MapPinEnhancedDB.global.options.changedalpha ~= nil then
            ---@type boolean
            local value = MapPinEnhancedDB.global.options.changedalpha
            MapPinEnhanced:SaveVar("floatingPin", "unlimitedDistance", value)
        end
        if MapPinEnhancedDB.global and MapPinEnhancedDB.global.options.maxTrackerEntries ~= nil then
            ---@type number
            local value = MapPinEnhancedDB.global.options.maxTrackerEntries
            MapPinEnhanced:SaveVar("tracker", "trackerHeight", value)
        end
        if MapPinEnhancedDB.global and MapPinEnhancedDB.global.options.autoTrackNearest ~= nil then
            ---@type boolean
            local value = MapPinEnhancedDB.options.autoTrackNearest
            MapPinEnhanced:SaveVar("general", "autoTrackNearestPin", value)
        end


        if MapPinEnhancedDB.global and MapPinEnhancedDB.global.presets then
            local SetManager = MapPinEnhanced:GetModule("SetManager")
            local PinProvider = MapPinEnhanced:GetModule("PinProvider")
            ---@diagnostic disable-next-line: param-type-mismatch, no-unknown we don't type anything we just want to migrate them over
            for _, preset in pairs(MapPinEnhancedDB.global.presets) do
                local migratedSetName = preset.name or "Imported"
                if preset.input then
                    local pins = PinProvider:DeserializeWayString(preset.input)
                    local newSet = SetManager:AddSet(migratedSetName)
                    for _, pin in ipairs(pins) do
                        newSet:AddPin({
                            mapID = pin.mapID,
                            x = pin.x,
                            y = pin.y,
                            title = pin.title,
                        })
                    end
                end
            end
        end
        MapPinEnhanced:DeleteVar("global")
        MapPinEnhanced:DeleteVar("profileKeys")
        MapPinEnhanced:DeleteVar("profiles")
    end
end
