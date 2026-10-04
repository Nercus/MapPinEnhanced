---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L

---@class MapPinEnhancedFloatingPanelTemplate : MapPinEnhancedWayfinderInstructionTemplate, MapPinEnhancedFadingFrameTemplate
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field loading Texture
---@field clearButton Button
---@field reportButton MapPinEnhancedIconButtonTemplate
---@field progress MapPinEnhancedWayfinderProgressTemplate
---@field title FontString
---@field areaStatus FontString
---@field description MapPinEnhancedWayfinderDescriptionTemplate
---@field target WayfinderData?
---@field destinationText string?
---@field textTruncated boolean?
---@field actionButton MapPinEnhancedWayfinderActionButton? only the travel variant
---@field actionBlocker MapPinEnhancedWayfinderActionVisual? only the travel variant
MapPinEnhancedFloatingPanelMixin = {}

function MapPinEnhancedFloatingPanelMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self, true)
    if self.actionButton then
        MapPinEnhancedWayfinderInstructionMixin.OnLoad(self)
        -- Only travel controls have protected ancestry. Objective information
        -- uses the same visual template without those controls or a combat driver.
        RegisterStateDriver(self, "visibility", "[combat] hide;")
    end
    self.description.mouseOwner = self
    MapPinEnhanced:RegisterDraggableFrame(self, "navigationStepFrame", nil, InCombatLockdown)
    self:RestorePosition()
end

function MapPinEnhancedFloatingPanelMixin:RestorePosition()
    -- Registration owns saving; restore only saved coordinates so first use
    -- keeps the XML default instead of LibWindow's center-screen fallback.
    local position = MapPinEnhanced:GetVar("frames", "navigationStepFrame")
    if position and position.x and position.y then
        MapPinEnhanced:RestoreFrame(self)
    end
end

---@param step WayfinderStepData?
function MapPinEnhancedFloatingPanelMixin:SetStep(step)
    if self.actionButton then
        MapPinEnhancedWayfinderInstructionMixin.SetStep(self, step)
    else
        self.step = step
        self.fullText = step and step.instruction or ""
    end
    local target = self.target
    local calculating = step and step.phase == "calculating"
    self.loading:SetShown(calculating == true)
    self:SetDestinationText()
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
    if not InCombatLockdown() or not self:IsProtected() then
        local action = step and step.showInstruction ~= false and step.desiredAction
        self.pinFrame:SetShown(target ~= nil and not action and not calculating)
        self.clearButton:SetEnabled(Providers:CanClearNavigationTracking())
        self:UpdateLayout()
    end
end

---@param step WayfinderStepData?
---@param target WayfinderData?
function MapPinEnhancedFloatingPanelMixin:Apply(step, target)
    -- Both variants share one saved position. Refresh it when switching views,
    -- including area entry in combat; only the objective variant can move then.
    if step and not self.step and (not InCombatLockdown() or not self:IsProtected()) then
        self:RestorePosition()
    end
    self.target = target
    self:SetStep(step)
    local menu = step and Wayfinders:BuildNavigationMenuEntries()
    self.onMenu = menu and function(owner) MapPinEnhanced:GenerateMenu(owner, menu) end or nil
    self:ApplyVisibility(step ~= nil and (step.insideObjectiveArea == true or
        step.showInstruction ~= false and step.stepCount ~= 1))
end

---@param shown boolean
function MapPinEnhancedFloatingPanelMixin:ApplyVisibility(shown)
    if not InCombatLockdown() or not self:IsProtected() then self:SetShownWithFade(shown) end
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
    if InCombatLockdown() and self:IsProtected() then return end
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
    Wayfinders:ApplyWrappedText(self.areaStatus, inside and L["In objective area"] or "", 210, 2)
    self.areaStatus:SetShown(inside == true)
    self.areaStatus:ClearAllPoints()
    self.areaStatus:SetPoint("TOPLEFT", descriptionHeight > 0 and self.description or self.title,
        "BOTTOMLEFT", 0, -3)
    local textHeight = self.title:GetHeight() +
        (inside and descriptionHeight + self.areaStatus:GetHeight() + 3 or self.text:GetHeight() + 3)
    -- Match the 16-unit side inset; the progress strip is only an overlay.
    local height = math.max(62, math.max(textHeight, self.pinFrame:GetHeight(),
        self.actionButton and self.actionButton:GetHeight() or 0) + 32)
    self:SetHeight(height)
    self.title:SetPoint("TOPLEFT", self, "TOPLEFT", 64, -(height - textHeight) / 2)
    self.pinFrame:SetPoint("LEFT", self, "LEFT", 16, 0)
    if self.actionButton and self.actionBlocker then
        self.actionButton:SetPoint("TOPLEFT", self, "TOPLEFT", 12,
            -(height - self.actionButton:GetHeight()) / 2)
        self.actionBlocker:SetPoint("TOPLEFT", self, "TOPLEFT", 12,
            -(height - self.actionBlocker:GetHeight()) / 2)
    end
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

function MapPinEnhancedFloatingPanelMixin:OnShow()
    -- A travel view activated during combat could not restore its position yet.
    if not InCombatLockdown() or not self:IsProtected() then self:RestorePosition() end
    if self.actionButton then
        MapPinEnhancedWayfinderInstructionMixin.OnShow(self)
    else
        self:SetStep(self.step)
    end
end

function MapPinEnhancedFloatingPanelMixin:OnHide()
    MapPinEnhancedWayfinderInstructionMixin.OnHide(self)
    self.areaStatus:SetText("")
end

function MapPinEnhancedFloatingPanelMixin:ReportNavigation()
    MapPinEnhanced:GetModule("Navigation"):ShowDebugDump()
end
