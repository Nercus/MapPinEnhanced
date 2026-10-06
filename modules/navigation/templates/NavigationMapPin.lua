---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Navigation = MapPinEnhanced:GetModule("Navigation")
local Options = MapPinEnhanced:GetModule("Options")
local L = MapPinEnhanced.L

local HOVER_SCALE = 1.4
local HOVER_SCALE_SPEED = (HOVER_SCALE - 1) / 0.15

---@class MapPinEnhancedNavigationMapPinTemplate : Frame
---@field line Line
---@field step NavigationStep?
---@field lineScroll AnimationGroup
---@field lineSpan number?
---@field circle Texture
---@field number FontString
---@field lineEnd MapPinEnhancedNavigationMapPinTemplate?
---@field lineStart MapPinEnhancedNavigationMapPinTemplate?
---@field routePathType string?
---@field isMapEdge boolean?
---@field hoverScaleTarget number?
MapPinEnhancedNavigationMapPinMixin = {}

---@param endFrame MapPinEnhancedNavigationMapPinTemplate
---@param isCurrent boolean
function MapPinEnhancedNavigationMapPinMixin:SetRouteLine(endFrame, isCurrent)
    self:ClearRouteLine()
    if endFrame.lineStart and endFrame.lineStart ~= self then
        endFrame.lineStart:ClearRouteLine()
    end
    self.lineEnd = endFrame
    endFrame.lineStart = self
    self.line:ClearAllPoints()
    self.line:SetStartPoint("CENTER", self)
    self.line:SetEndPoint("CENTER", endFrame)
    self.line:SetTexture("Interface/AddOns/MapPinEnhanced/assets/navigation/AntLine.png", "REPEAT", "CLAMP")
    self.line:SetVertexColor(1, 1, 1, isCurrent and 1 or 0.55)
    self:RefreshLine()
end

-- The start frame owns the Line region. The reciprocal endpoint link lets
-- either projected frame refresh or detach that owner as map visibility changes.
function MapPinEnhancedNavigationMapPinMixin:ClearRouteLine()
    local endFrame = self.lineEnd
    if endFrame and endFrame.lineStart == self then
        endFrame.lineStart = nil
    end
    self.lineEnd = nil
    self.lineScroll:Stop()
    self.line:Hide()
    self.line:ClearAllPoints()
    self:RefreshUpdateScript()
    self.lineSpan = nil
end

---@param pathType string
function MapPinEnhancedNavigationMapPinMixin:SetRoutePoint(pathType)
    self.routePathType = pathType
    if self.isMapEdge then
        self:SetLineEndpoint()
        return
    end
    local color = Navigation:GetPathColor(pathType)
    self.circle:SetVertexColor(color:GetRGBA())
    self.circle:Show()
    local index = self.step and self.step.index
    local font, size, flags = GameFontNormal:GetFont()
    self.number:SetFont(font, index and index >= 10 and size * 0.8 or size, flags)
    self.number:SetText(index or "")
    self.number:Show()
    self:EnableMouse(true)
end

function MapPinEnhancedNavigationMapPinMixin:SetLineEndpoint()
    self:OnLeave()
    self:ResetHoverScale()
    self.circle:Hide()
    self.number:Hide()
    self:EnableMouse(false)
end

function MapPinEnhancedNavigationMapPinMixin:RefreshLine()
    local shown = self.lineEnd ~= nil and self:IsVisible() and self.lineEnd:IsVisible()
    self.line:SetShown(shown)
    if shown then
        self:RefreshLineGeometry()
        if not self.lineScroll:IsPlaying() then self.lineScroll:Play() end
    else
        self.lineScroll:Stop()
        self.lineSpan = nil
    end
end

-- Only the brief hover interpolation owns a Lua frame-update script.
function MapPinEnhancedNavigationMapPinMixin:RefreshUpdateScript()
    local animate = self:IsShown() and self.hoverScaleTarget ~= nil
    self:SetScript("OnUpdate", animate and self.OnUpdate or nil)
end

---@param hovered boolean
function MapPinEnhancedNavigationMapPinMixin:SetHoverScale(hovered)
    local target = hovered and Options:GetOptionValue("Pins.Miscellaneous.ScaleOnHover") and HOVER_SCALE or 1
    self.hoverScaleTarget = self:GetScale() ~= target and target or nil
    self:RefreshUpdateScript()
