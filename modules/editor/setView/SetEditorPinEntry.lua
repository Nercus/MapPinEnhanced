-- Template: file://./SetEditorPinEntry.xml
---@class MapPinEnhanced
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
    self.title:SetText(pin.title)
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
end

function MapPinEnhancedSetEditorPinEntryMixin:SetupPinOptions(initPersistent)
    ---@type SelectOptions
    local selectOptions = {
        default = {
            persistent = false,
        },
        init = {
            persistent = initPersistent or false,
        },
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

local HBDData = MapPinEnhanced.HBD.mapData --[[@as table<number, HereBeDragonMapData>]]
---@type table<Enum.UIMapType, table<number, {mapData: HereBeDragonMapData, mapID: number}>>
local sortedByMapType = {}
for mapID, mapData in pairs(HBDData) do
    local mapType = mapData.mapType
    if not sortedByMapType[mapType] then
        sortedByMapType[mapType] = {}
    end
    if mapData.parent == 947 then
        table.insert(sortedByMapType[mapType], { mapData = mapData, mapID = mapID })
    end
end
local continents = sortedByMapType[Enum.UIMapType.Continent]


function MapPinEnhancedSetEditorPinEntryMixin:OpenMapHelperMenu()
    MenuUtil.CreateContextMenu(self.mapID.mapSelection, function(_, rootDescription)
        rootDescription:CreateTitle(L["Map Select"])
        ---@param menu SubMenuUtil
        ---@param children UiMapDetails[]
        ---@param parent UiMapDetails
        local function CreateSubMenu(menu, children, parent)
            assert(menu, "Menu is nil")
            assert(children, "Children is nil")
            assert(parent, "Parent is nil")

            ---@type table<string, number>
            local existingZoneNames = {}
            menu:CreateButton(parent.name, function()
                self.mapID:SetText(tostring(parent.mapID))
                self:OnChange('title', self.title:GetText())
            end)
            menu:CreateDivider()
            for _, child in ipairs(children) do
                if C_Map.CanSetUserWaypointOnMap(child.mapID) then
                    local mapName = child.name
                    if existingZoneNames[mapName] then
                        ---@type string
                        mapName = mapName .. " (" .. (existingZoneNames[mapName] + 1) .. ")"
                    end
                    ---@type SubMenuUtil
                    local sub
                    sub = menu:CreateButton(mapName, function()
                        self.mapID:SetText(tostring(child.mapID))
                        self:OnChange('title', self.title:GetText())
                    end) --[[@as SubMenuUtil]]
                    existingZoneNames[child.name] = (existingZoneNames[child.name] or 0) + 1
                    local nextChildren = C_Map.GetMapChildrenInfo(child.mapID, 3)
                    if nextChildren and #nextChildren > 0 then
                        local mapInfo = C_Map.GetMapInfo(child.mapID)
                        CreateSubMenu(sub, nextChildren, mapInfo)
                    end
                end
            end
        end

        ---@type table<string, number>
        local existingZoneNames = {}
        for _, continent in ipairs(continents) do
            local mapName = continent.mapData.name
            if existingZoneNames[mapName] then
                mapName = string.format("%s (%d)", mapName, existingZoneNames[mapName] + 1)
            end
            ---@type SubMenuUtil
            local sub = rootDescription:CreateButton(mapName, function()
                self.mapID:SetText(tostring(continent.mapID))
                self:OnChange('title', self.title:GetText())
            end)
            existingZoneNames[continent.mapData.name] = (existingZoneNames[mapName] or 0) + 1
            local children = C_Map.GetMapChildrenInfo(continent.mapID, 3)
            if children and #children > 0 then
                local mapInfo = C_Map.GetMapInfo(continent.mapID)
                CreateSubMenu(sub, children, mapInfo)
            end
        end
    end);
end
