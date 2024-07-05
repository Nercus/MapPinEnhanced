---@class MapPinEnhancedTrackerPinEntryMixin : MapPinEnhancedBasePinMixin, Button
---@field Pin MapPinEnhancedBasePinMixin
MapPinEnhancedTrackerPinEntryMixin = CreateFromMixins(MapPinEnhancedBasePinMixin)


function MapPinEnhancedTrackerPinEntryMixin:Setup()
    ---@diagnostic disable-next-line: undefined-field not defined in the vscode extions yet
    if (not self.Pin.SetPropagateMouseClicks or not self.Pin.SetPropagateMouseMotion) then
        return
    end
    ---@diagnostic disable-next-line: undefined-field not defined in the vscode extions yet
    self.Pin:SetPropagateMouseClicks(true)
    ---@diagnostic disable-next-line: undefined-field
    self.Pin:SetPropagateMouseMotion(true)
end

function MapPinEnhancedTrackerPinEntryMixin:OnClick()
    print("MapPinEnhancedTrackerPinEntryMixin:OnClick()")
end

---comment we override the texture function from the base pin mixin to include the other pathing to the texture
function MapPinEnhancedTrackerPinEntryMixin:SetCustomTexture()
    -- TODO: this function is for using a custom texture that is placed on top of the base pin textures
end

function MapPinEnhancedTrackerPinEntryMixin:SetTrackedTexture()
    local pinData = self.pinData
    if not pinData then return end
    self.Pin.icon:SetTexture(self.trackedTexture)
end

function MapPinEnhancedTrackerPinEntryMixin:SetUntrackedTexture()
    local pinData = self.pinData
    if not pinData then return end
    self.Pin.icon:SetTexture(self.untrackedTexture)
end

---comment we override the title position function from the base pin mixin to include the other pathing to the title
function MapPinEnhancedTrackerPinEntryMixin:SetTitle()
    if not self.pinData then
        return
    end
    local title = self.pinData.title or "Map Pin"
    self.Pin.title:SetText(title)
end

function MapPinEnhancedTrackerPinEntryMixin:SetTitlePosition(position, xOffset, yOffset)
    self.Pin.title:ClearAllPoints()
    if not position then
        return
    end


    local relativePosition =
        position == 'LEFT' and 'RIGHT' or
        position == 'RIGHT' and 'LEFT' or
        position == 'TOP' and 'BOTTOM' or
        position == 'BOTTOM' and 'TOP' or 'CENTER'


    self.Pin.title:SetPoint(relativePosition, self.Pin.icon, position, xOffset, yOffset)
    -- justify based on position
    self.Pin.title:SetJustifyH(
        position == 'LEFT' and 'RIGHT' or
        position == 'RIGHT' and 'LEFT' or 'MIDDLE'
    )
    self.Pin.title:SetJustifyV(
        position == 'TOP' and 'BOTTOM' or
        position == 'BOTTOM' and 'TOP' or 'MIDDLE'
    )
end

function MapPinEnhancedTrackerPinEntryMixin:OnEnter()
    self.Pin:LockHighlight()
end

function MapPinEnhancedTrackerPinEntryMixin:OnLeave()
    self.Pin:UnlockHighlight()
end
