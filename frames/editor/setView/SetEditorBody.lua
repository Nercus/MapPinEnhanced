-- Template: file://./SetEditorBody.xml
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class SetEditorViewBodyHeader : Frame
---@field setName EditBox
---@field deleteButton Button
---@field importButton Button
---@field exportButton Button

---@class MapPinEnhancedSetEditorViewBodyMixin : Frame
---@field activeEditorSet SetObject | nil
---@field scrollFrame SetListScrollFrame
---@field sidebar MapPinEnhancedSetEditorViewSidebarMixin
---@field setHeader SetEditorViewBodyHeader
MapPinEnhancedSetEditorViewBodyMixin = {}



local CB = MapPinEnhanced.CB



local PinEntryFramePool = CreateFramePool("Frame", nil, "MapPinEnhancedSetEditorPinEntryTemplate")


---@param key 'mapID' | 'xCoord' | 'yCoord' | 'title'
---@param value string
function MapPinEnhancedSetEditorViewBodyMixin:OnPinDataChange(key, value)
    print(key, value)
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdatePinList()
    local scrollChild = self.scrollFrame.Child
    for _, child in pairs({ scrollChild:GetChildren() }) do
        local child = child --[[@as Frame]]
        child:Hide()
        child:ClearAllPoints()
    end
    PinEntryFramePool:ReleaseAll()
    if not self.activeEditorSet then return end
    local pins = self.activeEditorSet:GetPins()

    local lastFrame = nil
    for _, pin in pairs(pins) do
        local pinFrame = PinEntryFramePool:Acquire() --[[@as MapPinEnhancedSetEditorPinEntryMixin]]
        pinFrame:SetParent(scrollChild)
        pinFrame:Show()
        if not lastFrame then
            pinFrame:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, -10)
        else
            pinFrame:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -5)
        end
        lastFrame = pinFrame
        pinFrame:SetPin(pin)
        pinFrame:SetChangeCallback(function(key, value)
            self:OnPinDataChange(key, value)
        end)
    end
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdateSetHeader()
    if not self.activeEditorSet then
        self.setHeader:Hide()
        return
    end
    self.setHeader:Show()
    self.setHeader.setName:SetText(self.activeEditorSet.name)
    self.setHeader.deleteButton:SetScript("OnClick", function()
        ---@class SetManager : Module
        local SetManager = MapPinEnhanced:GetModule("SetManager")
        SetManager:DeleteSet(self.activeEditorSet.setID)
        self:SetActiveEditorSet()
        CB:Fire('UpdateSetList')
    end)
end

function MapPinEnhancedSetEditorViewBodyMixin:UpdateEditor()
    self:UpdatePinList()
    self:UpdateSetHeader()
end

function MapPinEnhancedSetEditorViewBodyMixin:SetActiveEditorSet(set)
    self.activeEditorSet = set
    if set then
        self.setHeader.setName:SetText(set.name)
    end
    self:UpdateEditor()
    self:UpdateSetHeader()
end
