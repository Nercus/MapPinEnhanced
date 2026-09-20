---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Providers = MapPinEnhanced:GetModule("Providers")

---@class MapPinEnhancedNavigationStepTemplate : MapPinEnhancedWayfinderInstructionTemplate
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field clearButton Button
---@field title FontString
MapPinEnhancedNavigationStepMixin = {}

function MapPinEnhancedNavigationStepMixin:OnLoad()
    MapPinEnhancedWayfinderInstructionMixin.OnLoad(self)
    -- The secure driver hides the protected action ancestry on combat entry.
    -- Wayfinders reapplies only the latest Step when combat ends.
    RegisterStateDriver(self, "visibility", "[combat] hide;")
end

---@param step WayfinderStepData?
function MapPinEnhancedNavigationStepMixin:SetStep(step)
    MapPinEnhancedWayfinderInstructionMixin.SetStep(self, step)
    local ownedStep = step and Navigation.routeSteps[step.stepIndex or 1]
    local target = ownedStep and ownedStep.target
    self:SetDestinationText(target and target.title)
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
        self:SetHeight(math.max(76, self.text:GetStringHeight() + 42))
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
    self.title:SetText(title or "")
end
