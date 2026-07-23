---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedEditorCollectionEntryTemplate : Button
---@field collection MapPinEnhancedCollectionMixin?
---@field editor MapPinEnhancedEditorTemplate?
---@field ring Texture
---@field title FontString
---@field pinCount FontString
---@field border Texture
MapPinEnhancedEditorCollectionEntryMixin = {}

local L = MapPinEnhanced.L

function MapPinEnhancedEditorCollectionEntryMixin:Reset()
    self.collection = nil
    self.editor = nil
    self:SetSelected(false)
end

---@param collection MapPinEnhancedCollectionMixin
---@param editor MapPinEnhancedEditorTemplate
function MapPinEnhancedEditorCollectionEntryMixin:Init(collection, editor)
    self.collection = collection
    self.editor = editor
    self.title:SetText(collection:GetName())
    self.pinCount:SetText(string.format(L["%d |4pin:pins;"], collection:GetPinCount()))
    self:SetSelected(editor:IsCollectionSelected(collection))
end

local selectedColor = CreateColor(1, 0.82, 0)
local unselectedColor = CreateColor(1, 1, 1)

---@param selected boolean
function MapPinEnhancedEditorCollectionEntryMixin:SetSelected(selected)
    self.ring:SetAtlas(selected and "pet-list_active-ring" or "pet-list_default-ring")
    self.ring:SetDesaturated(not selected)
    local color = selected and selectedColor or unselectedColor
    self.border:SetVertexColor(color.r, color.g, color.b)
end

function MapPinEnhancedEditorCollectionEntryMixin:OnClick(button)
    if button ~= "LeftButton" or not self.collection or not self.editor then return end
    self.editor:ToggleSelectedCollection(self.collection)
end
