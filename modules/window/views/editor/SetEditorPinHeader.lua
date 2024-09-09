---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedWindowSetPinHeaderMixin : Frame
---@field bg FontString
---@field Pin FontString
---@field mapID FontString
---@field xCoord FontString
---@field yCoord FontString
---@field title FontString
---@field options FontString
MapPinEnhancedWindowSetPinHeaderMixin = {}

local L = MapPinEnhanced.L

function MapPinEnhancedWindowSetPinHeaderMixin:OnLoad()
    self.Pin:SetText(L["Icon"])
    self.mapID:SetText(L["Map ID"])
    self.xCoord:SetText(L["X"])
    self.yCoord:SetText(L["Y"])
    self.title:SetText(L["Title"])
    self.options:SetText(L["Options"])
end
