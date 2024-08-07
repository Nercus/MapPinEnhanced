-- Template: file://./SetEditorPinEntry.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedMapIDEditBox : MapPinEnhancedInputMixin
---@field mapSelection Button


---@class MapPinEnhancedSetEditorPinEntryMixin : Frame
---@field Pin MapPinEnhancedBasePinMixin
---@field currentFocus number
---@field mapID MapPinEnhancedMapIDEditBox
---@field xCoord MapPinEnhancedInputMixin
---@field yCoord MapPinEnhancedInputMixin
---@field title MapPinEnhancedInputMixin
---@field pinOptions MapPinEnhancedSelectMixin
---@field onChangeCallback function
---@field initValues table<'mapID' | 'xCoord' | 'yCoord' | 'title' | 'color', string | number>
MapPinEnhancedSetEditorPinEntryMixin = {}


local CONSTANTS = MapPinEnhanced.CONSTANTS
local tonumber = tonumber
local tostring = tostring
local Round = Round


---@param pin pinData
function MapPinEnhancedSetEditorPinEntryMixin:SetPin(pin)
    self.Pin:Setup(pin)
    self.Pin:SetTrackedTexture()
    self.mapID:SetText(tostring(pin.mapID))
    local xCoord = tostring(Round(pin.x * 10000) / 100)
    self.xCoord:SetText(xCoord)
    local yCoord = tostring(Round(pin.y * 10000) / 100)
    self.yCoord:SetText(yCoord)
    self.title:SetText(pin.title)
    self.initValues = {
        mapID = pin.mapID,
        xCoord = Round(pin.x * 10000) / 10000,
        yCoord = Round(pin.y * 10000) / 10000,
        title = pin.title,
    }
end

function MapPinEnhancedSetEditorPinEntryMixin:SetChangeCallback(callback)
    self.onChangeCallback = callback
end

---@param key 'mapID' | 'x' | 'y' | 'title' | 'color'
---@param value string
function MapPinEnhancedSetEditorPinEntryMixin:OnChange(key, value)
    assert(self.onChangeCallback, "No callback set")
    ---@type string | number?
    local cleanedValue = value
    if key == 'mapID' then
        cleanedValue = tonumber(value)
    elseif key == 'x' or key == 'y' then
        cleanedValue = tonumber(value) / 100
    end

    if tostring(self.initValues[key]) == tostring(cleanedValue) then
        return
    end
    self.onChangeCallback(key, cleanedValue)
end

function MapPinEnhancedSetEditorPinEntryMixin:OnLoad()
    self.mapID:SetScript("OnTextChanged", function()
        self:OnChange('mapID', self.mapID:GetText())
    end)
    self.xCoord:SetScript("OnTextChanged", function()
        self:OnChange('x', self.xCoord:GetText())
    end)
    self.yCoord:SetScript("OnTextChanged", function()
        self:OnChange('y', self.yCoord:GetText())
    end)
    self.title:SetScript("OnTextChanged", function()
        self:OnChange('title', self.title:GetText())
    end)
    -- TODO: implement pinOptions dropdown
    -- self.pinOptions:SetScript("OnValueChanged", function()
    --     self:OnChange()
    -- end)
end

function MapPinEnhancedSetEditorPinEntryMixin:OpenColorMenu()
    local pin = self.Pin

    local function IsColorSelected(colorIndex)
        local colorTable = CONSTANTS.PIN_COLORS[colorIndex]
        return pin.pinData.color == colorTable.colorName or
            (pin.pinData.color == nil and colorIndex == 1) -- default to yellow
    end

    local function SetColor(colorName)
        pin.pinData.color = colorName
        pin:SetPinColor(colorName)
        pin:SetTrackedTexture()
        self.onChangeCallback('color', colorName)
    end
    MenuUtil.CreateContextMenu(pin, function(_, rootDescription)
        for colorIndex, colorTable in ipairs(CONSTANTS.PIN_COLORS) do
            local label = string.format(CONSTANTS.MENU_COLOR_BUTTON_PATTERN, colorTable.color:GetRGBAsBytes())
            rootDescription:CreateRadio(label, IsColorSelected, function() SetColor(colorTable.colorName) end,
                colorIndex)
        end
    end)
end
