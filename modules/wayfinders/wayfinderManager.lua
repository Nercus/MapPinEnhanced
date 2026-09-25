---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
---@field wayfinders table<string, MapPinEnhancedWayfinder> a table of registered wayfinders, with values injected in each wayfinder file
---@field activeWayfinder MapPinEnhancedWayfinder? the selected wayfinder presentation
---@field setupAfterCombat fun()?
---@field instructionFrame MapPinEnhancedNavigationStepTemplate? dedicated navigation panel
---@field TARGET_TYPE_PIN WayfinderTargetType
---@field TARGET_TYPE_BLIZZARD WayfinderTargetType
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Pins = MapPinEnhanced:GetModule("Pins")
local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedWayfinder
---@field Init fun(self: MapPinEnhancedWayfinder, targetData: WayfinderData | nil) sets the wayfinder pin for the wayfinder
---@field Enable fun(self: MapPinEnhancedWayfinder) enables the wayfinder
---@field Disable fun(self: MapPinEnhancedWayfinder) disables the wayfinder
---@field SetDestinationText fun(self: MapPinEnhancedWayfinder, title: string, description: string?)
---@field SetTitle fun(self: MapPinEnhancedWayfinder, title: string) sets the wayfinder title, if the wayfinder supports it
---@field SetColor fun(self: MapPinEnhancedWayfinder, color: string) sets the wayfinder color, if the wayfinder supports it
---@field SetTexture fun(self: MapPinEnhancedWayfinder, texture: string|number, usesAtlas: boolean) sets the wayfinder texture, if the wayfinder supports it
---@field SetTargetType fun(self: MapPinEnhancedWayfinder, targetType: WayfinderTargetType) sets the target style type
---@field SetLock fun(self: MapPinEnhancedWayfinder, lock: boolean) sets the wayfinder lock, if the wayfinder supports it
---@field SetStep fun(self: MapPinEnhancedWayfinder, step: WayfinderStepData?)

---@alias WayfinderTargetType "pin" | "blizzard"
Wayfinders.TARGET_TYPE_PIN = "pin"
Wayfinders.TARGET_TYPE_BLIZZARD = "blizzard"

---@enum WayfinderType
local AVAILABLE_WAYFINDERS = {
    WAYFINDER_FLOATING = "WAYFINDER_FLOATING",
    WAYFINDER_ARROW = "WAYFINDER_ARROW",
}

local WAYFINDER_SELECTION_OPTION = "Wayfinder.General.Selection"
local HIDE_BLIZZARD_OPTION = "Wayfinder.General.HideBlizzardFloatingDiamond"
local WAYFINDER_TYPES_BY_SELECTION = {
    [Options.WAYFINDER_SELECTION_ARROW] = AVAILABLE_WAYFINDERS.WAYFINDER_ARROW,
    [Options.WAYFINDER_SELECTION_FLOATING] = AVAILABLE_WAYFINDERS.WAYFINDER_FLOATING,
}
---@class WayfinderData
---@field mapID number UIMapID of the zone
---@field x number x coordinate between 0 and 1
---@field y number y coordinate between 0 and 1
---@field title string? title of the target
---@field description string? original destination plain text
---@field texture string|number? an optional texture to use for the target; this overrides the color
---@field usesAtlas boolean? if true, the texture is an atlas, otherwise it is a file path
---@field color string? the target color; ignored when texture is set
---@field lock boolean? if true, the target will not be removed automatically when reached
---@field targetType WayfinderTargetType? the presentation kind; missing or unknown values safely use the pin presentation
---@field pinStyleMode PinStyleMode? an optional presentation-only override for the target's BasePin
---@field mapDistanceOnly boolean? if true, distance sampling ignores Blizzard's separately super-tracked destination

---@alias WayfinderTargetArrival fun()

---@class ActiveWayfinderTarget
---@field data WayfinderData
---@field onArrival WayfinderTargetArrival?
---@field arrivalIdentity string?

---@type ActiveWayfinderTarget?
local activeTarget

---@class WayfinderDesiredAction
---@field type "spell"|"item"|"toy"
---@field id number

