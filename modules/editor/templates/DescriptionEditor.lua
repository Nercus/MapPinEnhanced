---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Editor
local Editor = MapPinEnhanced:GetModule("Editor")
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L

---@class MapPinEnhancedDescriptionEditorTemplate : MapPinEnhancedWindowTemplate
---@field input MapPinEnhancedTextareaTemplate
---@field heading FontString
---@field info FontString
---@field groupID UUID?
---@field pinID UUID?
MapPinEnhancedDescriptionEditorMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

function MapPinEnhancedDescriptionEditorMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)
    self:SetTitle(L["Description"])
    self.heading:SetText(L["Edit Description"])
    self.info:SetText(L["Add notes for this pin. Descriptions appear in pin tooltips and below the wayfinder title."])
    self.input.editbox:SetMaxLetters(0)
    self.input.editbox:SetText("")
end

---@param groupID UUID
---@param pinID UUID
function MapPinEnhancedDescriptionEditorMixin:Open(groupID, pinID)
    self:Hide()
    local group = Groups:GetGroupByID(groupID)
    local pin = group and group:GetPinByID(pinID)
    local archived = group and group:GetArchivedPinByID(pinID)
    local data = pin and pin:GetPinData() or archived and archived.data
    if not data then return end
    self.groupID, self.pinID = groupID, pinID
    self.input.editbox:SetScript("OnEscapePressed", function() self:Hide() end)
    self.input.editbox:SetText(data.description or "")
    self:Show()
    self.input:SetVerticalScroll(0)
    self.input.editbox:SetFocus()
end

function MapPinEnhancedDescriptionEditorMixin:Apply()
    local group = self.groupID and Groups:GetGroupByID(self.groupID)
    -- Resolve IDs again: neither a pooled row nor a pooled Pin owns the draft.
    if not group or not self.pinID or not group:SetPinDescription(self.pinID, self.input.editbox:GetText()) then
        MapPinEnhanced:Notify(L["This pin is no longer in this group."], "ERROR")
    end
    self:Hide()
end

function MapPinEnhancedDescriptionEditorMixin:OnHide()
    self.input.editbox:SetScript("OnEscapePressed", nil)
    self.input.editbox:ClearFocus()
    self.input.editbox:SetText("")
    self.groupID, self.pinID = nil, nil
    MapPinEnhancedWindowMixin.OnHide(self)
end

---@type MapPinEnhancedDescriptionEditorTemplate?
local dialog

---@param groupID UUID
---@param pinID UUID
function Editor:EditDescription(groupID, pinID)
    if not dialog then
        dialog = CreateFrame("Frame", "MapPinEnhancedDescriptionEditor", self:GetGroupEditorFrame(),
            "MapPinEnhancedDescriptionEditorTemplate")
    end
    dialog:Open(groupID, pinID)
end

function Editor:CloseDescriptionEditor()
    if dialog then dialog:Hide() end
end
