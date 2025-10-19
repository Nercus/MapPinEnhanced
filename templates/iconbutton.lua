---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedIconButtonMixin : Button
---@field iconTexture MapPinEnhancedIconMixin
---@field icon MapPinEnhancedIcon
MapPinEnhancedIconButtonMixin = {}

---@param icon? MapPinEnhancedIcon
function MapPinEnhancedIconButtonMixin:SetIconTexture(icon)
    if icon then
        -- Allow setting the icon directly if provided
        self.icon = icon
    end
    assert(self.icon, "MapPinEnhancedIconButtonMixin: SetIconTexture called without icon set")
    self.iconTexture:SetIconTexture(self.icon)
end

function MapPinEnhancedIconButtonMixin:OnLoad()
    self:SetIconTexture()
    -- set icon size to fit nicely within the button based on its size
    local width = self:GetWidth()
    local height = self:GetHeight()
    local size = math.min(width, height) * 0.5
    self.iconTexture:SetSize(size, size)
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
