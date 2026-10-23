---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@alias MapPinEnhancedOptionValue number | string | boolean | table

local RELOAD_OPTION_KEY = "Wayfinder.HideBlizzardFloatingDiamond"

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

---@param key string The unique key for the option, used for saving values. Is of the format "Category.OptionName", e.g. "General.ShowMinimapButton".
---@param frame MapPinEnhancedFormElementTemplate
function Options:RegisterOption(key, frame)
    assert(self.options[key] == nil, "Option with key " .. key .. " is already registered")
    self.options[key] = frame
    frame:Setup(self:GetOptionInitValue(key))
    frame.lastValue = frame:GetValue()
    if key == RELOAD_OPTION_KEY then
        assert(type(frame:GetValue()) == "boolean",
            "Options:RegisterOption: reload option must be boolean: " .. key)
    end
    self:SubscribeToOptionChanges(key, function(value)
        self:SaveOptionValue(key, value)
    end)
end

---@class PendingReloadOption
---@field frame MapPinEnhancedFormElementTemplate
---@field value boolean

-- Only the Blizzard diamond preference requires a reload. Retain its original
-- value until reload, reversal, or rollback when the options window reopens.
---@type PendingReloadOption?
local pendingReloadOption
local reloadDialogOpen = false
---@type MapPinEnhancedStaticDialogFrame?
local reloadDialog

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
function Options:HandleReloadRequiredChange(frame, previousValue)
    if frame.key ~= RELOAD_OPTION_KEY then return end
    pendingReloadOption = pendingReloadOption or { frame = frame, value = previousValue }
    if frame:IsValueEqual(pendingReloadOption.value) then
        pendingReloadOption = nil
        DismissReloadDialog()
    else
        self:RequestReload()
    end
end

function Options:RestorePendingReloadOption()
    local pending = pendingReloadOption
    if not pending then return end
    pendingReloadOption = nil
    DismissReloadDialog()
    local frame = pending.frame
    if not frame:IsValueEqual(pending.value) then
        frame:SetValue(pending.value)
        frame:NotifyChange(pending.value, true)
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
    if not frame:IsAvailable() then return end
    assert(frame.ScrollToOption, "Option frame must have a ScrollToOption method")
    if self.frame then self.frame.scrollFrame.Child.Wayfinder:RevealOption(key) end
    if not frame:IsShown() then
        local category = frame:GetParent() --[[@as MapPinEnhancedOptionCategoryBaseTemplate]]
        if category.enableKey then frame = self.options[category.enableKey] end
    end
    for _, option in pairs(self.options) do option.searchHighlight:Hide() end
    frame:ScrollToOption()
end

MapPinEnhanced:OnLoad(function()
    Options:SubscribeToOptionChanges("General.TooltipHelper", function(enabled)
        MapPinEnhanced:SetTooltipHelperEnabled(enabled)
    end)
end)
