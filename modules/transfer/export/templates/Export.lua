---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedExportWindowTemplate : MapPinEnhancedWindowTemplate
---@field textarea MapPinEnhancedTextareaTemplate
---@field exportTypeRadio MapPinEnhancedRadioGroupTemplate
---@field prefixRadio MapPinEnhancedRadioGroupTemplate
---@field description FontString
---@field summary FontString
---@field prefixLabel FontString
---@field warning FontString
---@field exportTarget ExportTarget?
---@field selectedExportType "way"|"serialized"
---@field selectedPrefix "/way"|"/mph"|"/mpe"
---@field output string
MapPinEnhancedExportWindowMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

---@alias ExportTarget MapPinEnhancedGroupMixin | MapPinEnhancedPinMixin
---@class SerializedExport
---@field version integer
---@field group SerializedExportGroup

---@class SerializedExportGroup
---@field name string?
---@field icon string|number?
---@field trackingMode GroupTrackingMode?
---@field pinOrder table<UUID, number>
---@field pins pinData[]

local L = MapPinEnhanced.L
local Groups = MapPinEnhanced:GetModule("Groups")

local exportOptions = {
    { label = L["Way commands"],    value = "way" },
    { label = L["Serialized data"], value = "serialized" },
}

local prefixOptions = {
    { label = "/way", value = "/way" },
    { label = "/mph", value = "/mph" },
    { label = "/mpe", value = "/mpe" },
}

---@param pinData SaveablePinData | pinData
---@param keepPinID boolean?
---@return pinData
local function CleanPinData(pinData, keepPinID)
    ---@type SaveablePinData | pinData
    local cleanPinData = CopyTable(pinData)
    if not keepPinID then
        cleanPinData.pinID = nil
    end
    cleanPinData.setTracked = nil
    ---@cast cleanPinData pinData
    return cleanPinData
end

local function AddPin(pins, pin)
    local pinData = pin.GetPinData and pin:GetPinData() or pin
    if pinData and pinData.mapID and pinData.x and pinData.y then
        table.insert(pins, pinData)
    end
end

---@param target ExportTarget
---@return pinData[]
local function GetPins(target)
    local pins = {}
    if target.classification == "pin" then
        AddPin(pins, target)
    elseif target.classification == "group" then
        for _, pinData in ipairs(target:GetAllPinData()) do AddPin(pins, pinData) end
    end
    return pins
end

---@param group MapPinEnhancedGroupMixin
---@return string?
local function GetExportedGroupName(group)
    if group:IsProtected() then return nil end
    return group:GetName()
end

---@return SerializedExport
function MapPinEnhancedExportWindowMixin:GetSerializedTarget()
    local target = self.exportTarget
    assert(target, "MapPinEnhancedExportWindowMixin:GetSerializedTarget: exportTarget is nil")

    if target.classification == "pin" then
        local group = target.group
        assert(group, "MapPinEnhancedExportWindowMixin:GetSerializedTarget: pin has no group")
        return {
            version = MapPinEnhanced.EXPORT_VERSION,
            group = {
                name = GetExportedGroupName(group),
                icon = group:GetIcon(),
                trackingMode = group:GetTrackingMode(),
                pinOrder = {},
                pins = { CleanPinData(target:GetPinData()) },
            },
        }
    end

    ---@type table<string, any>
    local data = CopyTable(target:GetSaveableData())
    data["source"] = nil
    data["hidden"] = nil
    data["groupType"] = nil
    data["pinArchive"] = nil
    data["groupID"] = nil
    data["name"] = GetExportedGroupName(target)
    data["trackingMode"] = target:GetTrackingMode()
    data["pinOrder"] = data["pinOrder"] or {}
    ---@cast data SerializedExportGroup

    for pinID, archivedPin in target:EnumerateArchivedPins() do
        data["pinOrder"][pinID] = archivedPin.order or GetTime()
    end

    ---@type pinData[]
    local cleanedPins = {}
    for _, pinData in ipairs(target:GetAllPinData()) do
        table.insert(cleanedPins, CleanPinData(pinData, true))
    end
    data.pins = cleanedPins
    return {
        version = MapPinEnhanced.EXPORT_VERSION,
        group = data,
    }
end

---@param pins pinData[]
function MapPinEnhancedExportWindowMixin:UpdateSummary(pins)
    ---@type table<number, boolean>
    local maps = {}
    for _, pinData in ipairs(pins) do maps[pinData.mapID] = true end
    local mapCount = 0
    for _ in pairs(maps) do mapCount = mapCount + 1 end
    self.summary:SetText(string.format(L["Exporting %d pins across %d maps"], #pins, mapCount))
end

function MapPinEnhancedExportWindowMixin:UpdateOutput()
    if not self.exportTarget then return end
    local pins = GetPins(self.exportTarget)
    ---@type string
    local output
    if self.selectedExportType == "serialized" then
        output = MapPinEnhanced:SerializeData(self:GetSerializedTarget())
    else
        local lines = {}
        for _, pinData in ipairs(pins) do
            table.insert(lines, MapPinEnhanced:SerializeWayLine(pinData, self.selectedPrefix))
        end
        output = table.concat(lines, "\n")
    end

    self.output = output
    self.textarea:SetValue(output)
    self.textarea.editbox:HighlightText()
    self:UpdateSummary(pins)

    local losesStyle = false
    for _, pinData in ipairs(pins) do
        if pinData.texture or pinData.color then
            losesStyle = true
            break
        end
    end
    self.warning:SetShown(self.selectedExportType == "way" and losesStyle)
    self.prefixRadio:SetShown(self.selectedExportType == "way")
    self.prefixLabel:SetShown(self.selectedExportType == "way")
end

---@param target ExportTarget
function MapPinEnhancedExportWindowMixin:SetExportTarget(target)
    assert(target, "MapPinEnhancedExportWindowMixin:SetExportTarget: target is nil")
    self.exportTarget = target
    if self.textarea then self:UpdateOutput() end
end

function MapPinEnhancedExportWindowMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)
    self.description:SetText(L["Choose an export format, then copy the text below."])
    self.prefixLabel:SetText(L["Command prefix:"])
    self.warning:SetText(L["Warning: /way commands only preserve pin titles. Custom icons and colors will be lost."])
    self.textarea:Setup({ onChange = function() end })
    self.textarea.editbox:SetScript("OnTextChanged", function(_, userInput)
        if userInput then
            self.textarea:SetValue(self.output or "")
            self.textarea.editbox:HighlightText()
        end
    end)
    self.textarea.editbox:HookScript("OnEditFocusGained", function(editbox)
        editbox:HighlightText()
    end)
    self.exportTypeRadio:Setup({
        options = exportOptions,
        orientation = "horizontal",
        init = function() return "way" end,
        onChange = function(value)
            self.selectedExportType = value
            self:UpdateOutput()
        end,
    })
    self.prefixRadio:Setup({
        options = prefixOptions,
        orientation = "horizontal",
        init = function() return "/way" end,
        onChange = function(value)
            self.selectedPrefix = value
            self:UpdateOutput()
        end,
    })
    self.selectedExportType = "way"
    self.selectedPrefix = "/way"
end
