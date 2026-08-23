---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@alias MapPinEnhancedOptionValue number | string | boolean | table
---@alias OptionReloadRequirement "onEnable"|"onDisable"|"both"

---@class Options
---@field options table<string, MapPinEnhancedFormElementTemplate> A table mapping option keys to their corresponding frames.
local Options = MapPinEnhanced:GetModule("Options")
Options.options = {}

---@param key string
---@return MapPinEnhancedOptionValue
function Options:GetDefaultValue(key)
    ---@type MapPinEnhancedOptionValue
    local default = self.DEFAULTS[key]
    assert(default ~= nil, "No default value found for key: " .. tostring(key))
    return default
end

function Options:GetOptionInitValue(key)
    local savedValue = MapPinEnhanced:GetVar("options", key)
    if savedValue ~= nil then
        return savedValue
    end
    return self:GetDefaultValue(key)
end

function Options:SaveOptionValue(key, value)
    MapPinEnhanced:SetVar("options", key, value)
end

---@param key string The unique key for the option, used for saving values. Is of the format "category.optionName", e.g. "general.showMinimapPin".
---@param frame MapPinEnhancedFormElementTemplate
function Options:RegisterOption(key, frame)
    assert(self.options[key] == nil, "Option with key " .. key .. " is already registered")
    assert(frame.requireReload == nil or frame.requireReload == "onEnable" or frame.requireReload == "onDisable" or
        frame.requireReload == "both", "Options:RegisterOption: invalid requireReload value for " .. key)
    self.options[key] = frame
    frame:Setup(self:GetOptionInitValue(key))
    frame.lastValue = frame:GetValue()
    if frame.requireReload == "onEnable" or frame.requireReload == "onDisable" then
        assert(type(frame:GetValue()) == "boolean",
            "Options:RegisterOption: " .. frame.requireReload .. " requires a boolean option: " .. key)
    end
    self:SubscribeToOptionChanges(key, function(value)
        self:SaveOptionValue(key, value)
    end)
end

---@class PendingReloadOption
---@field value any

---@type table<string, PendingReloadOption>
local pendingReloadOptions = {}
---@type string[]
local pendingReloadOrder = {}
local reloadDialogOpen = false
---@type MapPinEnhancedStaticDialogFrame?
local reloadDialog

local function HasPendingReloadOptions()
    return next(pendingReloadOptions) ~= nil
end

local function DismissReloadDialog()
    if reloadDialog then reloadDialog:Hide() end
    reloadDialog = nil
    reloadDialogOpen = false
end

function Options:RequestReload()
    if reloadDialogOpen then return end
    reloadDialogOpen = true
    reloadDialog = MapPinEnhanced:ShowConfirmDialog(L["Reload UI"],
        L["This change requires a UI reload. Reload now?"],
        function()
            ReloadUI()
        end,
        nil,
        function()
            reloadDialog = nil
            reloadDialogOpen = false
        end)
    if not reloadDialog then reloadDialogOpen = false end
end

---@param frame MapPinEnhancedFormElementTemplate
---@param previousValue any
---@param value any
function Options:HandleReloadRequiredChange(frame, previousValue, value)
    local requirement = frame.requireReload
    if not requirement then return end
    if requirement ~= "both" then
        assert(type(value) == "boolean",
            "Options:HandleReloadRequiredChange: transition requirement needs a boolean value")
    end

    local requiresReload = requirement == "both" or requirement == "onEnable" and value or
        requirement == "onDisable" and not value
    if requiresReload and not pendingReloadOptions[frame.key] then
        pendingReloadOptions[frame.key] = { value = previousValue }
        table.insert(pendingReloadOrder, frame.key)
    end

    local pending = pendingReloadOptions[frame.key]
    if pending and frame:IsValueEqual(pending.value) then
        pendingReloadOptions[frame.key] = nil
    end

    if requiresReload and pendingReloadOptions[frame.key] then
        self:RequestReload()
    elseif not HasPendingReloadOptions() then
        DismissReloadDialog()
    end
end

function Options:RestorePendingReloadOptions()
    if not HasPendingReloadOptions() then return end

    local optionsToRestore = pendingReloadOptions
    local restoreOrder = pendingReloadOrder
    pendingReloadOptions = {}
    pendingReloadOrder = {}
    DismissReloadDialog()

    for index = #restoreOrder, 1, -1 do
        local key = restoreOrder[index]
        local pending = optionsToRestore[key]
        if pending then
            local frame = self.options[key]
            assert(frame, "Options:RestorePendingReloadOptions: option not found: " .. key)
            if not frame:IsValueEqual(pending.value) then
                frame:SetValue(pending.value)
                frame:NotifyChange(pending.value, true)
            end
        end
    end
end

function Options:SetOptionValue(key, value)
    local frame = self.options[key]
    if not frame then
        error("Option with key " .. key .. " not found")
    end
    assert(frame.SetValue, "Option frame must have a SetValue method")
    assert(frame.IsValueEqual, "Option frame must have an IsValueEqual method")
    assert(frame.NotifyChange, "Option frame must have a NotifyChange method")
    if frame:IsValueEqual(value) then
        return
    end
    frame:SetValue(value)
    frame:NotifyChange(value)
end

function Options:GetOptionValue(key)
    local frame = self.options[key]
    if not frame then
        error("Option with key " .. key .. " not found")
    end
    assert(frame.GetValue, "Option frame must have a Get method")
    return frame:GetValue()
end

---@param key string
---@param enabled boolean
function Options:SetOptionEnabled(key, enabled)
    local frame = self.options[key]
    if not frame then
        error("Option with key " .. key .. " not found")
    end
    assert(frame.SetEnabledState, "Option frame must have a SetEnabledState method")
    frame:SetEnabledState(enabled)
end

local addonLoaded = false
local cachedCallbacks = {}

---@param key string
---@param callback function
---@return fun() unsubscribe Call to remove this callback
function Options:SubscribeToOptionChanges(key, callback)
    local frame = self.options[key]
    if not frame then
        error("Option with key " .. key .. " not found")
    end
    assert(frame.OnChange, "Option frame must have a OnChange method")

    if not addonLoaded then
        table.insert(cachedCallbacks, function()
            callback(self:GetOptionInitValue(key))
        end)
    else
        callback(self:GetOptionInitValue(key))
    end
    return frame:OnChange(callback)
end

MapPinEnhanced:OnLoad(function()
    if addonLoaded then return end
    addonLoaded = true
    while #cachedCallbacks > 0 do
        local callback = table.remove(cachedCallbacks, 1)
        callback()
    end
end)

function Options:ScrollToOption(key)
    local frame = self.options[key]
    if not frame then
        error("Option with key " .. key .. " not found")
    end
    assert(frame.ScrollToOption, "Option frame must have a ScrollToOption method")
    frame:ScrollToOption()
end
