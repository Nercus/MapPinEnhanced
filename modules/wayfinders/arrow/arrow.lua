---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Options = MapPinEnhanced:GetModule("Options")
local Providers = MapPinEnhanced:GetModule("Providers")

---@class MapPinEnhancedWayfinderArrow : MapPinEnhancedWayfinder
---@field frame MapPinEnhancedWayfinderArrowTemplate
---@field step WayfinderStepData?
---@field title string?
---@field description string?
---@field positionFrame MapPinEnhancedWayfinderArrowPositionTemplate?
local MapPinEnhancedWayfinderArrow = {}

---@class MapPinEnhancedWayfinderArrowPositionTemplate : Frame
---@field display MapPinEnhancedWayfinderArrowTemplate
---@field instruction MapPinEnhancedWayfinderInstructionTemplate

---@return MapPinEnhancedWayfinderArrowTemplate
function MapPinEnhancedWayfinderArrow:GetFrame()
    if not self.frame then
        local position = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedWayfinderArrowTemplate")
        ---@cast position MapPinEnhancedWayfinderArrowPositionTemplate
        self.positionFrame = position
        self.frame = position.display
        self.frame.textContainer.description.onHidden = function() self:UpdateText() end
        self.frame.readout.onTextChanged = function() self:UpdateText() end
        position.instruction:SetFrameLevel(self.frame:GetFrameLevel() + 3)
        position.instruction:UpdateFrameLevels()
        position.instruction.text:SetNonSpaceWrap(true)
        position.instruction.onTextChanged = function() self:UpdateText() end
    end
    return self.frame
end

function MapPinEnhancedWayfinderArrow:Setup()
    self:GetFrame()
end

---@return string
function MapPinEnhancedWayfinderArrow:GetActionDebugText()
    return self.positionFrame and self.positionFrame.instruction:GetActionDebugText() or "Arrow not created"
end

---@param title string
function MapPinEnhancedWayfinderArrow:SetTitle(title)
    self.title = title
    self:UpdateText()
end

---@param color PinColor
function MapPinEnhancedWayfinderArrow:SetColor(color)
    self:GetFrame():SetColor(color)
end

---@param texture string|number
---@param usesAtlas boolean
function MapPinEnhancedWayfinderArrow:SetTexture(texture, usesAtlas)
    self:GetFrame():SetTexture(texture, usesAtlas)
end

---@param lock boolean
function MapPinEnhancedWayfinderArrow:SetLock(lock)
    self:GetFrame().pin:SetLock(lock)
end

---@param step WayfinderStepData?
function MapPinEnhancedWayfinderArrow:SetStep(step)
    local frame = self:GetFrame()
    self.step = step
    frame.step = step
    if self.positionFrame then self.positionFrame.instruction:SetStep(step) end
    local inside = step and step.insideObjectiveArea
    local showDirection = step == nil or step.showDirection and step.desiredAction == nil and not inside
    frame.needleContainer:SetShown(showDirection)
    local calculating = step and step.phase == "calculating"
    frame.loading:SetShown(calculating == true)
    frame.pin:SetShown(not calculating and not (step and step.showInstruction ~= false and step.desiredAction))
    frame.textContainer:Show()
    frame.clearButton:SetEnabled(step ~= nil and Providers:CanClearNavigationTracking())
    frame.readout:SetStatusText(inside and MapPinEnhanced.L["In objective area"] or nil)
    self:UpdateText()
    frame:SetDirectionVisible(showDirection)
end

