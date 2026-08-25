---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedIconButtonTemplate: Button, MapPinEnhancedTooltipMixin
---@field iconTexture MapPinEnhancedIconMixin
---@field icon MapPinEnhancedIcon
---@field iconSize MapPinEnhancedIconButtonSize
---@field customIcon boolean?
MapPinEnhancedIconButtonMixin = {}

---@alias MapPinEnhancedIconButtonSize "small"|"medium"|"large"

---@type table<MapPinEnhancedIconButtonSize, number>
local ICON_SIZE_PERCENTAGES = {
    small = 0.35,
    medium = 0.5,
    large = 0.65,
}

---@param icon? MapPinEnhancedIcon
function MapPinEnhancedIconButtonMixin:SetIconTexture(icon)
    if icon then
        -- Allow setting the icon directly if provided
        self.icon = icon
    end
    assert(self.icon, "MapPinEnhancedIconButtonMixin: SetIconTexture called without icon set")
    self.iconTexture:SetIconTexture(self.icon)
end

function MapPinEnhancedIconButtonMixin:UpdateIconSize()
    local percentage = ICON_SIZE_PERCENTAGES[self.iconSize]
    assert(percentage, "MapPinEnhancedIconButtonMixin: invalid iconSize: " .. tostring(self.iconSize))
    local size = math.min(self:GetWidth(), self:GetHeight()) * percentage
    self.iconTexture:SetSize(size, size)
end

function MapPinEnhancedIconButtonMixin:OnLoad()
    self:OnTooltipLoad()
    if not self.customIcon then
        self:SetIconTexture()
    end
    self:UpdateIconSize()
end

function MapPinEnhancedIconButtonMixin:OnSizeChanged()
    self:UpdateIconSize()
end

function MapPinEnhancedIconButtonMixin:OnMouseDown()
    if not self:IsEnabled() then return end
    self.iconTexture:SetPoint("CENTER", self, "CENTER", 1, -1)
    self.iconTexture:SetAlpha(0.6)
end

function MapPinEnhancedIconButtonMixin:OnMouseUp()
    if not self:IsEnabled() then return end
    self.iconTexture:SetPoint("CENTER", self, "CENTER", 0, 0)
    self.iconTexture:SetAlpha(1.0)
end

---@param callback fun(value: mouseButton, down: boolean)
function MapPinEnhancedIconButtonMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@param formData ButtonSetup
function MapPinEnhancedIconButtonMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")

    self:SetCallback(formData.onChange)
    self:SetScript("OnClick", function(_, button, down)
        if self.onChangeCallback then
            self.onChangeCallback(button, down)
        end
    end)
end

---@param triggerCallback boolean|nil
function MapPinEnhancedIconButtonMixin:SetValue(_, triggerCallback)
    if triggerCallback and self.onChangeCallback then
        -- simulate a left button click
        self.onChangeCallback("LeftButton", false)
    end
end
