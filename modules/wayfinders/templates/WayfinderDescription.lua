---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedWayfinderDescriptionTemplate : Frame
---@field text FontString
---@field title string?
---@field description string?
---@field truncated boolean?
---@field mouseOwner Frame?
MapPinEnhancedWayfinderDescriptionMixin = {}

---@param title string?
---@param description string?
function MapPinEnhancedWayfinderDescriptionMixin:Apply(title, description)
    if self.truncated ~= nil and self.title == title and self.description == description then return end
    self:OnLeave()
    self.title, self.description = title, description
    if not description then
        self.text:SetText("")
        self.truncated = false
        self:SetSize(1, 1)
        self:EnableMouse(false)
        self:Hide()
        return
    end
    local flattened = description:gsub("\n", " ")
    local _, truncated = MapPinEnhanced:BoundDescription(self.text, flattened, 450, 1)
    self.truncated = truncated
    self.text:SetWordWrap(false)
    self.text:SetNonSpaceWrap(false)
    self.text:SetWidth(math.min(450, math.ceil(self.text:GetUnboundedStringWidth())))
    self:SetSize(math.max(1, self.text:GetWidth()), self.text:GetHeight())
    self:EnableMouse(truncated)
    self:SetPropagateMouseClicks(self.mouseOwner == nil)
    self:Show()
end

function MapPinEnhancedWayfinderDescriptionMixin:OnEnter()
    if not self.truncated or not self.description then return end
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
    GameTooltip:SetText(self.title or "", 1, 0.82, 0, 1, true)
    MapPinEnhanced:AddDescriptionToTooltip(self.description)
    GameTooltip:Show()
end

function MapPinEnhancedWayfinderDescriptionMixin:OnLeave()
    if GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end

function MapPinEnhancedWayfinderDescriptionMixin:OnHide()
    self:OnLeave()
    self:EnableMouse(false)
end

function MapPinEnhancedWayfinderDescriptionMixin:OnShow()
    self:EnableMouse(self.truncated == true)
end

function MapPinEnhancedWayfinderDescriptionMixin:OnLoad()
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
