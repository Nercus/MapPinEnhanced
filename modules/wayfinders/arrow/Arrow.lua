---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedWayfinderArrow : MapPinEnhancedWayfinder
---@field frame MapPinEnhancedWayfinderArrowTemplate
---@field title string?
---@field description string?
---@field positionFrame MapPinEnhancedWayfinderArrowPositionTemplate?
---@field unsubscribeRotatePinOption fun() | nil
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
        position.instruction:SetFrameLevel(self.frame:GetFrameLevel() + 3)
        position.instruction:UpdateFrameLevels()
    end
    return self.frame
end

---@param title string
function MapPinEnhancedWayfinderArrow:SetTitle(title)
    self.title = title
    self:GetFrame():SetTitle(title)
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
    if self.positionFrame then self.positionFrame.instruction:SetStep(step) end
    local showDirection = step == nil or step.showDirection and step.desiredAction == nil
    frame.needleContainer:SetShown(showDirection)
    frame.pin:SetShown(showDirection)
    frame.textContainer:SetShown(showDirection)
    self:UpdateText(step)
    frame:SetDirectionVisible(showDirection)
end

---@param step WayfinderStepData?
function MapPinEnhancedWayfinderArrow:UpdateText(step)
    local frame = self:GetFrame()
    frame:SetTitle(step and step.showInstruction ~= false and "" or self.title)
    frame.textContainer.description:Apply(self.title,
        not (step and step.showInstruction ~= false) and self.description or nil)
    local instruction = self.positionFrame and self.positionFrame.instruction
    local readoutAnchor = step and step.showInstruction ~= false and instruction and instruction.text or
        (self.description and frame.textContainer.description or frame.title)
    frame.readout:ClearAllPoints()
    frame.readout:SetPoint("TOP", readoutAnchor, "BOTTOM", 0, -2)
end

---@param rotatePin boolean
function MapPinEnhancedWayfinderArrow:SetRotatePin(rotatePin)
    if not self.frame then return end
    self.frame:SetRotatePin(rotatePin)
end

---@param wayfinderData WayfinderData | nil
function MapPinEnhancedWayfinderArrow:Init(wayfinderData)
    local frame = self:GetFrame()
    if not wayfinderData or not wayfinderData.mapID or not wayfinderData.x or not wayfinderData.y then
        frame.textContainer.description:Apply(nil, nil)
        self.description = nil
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
    frame.textContainer.description:Apply(self.title, self.description)
    self:SetLock(wayfinderData.lock)
    if frame:IsShown() then
        frame.fadeIn:SetParentShownInstantly(true, frame.fadeOut)
    else
        frame.fadeIn:PlayShowing(frame.fadeOut)
    end
end

function MapPinEnhancedWayfinderArrow:Enable()
    self:GetFrame()
    self.unsubscribeRotatePinOption = Options:SubscribeToOptionChanges("Wayfinder.Arrow.RotatePin", function(value)
        self:SetRotatePin(value)
    end)
end

function MapPinEnhancedWayfinderArrow:Disable()
    if self.positionFrame then self.positionFrame.instruction:SetStep(nil) end
    if self.frame then
        self.frame.fadeOut:PlayHiding(self.frame.fadeIn)
    end
    if self.unsubscribeRotatePinOption then
        self.unsubscribeRotatePinOption()
        self.unsubscribeRotatePinOption = nil
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
    self:UpdateText(Wayfinders:GetStepSnapshot())
end
