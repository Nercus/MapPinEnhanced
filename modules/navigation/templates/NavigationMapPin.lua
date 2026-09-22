---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

---@class MapPinEnhancedNavigationMapPinTemplate : Frame
---@field line Line
---@field step NavigationStep?
---@field antOffset number?
---@field circle Texture
---@field number FontString
---@field lineEnd MapPinEnhancedNavigationMapPinTemplate?
---@field lineStart MapPinEnhancedNavigationMapPinTemplate?
---@field routePathType string?
---@field isMapEdge boolean?
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
    self.antOffset = 0
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
    self.line:Hide()
    self.line:ClearAllPoints()
    self:SetScript("OnUpdate", nil)
    self.antOffset = nil
end

---@param pathType string
function MapPinEnhancedNavigationMapPinMixin:SetRoutePoint(pathType)
    self.routePathType = pathType
    if self.isMapEdge then
        self:SetLineEndpoint()
        return
    end
    local color = Navigation.PATH_COLORS[pathType] or Navigation.DEFAULT_PATH_COLOR
    self.circle:SetVertexColor(color:GetRGBA())
    self.circle:Show()
    self.number:SetText(self.step and self.step.index or "")
    self.number:Show()
    self:EnableMouse(true)
end

function MapPinEnhancedNavigationMapPinMixin:SetLineEndpoint()
    self:OnLeave()
    self.circle:Hide()
    self.number:Hide()
    self:EnableMouse(false)
end

function MapPinEnhancedNavigationMapPinMixin:RefreshLine()
    local shown = self.lineEnd ~= nil and self:IsShown() and self.lineEnd:IsShown()
    self.line:SetShown(shown)
    self:SetScript("OnUpdate", shown and self.OnUpdate or nil)
    if shown then self:OnUpdate(0) end
end

-- UV scrolling keeps dash spacing constant as the map zooms or endpoints move.
-- Only visible connected pins animate; reset/hide detach the update script.
---@param elapsed number
function MapPinEnhancedNavigationMapPinMixin:OnUpdate(elapsed)
    local endpoint = self.lineEnd
    if not endpoint then return end
    local x, y = self:GetCenter()
    local endX, endY = endpoint:GetCenter()
    if not x or not y or not endX or not endY then return end
    local scale = endpoint:GetEffectiveScale() / self:GetEffectiveScale()
    local dx, dy = endX * scale - x, endY * scale - y
    local length = math.sqrt(dx * dx + dy * dy)
    self.antOffset = ((self.antOffset or 0) - elapsed * 0.75) % 1
    self.line:SetTexCoord(self.antOffset, self.antOffset + length / 16, 0, 1)
end

function MapPinEnhancedNavigationMapPinMixin:OnShow()
    self:RefreshLine()
    if self.lineStart then self.lineStart:RefreshLine() end
end

function MapPinEnhancedNavigationMapPinMixin:OnHide()
    self:OnLeave()
    self:SetScript("OnUpdate", nil)
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
    self:EnableMouse(false)
    self.routePathType = nil
    self.step = nil
    self:SetScript("OnUpdate", nil)
    self.isMapEdge = nil
    self:Hide()
end

function MapPinEnhancedNavigationMapPinMixin:OnEnter()
    local step = self.step
    local progression = Navigation.progression
    local graph = Navigation:GetGraph()
    local reference = step and progression and progression.route.pathReferences[step.index]
    if not step or not graph or not reference or self.isMapEdge then return end
    local pathType = graph.pathTypes[reference]
    local pointIndex = graph.pathToPointIndexes[reference]
    local mapID = graph.pointMapIDs[pointIndex]
    local color = Navigation.PATH_COLORS[pathType] or Navigation.DEFAULT_PATH_COLOR
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:AddLine(string.format(L["Navigation Step Number"], step.index,
        Navigation:GetPathMethod(pathType)), color:GetRGB())
    local info = step.info
    GameTooltip:AddLine(info and info.instruction or Navigation:GetPathInstruction(pathType, mapID), 1, 1, 1, true)
    local mapInfo = C_Map.GetMapInfo(mapID)
    GameTooltip:AddLine(string.format("%s (%.1f, %.1f)", mapInfo and mapInfo.name or tostring(mapID),
        graph.pointXs[pointIndex] * 100, graph.pointYs[pointIndex] * 100), 0.7, 0.7, 0.7, true)
    if info and info.status and info.status ~= "" then
        GameTooltip:AddLine(info.status, 1, 0.82, 0, true)
    end
    GameTooltip:Show()
end

function MapPinEnhancedNavigationMapPinMixin:OnLeave()
    if GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end
