---@class MapPinEnhancedMenuTitleActionData
---@field label string
---@field icon MapPinEnhancedIcon?
---@field onClick fun()?

---@class MapPinEnhancedMenuTitleActionButton : Button
---@field icon MapPinEnhancedIconMixin

---@class MapPinEnhancedMenuTitleActionTemplate : Frame
---@field label FontString
---@field button MapPinEnhancedMenuTitleActionButton
---@field data MapPinEnhancedMenuTitleActionData | nil
MapPinEnhancedMenuTitleActionMixin = {}

---@param data MapPinEnhancedMenuTitleActionData
function MapPinEnhancedMenuTitleActionMixin:SetData(data)
    self.data = data
    self.label:SetText(data.label or "")

    if data.icon then
        self.button.icon:SetIconTexture(data.icon)
        self.button.icon:Show()
    else
        self.button.icon:Hide()
    end
end

function MapPinEnhancedMenuTitleActionMixin:OnClick()
    if self.data and self.data.onClick then
        self.data.onClick()
    end
end
