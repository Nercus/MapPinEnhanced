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
---@field pins PortablePinData[]

---@class PortablePinData : pinData
---@field pinID UUID?

---@type table<string, boolean>
local PORTABLE_PIN_FIELDS = {
    mapID = true,
    x = true,
    y = true,
    title = true,
    description = true,
    texture = true,
    usesAtlas = true,
    color = true,
    lock = true,
    pinID = true,
}

---Copy only portable scalar fields; unknown nested data never enters the preview.
---@param data pinData|SaveablePinData
---@return PortablePinData
function Transfer:CopyPortablePin(data)
    ---@cast data PortablePinData
    return {
        mapID = data.mapID,
        x = data.x,
        y = data.y,
        title = data.title,
        description = data.description,
        texture = data.texture,
        usesAtlas = data.usesAtlas,
        color = data.color,
        lock = data.lock,
        pinID = data.pinID,
    }
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
    ---@type MapPinEnhancedGroupMixin?
    local group
    if target.classification == "pin" then group = target.group else group = target end
    assert(group, "Transfer:GetSerializedTarget: pin has no group")
    ---@cast group MapPinEnhancedGroupMixin
    ---@type SerializedExportGroup
    local exportGroup = {
        name = GetExportedGroupName(group),
        icon = group:GetIcon(),
        trackingMode = group:GetTrackingMode(),
        pinOrder = {},
        pins = {},
    }
    if target.classification == "pin" then
        local data = self:CopyPortablePin(target:GetPinData())
        data.pinID = nil
        exportGroup.pins[1] = data
    else
        -- Capture once without yielding. Entries already own copies, including
        -- archived data; reuse them instead of copying the saved group and pins.
        for _, entry in ipairs(group:GetPinEntries()) do
            local data = entry.data
            local fields = data --[[@as table<string, any>]]
            for key in pairs(fields) do
                if not PORTABLE_PIN_FIELDS[key] then fields[key] = nil end
            end
            exportGroup.pins[#exportGroup.pins + 1] = fields --[[@as PortablePinData]]
            exportGroup.pinOrder[entry.pinID] = entry.order
        end
    end
    return { version = MapPinEnhanced.EXPORT_VERSION, group = exportGroup }
end
