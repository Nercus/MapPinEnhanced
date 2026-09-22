---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Transfer
local Transfer = MapPinEnhanced:GetModule("Transfer")

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

---@param group MapPinEnhancedGroupMixin
---@return string?
local function GetExportedGroupName(group)
    if group:IsProtected() then return nil end
    return group:GetName()
end

---@param target ExportTarget
---@return SerializedExport
function Transfer:GetSerializedTarget(target)
    assert(target, "Transfer:GetSerializedTarget: target is nil")
    if target.classification == "pin" then
        local group = target.group
        assert(group, "Transfer:GetSerializedTarget: pin has no group")
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
    local exportGroup = CopyTable(target:GetSaveableData())
    exportGroup["source"] = nil
    exportGroup["hidden"] = nil
    exportGroup["groupType"] = nil
    exportGroup["pinArchive"] = nil
    exportGroup["groupID"] = nil
    exportGroup["name"] = GetExportedGroupName(target)
    exportGroup["trackingMode"] = target:GetTrackingMode()
    exportGroup["pinOrder"] = exportGroup["pinOrder"] or {}
    ---@cast exportGroup SerializedExportGroup

    for pinID, archivedPin in target:EnumerateArchivedPins() do
        exportGroup["pinOrder"][pinID] = archivedPin.order or GetTime()
    end

    ---@type pinData[]
    local cleanedPins = {}
    for _, pinData in ipairs(target:GetAllPinData()) do
        table.insert(cleanedPins, CleanPinData(pinData, true))
    end
    exportGroup.pins = cleanedPins
    return {
        version = MapPinEnhanced.EXPORT_VERSION,
        group = exportGroup,
    }
end
