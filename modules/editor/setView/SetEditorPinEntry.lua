-- Template: file://./SetEditorPinEntry.xml
---@class MapPinEnhanced
---@field L Locale
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class MapPinEnhancedMapIDEditBox : MapPinEnhancedInputMixin
---@field mapSelection Button

---@class MapIDInputBox : MapPinEnhancedInputMixin
---@field mapSelection Button


---@class MapPinEnhancedCheckboxMixinWithLabel : MapPinEnhancedCheckboxMixin
---@field label FontString

---@class PinOptionsCheckboxFrame : Frame
---@field checkbox MapPinEnhancedCheckboxMixinWithLabel

---@class MapPinEnhancedSetEditorPinEntryMixin : Frame
---@field Pin MapPinEnhancedBasePinMixin
---@field currentFocus number
---@field mapID MapIDInputBox
---@field xCoord MapPinEnhancedInputMixin
---@field yCoord MapPinEnhancedInputMixin
---@field title MapPinEnhancedInputMixin
---@field pinOptions PinOptionsCheckboxFrame
---@field onChangeCallback function
---@field deleteButton Button
---@field MapHelperMenuTemplate AnyMenuEntry[]
---@field existingZoneNames table<string, number>
---@field initValues table<'mapID' | 'xCoord' | 'yCoord' | 'title' | 'color', string | number>
MapPinEnhancedSetEditorPinEntryMixin = {}


local CONSTANTS = MapPinEnhanced.CONSTANTS


---@param pin pinData
function MapPinEnhancedSetEditorPinEntryMixin:SetPin(pin)
    self.Pin:Setup(pin)
    self.Pin:SetTrackedTexture()
    self.mapID:SetText(tostring(pin.mapID))

    local xCoord = tostring(Round(pin.x * 10000) / 100)
    self.xCoord:SetText(xCoord)
    local yCoord = tostring(Round(pin.y * 10000) / 100)
    self.yCoord:SetText(yCoord)
    self.title:SetText(pin.title or "")
    self.title:SetCursorPosition(0)
    self.initValues = {
        mapID = pin.mapID,
        xCoord = Round(pin.x * 10000) / 10000,
        yCoord = Round(pin.y * 10000) / 10000,
        title = pin.title,
    }
    self:SetupPinOptions(pin.lock)
end

function MapPinEnhancedSetEditorPinEntryMixin:SetChangeCallback(callback)
    self.onChangeCallback = callback
end

---@param key changeableKeys
---@param value (string | number | boolean)?
function MapPinEnhancedSetEditorPinEntryMixin:OnChange(key, value)
    assert(self.onChangeCallback, "No callback set")
    ---@type (string | number | boolean)?
    local cleanedValue = value
    if key == 'mapID' then
        cleanedValue = tonumber(value)
    elseif (key == 'x' or key == 'y') and value ~= "" then
        cleanedValue = tonumber(value) / 100
    end

    if tostring(self.initValues[key]) == tostring(cleanedValue) then
        return
    end
    self.onChangeCallback(key, cleanedValue)
end

function MapPinEnhancedSetEditorPinEntryMixin:SetupPinButton()
    self.Pin:SetScript("OnEnter", function()
        GameTooltip:SetOwner(self.Pin, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["Click to Change Color"] .. "\n" .. L["Shift-Click to Share to Chat"])
        GameTooltip:Show()
    end)
    self.Pin:SetScript("OnLeave", function() GameTooltip:Hide() end)

    self.Pin:SetScript("OnClick", function()
        if IsShiftKeyDown() then
            local x = self.Pin.pinData.x / 100
            local y = self.Pin.pinData.y / 100
            local mapID = self.Pin.pinData.mapID
            local Blizz = MapPinEnhanced:GetModule("Blizz")
            Blizz:InsertWaypointLinkToChat(x, y, mapID)
        else
            self:OpenColorMenu()
        end
    end)
end

