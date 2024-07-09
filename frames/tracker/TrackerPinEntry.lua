---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinEntryMixin :  Button
---@field Pin MapPinEnhancedBasePinMixin
---@field titlePosition string | nil
---@field titleXOffset number | nil
---@field titleYOffset number | nil
MapPinEnhancedTrackerPinEntryMixin = {}


function MapPinEnhancedTrackerPinEntryMixin:OnLoad()
    ---@diagnostic disable-next-line: undefined-field not defined in the vscode extions yet
    if (not self.Pin.SetPropagateMouseClicks or not self.Pin.SetPropagateMouseMotion) then
        return
    end
    ---@diagnostic disable-next-line: undefined-field not defined in the vscode extions yet
    self.Pin:SetPropagateMouseClicks(true)
    ---@diagnostic disable-next-line: undefined-field
    self.Pin:SetPropagateMouseMotion(true)
end

function MapPinEnhancedTrackerPinEntryMixin:Setup(pinData)
    if pinData then
        self.pinData = pinData
    end
    if not self.pinData then
        return
    end
    self.Pin.titlePosition = self.titlePosition
    self.Pin.titleXOffset = self.titleXOffset
    self.Pin.titleYOffset = self.titleYOffset
    self.Pin:Setup(pinData)
end

---comment we override the texture function from the base pin mixin to include the other pathing to the texture
function MapPinEnhancedTrackerPinEntryMixin:SetPinIcon()
    self.Pin:SetPinIcon()
end

function MapPinEnhancedTrackerPinEntryMixin:SetPinColor(color)
    self.Pin:SetPinColor(color)
end

function MapPinEnhancedTrackerPinEntryMixin:SetTrackedTexture()
    -- NOTE: change the texture of the tracker entry here
    self.Pin:SetTrackedTexture()
end

function MapPinEnhancedTrackerPinEntryMixin:SetUntrackedTexture()
    -- NOTE: change the texture of the tracker entry here
    self.Pin:SetUntrackedTexture()
end

---comment we override the title position function from the base pin mixin to include the other pathing to the title
function MapPinEnhancedTrackerPinEntryMixin:SetTitle()
    self.Pin:SetTitle()
end

function MapPinEnhancedTrackerPinEntryMixin:OnEnter()
    self.Pin:LockHighlight()
end

function MapPinEnhancedTrackerPinEntryMixin:OnLeave()
    self.Pin:UnlockHighlight()
end