function MapPinEnhancedWayfinderArrow:UpdateText()
    local frame = self:GetFrame()
    local step = self.step
    local intermediate = Wayfinders:IsIntermediateStep()
    local showInstruction = step and not step.insideObjectiveArea and step.showInstruction ~= false and
        (intermediate or step.phase == "calculating" or step.phase == "no-direction" or
            step.desiredAction ~= nil or step.status and step.status ~= "")
    local instruction = self.positionFrame and self.positionFrame.instruction
    local title = self.title
    if showInstruction and step and step.destinationMapID then
        local mapInfo = C_Map.GetMapInfo(step.destinationMapID)
        title = string.format(MapPinEnhanced.L["Navigation Route To"],
            step.destinationTitle or MapPinEnhanced.L["Map Pin"],
            mapInfo and mapInfo.name or tostring(step.destinationMapID))
    end
    frame.title:SetFontObject(showInstruction and GameFontHighlightSmall or GameFontNormal)
    frame.fullTitle = title
    frame.fullDescription = not intermediate and self.description or nil
    frame.textTruncated = Wayfinders:ApplyWrappedText(frame.title, title, 166, 4)
    frame.title:SetTextColor(showInstruction and 0.65 or 1, showInstruction and 0.65 or 0.82,
        showInstruction and 0.65 or 0)
    frame.title:ClearAllPoints()
    local instructionHeight = 0
    if showInstruction and instruction then
        frame.instructionText = instruction.fullText
        local truncated = Wayfinders:ApplyWrappedText(instruction.text, instruction.fullText, 166, 4)
        frame.textTruncated = frame.textTruncated or truncated
        frame.title:SetPoint("TOPLEFT", instruction.text, "BOTTOMLEFT", 0, -3)
        instructionHeight = instruction.text:GetHeight()
    else
        frame.instructionText = nil
        if instruction then instruction.text:SetText("") end
        frame.title:SetPoint("TOPLEFT", frame.textContainer, "TOPLEFT", 64, -8)
    end
    frame.textContainer.description:Apply(self.title, frame.fullDescription)
    local descriptionHeight = frame.textContainer.description:IsShown() and
        frame.textContainer.description:GetHeight() + 3 or 0
    frame.readout:ClearAllPoints()
    frame.readout:SetPoint("TOPLEFT", descriptionHeight > 0 and frame.textContainer.description or frame.title,
        "BOTTOMLEFT", 0, -3)
    frame.progress:Apply(step, frame:GetWidth())
    local textHeight = frame.title:GetHeight() + descriptionHeight +
        (frame.readout:IsShown() and frame.readout:GetHeight() + 3 or 0)
    if instructionHeight > 0 then textHeight = textHeight + instructionHeight + 3 end
    -- Match the 16-unit side inset; the progress strip is only an overlay.
    local artworkHeight = math.max(frame.pin:GetHeight(),
        frame.needleContainer:IsShown() and frame.needleContainer:GetHeight() or 0)
    local height = math.max(62, math.max(textHeight, artworkHeight) + 32)
    frame.pin:SetPoint("LEFT", frame.textContainer, "LEFT", 16, 0)
    frame.needleContainer:SetPoint("RIGHT", frame.textContainer, "RIGHT", -32, 0)
    frame.textContainer:SetHeight(height)
    frame:SetHeight(height)
    -- Center the complete text stack and artwork in the full panel.
    local textTop = -(height - textHeight) / 2
    if showInstruction and instruction then
        instruction.text:SetPoint("TOPLEFT", instruction, "TOPLEFT", 64, textTop)
    else
        frame.title:SetPoint("TOPLEFT", frame.textContainer, "TOPLEFT", 64, textTop)
    end
    if instruction and not InCombatLockdown() then
        instruction.actionButton:SetPoint("TOPLEFT", instruction, "TOPLEFT", 12,
            -(height - instruction.actionButton:GetHeight()) / 2)
        instruction.actionBlocker:SetPoint("TOPLEFT", instruction, "TOPLEFT", 12,
            -(height - instruction.actionBlocker:GetHeight()) / 2)
    end
end

---@param wayfinderData WayfinderData | nil
function MapPinEnhancedWayfinderArrow:Init(wayfinderData)
    local frame = self:GetFrame()
    frame:OnLeave()
    if not wayfinderData or not wayfinderData.mapID or not wayfinderData.x or not wayfinderData.y then
        frame.loading:Hide()
        self.description = nil
        frame.textContainer.description:Apply(nil, nil)
        frame:ResetDistanceReadout()
        self.frame.fadeOut:PlayHiding(self.frame.fadeIn)
        return
    end
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
    self.description = wayfinderData.description
    self:SetTitle(wayfinderData.title)
    self:SetLock(wayfinderData.lock)
    if frame:IsShown() then
        frame.fadeIn:SetParentShownInstantly(true, frame.fadeOut)
    else
        frame.fadeIn:PlayShowing(frame.fadeOut)
    end
end

function MapPinEnhancedWayfinderArrow:Enable()
    self:GetFrame()
end

function MapPinEnhancedWayfinderArrow:Disable()
    self.step = nil
    if self.frame then self.frame.step = nil end
    if self.positionFrame then self.positionFrame.instruction:SetStep(nil) end
    if self.frame then
        self.frame.loading:Hide()
        self.frame.readout:SetStatusText(nil)
        self.frame.fadeOut:PlayHiding(self.frame.fadeIn)
    end
end

--- Inject into WayfinderManager
if not Wayfinders.wayfinders then
    Wayfinders.wayfinders = {}
end
Wayfinders.wayfinders["WAYFINDER_ARROW"] = MapPinEnhancedWayfinderArrow

---@param title string
---@param description string?
function MapPinEnhancedWayfinderArrow:SetDestinationText(title, description)
    self.title, self.description = title, description
    self:GetFrame():OnLeave()
    self:GetFrame().readout:UpdateText()
    self:UpdateText()
end
