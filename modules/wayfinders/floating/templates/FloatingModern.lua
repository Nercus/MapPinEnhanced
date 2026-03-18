---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedFloatingModernTemplate : Frame
MapPinEnhancedFloatingModernMixin = {}

-- TODO: the distant diamond should scale based on distance
-- TODO: use the generic-frame-chamfered-12d-2o atlas to use as title background
-- TODO: use interpolation to smooth movement when clamped to the edge of the screen

local needsReset = false
local mathSqrt = math.sqrt

---@param color PinColor
function MapPinEnhancedFloatingModernMixin:SetColor(color)

end

function MapPinEnhancedFloatingModernMixin:SetTexture(texture, usesAtlas)
    if not texture then return end
end

function MapPinEnhancedFloatingModernMixin:SetTitle(title)

end

function MapPinEnhancedFloatingModernMixin:SetLocation(mapID, x, y)
    self.targetMapID = mapID
    self.targetX = x
    self.targetY = y
end

local function GetCenterScreenPoint()
    local centerX, centerY = WorldFrame:GetCenter();
    local scale = UIParent:GetEffectiveScale() or 1;
    return centerX / scale, centerY / scale;
end

---@param major number
---@param minor number
function MapPinEnhancedFloatingModernMixin:SetEllipticalRadii(major, minor)
    self.majorAxis = major
    self.minorAxis = minor
    self.majorAxisSquared = major * major
    self.minorAxisSquared = minor * minor
    self.axesMultiplied = major * minor
end

function MapPinEnhancedFloatingModernMixin:InitializeNavigationFrame()
    if self.navFrame then return end
    self.navFrame = C_Navigation.GetFrame()
    self:SetShown(self.navFrame ~= nil)

    if self.navFrame then
        self:ClearAllPoints()
        self:SetPoint("CENTER", self.navFrame, "CENTER")
    end
end

function MapPinEnhancedFloatingModernMixin:ShutdownNavigationFrame()
    self:ClearAllPoints()
    self.navFrame = nil
    self.isClamped = nil
    self.clampedChanged = nil
end

function MapPinEnhancedFloatingModernMixin:CheckInitializeNavigationFrame()
    if not self.navFrame then
        self:InitializeNavigationFrame()
    end
end

function MapPinEnhancedFloatingModernMixin:UpdateClampedState()
    local clamped = C_Navigation.WasClampedToScreen()
    self.clampedChanged = clamped ~= self.isClamped
    self.isClamped = clamped
end

function MapPinEnhancedFloatingModernMixin:ClampElliptical()
    local centerX, centerY = GetCenterScreenPoint()
    local navX, navY = self.navFrame:GetCenter()

    if type(navX) ~= "number" or type(navY) ~= "number" then return end

    local majorAxisSquared = self.majorAxisSquared or 0
    local minorAxisSquared = self.minorAxisSquared or 0
    local axesMultiplied = self.axesMultiplied or 0

    local pX = navX - centerX
    local pY = navY - centerY
    local denominator = mathSqrt(majorAxisSquared * pY * pY + minorAxisSquared * pX * pX)

    if denominator ~= 0 then
        local ratio = axesMultiplied / denominator
        local intersectionX = pX * ratio
        local intersectionY = pY * ratio
        self:SetPoint("CENTER", WorldFrame, "CENTER", intersectionX, intersectionY)
    end
end

function MapPinEnhancedFloatingModernMixin:UpdatePosition()
    if self.isClamped or self.clampedChanged then
        self:ClearAllPoints()

        if self.isClamped then
            self:ClampElliptical()
        else
            self:SetPoint("CENTER", self.navFrame, "CENTER")
        end
    end
end

function MapPinEnhancedFloatingModernMixin:OnUpdate(_)
    self:CheckInitializeNavigationFrame()

    if not self.navFrame then return end
    self:UpdateClampedState()
    self:UpdatePosition()
end

function MapPinEnhancedFloatingModernMixin:OnLoad()
    self:RegisterEvent("NAVIGATION_FRAME_CREATED")
    self:RegisterEvent("NAVIGATION_FRAME_DESTROYED")
    self:SetEllipticalRadii(500, 200)
end

function MapPinEnhancedFloatingModernMixin:OnEvent(event)
    if event == "NAVIGATION_FRAME_CREATED" then
        self:InitializeNavigationFrame()
    elseif event == "NAVIGATION_FRAME_DESTROYED" then
        self:ShutdownNavigationFrame()
    end
end

function MapPinEnhancedFloatingModernMixin:OnShow()
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_CREATED");
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_DESTROYED");
    SuperTrackedFrame:UnregisterEvent("SUPER_TRACKING_CHANGED");
    SuperTrackedFrame:ShutdownNavigationFrame();
    SuperTrackedFrame:Hide();
    needsReset = true

    self:InitializeNavigationFrame()
    self:SetScript("OnUpdate", function(_, dt)
        self:OnUpdate(dt)
    end)
end

function MapPinEnhancedFloatingModernMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    self:ShutdownNavigationFrame()

    if needsReset then
        SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_CREATED");
        SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_DESTROYED");
        SuperTrackedFrame:RegisterEvent("SUPER_TRACKING_CHANGED");
        SuperTrackedFrame:InitializeNavigationFrame();
        SuperTrackedFrame:Show();
    end
end
