---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Options = MapPinEnhanced:GetModule("Options")
local L = MapPinEnhanced.L

---@class MapPinEnhancedOptionControl : Frame
---@field SetEnabled fun(self: MapPinEnhancedOptionControl, enabled: boolean)

---@class MapPinEnhancedFormElementTemplate : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedOptionControl
---@field searchHighlight Texture
---@field searchAnimation AnimationGroup
---@field key string
---@field scrollPadding number
---@field normalAlpha number
---@field hoverAlpha number
---@field requireReload? OptionReloadRequirement
---@field optionEnabled boolean
---@field lastValue any
---@field callbacks function[]?
---@field GetValue fun(self: MapPinEnhancedFormElementTemplate): any
---@field SetValue fun(self: MapPinEnhancedFormElementTemplate, value: any)
---@field Setup fun(self: MapPinEnhancedFormElementTemplate, initialValue: any)
MapPinEnhancedFormElementMixin = CreateFromMixins(MapPinEnhancedFormFieldMixin)

function MapPinEnhancedFormElementMixin:GetLabelText()
    if not self.key then return nil end
    local localizationKey = self.key .. "_LABEL"
    return L[localizationKey] ~= localizationKey and L[localizationKey] or nil
end

function MapPinEnhancedFormElementMixin:GetDescriptionText()
    if not self.key then return nil end
    local localizationKey = self.key .. "_DESCRIPTION"
    return L[localizationKey] ~= localizationKey and L[localizationKey] or nil
end

function MapPinEnhancedFormElementMixin:IsValueEqual(value)
    return self:GetValue() == value
end

---@param value any
---@param skipReloadRequirement? boolean
function MapPinEnhancedFormElementMixin:NotifyChange(value, skipReloadRequirement)
    local previousValue = self.lastValue
    self.lastValue = value
    if self.callbacks then
        for _, callback in ipairs(self.callbacks) do callback(value) end
    end
    if not skipReloadRequirement then
        Options:HandleReloadRequiredChange(self, previousValue, value)
    end
end

function MapPinEnhancedFormElementMixin:IsOptionEnabled()
    return self.optionEnabled
end

---@param enabled boolean
function MapPinEnhancedFormElementMixin:SetEnabledState(enabled)
    assert(type(enabled) == "boolean", "Options:SetOptionEnabled: enabled must be a boolean")
    self.optionEnabled = enabled
    self.child:SetEnabled(enabled)
    self:SetAlpha(enabled and self.normalAlpha or self.normalAlpha * 0.5)
end

function MapPinEnhancedFormElementMixin:OnChange(callback)
    self.callbacks = self.callbacks or {}
    for _, existingCallback in ipairs(self.callbacks) do
        if existingCallback == callback then return function() end end
    end
    table.insert(self.callbacks, callback)
    return function()
        for index, registeredCallback in ipairs(self.callbacks) do
            if registeredCallback == callback then
                table.remove(self.callbacks, index)
                return
            end
        end
    end
end

function MapPinEnhancedFormElementMixin:ScrollToOption()
    if not Options.frame or not Options.frame.scrollFrame then return end
    if not Options.frame.scrollFrame:GetScrollChild() then return end
    local childTop, selfTop = Options.frame.scrollFrame:GetScrollChild():GetTop(), self:GetTop()
    if not childTop or not selfTop then return end
    local target = math.max(0, math.min(childTop - selfTop - self.scrollPadding,
        Options.frame.scrollFrame:GetVerticalScrollRange() or 0))
    Options.frame.scrollFrame:SetVerticalScroll(target)
    self.searchHighlight:Show()
end

function MapPinEnhancedFormElementMixin:OnEnter()
    if not self.optionEnabled then return end
    self:SetAlpha(self.hoverAlpha)
end

function MapPinEnhancedFormElementMixin:OnLeave()
    if not self.optionEnabled then return end
    if not self:IsMouseOver() then self:SetAlpha(self.normalAlpha) end
end

function MapPinEnhancedFormElementMixin:OnLoad()
    assert(self.key, "Form element must have a key")
    assert(self.GetValue and self.SetValue and self.OnChange and self.Setup,
        "Form element is missing its control implementation")
    MapPinEnhancedFormFieldMixin.OnLoad(self)
    self.optionEnabled = true
    self:SetAlpha(self.normalAlpha)
    self.child:HookScript("OnEnter", function() self:OnEnter() end)
    self.child:HookScript("OnLeave", function() self:OnLeave() end)
    Options:RegisterOption(self.key, self)
end
