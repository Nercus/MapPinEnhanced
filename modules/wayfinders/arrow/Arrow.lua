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
        self.frame.readout.onTextChanged = function()
            -- Preserve the pin, needle and edge space around the full readout line.
            local readoutWidth = math.max(166, math.ceil(self.frame.readout.text:GetUnboundedStringWidth()))
            self.frame.readout:SetWidth(readoutWidth)
            self.frame.textContainer:SetWidth(readoutWidth + 152)
            self.frame:SetWidth(readoutWidth + 152)
        end
        position.instruction:SetFrameLevel(self.frame:GetFrameLevel() + 3)
        position.instruction:UpdateFrameLevels()
        position.instruction.text:SetNonSpaceWrap(true)
        position.instruction.onTextChanged = function() self:UpdateText() end
    end
    return self.frame
end

function MapPinEnhancedWayfinderArrow:SetUp()
    self:GetFrame()
end

--@debug@
---@return string
function MapPinEnhancedWayfinderArrow:GetActionDebugText()
    return self.positionFrame and self.positionFrame.instruction:GetActionDebugText() or "Arrow not created"
end
--@end-debug@

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

---@param targetType WayfinderTargetType
function MapPinEnhancedWayfinderArrow:SetTargetType(targetType)
    self:GetFrame().pin:SetStyleMode(Wayfinders:GetTargetStyleMode(targetType))
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
    local showDirection = step == nil or step.showDirection and step.desiredAction == nil
    frame.needleContainer:SetShown(showDirection)
    frame.pin:SetShown(not (step and step.showInstruction ~= false and step.desiredAction))
    frame.textContainer:Show()
    frame.clearButton:SetEnabled(step ~= nil and Providers:CanClearNavigationTracking())
    self:UpdateText()
    frame:SetDirectionVisible(showDirection)
end

function MapPinEnhancedWayfinderArrow:UpdateText()
    local frame = self:GetFrame()
    local step = self.step
    local showInstruction = step and step.showInstruction ~= false
    local instruction = self.positionFrame and self.positionFrame.instruction
    local title = self.title
    if showInstruction and step and step.destinationMapID then
        local mapInfo = C_Map.GetMapInfo(step.destinationMapID)
        title = string.format(MapPinEnhanced.L["Navigation Route To"], step.destinationTitle or MapPinEnhanced.L["Map Pin"],
            mapInfo and mapInfo.name or tostring(step.destinationMapID))
    end
    frame.title:SetFontObject(showInstruction and GameFontHighlightSmall or GameFontNormal)
    frame:SetTitle(title)
    frame.title:SetTextColor(showInstruction and 0.65 or 1, showInstruction and 0.65 or 0.82,
        showInstruction and 0.65 or 0)
    frame.title:ClearAllPoints()
    local instructionHeight = 0
    if showInstruction and instruction then
        frame.title:SetPoint("TOPLEFT", instruction.text, "BOTTOMLEFT", 0, -3)
        instructionHeight = instruction.text:GetStringHeight()
    else
        frame.title:SetPoint("TOPLEFT", frame.textContainer, "TOPLEFT", 64, -8)
    end
    frame.textContainer.description:Apply(self.title, not showInstruction and self.description or nil)
    local descriptionHeight = frame.textContainer.description:IsShown() and
        frame.textContainer.description:GetHeight() + 3 or 0
    local height = math.max(62, instructionHeight + frame.title:GetStringHeight() + descriptionHeight + 32)
    frame.textContainer:SetHeight(height)
    frame:SetHeight(height)
    if not showInstruction and descriptionHeight == 0 then
        local textHeight = frame.title:GetStringHeight() + 3 + frame.readout:GetHeight()
        frame.title:SetPoint("TOPLEFT", frame.textContainer, "TOPLEFT", 64, -(height - textHeight) / 2)
    end
end

---@param wayfinderData WayfinderData | nil
function MapPinEnhancedWayfinderArrow:Init(wayfinderData)
    local frame = self:GetFrame()
    if not wayfinderData or not wayfinderData.mapID or not wayfinderData.x or not wayfinderData.y then
        self.description = nil
        frame.textContainer.description:Apply(nil, nil)
        frame:ResetDistanceReadout()
        self.frame.fadeOut:PlayHiding(self.frame.fadeIn)
        return
    end
    self:SetTargetType(wayfinderData.targetType)
    if wayfinderData.pinStyleMode then
        frame.pin:SetStyleMode(wayfinderData.pinStyleMode)
    end
    frame:SetLocation(wayfinderData.mapID, wayfinderData.x, wayfinderData.y)
    if wayfinderData.texture then
        self:SetTexture(wayfinderData.texture, wayfinderData.usesAtlas)
    else
        self:SetColor(wayfinderData.color)
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
    self:UpdateText()
end
