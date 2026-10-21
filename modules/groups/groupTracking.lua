---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")
local Pins = MapPinEnhanced:GetModule("Pins")
local Navigation = MapPinEnhanced:GetModule("Navigation")

---@class GroupNextPinPrediction
---@field groupID UUID
---@field lifetimeChangeNumber number
---@field pinID UUID
---@field cancel fun()?
---@field result NavigationDestinationPrediction?

local pending ---@type GroupNextPinPrediction?

-- Mutation owners invalidate synchronously; callback delivery cannot protect
-- a prediction from pin/group pool reuse or a new tracking selection.
---@param group MapPinEnhancedGroupMixin?
function Groups:CancelNextPinPrediction(group)
    if group then group.predictionChangeNumber = (group.predictionChangeNumber or 0) + 1 end
    if not pending or group and pending.groupID ~= group:GetGroupID() then return end
    local previous = pending
    pending = nil
    if previous.cancel then previous.cancel() end
    previous.cancel, previous.result = nil, nil
end

---@param group MapPinEnhancedGroupMixin?
---@return boolean
local function CanPredict(group)
    return group ~= nil and not group:IsProtected() and not group:IsHidden() and
        not group.pinsUpdating and not group.isDeleting and
        group:GetTrackingMode() == Groups.TRACKING_MODE_NEAREST and group:GetPinCount() > 2
end

---@param pin MapPinEnhancedPinMixin
function Groups:PrepareNextPinPrediction(pin)
    if pending and pending.pinID == pin.pinID then return end
    self:CancelNextPinPrediction()
    local group = pin.group
    local owner, destinationID = Navigation:GetActiveDestinationState()
    if owner ~= "addonPins" or destinationID ~= pin.pinID then return end
    if not Navigation.routeNavigationEnabled or not Navigation:GetGraph() or
        not CanPredict(group) or Pins:GetTrackedPin() ~= pin then return end
    ---@cast group MapPinEnhancedGroupMixin
    ---@type GroupNextPinPrediction
    local request = { groupID = group:GetGroupID(), lifetimeChangeNumber = group.lifetimeChangeNumber,
        pinID = pin.pinID }
    pending = request
    request.cancel = MapPinEnhanced:BatchExecution({ function()
        local checkpoint = MapPinEnhanced:CreateBatchCheckpoint(0.1)
        local candidates = {} ---@type NavigationDestinationCandidate[]
        local data = pin:GetPinData()
        local origin = { mapID = data.mapID, x = data.x, y = data.y } ---@type WayfinderData
        for pinID, candidate in group:EnumeratePins() do
            if pinID ~= request.pinID then
                local candidateData = candidate:GetPinData()
                candidates[#candidates + 1] = { id = pinID, order = group:GetPinOrder(pinID),
                    data = { mapID = candidateData.mapID, x = candidateData.x, y = candidateData.y } }
            end
            checkpoint()
        end
        if pending ~= request then return end
        -- The copying worker finishes this frame; navigation starts next frame.
        request.cancel = Navigation:FindFastestDestination(origin, candidates, function(result)
            if pending ~= request then return end
            request.cancel = nil
            request.result = result
        end)
    end }, nil, nil, 1, function(message)
        if pending == request then self:CancelNextPinPrediction() end
        geterrorhandler()(message)
    end)
end

-- Called before arrival releases the tracked pin. Consume only a completed
-- prediction for this exact group lifetime; manual clearing never calls here.
---@param group MapPinEnhancedGroupMixin
---@param pinID UUID
---@return NavigationDestinationPrediction?
function Groups:TakeNextPinPrediction(group, pinID)
    local request = pending
    local result = request and request.result
    local prediction ---@type NavigationDestinationPrediction?
    if request and result and request.pinID == pinID and request.groupID == group:GetGroupID() and
        request.lifetimeChangeNumber == group.lifetimeChangeNumber and CanPredict(group) and
        Pins:GetTrackedPin() == group:GetPinByID(pinID) and Navigation:IsDestinationPredictionFresh(result) and
        group:GetPinByID(result.id) then
        prediction = result
    end
    self:CancelNextPinPrediction()
    return prediction
end

-- CallbackHandler dispatches tracking synchronously. Keep the handoff scoped
-- to this Track call, so a later manual selection can never inherit a route.
local handoff ---@type {pin: MapPinEnhancedPinMixin, group: MapPinEnhancedGroupMixin?, lifetime: number?, prediction: NavigationDestinationPrediction}?

---@param pin MapPinEnhancedPinMixin
---@param prediction NavigationDestinationPrediction?
function Groups:TrackPredictedPin(pin, prediction)
    if not prediction then
        pin:TrackWithoutPersisting()
        return
    end
    local group = pin.group
    local transfer = { pin = pin, group = group, lifetime = group and group.lifetimeChangeNumber,
        prediction = prediction }
    handoff = transfer
    local success, message = pcall(pin.TrackWithoutPersisting, pin)
    if handoff == transfer then handoff = nil end
    if not success then error(message, 0) end
end

---@param pin MapPinEnhancedPinMixin
---@return NavigationDestinationPrediction?
function Groups:TakeTrackedPinPrediction(pin)
    local transfer = handoff
    handoff = nil
    if not transfer or transfer.pin ~= pin or transfer.prediction.id ~= pin.pinID or
        Pins:GetTrackedPin() ~= pin or pin.group ~= transfer.group or
        not pin.group or pin.group.lifetimeChangeNumber ~= transfer.lifetime then return nil end
    return transfer.prediction
end

MapPinEnhanced:GetModule("Options"):SubscribeToOptionChanges("Wayfinder.Navigation.Enable", function()
    Groups:CancelNextPinPrediction()
end)

-- Saved tracking can be restored before Navigation builds its graph at login.
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    local pin = Pins:GetTrackedPin()
    if pin then Groups:PrepareNextPinPrediction(pin) end
end)
