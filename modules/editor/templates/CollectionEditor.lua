---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

local Collections = MapPinEnhanced:GetModule("Collections")

local COLLECTION_ICON_MENU_COLUMNS = 4
local COLLECTION_ICON_MENU_ENTRY_SIZE = 36
local DEFAULT_COLLECTION_ICON = MapPinEnhanced.assetsPath .. "\\icons\\IconCollections_Yellow.png"

---@class MapPinEnhancedEditorCollectionEditorTemplate : Frame
---@field editor MapPinEnhancedEditorCollectionEditorControlsTemplate
---@field emptyState FontString

---@class MapPinEnhancedEditorCollectionEditorControlsTemplate : Frame
---@field titleInput MapPinEnhancedInputTemplate
---@field iconButton MapPinEnhancedIconButtonTemplate
---@field saveButton MapPinEnhancedIconButtonTemplate
---@field deleteButton MapPinEnhancedIconButtonTemplate
---@field pinList MapPinEnhancedEditorPinListTemplate
---@field fadeIn MapPinEnhancedAnimationVisibilityMixin
---@field fadeOut MapPinEnhancedAnimationVisibilityMixin

---@type PinIcon[]
local COLLECTION_ICONS = {
    { path = MapPinEnhanced.assetsPath .. "\\icons\\IconCollections_Yellow.png", usesAtlas = false },
    { path = MapPinEnhanced.assetsPath .. "\\icons\\IconPin_Yellow.png",         usesAtlas = false },
    { path = MapPinEnhanced.assetsPath .. "\\icons\\IconMap_Yellow.png",         usesAtlas = false },
    { path = MapPinEnhanced.assetsPath .. "\\icons\\IconImport_Yellow.png",      usesAtlas = false },
    { path = MapPinEnhanced.assetsPath .. "\\icons\\IconExport_Yellow.png",      usesAtlas = false },
    { path = MapPinEnhanced.assetsPath .. "\\icons\\IconEditor_Yellow.png",      usesAtlas = false },
    { path = MapPinEnhanced.assetsPath .. "\\icons\\IconSettings_Yellow.png",    usesAtlas = false },
    { path = MapPinEnhanced.assetsPath .. "\\icons\\IconTick_Yellow.png",        usesAtlas = false },
}

function MapPinEnhancedEditorMixin:SetupCollectionEditor()
    self.collectionEditor.emptyState:SetText(L["Select a collection to edit."])
    local editor = self.collectionEditor.editor
    editor.titleInput:Setup({
        onChange = function() end,
    })
    editor.titleInput:SetPlaceholderText(L["Collection Title"])
    editor.titleInput:SetScript("OnEnterPressed", function()
        self:SaveSelectedCollection()
    end)

    editor.iconButton:SetScript("OnClick", function()
        if self.selectedCollection then
            self:ShowCollectionIconMenu()
        end
    end)

    editor.saveButton:SetScript("OnClick", function()
        self:SaveSelectedCollection()
    end)

    editor.deleteButton:SetScript("OnClick", function()
        self:DeleteSelectedCollection()
    end)

    self:SetupPinList()
    self:UpdateSelectedCollectionEditor()
end

function MapPinEnhancedEditorMixin:PersistSelectedCollection()
    if not self.selectedCollection then return end
    Collections:PersistCollection(self.selectedCollection)
end

function MapPinEnhancedEditorMixin:GetCollectionIcon()
    if self.pendingCollectionIcon then
        return self.pendingCollectionIcon
    end
    if not self.selectedCollection then
        return DEFAULT_COLLECTION_ICON
    end
    return self.selectedCollection:GetIcon() or DEFAULT_COLLECTION_ICON
end

---@param icon string
function MapPinEnhancedEditorMixin:SetCollectionIconTexture(icon)
    self.collectionEditor.editor.iconButton.iconTexture:SetTexture(icon)
end

