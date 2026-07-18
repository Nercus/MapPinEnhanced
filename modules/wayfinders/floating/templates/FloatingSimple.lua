---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedFloatingSimpleTextContainer : Frame
---@field title FontString
---@field distance FontString
---@field eta FontString

---@class MapPinEnhancedFloatingSimpleClampedArrow : Frame
---@field needle Texture

---@class MapPinEnhancedFloatingSimpleTemplate : Frame
---@field clampedArrow MapPinEnhancedFloatingSimpleClampedArrow
---@field pin MapPinEnhancedBasePinTemplate
---@field textContainer MapPinEnhancedFloatingSimpleTextContainer
---@field title FontString
---@field distance FontString
---@field eta FontString
---@field distanceCallback fun(distance: number, timeToTarget: number) | nil
MapPinEnhancedFloatingSimpleMixin = {}

local Pins = MapPinEnhanced:GetModule("Pins")
local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME
local DEFAULT_COLOR = PIN_COLORS_BY_NAME[Pins.DEFAULT_COLOR]

---@return SuperTrackedFrame | nil
local function GetSuperTrackedFrame()
    local superTrackedFrame = SuperTrackedFrame
    ---@cast superTrackedFrame SuperTrackedFrame | nil
    return superTrackedFrame
end

---@param color PinColor
function MapPinEnhancedFloatingSimpleMixin:SetColor(color)
    local colorValue = color and PIN_COLORS_BY_NAME[color] or DEFAULT_COLOR
    self.clampedArrow.needle:SetVertexColor(colorValue:GetRGBA())
    self.pin:SetColor(color)
end

function MapPinEnhancedFloatingSimpleMixin:SetTexture(texture, usesAtlas)
    if not texture then return end
    self.pin:SetIconTexture(texture, usesAtlas)
    self.clampedArrow.needle:SetVertexColor(DEFAULT_COLOR:GetRGBA())
    self.pin:SetTextureColor(DEFAULT_COLOR)
end

---@param title string?
function MapPinEnhancedFloatingSimpleMixin:SetTitle(title)
    self.title:SetText(title or "")
end

function MapPinEnhancedFloatingSimpleMixin:SetLocation(_mapID, _x, _y)
end

---@param distance number?
---@param timeToTarget number?
function MapPinEnhancedFloatingSimpleMixin:OnDistanceUpdate(distance, timeToTarget)
    if distance and timeToTarget then
        self.distance:SetText(MapPinEnhanced:FormatDistance(distance))
        self.eta:SetText(MapPinEnhanced:FormatETA(timeToTarget))
    else
        self.distance:SetText("")
        self.eta:SetText("")
    end
    if distance and distance < 10 then
        self.pin:ShowPulse()
    else
        self.pin:HidePulse()
    end
end

function MapPinEnhancedFloatingSimpleMixin:UpdateClampedArrow()
    local superTrackedFrame = GetSuperTrackedFrame()
    local arrow = superTrackedFrame and superTrackedFrame.Arrow
    if not arrow or not C_Navigation.WasClampedToScreen() then
        self.clampedArrow:Hide()
        return
    end

    local getRotation = arrow.GetRotation
    local rotation = getRotation and getRotation(arrow) or 0

    self.clampedArrow:ClearAllPoints()
    self.clampedArrow:SetPoint("CENTER", arrow, "CENTER")
    self.clampedArrow.needle:SetRotation(rotation)
    self.clampedArrow:Show()
end

function MapPinEnhancedFloatingSimpleMixin:OnUpdate()
    self:UpdateClampedArrow()
end

function MapPinEnhancedFloatingSimpleMixin:AttachToSuperTrackedFrame()
    local superTrackedFrame = GetSuperTrackedFrame()
    if not superTrackedFrame then return end

    self:SetParent(superTrackedFrame)
    self:ClearAllPoints()
    self:SetPoint("CENTER", superTrackedFrame, "CENTER")
    self:SetFrameStrata(superTrackedFrame:GetFrameStrata())

    local frameLevel = superTrackedFrame:GetFrameLevel()
    self:SetFrameLevel(frameLevel + 10)
    self.clampedArrow:SetFrameLevel(frameLevel + 10)
    self.pin:SetFrameLevel(frameLevel + 11)
    self.textContainer:SetFrameLevel(frameLevel + 12)
end

function MapPinEnhancedFloatingSimpleMixin:HideSuperTrackedRegions()
    local superTrackedFrame = GetSuperTrackedFrame()
    if not superTrackedFrame then return end

    superTrackedFrame.Arrow:SetAlpha(0)
    superTrackedFrame.Icon:SetAlpha(0)
    superTrackedFrame.DistanceText:SetAlpha(0)
    superTrackedFrame.Arrow:Hide()
    superTrackedFrame.Icon:Hide()
    superTrackedFrame.DistanceText:Hide()
end

function MapPinEnhancedFloatingSimpleMixin:RestoreSuperTrackedRegions()
    local superTrackedFrame = GetSuperTrackedFrame()
    if not superTrackedFrame then return end
    superTrackedFrame.Arrow:SetAlpha(1)
    superTrackedFrame.Icon:SetAlpha(1)
    superTrackedFrame.DistanceText:SetAlpha(1)
    superTrackedFrame.Arrow:Show()
    superTrackedFrame.Icon:Show()
    superTrackedFrame.DistanceText:Show()
end

function MapPinEnhancedFloatingSimpleMixin:OnLoad()
    self.title = self.textContainer.title
    self.distance = self.textContainer.distance
    self.eta = self.textContainer.eta
    self.pin:SetTracked(true)
    self:RegisterEvent("NAVIGATION_FRAME_CREATED")
end

---@param event string
function MapPinEnhancedFloatingSimpleMixin:OnEvent(event)
    if event ~= "NAVIGATION_FRAME_CREATED" or not self:IsShown() then return end

    self:AttachToSuperTrackedFrame()
    self:HideSuperTrackedRegions()
end

function MapPinEnhancedFloatingSimpleMixin:OnShow()
    self:AttachToSuperTrackedFrame()
    self:HideSuperTrackedRegions()
    self:SetScript("OnUpdate", function()
        self:OnUpdate()
    end)

    self.distanceCallback = function(distance, timeToTarget)
        self:OnDistanceUpdate(distance, timeToTarget)
    end
    MapPinEnhanced:RegisterContinuousDistanceCallback(self.distanceCallback)
    self:UpdateClampedArrow()
end

function MapPinEnhancedFloatingSimpleMixin:Reset()
    self.distance:SetText("")
    self.eta:SetText("")
    self.pin:HidePulse()
    self.clampedArrow:Hide()
    self.clampedArrow.needle:SetRotation(0)
end

function MapPinEnhancedFloatingSimpleMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    self:Reset()
    self:RestoreSuperTrackedRegions()

    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
end
