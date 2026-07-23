---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Collections = MapPinEnhanced:GetModule("Collections")

---@class MapPinEnhancedEditorCollectionListTemplate : Frame
---@field searchBox MapPinEnhancedInputTemplate
---@field scrollBox WowScrollBoxList
---@field scrollBar MinimalScrollBar

---@param collection1 MapPinEnhancedCollectionMixin
---@param collection2 MapPinEnhancedCollectionMixin
---@return boolean
local function CollectionSortComparator(collection1, collection2)
    return (collection1:GetName() or "") < (collection2:GetName() or "")
end

function MapPinEnhancedEditorMixin:SetupCollectionList()
    self.dataProvider = CreateDataProvider()

    local scrollView = CreateScrollBoxListLinearView()
    scrollView:SetElementInitializer("MapPinEnhancedEditorCollectionEntryTemplate", function(entry, collection)
        ---@cast entry MapPinEnhancedEditorCollectionEntryTemplate
        ---@cast collection MapPinEnhancedCollectionMixin
        entry:Init(collection, self)
    end)
    scrollView:SetElementResetter(function(entry)
        ---@cast entry MapPinEnhancedEditorCollectionEntryTemplate
        entry:Reset()
    end)
    scrollView:SetDataProvider(self.dataProvider)

    self.collectionList.scrollBar:SetInterpolateScroll(true)
    self.collectionList.scrollBox:SetInterpolateScroll(true)
    self.collectionList.scrollBar:SetHideIfUnscrollable(true)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.collectionList.scrollBox, self.collectionList.scrollBar, scrollView)

    self.collectionList.searchBox:Setup({
        onChange = function()
            self:UpdateCollectionList()
        end,
    })
end

function MapPinEnhancedEditorMixin:UpdateCollectionList()
    local searchText = self.collectionList.searchBox:GetText() or ""

    self.dataProvider:Flush()
    if searchText == "" then
        ---@param collection MapPinEnhancedCollectionMixin
        for collection in Collections:EnumerateCollections() do
            self.dataProvider:Insert(collection)
        end
        self.dataProvider:SetSortComparator(CollectionSortComparator, false)
        return
    end

    ---@type MapPinEnhancedCollectionMixin[]
    local collections = {}
    ---@type string[]
    local collectionNames = {}

    ---@param collection MapPinEnhancedCollectionMixin
    for collection in Collections:EnumerateCollections() do
        table.insert(collections, collection)
        table.insert(collectionNames, collection:GetName() or "")
    end

    local results = MapPinEnhanced:Filter(searchText, collectionNames, false)
    for _, result in ipairs(results) do
        self.dataProvider:Insert(collections[result.i])
    end
end

---@param collection MapPinEnhancedCollectionMixin
---@return boolean
function MapPinEnhancedEditorMixin:IsCollectionSelected(collection)
    return self.selectedCollection == collection
end

---@param collection MapPinEnhancedCollectionMixin?
function MapPinEnhancedEditorMixin:SetSelectedCollection(collection)
    self:ClearPinDragState()
    self.selectedCollection = collection
    self:UpdateSelectedCollectionEditor()
    self:UpdateCollectionSelection()
end

---@param collection MapPinEnhancedCollectionMixin
function MapPinEnhancedEditorMixin:ToggleSelectedCollection(collection)
    if self:IsCollectionSelected(collection) then
        self:SetSelectedCollection(nil)
    else
        self:SetSelectedCollection(collection)
    end
end

function MapPinEnhancedEditorMixin:UpdateCollectionSelection()
    self.collectionList.scrollBox:ForEachFrame(function(frame)
        ---@cast frame MapPinEnhancedEditorCollectionEntryTemplate
        frame:SetSelected(frame.collection and self:IsCollectionSelected(frame.collection) or false)
    end)
end
