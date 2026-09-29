---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class MapPinEnhancedEditorPinDragGhost : Frame
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field title FontString
MapPinEnhancedEditorPinDragGhostMixin = {}

---@param pinData pinData
function MapPinEnhancedEditorPinDragGhostMixin:Init(pinData)
    if pinData.texture then
        self.pinFrame:SetIconTexture(pinData.texture, pinData.usesAtlas)
    else
        self.pinFrame:SetColor(pinData.color)
    end
    self.pinFrame:SetTracked(true)
    self.pinFrame:SetLock(pinData.lock)
    self.title:SetText(pinData.title or L["Map Pin"])
    self:UpdatePosition()
    self:Show()
end

function MapPinEnhancedEditorPinDragGhostMixin:UpdatePosition()
    local cursorX, cursorY = GetCursorPosition()
    cursorX = cursorX / UIParent:GetEffectiveScale()
    cursorY = cursorY / UIParent:GetEffectiveScale()
    self:ClearAllPoints()
    self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", cursorX + 16, cursorY - 16)
end
