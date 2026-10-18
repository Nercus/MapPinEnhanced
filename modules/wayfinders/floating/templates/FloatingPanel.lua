---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local L = MapPinEnhanced.L

---@class MapPinEnhancedFloatingPanelTemplate : MapPinEnhancedWayfinderInstructionTemplate, MapPinEnhancedFadingFrameTemplate
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field loading Texture
---@field clearButton Button
---@field reportButton MapPinEnhancedIconButtonTemplate
---@field progress MapPinEnhancedWayfinderProgressTemplate
---@field title FontString
---@field areaStatus FontString
---@field dataWarning MapPinEnhancedTooltipMixin
---@field description MapPinEnhancedWayfinderDescriptionTemplate
---@field target WayfinderData?
---@field destinationText string?
---@field textTruncated boolean?
---@field applying boolean?
---@field savePositionAfterCombat boolean?
---@field pendingApply { step: WayfinderStepData?, target: WayfinderData? }?
---@field actionButton MapPinEnhancedWayfinderActionButton? only the travel variant
---@field actionBlocker MapPinEnhancedWayfinderActionVisual? only the travel variant
MapPinEnhancedFloatingPanelMixin = {}

function MapPinEnhancedFloatingPanelMixin:OnLoad()
    MapPinEnhancedFadingFrameMixin.SetupVisibilityFade(self, true)
    self.pinFrame:SetTracked(true)
    if self.actionButton then
        SecureHandler_OnLoad(self)
        MapPinEnhancedWayfinderInstructionMixin.OnLoad(self)
        -- Secure hide/show stops a drag already in progress when combat begins,
        -- while retaining the prepared action and the panel's prior visibility.
        self:SetAttribute("_onstate-combat", [[
            if newstate == "combat" and self:IsShown() then
                self:Hide()
                self:Show()
            end
        ]])
        RegisterStateDriver(self, "combat", "[combat] combat; peace")
    end
    self.description.mouseOwner = self
    MapPinEnhanced:RegisterDraggableFrame(self, "navigationStepFrame", nil,
        self.actionButton and InCombatLockdown or nil)
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
    if InCombatLockdown() and self.actionButton then return end
    if self.actionButton then
        MapPinEnhancedWayfinderInstructionMixin.SetStep(self, step)
    else
        self.step = step
        self.fullText = step and step.instruction or ""
    end
    if step and step.showInstruction == false then
        self.fullText = step.instruction
    end
    local target = self.target
    local calculating = step and step.phase == "calculating"
    self.loading:SetShown(calculating == true)
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
        self.clearButton:SetEnabled(Wayfinders:CanClearNavigationTracking())
    end
    self:SetDestinationText()
end

---@param step WayfinderStepData?
---@param target WayfinderData?
function MapPinEnhancedFloatingPanelMixin:Apply(step, target)
    if InCombatLockdown() and self.actionButton then
        -- Keep the displayed Step intact. Retain only the latest request, including
        -- clears and selection changes that the active-wayfinder replay cannot see.
        self.pendingApply = { step = step, target = target }
        if not self.reconcileAfterCombat then
            self.reconcileAfterCombat = MapPinEnhanced:RegisterEventBucket({ "PLAYER_REGEN_ENABLED" }, function()
                local pending = self.pendingApply
                if pending then self:Apply(pending.step, pending.target) end
            end)
        end
        return
    end
    if self.reconcileAfterCombat then
        self.reconcileAfterCombat()
        self.reconcileAfterCombat = nil
    end
    self.pendingApply = nil
    if self.savePositionAfterCombat then
        MapPinEnhanced:SaveFramePosition(self)
        self.savePositionAfterCombat = nil
    end
    -- The objective view has no protected controls and can update in combat.
    -- Both variants restore their shared saved position when switching views.
    if step and not self.step and (not InCombatLockdown() or not self:IsProtected()) then
        self:RestorePosition()
    end
    self.target = target
    self.applying = true
    self:SetStep(step)
    self.applying = nil
    self:UpdateLayout()
    self.onMenu = step and function(owner)
        MapPinEnhanced:GenerateMenu(owner, Wayfinders:BuildNavigationMenuEntries())
    end or nil
    self.applying = true
    self:ApplyVisibility(step ~= nil and (step.insideObjectiveArea == true or
        step.showInstruction ~= false and (step.isTraversal or step.stepCount ~= 1)))
    self.applying = nil
end

