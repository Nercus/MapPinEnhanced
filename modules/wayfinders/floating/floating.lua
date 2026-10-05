---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Options = MapPinEnhanced:GetModule("Options")
local Providers = MapPinEnhanced:GetModule("Providers")

---@class MapPinEnhancedWayfinderFloating : MapPinEnhancedWayfinder
---@field data WayfinderData?
---@field frame MapPinEnhancedWayfinderFloatingTemplate?
---@field panel MapPinEnhancedFloatingPanelTemplate?
---@field objectivePanel MapPinEnhancedFloatingPanelTemplate?
---@field runtimeEnabled boolean?
---@field blizzardHiddenByOption boolean?
---@field unsubscribeBeamOption fun()?
---@field step WayfinderStepData?
local MapPinEnhancedWayfinderFloating = {}

function MapPinEnhancedWayfinderFloating:Setup()
    if self.panel then return end
    local panel = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedFloatingPanelTemplate")
    ---@cast panel MapPinEnhancedFloatingPanelTemplate
    self.panel = panel
    local combatPanel = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedFloatingPanelCombatTemplate")
    ---@cast combatPanel MapPinEnhancedFloatingPanelTemplate
    panel.combatPanel = combatPanel
    local objectivePanel = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedFloatingPanelDisplayTemplate")
    ---@cast objectivePanel MapPinEnhancedFloatingPanelTemplate
    self.objectivePanel = objectivePanel
end

---@return string
function MapPinEnhancedWayfinderFloating:GetActionDebugText()
    return self.panel and self.panel:GetActionDebugText() or "Floating instruction not created"
end

---@return MapPinEnhancedWayfinderFloatingTemplate
function MapPinEnhancedWayfinderFloating:GetFrame()
    if not self.frame then
        self.frame = CreateFrame("Frame", "MapPinEnhancedWayfinderFloating", nil,
            "MapPinEnhancedWayfinderFloatingTemplate")
        self.frame.content:SetShowBeam(Options:GetOptionValue("Wayfinder.Floating.ShowBeam") == true)
    end
    return self.frame
end

---@param title string
function MapPinEnhancedWayfinderFloating:SetTitle(title)
    self:SetDestinationText(title, self.data and self.data.description)
end

function MapPinEnhancedWayfinderFloating:RefreshTitle()
    local title = self.data and self.data.title
    local description = self.data and self.data.description
    local step = self.step
    if step and step.showInstruction ~= false and Wayfinders:IsIntermediateStep() then
        description = title
        title = step.instruction
        if step.status and step.status ~= "" then title = title .. "\n" .. step.status end
    end
    self:GetFrame():SetDestinationText(title, description)
end

---@param color PinColor
function MapPinEnhancedWayfinderFloating:SetColor(color)
    self:GetFrame():SetColor(color)
end

---@param texture string|number
---@param usesAtlas boolean
function MapPinEnhancedWayfinderFloating:SetTexture(texture, usesAtlas)
    self:GetFrame():SetTexture(texture, usesAtlas)
end

---@param lock boolean
function MapPinEnhancedWayfinderFloating:SetLock(lock)
    self:GetFrame().pin:SetLock(lock)
end

---@param step WayfinderStepData?
function MapPinEnhancedWayfinderFloating:SetStep(step)
    self.step = step
    local inside = step and step.insideObjectiveArea
    if self.panel then self.panel:Apply(not inside and step or nil, self.data) end
    if self.objectivePanel then
        local showObjectives = inside and Options:GetOptionValue("Wayfinder.General.ShowObjectiveFrame")
        self.objectivePanel:Apply(showObjectives and step or nil, self.data)
    end
    -- Reset has released tracking; retain the last artwork until its fade ends.
    if not self.data then return end
    local frame = self:GetFrame()
    self:RefreshTitle()
    local showDirection = step == nil or step.showDirection and
        (not inside or step.showDirectionInObjectiveArea == true)
    -- Reaching an entrance can hide direction while its Step still owns tracking.
    -- Keep the waypoint protected from native arrival clearing until the Step ends.
    if self.data and self.data.mapDistanceOnly then
        Providers:SetStepSuperTracking(self.data)
    else
        Providers:ClearStepSuperTracking()
    end
    frame.lastNavigationTargetCheck = nil
    frame:SetDirectionShown(showDirection)
