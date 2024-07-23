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
---@field initValues table<'mapID' | 'xCoord' | 'yCoord' | 'title', string | number>
MapPinEnhancedSetEditorPinEntryMixin = {}



local tonumber = tonumber
local tostring = tostring
local Round = Round


---@param pin pinData
function MapPinEnhancedSetEditorPinEntryMixin:SetPin(pin)
    self.Pin:Setup(pin)
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

---@param key 'mapID' | 'xCoord' | 'yCoord' | 'title'
---@param value string
function MapPinEnhancedSetEditorPinEntryMixin:OnChange(key, value)
    assert(self.onChangeCallback, "No callback set")


    ---@type string | number?
    local cleanedValue = value
    if key == 'mapID' then
        cleanedValue = tonumber(value)
    elseif key == 'xCoord' or key == 'yCoord' then
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
        self:OnChange('xCoord', self.xCoord:GetText())
    end)
    self.yCoord:SetScript("OnTextChanged", function()
        self:OnChange('yCoord', self.yCoord:GetText())
    end)
    self.title:SetScript("OnTextChanged", function()
        self:OnChange('title', self.title:GetText())
    end)
    -- self.pinOptions:SetScript("OnValueChanged", function()
    --     self:OnChange()
    -- end)
end

-- local order = {
--     "mapID",
--     "xCoord",
--     "yCoord",
--     "title",
-- }
-- local orderCount = #order


-- function MapPinEnhancedSetEditorPinEntryMixin:IsFocusingInput()
--     if self.mapID:HasFocus() then return true end
--     if self.xCoord:HasFocus() then return true end
--     if self.yCoord:HasFocus() then return true end
--     if self.title:HasFocus() then return true end
--     return false
-- end

-- function MapPinEnhancedSetEditorPinEntryMixin:SetEditBoxPropagation(propagation)
--     self.mapID:SetPropagateKeyboardInput(propagation)
--     self.xCoord:SetPropagateKeyboardInput(propagation)
--     self.yCoord:SetPropagateKeyboardInput(propagation)
--     self.title:SetPropagateKeyboardInput(propagation)
-- end

-- function MapPinEnhancedSetEditorPinEntryMixin:CycleEditboxes()
--     if not self.currentFocus or self.currentFocus > orderCount then
--         self.currentFocus = 0
--     end
--     self.currentFocus = self.currentFocus + 1
--     ---@type "mapID" | "xCoord" | "yCoord" | "title" | nil
--     local nextFocus = order[self.currentFocus]
--     if not nextFocus then
--         self:CycleEditboxes()
--         return
--     end
--     self[nextFocus]:SetFocus()
-- end

-- function MapPinEnhancedSetEditorPinEntryMixin:OnKeyDown(key)
--     if key ~= "TAB" then return end
--     self:CycleEditboxes()
-- end
