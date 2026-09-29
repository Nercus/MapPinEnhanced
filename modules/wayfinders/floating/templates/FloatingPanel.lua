---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L

---@class MapPinEnhancedFloatingPanelTemplate : MapPinEnhancedWayfinderInstructionTemplate, MapPinEnhancedFadingFrameTemplate
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field clearButton Button
---@field title FontString
---@field distance FontString
---@field distanceCallback fun(distance: number)?
---@field target WayfinderData?
MapPinEnhancedFloatingPanelMixin = {}

function MapPinEnhancedFloatingPanelMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self, true)
    MapPinEnhancedWayfinderInstructionMixin.OnLoad(self)
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
    local instruction = step and step.instruction or ""
    if step and step.stepIndex and step.stepCount then
        instruction = string.format(L["Navigation Instruction Count"], instruction, step.stepIndex, step.stepCount)
    end
    self.title:SetText(instruction)
    self:SetDestinationText()
    self:UpdateDistanceSubscription()
    if target then
        self.pinFrame:SetStyleMode("outline")
        if target.texture then
            self.pinFrame:SetIconTexture(target.texture, target.usesAtlas)
        else
            self.pinFrame:SetColor(target.color)
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
    self:ApplyVisibility(step ~= nil and step.showInstruction ~= false and step.stepCount ~= 1)
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
        self.text:SetText(string.format(L["Navigation Route To"], title or step.destinationTitle or L["Map Pin"],
            mapInfo and mapInfo.name or tostring(step.destinationMapID)))
    else
        self.text:SetText("")
    end
    self:UpdateLayout()
end

function MapPinEnhancedFloatingPanelMixin:UpdateLayout()
    if InCombatLockdown() then return end
    self:SetHeight(math.max(62, self.title:GetStringHeight() + self.text:GetStringHeight() + 32))
end

-- The panel shares the active Wayfinder target's sampler and owns only its
-- visible subscription. Re-registering replays the latest sample after a Step change.
function MapPinEnhancedFloatingPanelMixin:UpdateDistanceSubscription()
    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
    self.distance:SetText("")
    if not self:IsShown() or not self.step or self.step.showInstruction == false then return end
    self.distanceCallback = function(distance)
        self.distance:SetText(MapPinEnhanced:FormatDistance(distance))
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
