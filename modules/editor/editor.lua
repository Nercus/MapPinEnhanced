---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Editor
---@field EditGroup fun(self: Editor, group: MapPinEnhancedGroupMixin)
local Editor = MapPinEnhanced:GetModule("Editor")
local L = MapPinEnhanced.L

Editor.DEFAULT_GROUP_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"

---@param group MapPinEnhancedGroupMixin
---@return boolean
function Editor:ShouldShowGroup(group)
    return not group:IsProtected()
end

---@param group MapPinEnhancedGroupMixin
---@return boolean
function Editor:ShouldShowSystemGroup(group)
    return group.groupType == "ungrouped" or group.groupType == "way-back"
end

---@param value string|number|nil
---@return number?
function Editor:ParsePercent(value)
    if type(value) == "string" and not value:match("^%d*%.?%d*$") then return nil end
    local numberValue = tonumber(value)
    if not numberValue or not (numberValue >= 0 and numberValue <= 100) then return nil end
    return numberValue / 100
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@return pinData
function Editor:GetPinData(pinNode)
    if pinNode.pin then return pinNode.pin:GetPinData() end
    local archivedPin = pinNode.group:GetArchivedPinByID(pinNode.pinID)
    return archivedPin and archivedPin.data or pinNode.pinData
end

---@param group MapPinEnhancedGroupMixin
---@return MapPinEnhancedEditorPinNodeData[]
function Editor:GetSortedPins(group)
    ---@type MapPinEnhancedEditorPinNodeData[]
    local nodes = {}
    for _, entry in ipairs(group:GetPinEntries()) do
        table.insert(nodes, {
            classification = "editorPin",
            group = group,
            pin = entry.pin,
            pinID = entry.pinID,
            pinData = entry.data,
            archiveState = entry.state ~= "active" and entry.state or nil,
            order = entry.order,
        })
    end
    table.sort(nodes, function(a, b)
        if (a.order or 0) ~= (b.order or 0) then return (a.order or 0) > (b.order or 0) end
        return ((self:GetPinData(a).title or "") < (self:GetPinData(b).title or ""))
    end)
    return nodes
end

---@class MapPinEnhancedEditorMapEntry
---@field mapID number
---@field name string

local mapCacheReady = false
---@type table<number, MapPinEnhancedEditorMapEntry>
local mapCache = {}
---@type MapPinEnhancedEditorMapEntry[]
local mapNames = {}
---@type AutocompleteOption[]
local mapOptions = {}
local nextMapID = 1
---@type fun()?
local cancelMapCache

---@return AutocompleteOption[]? options nil while the editor owns a pending build
function Editor:GetMapOptions()
    if mapCacheReady then return mapOptions end
    if cancelMapCache or not self:IsShown() then return nil end
    cancelMapCache = MapPinEnhanced:BatchExecution({ function()
        local checkpoint = MapPinEnhanced:CreateBatchCheckpoint()
        -- Sparse IDs retain the existing catalogue bounds. Only complete options
        -- reach rows; closing the editor pauses this session's one-time scan.
        while nextMapID <= 5000 do
            local mapID = nextMapID
            local mapInfo = C_Map.GetMapInfo(mapID)
            if mapInfo and mapInfo.name and mapInfo.name ~= "" then
                local entry = { mapID = mapID, name = mapInfo.name }
                mapCache[mapID] = entry
                table.insert(mapNames, entry)
                table.insert(mapOptions, {
                    label = string.format("%s (%d)", mapInfo.name, mapID),
                    description = tostring(mapID),
                    searchString = mapInfo.name .. " " .. mapID,
                    value = mapID,
                })
            end
            nextMapID = mapID + 1
            checkpoint()
        end
    end }, nil, function()
        cancelMapCache = nil
        mapCacheReady = true
        self:GetGroupEditorFrame():RequestRefresh()
    end, nil, function(message)
        cancelMapCache = nil
        geterrorhandler()(message)
    end)
    return nil
end

function Editor:CancelMapOptions()
    if cancelMapCache then cancelMapCache() end
    cancelMapCache = nil
end

---@param mapID number
---@return string
function Editor:GetMapDisplay(mapID)
    local entry = mapCache[mapID]
    return entry and string.format("%s (%d)", entry.name, mapID) or tostring(mapID or "")
end

---@param text string
---@return number?
function Editor:FindExactMap(text)
    local mapID = tonumber(text:match("^%s*(%d+)%s*$") or text:match("%((%d+)%)%s*$"))
    if mapID and mapCache[mapID] then return mapID end
    local lowered = string.lower(strtrim(text))
    ---@type number?
    local match
    for _, entry in ipairs(mapNames) do
        if string.lower(entry.name) == lowered then
            if match then return nil end
            match = entry.mapID
        end
    end
    return match
end

function Editor:GetGroupEditorFrame()
    if not self.groupEditor then
        self.groupEditor = CreateFrame("Frame", "MapPinEnhancedGroupEditor", UIParent,
            "MapPinEnhancedGroupEditorTemplate")
    end
    return self.groupEditor
end

function Editor:ShowEditor()
    local frame = self:GetGroupEditorFrame()
    frame:ShowFrame()
end

---@param group MapPinEnhancedGroupMixin
function Editor:EditGroup(group)
    assert(type(group) == "table" and group.classification == "group", "Editor:EditGroup requires a group")
    if not self:ShouldShowGroup(group) and not self:ShouldShowSystemGroup(group) then return end
    local frame = self:GetGroupEditorFrame()
    frame:ShowFrame()
    frame:SelectGroup(group)
end

function Editor:HideEditor()
    local frame = self:GetGroupEditorFrame()
    if frame:IsShown() then
        frame:HideFrame()
    end
end

function Editor:IsShown()
    local frame = self:GetGroupEditorFrame()
    return frame and frame:IsShown() and not frame.visibilityFadeOut:IsPlaying() or false
end

MapPinEnhanced:AddSlashCommand({ "editor", L["Editor"]:lower() }, function()
    if Editor:IsShown() then
        Editor:HideEditor()
    else
        Editor:ShowEditor()
    end
end, L["Toggle the group editor."])