---@param enabled boolean
function MapPinEnhancedEditorMixin:SetCollectionEditorEnabled(enabled)
    local editor = self.collectionEditor.editor
    if enabled then
        editor.titleInput:Enable()
    else
        editor.titleInput:Disable()
    end
    editor.iconButton:SetEnabled(enabled)
    editor.saveButton:SetEnabled(enabled)
    editor.deleteButton:SetEnabled(enabled)

    self.collectionEditor.emptyState:SetShown(not enabled)
    if enabled then
        local shouldFadeIn = not editor:IsShown() or editor.fadeOut:IsPlaying()
        if editor.fadeOut:IsPlaying() then
            editor.fadeOut:Stop()
        end
        if shouldFadeIn then
            if editor.fadeIn:IsPlaying() then
                editor.fadeIn:Stop()
            end
            editor.fadeIn:Play()
        end
    elseif editor:IsShown() then
        if editor.fadeIn:IsPlaying() then
            editor.fadeIn:Stop()
        end
        editor.fadeOut:Play()
    end
end

function MapPinEnhancedEditorMixin:UpdateSelectedCollectionEditor()
    if not self.selectedCollection then
        self.pendingCollectionIcon = nil
        self.collectionEditor.editor.titleInput:SetValue("", false)
        self:SetCollectionIconTexture(DEFAULT_COLLECTION_ICON)
        self:SetCollectionEditorEnabled(false)
        self:UpdatePinList()
        return
    end

    self:SetCollectionEditorEnabled(true)
    self.pendingCollectionIcon = self.selectedCollection:GetIcon() or DEFAULT_COLLECTION_ICON
    self.collectionEditor.editor.titleInput:SetValue(self.selectedCollection:GetName() or "", false)
    self:SetCollectionIconTexture(self:GetCollectionIcon())
    self:UpdatePinList()
end

function MapPinEnhancedEditorMixin:BuildCollectionIconMenu()
    local iconMenu = {}
    for _, icon in ipairs(COLLECTION_ICONS) do
        local iconData = icon
        table.insert(iconMenu, {
            type = "template",
            template = "MapPinEnhancedMenuRadioCellTemplate",
            data = {
                owner = self,
                icon = iconData,
                isSelected = function()
                    return self:GetCollectionIcon() == iconData.path
                end,
                onClick = function()
                    if not self.selectedCollection then return end
                    self.pendingCollectionIcon = iconData.path
                    self:SetCollectionIconTexture(iconData.path)
                end,
            },
            initializer = function(_, _, menu)
                menu.minimumElementWidth = COLLECTION_ICON_MENU_ENTRY_SIZE
                return COLLECTION_ICON_MENU_ENTRY_SIZE, COLLECTION_ICON_MENU_ENTRY_SIZE
            end,
        })
    end
    return iconMenu
end

function MapPinEnhancedEditorMixin:ShowCollectionIconMenu()
    MapPinEnhanced:GenerateMenu(self.collectionEditor.editor.iconButton, self:BuildCollectionIconMenu(), {
        gridModeColumns = COLLECTION_ICON_MENU_COLUMNS,
    })
end

function MapPinEnhancedEditorMixin:SaveSelectedCollection()
    if not self.selectedCollection then return end

    local title = strtrim(self.collectionEditor.editor.titleInput:GetText() or "")
    if title == "" then
        title = self.selectedCollection:GetName()
    end

    local existingCollection = Collections:GetCollectionByName(title)
    if existingCollection and existingCollection ~= self.selectedCollection then
        MapPinEnhanced:Notify(string.format(L["A collection named \"%s\" already exists."], title), "ERROR")
        self.collectionEditor.editor.titleInput:SetValue(self.selectedCollection:GetName() or "", false)
        return
    end

    self.selectedCollection:SetName(title)
    if self.pendingCollectionIcon then
        self.selectedCollection:SetIcon(self.pendingCollectionIcon)
    end
    self:UpdateCollectionList()
    self:UpdateCollectionSelection()
end

function MapPinEnhancedEditorMixin:DeleteSelectedCollection()
    if not self.selectedCollection then return end

    local collection = self.selectedCollection
    self:SetSelectedCollection(nil)
    Collections:DeleteCollection(collection)
    self:UpdateCollectionList()
end