function MapPinEnhancedSetEditorPinEntryMixin:OnLoad()
    self.mapID:SetScript("OnTextChanged", function()
        self:OnChange('mapID', self.mapID:GetText())
    end)
    self.title:SetScript("OnTextChanged", function()
        self:OnChange('title', self.title:GetText())
    end)
    C_Timer.After(0.5, function()
        self.xCoord:SetScript("OnTextChanged", function()
            self:OnChange('x', self.xCoord:GetText())
        end)
        self.yCoord:SetScript("OnTextChanged", function()
            self:OnChange('y', self.yCoord:GetText())
        end)
    end)

    self.mapID.mapSelection:SetScript("OnClick", function()
        self:OpenMapHelperMenu()
    end)
    self.deleteButton:SetScript("OnClick", function()
        self.onChangeCallback('delete', true)
    end)
    self:SetupPinButton()
    self.pinOptions.checkbox.label:SetText(L["Lock Pin"])
end

function MapPinEnhancedSetEditorPinEntryMixin:SetupPinOptions(initLock)
    -- ---@type SelectOptions
    -- local selectOptions = {
    --     default = {
    --         lock = false,
    --     },
    --     init = function()
    --         return {
    --             lock = initLock
    --         }
    --     end,
    --     onChange = function(value)
    --         if not value then return end
    --         if type(value) ~= "table" then return end
    --         for optionKey, optionValue in pairs(value) do
    --             self:OnChange(optionKey, optionValue)
    --         end
    --     end,
    --     options = {
    --         {
    --             label = L["Lock Pin"],
    --             value = "lock",
    --             type = "checkbox"
    --         },
    --     }
    -- }

    ---@type CheckboxOptions
    local checkboxOptions = {
        default = initLock,
        init = function()
            return initLock
        end,
        onChange = function(value)
            self:OnChange('lock', value)
        end,
        disabledState = false
    }
    self.pinOptions.checkbox:Setup(checkboxOptions)
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

---@param parentTable table
---@param children UiMapDetails[]
---@param parent UiMapDetails?
function MapPinEnhancedSetEditorPinEntryMixin:GenerateMenuTemplateFromMapData(parentTable, children, parent)
    if parent then
        ---@type table
        parentTable[#parentTable + 1] = {
            type = "button",
            label = parent.name,
            onClick = function()
                self.mapID:SetText(tostring(parent.mapID))
                self:OnChange('title', self.title:GetText())
            end
        }
        ---@type table
        parentTable[#parentTable + 1] = {
            type = "divider"
        }
    end
    for _, child in ipairs(children) do
        if C_Map.CanSetUserWaypointOnMap(child.mapID) then
            local mapName = child.name
            if self.existingZoneNames[mapName] then
                mapName = string.format("%s (%d)", mapName, self.existingZoneNames[mapName] + 1)
            end
            self.existingZoneNames[child.name] = (self.existingZoneNames[child.name] or 0) + 1
            local nextChildren = C_Map.GetMapChildrenInfo(child.mapID, 3)
            if nextChildren and #nextChildren > 0 then
                ---@type table
                parentTable[#parentTable + 1] = {
                    type = "submenu",
                    label = mapName,
                    entries = {}
                }
                local mapInfo = C_Map.GetMapInfo(child.mapID)
                self:GenerateMenuTemplateFromMapData(parentTable[#parentTable].entries, nextChildren, mapInfo)
            else
                ---@type table
                parentTable[#parentTable + 1] = {
                    type = "button",
                    label = mapName,
                    onClick = function()
                        self.mapID:SetText(tostring(child.mapID))
                        self:OnChange('title', self.title:GetText())
                    end
                }
            end
        end
    end
end

local continents = C_Map.GetMapChildrenInfo(947, 2) -- 947 is Azeroth, 2 is continent
function MapPinEnhancedSetEditorPinEntryMixin:GetMenuTemplate()
    self.existingZoneNames = {}
    self.MapHelperMenuTemplate = {}
    if #self.MapHelperMenuTemplate == 0 then
        self:GenerateMenuTemplateFromMapData(self.MapHelperMenuTemplate, continents)
    end
    return self.MapHelperMenuTemplate
end

function MapPinEnhancedSetEditorPinEntryMixin:OpenMapHelperMenu()
    MapPinEnhanced:GenerateMenu(self.mapID.mapSelection, self:GetMenuTemplate())
end
