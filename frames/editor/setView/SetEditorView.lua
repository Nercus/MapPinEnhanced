---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class SetListScrollFrame : ScrollFrame
---@field Child Frame


---@class MapPinEnhancedSetEditorViewSidebarMixin : Frame
---@field activeEditorSet SetObject
---@field searchInput MapPinEnhancedInputMixin
---@field scrollFrame SetListScrollFrame
---@field switchViewButton Button
MapPinEnhancedSetEditorViewSidebarMixin = {}




function MapPinEnhancedSetEditorViewSidebarMixin:UpdateEditor()
    if not self.activeEditorSet then
        return
    end
end

function MapPinEnhancedSetEditorViewSidebarMixin:SetActiveEditorSet(set)
    self.activeEditorSet = set
    self:UpdateEditor()
end

---The set list can be updated with a custom set list, if not provided the set manager will be used -> used for search
---@param sets table<string, SetObject> | nil
function MapPinEnhancedSetEditorViewSidebarMixin:UpdateSetList(sets)
    if not sets then
        ---@class SetManager : Module
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        sets = SetManager:GetSets()
    end
    local scrollChild = self.scrollFrame.Child
    local lastFrame = nil
    for _, setObject in pairs(sets) do
        local setFrame = setObject.SetEditorEntry
        if not lastFrame then
            setFrame:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -10)
        else
            setFrame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5)
        end
        setFrame:SetParent(scrollChild)
        setFrame:Show()
        lastFrame = setFrame
        -- not the nicest solution but it works for now, we overwrite the OnClick function to set the active editor set and hope we dont need to update the set list too often
        setFrame:SetScript("OnClick", function()
            self:SetActiveEditorSet(setObject)
        end)
    end
end

function MapPinEnhancedSetEditorViewSidebarMixin:OnSearchChange()
    -- TODO: implement search
    print(123)
end

function MapPinEnhancedSetEditorViewSidebarMixin:OnShow()
    self:UpdateSetList()
end

---@class MapPinEnhancedSetEditorViewBodyMixin : Frame
MapPinEnhancedSetEditorViewBodyMixin = {}
