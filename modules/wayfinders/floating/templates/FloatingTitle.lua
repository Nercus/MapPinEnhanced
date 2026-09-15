---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedWayfinderFloatingTitleTemplate : Frame
---@field background Texture
---@field title FontString
---@field description MapPinEnhancedWayfinderDescriptionTemplate
---@field border Texture
MapPinEnhancedWayfinderFloatingTitleMixin = {}

local MAX_TITLE_WIDTH = 450
local TITLE_ELLIPSIS = "..."

function MapPinEnhancedWayfinderFloatingTitleMixin:OnLoad()
    self.title:SetMaxLines(1)
    self.title:SetWordWrap(false)
    self:SetTitle("")
    self:SetVisible(false)
end

---@param title string?
function MapPinEnhancedWayfinderFloatingTitleMixin:SetTitle(title)
    MapPinEnhanced:SetTruncatedText(self.title, title or "", MAX_TITLE_WIDTH, TITLE_ELLIPSIS)
    self:SetSize(self.title:GetWidth() + 30, self.title:GetHeight() + 10)
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingTitleMixin:SetColor(color)
    local r, g, b, a = color:GetRGBA()
    self.border:SetVertexColor(r, g, b, 1)

    local textR, textG, textB = math.min(r * 1.5, 1), math.min(g * 1.5, 1), math.min(b * 1.5, 1)
    self.title:SetTextColor(textR, textG, textB)
end

---@param shown boolean
function MapPinEnhancedWayfinderFloatingTitleMixin:SetVisible(shown)
    self:SetShown(shown)
end

---@param title string?
---@param description string?
function MapPinEnhancedWayfinderFloatingTitleMixin:SetDestinationText(title, description)
    self:SetTitle(title)
    self.description:Apply(title, description)
    local width = math.max(self.title:GetWidth(), description and self.description:GetWidth() or 0, 40)
    local height = self.title:GetHeight() + (description and self.description:GetHeight() + 2 or 0)
    self:SetSize(width + 30, height + 10)
end
