---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

local Dialog = MapPinEnhanced:GetModule("Dialog")
local Events = MapPinEnhanced:GetModule("Events")


---@class MapPinEnhancedWindowSetBodyHeaderMixin : Frame
---@field setName SetEditorSetNameEditBox
---@field deleteButton MapPinEnhancedSquareButton
---@field exportButton MapPinEnhancedSquareButton
---@field importFromMapButton MapPinEnhancedSquareButton
---@field bg Texture
---@field infoText FontString
MapPinEnhancedWindowSetBodyHeaderMixin = {}

---@class SetEditorSetNameEditBox : EditBox
---@field editButton MapPinEnhancedSquareButton

---@param mode 'info' | 'editor
function MapPinEnhancedWindowSetBodyHeaderMixin:SetMode(mode)
    assert(mode, "No mode")
    self.setName:SetShown(mode ~= "info")
    self.deleteButton:SetShown(mode ~= "info")
    self.exportButton:SetShown(mode ~= "info")
    self.importFromMapButton:SetShown(mode ~= "info")
    self.infoText:SetShown(mode == "info")
    self.mode = mode
end

function MapPinEnhancedWindowSetBodyHeaderMixin:ImportFromMap()
    -- local PinManager = MapPinEnhanced:GetModule("PinManager")
    -- local SetManager = MapPinEnhanced:GetModule("SetManager")
    -- local activeSet = self.body:GetActiveSet()
    -- if not activeSet then return end
    -- local pins = PinManager:GetPinsByOrder()
    -- for _, pin in ipairs(pins) do
    --     activeSet:AddPin(pin.pinData, true, true)
    -- end
    -- SetManager:PersistSets(activeSet.setID)
    -- self.body:UpdatePinList()
end

function MapPinEnhancedWindowSetBodyHeaderMixin:UpdateSetName()
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

function MapPinEnhancedWindowSetBodyHeaderMixin:OnChangeSetName()
    if not self.body.activeEditorSet then return end
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    SetManager:UpdateSetNameByID(self.body.activeEditorSet, self.setName:GetText())
end

function MapPinEnhancedWindowSetBodyHeaderMixin:SetInfoText(text)
    if self.mode == "editor" then return end
    self.infoText:SetText(text)
end

function MapPinEnhancedWindowSetBodyHeaderMixin:DeleteSet()
    local SetManager = MapPinEnhanced:GetModule("SetManager")
    SetManager:DeleteSet(self.body.activeEditorSet)
    self.body:SetActiveEditorSetID()
    Events:FireEvent('UpdateSetList')
end

local EditorWindow = MapPinEnhanced:GetModule("EditorWindow")

function MapPinEnhancedWindowSetBodyHeaderMixin:OnLoad()
    self.body = self:GetParent() --[[@as MapPinEnhancedWindowSetBodyMixin]]
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
        Dialog:ShowPopup({
            text = L["Are you sure you want to delete this set?"],
            onAccept = function()
                self:DeleteSet()
            end
        })
    end)

    local function StartMoving()
        EditorWindow:StartMoving()
        SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
    end
    self:SetScript("OnMouseDown", StartMoving)

    local function StopMoving()
        EditorWindow:StopMovingOrSizing()
        SetCursor(nil)
    end
    self:SetScript("OnMouseUp", StopMoving)
end

---------------------------------------------------------------------------