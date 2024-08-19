-- Template: file://./SetEditorBodyHeader.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L
local CB = MapPinEnhanced.CB

---@class MapPinEnhancedSetEditorBodyHeaderMixin : Frame
---@field setName SetEditorSetNameEditBox
---@field deleteButton MapPinEnhancedSquareButton
---@field exportButton MapPinEnhancedSquareButton
---@field importFromMapButton MapPinEnhancedSquareButton
---@field bg Texture
---@field infoText FontString
MapPinEnhancedSetEditorBodyHeaderMixin = {}

---@class SetEditorSetNameEditBox : EditBox
---@field editButton MapPinEnhancedSquareButton

---@param mode 'info' | 'editor
function MapPinEnhancedSetEditorBodyHeaderMixin:SetMode(mode)
    assert(mode, "No mode")
    self.setName:SetShown(mode ~= "info")
    self.deleteButton:SetShown(mode ~= "info")
    self.exportButton:SetShown(mode ~= "info")
    self.importFromMapButton:SetShown(mode ~= "info")
    self.infoText:SetShown(mode == "info")
    self.mode = mode
end

function MapPinEnhancedSetEditorBodyHeaderMixin:ImportFromMap()
    local PinManager = MapPinEnhanced:GetModule("PinManager")
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    local activeSet = self.body:GetActiveSet()
    if not activeSet then return end
    local pins = PinManager:GetPins()
    for _, pin in pairs(pins) do
        activeSet:AddPin({
            mapID = pin.pinData.mapID,
            x = pin.pinData.x,
            y = pin.pinData.y,
            title = pin.pinData.title,
            color = pin.pinData.color,
            persistent = pin.pinData.persistent,
            setTracked = pin.pinData.setTracked,
            texture = pin.pinData.texture,
            usesAtlas = pin.pinData.usesAtlas,
        }, true)
    end
    SetManager:PersistSets(activeSet.setID)
    self.body:UpdatePinList()
end

function MapPinEnhancedSetEditorBodyHeaderMixin:UpdateSetName()
    if self.mode == "info" then return end
    local set = self.body:GetActiveSet()
    local setName = ""
    if set then
        setName = set.name
    end
    self.setName:SetText(setName)
    self.setName:SetCursorPosition(0)
    self.setName:Disable()
end

function MapPinEnhancedSetEditorBodyHeaderMixin:OnChangeSetName()
    if not self.body.activeEditorSet then return end
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    SetManager:UpdateSetNameByID(self.body.activeEditorSet, self.setName:GetText())
end

function MapPinEnhancedSetEditorBodyHeaderMixin:SetInfoText(text)
    if self.mode == "editor" then return end
    self.infoText:SetText(text)
end

function MapPinEnhancedSetEditorBodyHeaderMixin:DeleteSet()
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    SetManager:DeleteSet(self.body.activeEditorSet)
    self.body:SetActiveEditorSetID()
    CB:Fire('UpdateSetList')
end

function MapPinEnhancedSetEditorBodyHeaderMixin:OnLoad()
    self.body = self:GetParent() --[[@as MapPinEnhancedSetEditorViewBodyMixin]]
    self.deleteButton.tooltip = L["Delete Set"]
    self.exportButton.tooltip = L["Export Set"]
    self.setName.editButton.tooltip = L["Edit Set Name"]
    self.importFromMapButton.tooltip = L["Import Pins from Tracker"]

    self.setName:SetScript("OnTextChanged", function() self:OnChangeSetName() end)
    self.exportButton:SetScript("OnClick", function() self.body.importExportFrame:ShowExportFrame() end)
    self.importFromMapButton:SetScript("OnClick", function() self:ImportFromMap() end)
    self.deleteButton:SetScript("OnClick", function()
        if IsShiftKeyDown() then
            self:DeleteSet()
            return
        end
        MapPinEnhanced:ShowPopup({
            text = L["Are you sure you want to delete this set?"],
            onAccept = function()
                self:DeleteSet()
            end
        })
    end)

    local function StartMoving()
        MapPinEnhanced.editorWindow:StartMoving()
        SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
    end
    self:SetScript("OnMouseDown", StartMoving)

    local function StopMoving()
        MapPinEnhanced.editorWindow:StopMovingOrSizing()
        SetCursor(nil)
    end
    self:SetScript("OnMouseUp", StopMoving)
end

---------------------------------------------------------------------------