---@class WayfinderStepData
---@field changeNumber integer
---@field arrivalIdentity string
---@field showDirection boolean
---@field showInstruction boolean? false hides navigation instructions when routing is disabled
---@field phase string
---@field stepIndex integer?
---@field stepCount integer?
---@field instruction string
---@field status string?
---@field desiredAction WayfinderDesiredAction?

---@type WayfinderStepData?
local activeStep
---@type WayfinderSelection?
local selectedWayfinder

---@param wayfinderType WayfinderType
---@return MapPinEnhancedWayfinder
local function GetWayfinder(wayfinderType)
    local wayfinder = Wayfinders.wayfinders and Wayfinders.wayfinders[wayfinderType]
    assert(wayfinder, "Wayfinders: wayfinder type is not registered: " .. tostring(wayfinderType))
    assert(wayfinder.Enable and wayfinder.Disable and wayfinder.Init and wayfinder.SetTargetType and
        wayfinder.SetStep, "Wayfinders: registered wayfinder does not implement the required interface")
    return wayfinder
end

---@return MapPinEnhancedNavigationStepTemplate
function Wayfinders:GetInstructionFrame()
    if self.instructionFrame then return self.instructionFrame end
    local frame = CreateFrame("Frame", nil, UIParent, "MapPinEnhancedNavigationStepTemplate")
    ---@cast frame MapPinEnhancedNavigationStepTemplate
    self.instructionFrame = frame
    return frame
end

---@param action WayfinderDesiredAction?
---@return WayfinderDesiredAction?
local function CopyDesiredAction(action)
    if not action then return nil end
    return { type = action.type, id = action.id }
end

---@param step WayfinderStepData
---@return WayfinderStepData
local function CopyStep(step)
    return {
        changeNumber = step.changeNumber,
        arrivalIdentity = step.arrivalIdentity,
        showDirection = step.showDirection,
        showInstruction = step.showInstruction,
        phase = step.phase,
        stepIndex = step.stepIndex,
        stepCount = step.stepCount,
        instruction = step.instruction,
        status = step.status,
        desiredAction = CopyDesiredAction(step.desiredAction),
    }
end

local function ApplyActiveStep()
    local floating = selectedWayfinder == Options.WAYFINDER_SELECTION_FLOATING
    local frame = Wayfinders.instructionFrame
    if frame then
        local step = floating and activeStep or nil
        frame:SetStep(step)
        local menu = step and Wayfinders:BuildNavigationMenuEntries()
        frame.onMenu = menu and function(owner) MapPinEnhanced:GenerateMenu(owner, menu) end or nil
        frame:ApplyVisibility(step and step.showInstruction ~= false or false)
    end
    if Wayfinders.activeWayfinder then
        Wayfinders.activeWayfinder:SetStep(activeStep)
    end
end

MapPinEnhanced:RegisterEvent("PLAYER_REGEN_ENABLED", ApplyActiveStep)

---@return WayfinderStepData?
function Wayfinders:GetStepSnapshot()
    return activeStep and CopyStep(activeStep) or nil
end

--@debug@
---@return string
function Wayfinders:GetActionDebugText()
    if selectedWayfinder == Options.WAYFINDER_SELECTION_ARROW then
        local arrow = GetWayfinder(AVAILABLE_WAYFINDERS.WAYFINDER_ARROW)
        ---@cast arrow MapPinEnhancedWayfinderArrow
        return arrow.positionFrame and arrow.positionFrame.instruction:GetActionDebugText() or "Arrow not created"
    end
    return self.instructionFrame and self.instructionFrame:GetActionDebugText() or "Floating instruction not created"
end

--@end-debug@

---@return AnyMenuEntry[]
function Wayfinders:BuildNavigationMenuEntries()
    local step = self:GetStepSnapshot()
    if not step then return {} end
    local Navigation = MapPinEnhanced:GetModule("Navigation")
    local entries = {
        { type = "divider" },
        { type = "title",  label = MapPinEnhanced.L["Wayfinder.Navigation_GROUPLABEL"] },
        {
            type = "button",
            label = MapPinEnhanced:Iconize("arrowcircle", MapPinEnhanced.L["Recalculate Route"]),
            onClick = function()
                Navigation:Recalculate(step.changeNumber)
            end
        },
    }
    if Navigation:GetRouteChatSteps(step.changeNumber) then
        entries[#entries + 1] = {
            type = "button",
            label = MapPinEnhanced:Iconize("share", MapPinEnhanced.L["Export Route to Chat"]),
            onClick = function()
                MapPinEnhanced:GetModule("Providers"):ShareRouteToChat(step.changeNumber)
            end,
        }
    end
    return entries
