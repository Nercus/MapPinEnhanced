-- Template: file://./SetEditorPinEntry.xml
---@class MapPinEnhanced
---@field L Locale
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class MapPinEnhancedMapIDEditBox : MapPinEnhancedInputMixin
---@field mapSelection Button

---@class MapIDInputBox : MapPinEnhancedInputMixin
---@field mapSelection Button

---@class MapPinEnhancedSetEditorPinEntryMixin : Frame
---@field Pin MapPinEnhancedBasePinMixin
---@field currentFocus number
---@field mapID MapIDInputBox
---@field xCoord MapPinEnhancedInputMixin
---@field yCoord MapPinEnhancedInputMixin
---@field title MapPinEnhancedInputMixin
---@field pinOptions MapPinEnhancedSelectMixin
---@field onChangeCallback function
---@field deleteButton Button
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
    self.title:SetText(pin.title or "")
    self.title:SetCursorPosition(0)
    self.initValues = {
        mapID = pin.mapID,
        xCoord = Round(pin.x * 10000) / 10000,
        yCoord = Round(pin.y * 10000) / 10000,
        title = pin.title,
    }
    self:SetupPinOptions(pin.persistent)
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
        GameTooltip:SetText(L["Click to change color"] .. "\n" .. L["Shift click to Share to chat"])
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
end

function MapPinEnhancedSetEditorPinEntryMixin:SetupPinOptions(initPersistent)
    ---@type SelectOptions
    local selectOptions = {
        default = {
            persistent = false,
        },
        init = function()
            return {
                persistent = initPersistent
            }
        end,
        onChange = function(value)
            if not value then return end
            if type(value) ~= "table" then return end
            for optionKey, optionValue in pairs(value) do
                self:OnChange(optionKey, optionValue)
            end
        end,
        options = {
            {
                label = L["Persistent"],
                value = "persistent",
                type = "checkbox"
            },
        }
    }
    self.pinOptions:Setup(selectOptions)
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

---@type table<string, number>
local existingZoneNames = {}
---@type AnyMenuEntry[]
local MapHelperMenuTemplate = {}
---@param parentTable table
---@param children UiMapDetails[]
---@param parent UiMapDetails?
local function GenerateMenuTemplateFromMapData(parentTable, children, parent)
    if parent then
        table.insert(parentTable, {
            type = "button",
            label = parent.name,
            onClick = function(self)
                self.mapID:SetText(tostring(parent.mapID))
                self:OnChange('title', self.title:GetText())
            end
        })
        table.insert(parentTable, {
            type = "divider"
        })
    end
    for _, child in ipairs(children) do
        if C_Map.CanSetUserWaypointOnMap(child.mapID) then
            local mapName = child.name
            if existingZoneNames[mapName] then
                mapName = string.format("%s (%d)", mapName, existingZoneNames[mapName] + 1)
            end
            existingZoneNames[child.name] = (existingZoneNames[child.name] or 0) + 1
            local nextChildren = C_Map.GetMapChildrenInfo(child.mapID, 3)
            if nextChildren and #nextChildren > 0 then
                table.insert(parentTable, {
                    type = "submenu",
                    label = mapName,
                    entries = {}
                })
                local mapInfo = C_Map.GetMapInfo(child.mapID)
                GenerateMenuTemplateFromMapData(parentTable[#parentTable].entries, nextChildren, mapInfo)
            else
                table.insert(parentTable, {
                    type = "button",
                    label = mapName,
                    onClick = function(self)
                        self.mapID:SetText(tostring(child.mapID))
                        self:OnChange('title', self.title:GetText())
                    end
                })
            end
        end
    end
end
local continents = C_Map.GetMapChildrenInfo(947, 2) -- 947 is Azeroth, 2 is continent
GenerateMenuTemplateFromMapData(MapHelperMenuTemplate, continents)

function MapPinEnhancedSetEditorPinEntryMixin:OpenMapHelperMenu()
    MapPinEnhanced:GenerateMenu(self.mapID.mapSelection, MapHelperMenuTemplate)
end
