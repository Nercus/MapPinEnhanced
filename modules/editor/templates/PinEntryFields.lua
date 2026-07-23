---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@type AutocompleteOption[]?
local mapOptions

local function GetMapOptions()
    if mapOptions then return mapOptions end

    mapOptions = {}
    for mapID, mapData in pairs(MapPinEnhanced.HBD.mapData) do
        local mapName = mapData.name
        if not mapName or mapName == "" then
            local mapInfo = C_Map.GetMapInfo(mapID)
            mapName = mapInfo and mapInfo.name
        end
        if mapName and mapName ~= "" then
            table.insert(mapOptions, {
                label = mapName .. " (#" .. tostring(mapID) .. ")",
                description = tostring(mapID),
                searchString = mapName .. " " .. tostring(mapID),
                value = mapID,
            })
        end
    end

    table.sort(mapOptions, function(a, b)
        return a.label < b.label
    end)

    return mapOptions
end

local function ToCoordinateValue(text)
    local value = tonumber((text or ""):gsub(",", "."))
    if not value then return end
    value = math.max(0, math.min(100, value))
    return value / 100
end

function MapPinEnhancedEditorPinEntryMixin:SetupFields()
    local pinData = self.pinData
    local editor = self.editor
    if not pinData or not editor then return end

    self.titleInput:Setup({
        init = function() return pinData.title or "" end,
        onChange = function(title)
            if title == "" then
                pinData.title = nil
            else
                pinData.title = title
            end
            editor:PersistSelectedCollection()
        end,
    })
    self.titleInput:SetPlaceholderText(L["Pin Title"])

    self.mapInput:Setup({
        options = GetMapOptions(),
        init = function() return pinData.mapID end,
        onChange = function(option)
            if not option then return end
            pinData.mapID = option.value
            editor:PersistSelectedCollection()
        end,
    })
    self.mapInput:SetPlaceholderText(L["Map"])

    self.xInput:Setup({
        init = function()
            return pinData.x and string.format("%.2f", pinData.x * 100) or ""
        end,
        onChange = function(text)
            local value = ToCoordinateValue(text)
            if value then
                pinData.x = value
                editor:PersistSelectedCollection()
            end
        end,
    })
    self.xInput:SetPlaceholderText(L["X"])

    self.yInput:Setup({
        init = function()
            return pinData.y and string.format("%.2f", pinData.y * 100) or ""
        end,
        onChange = function(text)
            local value = ToCoordinateValue(text)
            if value then
                pinData.y = value
                editor:PersistSelectedCollection()
            end
        end,
    })
    self.yInput:SetPlaceholderText(L["Y"])

    self.tooltipInput:Setup({
        init = function()
            return pinData.tooltip and pinData.tooltip.text or ""
        end,
        onChange = function(text)
            if text == "" then
                if pinData.tooltip then
                    pinData.tooltip.text = nil
                    if not pinData.tooltip.title then
                        pinData.tooltip = nil
                    end
                end
            else
                pinData.tooltip = pinData.tooltip or {}
                pinData.tooltip.text = text
            end
            editor:PersistSelectedCollection()
        end,
    })
    self.tooltipInput:SetPlaceholderText(L["Tooltip Description"])

    self.lockCheckbox:Setup({
        init = function() return pinData.lock or false end,
        onChange = function(isChecked)
            pinData.lock = isChecked or nil
            self.pinTexture:SetLock(pinData.lock)
            editor:PersistSelectedCollection()
        end,
    })
    self.lockCheckbox:SetLabel(L["Locked"])
    self.lockCheckbox.text:ClearAllPoints()
    self.lockCheckbox.text:SetPoint("LEFT", self.lockCheckbox.NormalTexture, "RIGHT", 1, 0)
end