end

---@param styleMode string?
---@return PinStyleMode?
local function GetPinStyleModeOrNil(styleMode)
    if styleMode == Pins.STYLE_MODE_PIN or styleMode == Pins.STYLE_MODE_OUTLINE then
        return styleMode
    end
    return nil
end

---@param targetData WayfinderData
---@return WayfinderData
local function CopyWayfinderData(targetData)
    return {
        mapID = targetData.mapID,
        x = targetData.x,
        y = targetData.y,
        title = targetData.title,
        description = targetData.description,
        texture = targetData.texture,
        usesAtlas = targetData.usesAtlas,
        color = targetData.color,
        lock = targetData.lock,
        targetType = Wayfinders:GetTargetTypeOrDefault(targetData.targetType),
        pinStyleMode = GetPinStyleModeOrNil(targetData.pinStyleMode),
        mapDistanceOnly = targetData.mapDistanceOnly,
    }
end

---@param targetData WayfinderData?
---@param onArrival WayfinderTargetArrival?
---@param arrivalIdentity string?
local function ApplyActiveTarget(targetData, onArrival, arrivalIdentity)
    local previous = activeTarget
    local data = targetData and CopyWayfinderData(targetData) or nil
    local old = previous and previous.data
    local sameArrival = previous ~= nil and previous.arrivalIdentity == arrivalIdentity
    local sameGeometry = old ~= nil and data ~= nil and old.mapID == data.mapID and
        old.x == data.x and old.y == data.y and old.lock == data.lock and
        old.mapDistanceOnly == data.mapDistanceOnly
    -- A status update must not rearm a consumed arrival or reset its samples.
    if sameArrival and previous then onArrival = previous.onArrival end
    activeTarget = data and { data = data, onArrival = onArrival, arrivalIdentity = arrivalIdentity } or nil
    local refreshTarget = not sameGeometry or not sameArrival
    local refreshDisplay = refreshTarget or
        old and data and (old.title ~= data.title or old.description ~= data.description or
            old.texture ~= data.texture or old.usesAtlas ~= data.usesAtlas or old.color ~= data.color or
            old.targetType ~= data.targetType or old.pinStyleMode ~= data.pinStyleMode)
    if refreshTarget then Wayfinders:ResetArrivalDetection() end
    if refreshDisplay and Wayfinders.activeWayfinder then Wayfinders.activeWayfinder:Init(data) end
    if not refreshTarget then return end
    if data and data.mapID and data.x and data.y then
        MapPinEnhanced:EnableContinuousDistanceCheck(data.mapID, data.x, data.y, not data.mapDistanceOnly)
    else
        MapPinEnhanced:DisableContinuousDistanceCheck()
    end
end

---@param targetData WayfinderData
---@param onArrival WayfinderTargetArrival?
---@param presentation WayfinderStepData
function Wayfinders:ApplyPresentation(targetData, onArrival, presentation)
    assert(type(targetData) == "table", "Wayfinders:ApplyPresentation: targetData must be a table")
    assert(onArrival == nil or type(onArrival) == "function",
        "Wayfinders:ApplyPresentation: onArrival must be a function or nil")
    assert(type(presentation) == "table", "Wayfinders:ApplyPresentation: presentation must be a table")
    activeStep = CopyStep(presentation)
    ApplyActiveTarget(targetData, onArrival, presentation.arrivalIdentity)
    ApplyActiveStep()
end

---@param targetType string?
---@return WayfinderTargetType
function Wayfinders:GetTargetTypeOrDefault(targetType)
    if targetType == self.TARGET_TYPE_BLIZZARD then
        return self.TARGET_TYPE_BLIZZARD
    end
    return self.TARGET_TYPE_PIN
end

---@param targetType string?
---@return PinStyleMode
function Wayfinders:GetTargetStyleMode(targetType)
    if self:GetTargetTypeOrDefault(targetType) == self.TARGET_TYPE_BLIZZARD then
        return Pins.STYLE_MODE_OUTLINE
    end
    return Pins.STYLE_MODE_PIN