end

function MapPinEnhancedNavigationMapPinMixin:ResetHoverScale()
    self.hoverScaleTarget = nil
    self:SetScale(1)
    self:RefreshUpdateScript()
end

-- The surface owner samples geometry at 20 Hz; hover refreshes its two affected lines.
---@param elapsed number
function MapPinEnhancedNavigationMapPinMixin:OnUpdate(elapsed)
    local target = self.hoverScaleTarget
    if target then
        local scale = self:GetScale()
        local step = HOVER_SCALE_SPEED * elapsed
        scale = scale < target and math.min(scale + step, target) or math.max(scale - step, target)
        self:SetScale(scale)
        if scale == target then
            self.hoverScaleTarget = nil
            self:RefreshUpdateScript()
        end
    end
    self:RefreshLineGeometry()
    if self.lineStart then self.lineStart:RefreshLineGeometry() end
end

function MapPinEnhancedNavigationMapPinMixin:RefreshLineGeometry()
    local endpoint = self.lineEnd
    if not endpoint or not self.line:IsShown() then return end
    local x, y = self:GetCenter()
    local endX, endY = endpoint:GetCenter()
    if not x or not y or not endX or not endY then return end
    local scale = endpoint:GetEffectiveScale() / self:GetEffectiveScale()
    local dx, dy = endX * scale - x, endY * scale - y
    local length = math.sqrt(dx * dx + dy * dy)
    local span = length / 16
    if span ~= self.lineSpan then
        self.lineSpan = span
        self.line:SetTexCoord(0, span, 0, 1)
    end
end

function MapPinEnhancedNavigationMapPinMixin:OnShow()
    self:RefreshLine()
    if self.lineStart then self.lineStart:RefreshLine() end
end

function MapPinEnhancedNavigationMapPinMixin:OnHide()
    self:OnLeave()
    self:ResetHoverScale()
    self:SetScript("OnUpdate", nil)
    self.lineScroll:Stop()
    self.lineSpan = nil
    self.line:Hide()
    if self.lineStart then self.lineStart:RefreshLine() end
end

function MapPinEnhancedNavigationMapPinMixin:Reset()
    if self.lineStart then self.lineStart:ClearRouteLine() end
    self.lineStart = nil
    self:ClearRouteLine()
    self.circle:SetVertexColor(1, 1, 1, 1)
    self.circle:Hide()
    self.number:SetText("")
    self.number:Hide()
    self:OnLeave()
    self:ResetHoverScale()
    self:EnableMouse(false)
    self.routePathType = nil
    self.step = nil
    self:SetScript("OnUpdate", nil)
    self.isMapEdge = nil
    self:Hide()
end

function MapPinEnhancedNavigationMapPinMixin:OnEnter()
    self:SetHoverScale(true)
    local step = self.step
    local progression = Navigation.progression
    local graph = progression and progression.route.graph
    local reference = step and progression and progression.route.pathReferences[step.index]
    if not step or not progression or not graph or not reference or self.isMapEdge then return end
    local pathType = graph.pathTypes[reference]
    local pointIndex = graph.pathToPointIndexes[reference]
    local mapID = graph.pointMapIDs[pointIndex]
    local color = Navigation:GetPathColor(pathType)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:AddLine(string.format(L["Navigation Step Number"], step.index,
        Navigation:GetPathMethod(pathType)), color:GetRGB())
    local info = step.info
    GameTooltip:AddLine(Navigation:GetPathInstruction(progression.route, step.index,
        step.index == progression.pathIndex and progression.phase or nil), 1, 1, 1, true)
    local mapInfo = C_Map.GetMapInfo(mapID)
    GameTooltip:AddLine(string.format("%s (%.1f, %.1f)", mapInfo and mapInfo.name or tostring(mapID),
        graph.pointXs[pointIndex] * 100, graph.pointYs[pointIndex] * 100), 0.7, 0.7, 0.7, true)
    if info and info.status and info.status ~= "" then
        GameTooltip:AddLine(info.status, 1, 0.82, 0, true)
    end
    GameTooltip:Show()
end

function MapPinEnhancedNavigationMapPinMixin:OnLeave()
    self:SetHoverScale(false)
    if GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end
