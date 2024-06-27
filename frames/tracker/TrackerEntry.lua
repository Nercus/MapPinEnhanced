---@class MapPinEnhancedTrackerEntryMixin : MapPinEnhancedBasePinMixin
---@field Pin MapPinEnhancedBasePinMixin
MapPinEnhancedTrackerEntryMixin = CreateFromMixins(MapPinEnhancedBasePinMixin)


function MapPinEnhancedTrackerEntryMixin:Setup()
    print("MapPinEnhancedTrackerEntryMixin:Setup()")
end

function MapPinEnhancedTrackerEntryMixin:OnClick()
    print("MapPinEnhancedTrackerEntryMixin:OnClick()")
end

---comment we override the texture function from the base pin mixin to include the other pathing to the texture
function MapPinEnhancedTrackerEntryMixin:OverrideTexture()
    ---@type pinData
    local pinData = self.pinData
    if (pinData.texture) then
        if (pinData.usesAtlas) then
            self.Pin.icon:SetAtlas(pinData.texture)
            return
        end
        self.Pin.icon:SetTexture(pinData.texture)
    end
end

---comment we override the title position function from the base pin mixin to include the other pathing to the title
function MapPinEnhancedTrackerEntryMixin:SetTitle()
    if not self.pinData then
        return
    end
    local title = self.pinData.title or "Map Pin"
    self.Pin.title:SetText(title)
end

function MapPinEnhancedTrackerEntryMixin:SetTitlePosition(position, xOffset, yOffset)
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

function MapPinEnhancedTrackerEntryMixin:OnEnter()
    self.Pin:LockHighlight()
end

function MapPinEnhancedTrackerEntryMixin:OnLeave()
    self.Pin:UnlockHighlight()
end
