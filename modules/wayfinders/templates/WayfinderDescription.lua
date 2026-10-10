---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@class MapPinEnhancedWayfinderDescriptionTemplate : MapPinEnhancedFadingFrameTemplate
---@field text FontString
---@field title string?
---@field description string?
---@field truncated boolean?
---@field mouseOwner Frame?
---@field maxWidth number?
---@field onHidden fun()?
---@field layoutKey string?
MapPinEnhancedWayfinderDescriptionMixin = {}

---@param title string?
---@param description string?
function MapPinEnhancedWayfinderDescriptionMixin:Apply(title, description)
    local font, size, flags = self.text:GetFont()
    local maxWidth = self.maxWidth or 325
    local layoutKey = table.concat({ maxWidth, UIParent:GetHeight(), font, size, flags or "", self.text:GetSpacing() },
        ":")
    if self.truncated ~= nil and self.title == title and self.description == description and
        self.layoutKey == layoutKey then
        return
    end
    self:OnLeave()
    self.layoutKey = layoutKey
    self.title, self.description = title, description
    if not description then
        self.truncated = false
        self:EnableMouse(false)
        self:Hide()
        if not self:IsShown() then self:ClearText() end
        return
    end
    local truncated = Wayfinders:ApplyWrappedText(self.text, description, maxWidth)
    self.truncated = truncated
    self:SetSize(math.max(1, self.text:GetWidth()), self.text:GetHeight())
    self:EnableMouse(truncated)
    self:SetMouseClickEnabled(truncated and self.mouseOwner ~= nil)
    self:Show()
end

function MapPinEnhancedWayfinderDescriptionMixin:OnEnter()
    if not self.truncated or not self.description then return end
    Wayfinders:ShowTextTooltip(self, self.title, self.description)
    if self.mouseOwner then
        MapPinEnhanced:AddTooltipInteractions(GameTooltip, { { MapPinEnhanced.L["Right Click"], MapPinEnhanced.L["Open menu"] } })
        GameTooltip:Show()
    end
end

function MapPinEnhancedWayfinderDescriptionMixin:OnLeave()
    if GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end

function MapPinEnhancedWayfinderDescriptionMixin:OnHide()
    self:OnLeave()
    self:EnableMouse(false)
    if not self.description then
        self:ClearText()
        if self.onHidden then self.onHidden() end
    end
end

-- Keep outgoing text and its layout space until the visibility fade finishes.
function MapPinEnhancedWayfinderDescriptionMixin:ClearText()
    self.text:SetText("")
    self:SetSize(1, 1)
end

function MapPinEnhancedWayfinderDescriptionMixin:OnShow()
    self:EnableMouse(self.truncated == true)
    self:SetMouseClickEnabled(self.truncated == true and self.mouseOwner ~= nil)
end

function MapPinEnhancedWayfinderDescriptionMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self)
    local font, size, flags = self.text:GetFont()
    self.text:SetFont(font, math.max(8, size - 1), flags)
end

---@param button MouseButton
function MapPinEnhancedWayfinderDescriptionMixin:OnMouseDown(button)
    local owner = self.mouseOwner
    local handler = owner and owner:GetScript("OnMouseDown")
    if handler then handler(owner, button) end
end

---@param button MouseButton
function MapPinEnhancedWayfinderDescriptionMixin:OnMouseUp(button)
    local owner = self.mouseOwner
    local handler = owner and owner:GetScript("OnMouseUp")
    if handler then handler(owner, button) end
end
