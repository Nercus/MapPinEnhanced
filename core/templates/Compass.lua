-- ---@class WayfinderCompassMixin : Frame
-- ---@field background Texture
-- WayfinderCompassMixin = {}
-- WayfinderCompassMixin.pins = {}

-- function WayfinderCompassMixin:OnLoad()
--     print("WayfinderCompassMixin:OnLoad()")
-- end

-- function WayfinderCompassMixin:OnEnter()
--     print("WayfinderCompassMixin:OnEnter()")
-- end

-- function WayfinderCompassMixin:OnLeave()
--     print("WayfinderCompassMixin:OnLeave()")
-- end



-- local testFrame = CreateFrame("Frame", nil, UIParent)
-- testFrame:SetSize(50, 50)
-- testFrame:SetPoint("CENTER", 0, 0)
-- testFrame.texture = testFrame:CreateTexture(nil, "BACKGROUND")
-- testFrame.texture:SetAllPoints()
-- testFrame.texture:SetColorTexture(1, 0, 0, 1)
-- testFrame:Show()



-- local function GetSuperTrackedCameraAngle(playerFacing)
--   if not SuperTrackedFrame then
--     return
--   end
--   if not SuperTrackedFrame.navFrame then
--     return
--   end


--   testFrame:SetPoint("CENTER", SuperTrackedFrame.navFrame, "CENTER", 0, 0)

--   local navFrame_x, navFrame_y = SuperTrackedFrame.navFrame:GetLeft(), SuperTrackedFrame.navFrame:GetTop()
--   -- x and y is based of top left corner of the screen; translate to center of the screen
--   navFrame_x = navFrame_x - (UIParent:GetWidth() / 2)
--   navFrame_y = navFrame_y - (UIParent:GetHeight() / 2)
--   print("navFrame_x: " .. navFrame_x)
--   local navFrameTheta = math.atan2(navFrame_y, navFrame_x)
--   local angleFromCenter = (math.pi / 2) - navFrameTheta
--   angleFromCenter = (angleFromCenter + 2 * math.pi) % (2 * math.pi)
--   print("angleFromCenter: " .. angleFromCenter)


--   local userWaypoint = C_Map.GetUserWaypoint()
--   local _, waypointWorldPosition = C_Map.GetWorldPosFromMapPos(userWaypoint.uiMapID, userWaypoint.position)

--   local playerMap = C_Map.GetBestMapForUnit("player")
--   local playerPosition = C_Map.GetPlayerMapPosition(playerMap, "player")
--   local _, playerWorldPosition = C_Map.GetWorldPosFromMapPos(playerMap, playerPosition)

--   local waypointTheta = math.atan2(waypointWorldPosition.y - playerWorldPosition.y, waypointWorldPosition.x - playerWorldPosition.x)
--   local angleFromNorth = (math.pi / 2) - waypointTheta
--   angleFromNorth = (angleFromNorth + 2 * math.pi) % (2 * math.pi)
--   print("angleFromNorth", angleFromNorth)

-- end





-- local GetPlayerFacing = GetPlayerFacing
-- function WayfinderCompassMixin:OnUpdate()
--   -- TODO: add smart throtteling (maybe based on facing change)
--   local facing = GetPlayerFacing()
--   -- print("facing: " .. facing)
--   if WayfinderCompassMixin.previousFacing and WayfinderCompassMixin.previousFacing == facing then
--     -- player has not changed facing
--     -- check if camera angle has changed by tracking supertrackednavframe x position
--     local superTrackingAngle = GetSuperTrackedCameraAngle(facing)
--     if not superTrackingAngle then
--       return
--     end
--     -- new facing from supertrackedframe exists
--   else
--     -- facing changed
--   end

--   WayfinderCompassMixin.previousFacing = GetPlayerFacing()


--   local playerFacing = GetPlayerFacing()
--   -- calculate the angle of the player's facing for every pin and set pin offset based on that angle
--   for i, pin in ipairs(self.pins) do
--     -- TODO: THIS IS NON WORKING CODE! This ist just to display the idea of the line compass
--     local angle = math.atan2(pin.pinData.y, pin.pinData.x)
--     local offset = angle - playerFacing
--     local x = math.cos(offset * math.pi) * (553 / 2)
--     local y = 0 -- set y to 0 to only display on the x axis
--     pin:ClearAllPoints()
--     pin:SetPoint("CENTER", self, "CENTER", x, y)
--   end
-- end


-- function WayfinderCompassMixin:AddPin(worldPin)
--     worldPin:SetPoint("CENTER", self, "CENTER", 10,20)
--     worldPin:Show()
--     table.insert(self.pins, worldPin)
-- end
