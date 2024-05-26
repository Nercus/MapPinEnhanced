---@class WayfinderCompassMixin : Frame
---@field background Texture
WayfinderCompassMixin = {}
WayfinderCompassMixin.pins = {}

function WayfinderCompassMixin:OnLoad()
    print("WayfinderCompassMixin:OnLoad()")
end

function WayfinderCompassMixin:OnEnter()
    print("WayfinderCompassMixin:OnEnter()")
end

function WayfinderCompassMixin:OnLeave()
    print("WayfinderCompassMixin:OnLeave()")
end


function WayfinderCompassMixin:OnUpdate()
  local playerFacing = GetPlayerFacing()
  -- calculate the angle of the player's facing for every pin and set pin offset based on that angle
  for i, pin in ipairs(self.pins) do
    -- TODO: THIS IS NON WORKING CODE! This ist just to display the idea of the line compass
    local angle = math.atan2(pin.pinData.y, pin.pinData.x)
    local offset = angle - playerFacing
    local x = math.cos(offset * math.pi) * (553 / 2)
    local y = 0 -- set y to 0 to only display on the x axis
    pin:ClearAllPoints()
    pin:SetPoint("CENTER", self, "CENTER", x, y)
  end
end


function WayfinderCompassMixin:AddPin(worldPin)
    worldPin:SetPoint("CENTER", self, "CENTER", 10,20)
    worldPin:Show()
    table.insert(self.pins, worldPin)
end
