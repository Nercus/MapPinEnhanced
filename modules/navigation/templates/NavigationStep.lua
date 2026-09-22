---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L

---@class MapPinEnhancedNavigationStepTemplate : MapPinEnhancedWayfinderInstructionTemplate
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field clearButton Button
---@field title FontString
---@field distance FontString
---@field distanceCallback fun(distance: number)?
MapPinEnhancedNavigationStepMixin = {}

function MapPinEnhancedNavigationStepMixin:OnLoad()
    MapPinEnhancedWayfinderInstructionMixin.OnLoad(self)
    -- The secure driver hides the protected action ancestry on combat entry.
    -- Wayfinders reapplies only the latest Step when combat ends.
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
function MapPinEnhancedNavigationStepMixin:SetStep(step)
    MapPinEnhancedWayfinderInstructionMixin.SetStep(self, step)
    local ownedStep = step and Navigation.routeSteps[step.stepIndex or 1]
    local target = ownedStep and ownedStep.target
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

---@param shown boolean
function MapPinEnhancedNavigationStepMixin:ApplyVisibility(shown)
    if not InCombatLockdown() then self:SetShown(shown) end
end

function MapPinEnhancedNavigationStepMixin:ClearTracking()
    if self.step then Providers:ClearNavigationTracking(self.step.changeNumber) end
end

---@param title string?
function MapPinEnhancedNavigationStepMixin:SetDestinationText(title)
    local destination = Navigation.activeDestination
    local data = self.step and destination and destination.data
    if data then
        local mapInfo = C_Map.GetMapInfo(data.mapID)
        self.text:SetText(string.format(L["Navigation Route To"], title or data.title or L["Map Pin"],
            mapInfo and mapInfo.name or tostring(data.mapID)))
    else
        self.text:SetText("")
    end
    self:UpdateLayout()
end

function MapPinEnhancedNavigationStepMixin:UpdateLayout()
    if InCombatLockdown() then return end
    self:SetHeight(math.max(62, self.title:GetStringHeight() + self.text:GetStringHeight() + 32))
end

-- The panel shares the active Wayfinder target's sampler and owns only its
-- visible subscription. Re-registering replays the latest sample after a Step change.
function MapPinEnhancedNavigationStepMixin:UpdateDistanceSubscription()
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

function MapPinEnhancedNavigationStepMixin:OnShow()
    MapPinEnhancedWayfinderInstructionMixin.OnShow(self)
    self:UpdateDistanceSubscription()
end

function MapPinEnhancedNavigationStepMixin:OnHide()
    MapPinEnhancedWayfinderInstructionMixin.OnHide(self)
    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
    self.distance:SetText("")
end
