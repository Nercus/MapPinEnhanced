---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedFloatingBasicTextContainer : Frame
---@field title FontString
---@field readout MapPinEnhancedWayfinderReadoutTemplate

---@class MapPinEnhancedFloatingBasicClampedArrow : Frame
---@field needle Texture

---@class MapPinEnhancedWayfinderFloatingBasicTemplate : Frame, MapPinEnhancedWayfinderDistanceMixin
---@field clampedArrow MapPinEnhancedFloatingBasicClampedArrow
---@field pin MapPinEnhancedBasePinTemplate
---@field textContainer MapPinEnhancedFloatingBasicTextContainer
---@field readout MapPinEnhancedWayfinderReadoutTemplate
---@field distanceCallback fun(distance: number, timeToTarget: number) | nil
MapPinEnhancedWayfinderFloatingBasicMixin = CreateFromMixins(MapPinEnhancedWayfinderDistanceMixin)

---@return SuperTrackedFrame | nil
local function GetSuperTrackedFrame()
    local superTrackedFrame = SuperTrackedFrame
    ---@cast superTrackedFrame SuperTrackedFrame | nil
    return superTrackedFrame
end

---@param color PinColor
function MapPinEnhancedWayfinderFloatingBasicMixin:SetColor(color)
    self.pin:SetColor(color)
    self.clampedArrow.needle:SetVertexColor(self.pin:GetActiveStyleColor():GetRGBA())
end

function MapPinEnhancedWayfinderFloatingBasicMixin:SetTexture(texture, usesAtlas)
    if not texture then return end
    self.pin:SetIconTexture(texture, usesAtlas)
    self.clampedArrow.needle:SetVertexColor(self.pin:GetActiveStyleColor():GetRGBA())
end

---@param title string?
function MapPinEnhancedWayfinderFloatingBasicMixin:SetTitle(title)
    self.textContainer.title:SetText(title or "")
end

function MapPinEnhancedWayfinderFloatingBasicMixin:SetLocation(_mapID, _x, _y)
    self:ResetDistanceReadout()
end

---@param distance number?
---@param timeToTarget number?
function MapPinEnhancedWayfinderFloatingBasicMixin:OnDistanceUpdate(distance, timeToTarget)
    if distance and distance < 10 then
        self.pin:ShowPulse()
    else
        self.pin:HidePulse()
    end
end

function MapPinEnhancedWayfinderFloatingBasicMixin:UpdateClampedArrow()
    local superTrackedFrame = GetSuperTrackedFrame()
    local arrow = superTrackedFrame and superTrackedFrame.Arrow
    if not arrow or not C_Navigation.WasClampedToScreen() then
        self.clampedArrow:Hide()
        if not self.textContainer:IsShown() then
            self.textContainer:Show()
        end
        return
    end

    local getRotation = arrow.GetRotation
    local rotation = getRotation and getRotation(arrow) or 0

    self.clampedArrow:ClearAllPoints()
    self.clampedArrow:SetPoint("CENTER", arrow, "CENTER")
    self.clampedArrow.needle:SetRotation(rotation)
    self.clampedArrow:Show()
    if self.textContainer:IsShown() then
        self.textContainer:Hide()
    end
end

function MapPinEnhancedWayfinderFloatingBasicMixin:OnUpdate()
    self:UpdateClampedArrow()
end

function MapPinEnhancedWayfinderFloatingBasicMixin:AttachToSuperTrackedFrame()
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

function MapPinEnhancedWayfinderFloatingBasicMixin:HideSuperTrackedRegions()
    local superTrackedFrame = GetSuperTrackedFrame()
    if not superTrackedFrame then return end

    superTrackedFrame.Arrow:SetAlpha(0)
    superTrackedFrame.Icon:SetAlpha(0)
    superTrackedFrame.DistanceText:SetAlpha(0)
    superTrackedFrame.Arrow:Hide()
    superTrackedFrame.Icon:Hide()
    superTrackedFrame.DistanceText:Hide()
end

function MapPinEnhancedWayfinderFloatingBasicMixin:RestoreSuperTrackedRegions()
    local superTrackedFrame = GetSuperTrackedFrame()
    if not superTrackedFrame then return end
    superTrackedFrame.Arrow:SetAlpha(1)
    superTrackedFrame.Icon:SetAlpha(1)
    superTrackedFrame.DistanceText:SetAlpha(1)
    superTrackedFrame.Arrow:Show()
    superTrackedFrame.Icon:Show()
    superTrackedFrame.DistanceText:Show()
end

function MapPinEnhancedWayfinderFloatingBasicMixin:OnLoad()
    self.readout = self.textContainer.readout
    self.pin:SetTracked(true)
end

---@param event string
function MapPinEnhancedWayfinderFloatingBasicMixin:OnEvent(event)
    if event ~= "NAVIGATION_FRAME_CREATED" or not self:IsShown() then return end

    self:AttachToSuperTrackedFrame()
    self:HideSuperTrackedRegions()
end

function MapPinEnhancedWayfinderFloatingBasicMixin:OnShow()
    self:RegisterEvent("NAVIGATION_FRAME_CREATED")
    local superTrackedFrame = GetSuperTrackedFrame()
    if superTrackedFrame then superTrackedFrame:Show() end
    self:AttachToSuperTrackedFrame()
    self:HideSuperTrackedRegions()
    self:SetScript("OnUpdate", function()
        self:OnUpdate()
    end)

    self:StartDistanceUpdates(self.readout, function(distance, timeToTarget)
        self:OnDistanceUpdate(distance, timeToTarget)
    end)
    self:UpdateClampedArrow()
end

function MapPinEnhancedWayfinderFloatingBasicMixin:Reset()
    self.pin:HidePulse()
    self.clampedArrow:Hide()
    self.clampedArrow.needle:SetRotation(0)
end

function MapPinEnhancedWayfinderFloatingBasicMixin:OnHide()
    self:SetScript("OnUpdate", nil)
    self:UnregisterEvent("NAVIGATION_FRAME_CREATED")
    self:StopDistanceUpdates()
    self:Reset()
    self:RestoreSuperTrackedRegions()
end
