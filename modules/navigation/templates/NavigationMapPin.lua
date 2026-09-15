---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Navigation = MapPinEnhanced:GetModule("Navigation")
local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedNavigationMapPinTemplate : Frame
---@field line Line
---@field step NavigationStep?
---@field antOffset number?
---@field circle Texture
---@field icon Texture
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
    local iconKey = Navigation:GetPathIcon(pathType)
    local iconConfig = Pins.PIN_ICONS[iconKey]
    self.circle:SetVertexColor(iconConfig.color:GetRGBA())
    self.circle:Show()
    self.icon:ClearAllPoints()
    local offset = iconConfig.offset or { x = 0, y = 0 }
    self.icon:SetPoint("CENTER", offset.x, offset.y)
    self.icon:SetScale(iconConfig.scale or 1)
    if iconConfig.usesAtlas then
        self.icon:SetAtlas(iconConfig.path, false)
    else
        self.icon:SetTexture(iconConfig.path)
    end
    self.icon:SetVertexColor(1, 1, 1, 1)
    self.icon:Show()
end

function MapPinEnhancedNavigationMapPinMixin:SetLineEndpoint()
    self.circle:Hide()
    self.icon:Hide()
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
    self.icon:ClearAllPoints()
    self.icon:SetPoint("CENTER")
    self.icon:SetScale(1)
    self.icon:SetTexture(nil)
    self.icon:SetVertexColor(1, 1, 1, 1)
    self.icon:Hide()
    self:EnableMouse(false)
    self.routePathType = nil
    self.step = nil
    self:SetScript("OnUpdate", nil)
    self.isMapEdge = nil
    self:Hide()
end