end

function Wayfinders:ClearPresentation()
    activeStep = nil
    ApplyActiveTarget(nil)
    ApplyActiveStep()
end

---@return boolean
function Wayfinders:CanRemoveActiveTargetOnArrival()
    return activeTarget ~= nil and not activeTarget.data.lock and activeTarget.onArrival ~= nil
end

---@param sampledDistance number
---@return number?
function Wayfinders:GetActiveTargetArrivalDistance(sampledDistance)
    local data = activeTarget and activeTarget.data
    if not data then return nil end
    local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
    if not mapID or not x or not y then return nil end
    local mapDistance = MapPinEnhanced.HBD:GetZoneDistance(mapID, x, y, data.mapID, data.x, data.y)
    if type(mapDistance) ~= "number" or mapDistance ~= mapDistance or mapDistance < 0 then return nil end
    -- Native navigation can still describe another waypoint during a transition.
    -- Arrival requires proximity to the owned target, not just that native guide.
    return math.max(sampledDistance, mapDistance)
end

function Wayfinders:RemoveActiveTargetOnArrival()
    if not self:CanRemoveActiveTargetOnArrival() then return end

    local target = activeTarget
    if not target then return end
    local onArrival = target.onArrival
    target.onArrival = nil
    self:ResetArrivalDetection()
    if onArrival then onArrival() end
end

---@param wayfinder MapPinEnhancedWayfinder
local function RefreshWayfinder(wayfinder)
    if activeTarget then
        wayfinder:Init(activeTarget.data)
    else
        wayfinder:Init(nil)
    end
end

---@param selection WayfinderSelection
function Wayfinders:SelectWayfinder(selection)
    local wayfinderType = WAYFINDER_TYPES_BY_SELECTION[selection]
    assert(wayfinderType, "Wayfinders:SelectWayfinder: invalid selection " .. tostring(selection))
    selectedWayfinder = selection
    if not self.instructionFrame then
        if InCombatLockdown() then
            -- Initial setup needs protected controls. Retain the latest selection
            -- and copied presentation until the controls can be created safely.
            if not self.setupAfterCombat then
                self.setupAfterCombat = MapPinEnhanced:RegisterEventBucket({ "PLAYER_REGEN_ENABLED" }, function()
                    if selectedWayfinder then self:SelectWayfinder(selectedWayfinder) end
                end)
            end
            return
        end
        if self.setupAfterCombat then
            self.setupAfterCombat()
            self.setupAfterCombat = nil
        end
        self:GetInstructionFrame()
        local arrow = GetWayfinder(AVAILABLE_WAYFINDERS.WAYFINDER_ARROW)
        ---@cast arrow MapPinEnhancedWayfinderArrow
        arrow:GetFrame()
    end
    local wayfinder = GetWayfinder(wayfinderType)
    if self.activeWayfinder ~= wayfinder then
        if self.activeWayfinder then self.activeWayfinder:Disable() end
        wayfinder:Enable()
        self.activeWayfinder = wayfinder
        RefreshWayfinder(wayfinder)
    end
    ApplyActiveStep()

    local floatingSelected = selection == Options.WAYFINDER_SELECTION_FLOATING
    Options:SetOptionEnabled(HIDE_BLIZZARD_OPTION, not floatingSelected)
    local floating = GetWayfinder(AVAILABLE_WAYFINDERS.WAYFINDER_FLOATING)
    ---@cast floating MapPinEnhancedWayfinderFloating
    if not floatingSelected and Options:GetOptionValue(HIDE_BLIZZARD_OPTION) then
        floating:HideBlizzardForSession()
    end
end

Options:SubscribeToOptionChanges(WAYFINDER_SELECTION_OPTION, function(selection)
    Wayfinders:SelectWayfinder(selection)
end)

---@param title string
---@param description string?
function Wayfinders:UpdateDestinationText(title, description)
    if not activeTarget then return end
    activeTarget.data.title = title
    activeTarget.data.description = description
    if self.instructionFrame then self.instructionFrame:SetDestinationText(title) end
    if self.activeWayfinder then self.activeWayfinder:SetDestinationText(title, description) end
end
