---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L

---@class MapPinEnhancedFloatingPanelTemplate : MapPinEnhancedWayfinderInstructionTemplate, MapPinEnhancedFadingFrameTemplate
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field clearButton Button
---@field progress MapPinEnhancedWayfinderProgressTemplate
---@field title FontString
---@field distance FontString
---@field description MapPinEnhancedWayfinderDescriptionTemplate
---@field distanceCallback fun(distance: number)?
---@field target WayfinderData?
---@field destinationText string?
---@field textTruncated boolean?
MapPinEnhancedFloatingPanelMixin = {}

function MapPinEnhancedFloatingPanelMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self, true)
    MapPinEnhancedWayfinderInstructionMixin.OnLoad(self)
    self.description.mouseOwner = self
    -- The secure driver hides the protected action ancestry on combat entry.
    -- Floating reapplies only the latest Step when combat ends.
    RegisterStateDriver(self, "visibility", "[combat] hide;")
    MapPinEnhanced:RegisterDraggableFrame(self, "navigationStepFrame", nil, InCombatLockdown)
    -- Registration owns saving; restore only saved coordinates so first use
    -- keeps the XML default instead of LibWindow's center-screen fallback.
    local position = MapPinEnhanced:GetVar("frames", "navigationStepFrame")
    if position and position.x and position.y then
        MapPinEnhanced:RestoreFrame(self)
    end
end

---@param step WayfinderStepData?
function MapPinEnhancedFloatingPanelMixin:SetStep(step)
    MapPinEnhancedWayfinderInstructionMixin.SetStep(self, step)
    local target = self.target
    self:SetDestinationText()
    self:UpdateDistanceSubscription()
    if target then
        ---@type boolean?
        local hasIcon = false
        if target.texture then
            hasIcon = self.pinFrame:SetIconTexture(target.texture, target.usesAtlas)
        else
            self.pinFrame:SetColor(target.color)
        end
        if not hasIcon and target.targetType == Wayfinders.TARGET_TYPE_BLIZZARD then
            self.pinFrame:SetIconTexture("Navigation-Tracked-Icon", true)
        end
    end
    if not InCombatLockdown() then
        local action = step and step.showInstruction ~= false and step.desiredAction
        self.pinFrame:SetShown(target ~= nil and not action)
        self.clearButton:SetEnabled(Providers:CanClearNavigationTracking())
        self:UpdateLayout()
    end
end

---@param step WayfinderStepData?
---@param target WayfinderData?
function MapPinEnhancedFloatingPanelMixin:Apply(step, target)
    self.target = target
    self:SetStep(step)
    local menu = step and Wayfinders:BuildNavigationMenuEntries()
    self.onMenu = menu and function(owner) MapPinEnhanced:GenerateMenu(owner, menu) end or nil
    self:ApplyVisibility(step ~= nil and (step.insideObjectiveArea == true or
        step.showInstruction ~= false and step.stepCount ~= 1))
end

---@param shown boolean
function MapPinEnhancedFloatingPanelMixin:ApplyVisibility(shown)
    if not InCombatLockdown() then self:SetShownWithFade(shown) end
end

function MapPinEnhancedFloatingPanelMixin:ClearTracking()
    if self.step then Providers:ClearNavigationTracking(self.step.changeNumber) end
end

---@param title string?
function MapPinEnhancedFloatingPanelMixin:SetDestinationText(title)
    local step = self.step
    if step and step.destinationMapID then
        local mapInfo = C_Map.GetMapInfo(step.destinationMapID)
        self.destinationText = string.format(L["Navigation Route To"], title or step.destinationTitle or L["Map Pin"],
            mapInfo and mapInfo.name or tostring(step.destinationMapID))
    else
        self.destinationText = ""
    end
    self:UpdateLayout()
end

function MapPinEnhancedFloatingPanelMixin:UpdateLayout()
    if InCombatLockdown() then return end
    local inside = self.step and self.step.insideObjectiveArea
    local target = self.target
    local title = inside and target and target.title or self.fullText
    local titleTruncated = Wayfinders:ApplyWrappedText(self.title, title, 210, 4)
    local destinationTruncated = Wayfinders:ApplyWrappedText(self.text, self.destinationText, 210, 4)
    self.text:SetShown(not inside)
    self.description:Apply(target and target.title, inside and target and target.description or nil)
    self.textTruncated = titleTruncated or not inside and destinationTruncated
    self.progress:Apply(self.step, self:GetWidth())
    local descriptionHeight = self.description:IsShown() and self.description:GetHeight() + 3 or 0
    self.distance:ClearAllPoints()
    self.distance:SetPoint("TOPLEFT", inside and (descriptionHeight > 0 and self.description or self.title) or self.text,
        "BOTTOMLEFT", 0, -3)
    local textHeight = self.title:GetHeight() + self.distance:GetHeight() + 3 +
        (inside and descriptionHeight or self.text:GetHeight() + 3)
    -- Match the 16-unit side inset; the progress strip is only an overlay.
    local height = math.max(textHeight, self.pinFrame:GetHeight(), self.actionButton:GetHeight()) + 32
    self:SetHeight(height)
    self.title:SetPoint("TOPLEFT", self, "TOPLEFT", 64, -(height - textHeight) / 2)
    self.pinFrame:SetPoint("LEFT", self, "LEFT", 16, 0)
    self.actionButton:SetPoint("TOPLEFT", self, "TOPLEFT", 12,
        -(height - self.actionButton:GetHeight()) / 2)
    self.actionBlocker:SetPoint("TOPLEFT", self, "TOPLEFT", 12,
        -(height - self.actionBlocker:GetHeight()) / 2)
end

function MapPinEnhancedFloatingPanelMixin:OnEnter()
    if not self.textTruncated then return end
    if self.step and self.step.insideObjectiveArea and self.target then
        Wayfinders:ShowTextTooltip(self, self.target.title, self.target.description)
    else
        Wayfinders:ShowTextTooltip(self, self.fullText, self.destinationText)
    end
end

function MapPinEnhancedFloatingPanelMixin:OnLeave()
    if GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end

-- The panel shares the active Wayfinder target's sampler and owns only its
-- visible subscription. Re-registering replays the latest sample after a Step change.
function MapPinEnhancedFloatingPanelMixin:UpdateDistanceSubscription()
    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
    self.distance:SetText("")
    if self.step and self.step.insideObjectiveArea then
        Wayfinders:ApplyWrappedText(self.distance, L["In objective area"], 210, 2)
        self:UpdateLayout()
        return
    end
    if not self:IsShown() or not self.step or self.step.showInstruction == false then return end
    self.distanceCallback = function(distance)
        Wayfinders:ApplyWrappedText(self.distance, MapPinEnhanced:FormatDistance(distance), 210, 2)
        self:UpdateLayout()
    end
    MapPinEnhanced:RegisterContinuousDistanceCallback(self.distanceCallback)
end

function MapPinEnhancedFloatingPanelMixin:OnShow()
    MapPinEnhancedWayfinderInstructionMixin.OnShow(self)
    self:UpdateDistanceSubscription()
end

function MapPinEnhancedFloatingPanelMixin:OnHide()
    MapPinEnhancedWayfinderInstructionMixin.OnHide(self)
    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
    self.distance:SetText("")
end