end

function MapPinEnhancedWayfinderFloating:Reset()
    if self.panel then self.panel:Apply(nil, nil) end
    if self.objectivePanel then self.objectivePanel:Apply(nil, nil) end
    if self.frame then
        self.frame:Hide()
        self.frame:StopTracking()
    end
    Providers:ClearStepSuperTracking()
    self.data = nil
    self.step = nil
end

---@param wayfinderData WayfinderData?
function MapPinEnhancedWayfinderFloating:Init(wayfinderData)
    if not wayfinderData then
        self:Reset()
        return
    end

    if not wayfinderData.mapDistanceOnly then Providers:ClearStepSuperTracking() end
    self.data = wayfinderData
    local frame = self:GetFrame()
    frame:SetLocation(wayfinderData.mapID, wayfinderData.x, wayfinderData.y)
    ---@type boolean?
    local hasIcon = false
    if wayfinderData.texture then
        hasIcon = frame:SetTexture(wayfinderData.texture, wayfinderData.usesAtlas)
    else
        frame:SetColor(wayfinderData.color)
    end
    if not hasIcon and wayfinderData.targetType == Wayfinders.TARGET_TYPE_BLIZZARD then
        frame:SetTexture("Navigation-Tracked-Icon", true)
    end
    self:RefreshTitle()
    frame.pin:SetLock(wayfinderData.lock)
    local wasFadingOut = frame.visibilityFadeOut:IsPlaying()
    frame:Show()
    if wasFadingOut then frame:OnShow() end
end

---@param enable boolean
local function OverrideSuperTrackedAlphaState(enable)
    local alpha = enable and 1 or 0
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, alpha)
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, alpha)
end

function MapPinEnhancedWayfinderFloating:RestoreBlizzardForFloating()
    if not self.blizzardHiddenByOption then return end
    SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_CREATED")
    SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_DESTROYED")
    SuperTrackedFrame:RegisterEvent("SUPER_TRACKING_CHANGED")
    SuperTrackedFrame:InitializeNavigationFrame()
    self.blizzardHiddenByOption = nil
end

function MapPinEnhancedWayfinderFloating:HideBlizzardForSession()
    if self.blizzardHiddenByOption then return end
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_CREATED")
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_DESTROYED")
    SuperTrackedFrame:UnregisterEvent("SUPER_TRACKING_CHANGED")
    SuperTrackedFrame:ShutdownNavigationFrame()
    SuperTrackedFrame:Hide()
    self.blizzardHiddenByOption = true
end

function MapPinEnhancedWayfinderFloating:Enable()
    if self.runtimeEnabled then return end
    self.runtimeEnabled = true
    self:RestoreBlizzardForFloating()
    OverrideSuperTrackedAlphaState(true)
    self.unsubscribeBeamOption = Options:SubscribeToOptionChanges("Wayfinder.Floating.ShowBeam", function(value)
        if self.frame then self.frame.content:SetShowBeam(value == true) end
    end)
end

function MapPinEnhancedWayfinderFloating:Disable()
    if not self.runtimeEnabled then return end
    self.runtimeEnabled = nil
    self:Reset()
    OverrideSuperTrackedAlphaState(false)
    if self.unsubscribeBeamOption then
        self.unsubscribeBeamOption()
        self.unsubscribeBeamOption = nil
    end
end

if not Wayfinders.wayfinders then Wayfinders.wayfinders = {} end
Wayfinders.wayfinders["WAYFINDER_FLOATING"] = MapPinEnhancedWayfinderFloating

---@param title string
---@param description string?
function MapPinEnhancedWayfinderFloating:SetDestinationText(title, description)
    if self.data then
        self.data.title, self.data.description = title, description
    end
    self:RefreshTitle()
    if self.frame then self.frame.readout:UpdateText() end
    if self.panel then self.panel:SetDestinationText(title) end
    if self.objectivePanel then self.objectivePanel:SetDestinationText(title) end
end
