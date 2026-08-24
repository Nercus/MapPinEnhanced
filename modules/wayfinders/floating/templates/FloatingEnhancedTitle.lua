---@class MapPinEnhancedWayfinderFloatingEnhancedTitleTemplate : Frame
---@field background Texture
---@field gradient Texture
---@field title FontString
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin
MapPinEnhancedWayfinderFloatingEnhancedTitleMixin = {}

local MAX_TITLE_WIDTH = 450
local TITLE_ELLIPSIS = "..."
local mathCeil = math.ceil
local mathMin = math.min
local stringByte = string.byte
local stringSub = string.sub

---@param text string
---@param endIndex number
---@return string
local function GetUTF8Prefix(text, endIndex)
    while endIndex > 0 do
        local nextByte = stringByte(text, endIndex + 1)
        if not nextByte or nextByte < 0x80 or nextByte >= 0xC0 then break end
        endIndex = endIndex - 1
    end
    return stringSub(text, 1, endIndex)
end

---@param fontString FontString
---@param text string
local function SetTruncatedTitle(fontString, text)
    fontString:SetWidth(0)
    fontString:SetText(text)

    local fullWidth = fontString:GetUnboundedStringWidth()
    if fullWidth <= MAX_TITLE_WIDTH then
        fontString:SetWidth(mathCeil(fullWidth))
        return
    end

    local low = 0
    local high = #text
    local truncatedText = TITLE_ELLIPSIS
    while low <= high do
        local middle = math.floor((low + high) / 2)
        local candidate = GetUTF8Prefix(text, middle) .. TITLE_ELLIPSIS
        fontString:SetText(candidate)
        if fontString:GetUnboundedStringWidth() <= MAX_TITLE_WIDTH then
            truncatedText = candidate
            low = middle + 1
        else
            high = middle - 1
        end
    end

    fontString:SetText(truncatedText)
    fontString:SetWidth(mathMin(MAX_TITLE_WIDTH, mathCeil(fontString:GetUnboundedStringWidth())))
end

function MapPinEnhancedWayfinderFloatingEnhancedTitleMixin:OnLoad()
    self.title:SetMaxLines(1)
    self.title:SetWordWrap(false)
    self:SetTitle("")
    self:SetVisible(false, true)
end

---@param title string?
function MapPinEnhancedWayfinderFloatingEnhancedTitleMixin:SetTitle(title)
    SetTruncatedTitle(self.title, title or "")
    self:SetSize(self.title:GetWidth() + 10, self.title:GetHeight() + 10)
end

---@param color ColorMixin
function MapPinEnhancedWayfinderFloatingEnhancedTitleMixin:SetColor(color)
    local r, g, b, a = color:GetRGBA()
    self.background:SetVertexColor(r, g, b, 1)
    self.gradient:SetVertexColor(r, g, b, a)
end

---@param shown boolean
---@param instantly boolean?
function MapPinEnhancedWayfinderFloatingEnhancedTitleMixin:SetVisible(shown, instantly)
    self.fadeIn:ApplyParentShown(shown, self.fadeOut, instantly)
end