---@param shown boolean
function MapPinEnhancedFloatingPanelMixin:ApplyVisibility(shown)
    if InCombatLockdown() and self:IsProtected() then return end
    self:SetShownWithFade(shown)
end

function MapPinEnhancedFloatingPanelMixin:ClearTracking()
    if self.step then Wayfinders:ClearNavigationTracking(self.step.changeNumber) end
end

---@param title string?
function MapPinEnhancedFloatingPanelMixin:SetDestinationText(title)
    if InCombatLockdown() and self.actionButton then return end
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
    if self.applying or InCombatLockdown() and self.actionButton then return end
    local inside = self.step and self.step.insideObjectiveArea
    local target = self.target
    local title = inside and target and target.title or self.fullText
    local warning = self.step and MapPinEnhanced:GetModule("Navigation"):GetMissingTravelDataWarning()
    local textWidth = warning and 198 or 210
    local titleTruncated = Wayfinders:ApplyWrappedText(self.title, title, textWidth, 4)
    local destinationTruncated = Wayfinders:ApplyWrappedText(self.text, self.destinationText, textWidth, 4)
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
    self.dataWarning:SetTooltip(warning)
    self.dataWarning:SetShown(warning ~= nil)
    -- Match the 16-unit side inset; the progress strip is only an overlay.
    local action = self.actionButton
    local height = math.max(62, math.max(textHeight, self.pinFrame:GetHeight(),
        action and action:GetHeight() or 0) + 32)
    self:SetHeight(height)
    self.title:SetPoint("TOPLEFT", self, "TOPLEFT", 64, -(height - textHeight) / 2)
    self.pinFrame:SetPoint("LEFT", self, "LEFT", 16, 0)
    if action then
        action:SetPoint("TOPLEFT", self, "TOPLEFT", 12,
            -(height - action:GetHeight()) / 2)
    end
    if self.actionBlocker then
        self.actionBlocker:SetPoint("TOPLEFT", self, "TOPLEFT", 12,
            -(height - self.actionBlocker:GetHeight()) / 2)
    end
end

function MapPinEnhancedFloatingPanelMixin:OnEnter()
    if self.textTruncated then
        if self.step and self.step.insideObjectiveArea and self.target then
            Wayfinders:ShowTextTooltip(self, self.target.title, self.target.description)
        else
            Wayfinders:ShowTextTooltip(self, self.fullText, self.destinationText)
        end
    else
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
    end
    self:AddCombatTooltip()
    if self.onMenu then
        MapPinEnhanced:AddTooltipInteractions(GameTooltip, { { L["Right Click"], L["Open menu"] } })
    end
    if GameTooltip:NumLines() > 0 then GameTooltip:Show() end
end

function MapPinEnhancedFloatingPanelMixin:OnLeave()
    if GameTooltip:IsOwned(self) then GameTooltip:Hide() end
end

function MapPinEnhancedFloatingPanelMixin:OnShow()
    if not InCombatLockdown() then self:RestorePosition() end
    if self.applying then return end
    if self.actionButton then
        MapPinEnhancedWayfinderInstructionMixin.OnShow(self)
    else
        self:SetStep(self.step)
    end
end

function MapPinEnhancedFloatingPanelMixin:OnHide()
    MapPinEnhancedWayfinderInstructionMixin.OnHide(self)
    self.areaStatus:SetText("")
    if InCombatLockdown() and self.actionButton and MapPinEnhanced:IsFrameDragging(self) then
        -- LibWindow saves also reanchor the frame, so wait until that is safe.
        self.savePositionAfterCombat = true
    end
end

function MapPinEnhancedFloatingPanelMixin:AddCombatTooltip()
    if not self.actionButton or not InCombatLockdown() then return end
    GameTooltip:AddLine(L["Navigation Step Waiting Combat"], 1, 0.82, 0, true)
    if self.preparedAction and self.actionButton:IsShown() then
        GameTooltip:AddLine(L["Navigation Action Shift Combat"], 1, 1, 1, true)
    end
end

---@param owner Frame
function MapPinEnhancedFloatingPanelMixin:OnActionEnter(owner)
    MapPinEnhancedWayfinderInstructionMixin.OnActionEnter(self, owner)
    self:AddCombatTooltip()
    GameTooltip:Show()
end

function MapPinEnhancedFloatingPanelMixin:ReportNavigation()
    MapPinEnhanced:GetModule("Navigation"):ShowDebugDump()
end
