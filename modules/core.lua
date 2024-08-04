---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinManager : Module
local PinManager = MapPinEnhanced:CreateModule("PinManager")

---@class PinFactory : Module
local PinFactory = MapPinEnhanced:CreateModule("PinFactory")

---@class SetManager : Module
local SetManager = MapPinEnhanced:CreateModule("SetManager")

---@class SetFactory : Module
local SetFactory = MapPinEnhanced:CreateModule("SetFactory")

---@class Blizz : Module
local Blizz = MapPinEnhanced:CreateModule("Blizz")

---toggle the pin tracker
---@param forceShow? boolean if true, the tracker will be shown, if false, the tracker will be hidden, if nil, the tracker will be toggled
function MapPinEnhanced:TogglePinTracker(forceShow)
    if not self.pinTracker then
        self.pinTracker = CreateFrame("Frame", "MapPinEnhancedTracker", UIParent, "MapPinEnhancedTrackerFrameTemplate") --[[@as MapPinEnhancedTrackerFrameMixin]]
    end
    if forceShow == true then
        self.pinTracker:Open()
    elseif forceShow == false then
        self.pinTracker:Close()
    else
        self.pinTracker:Toggle()
    end
end

---@param viewType TrackerView
function MapPinEnhanced:SetPinTrackerView(viewType)
    if not self.pinTracker then
        self:TogglePinTracker(true)
    end
    self.pinTracker:SetActiveView(viewType)
end

function MapPinEnhanced:ToggleImportWindow()
    if not self.importWindow then
        self.importWindow = CreateFrame("Frame", "MapPinEnhancedImportWindow", UIParent,
            "MapPinEnhancedImportWindowTemplate") --[[@as MapPinEnhancedImportWindowMixin]]
        self.importWindow:Open()
        return
    end
    if self.importWindow:IsVisible() then
        self.importWindow:Close()
    else
        self.importWindow:Open()
    end
end

function MapPinEnhanced:ToggleEditorWindow()
    if not self.editorWindow then
        self.editorWindow = CreateFrame("Frame", "MapPinEnhancedEditorWindow", UIParent,
            "MapPinEnhancedEditorWindowTemplate") --[[@as MapPinEnhancedEditorWindowMixin]]
        self.editorWindow:Open()
        return
    end
    if self.editorWindow:IsVisible() then
        self.editorWindow:Close()
    else
        self.editorWindow:Open()
    end
end

---@param options ModalOptions
function MapPinEnhanced:OpenTextModal(options)
    if not self.textModal then
        self.textModal = CreateFrame("Frame", "MapPinEnhancedTextModal", UIParent, "MapPinEnhancedTextModalTemplate") --[[@as MapPinEnhancedTextModalMixin]]
    end
    self.textModal:Open(options)
end

---@param pinData pinData | nil
function MapPinEnhanced:SetSuperTrackedPin(pinData)
    if not self.SuperTrackedPin then
        self.SuperTrackedPin = CreateFrame("Frame", "MapPinEnhancedSuperTrackedPin", UIParent,
            "MapPinEnhancedSuperTrackedPinTemplate") --[[@as MapPinEnhancedSuperTrackedPinMixin]]
    end
    if not pinData then
        self.SuperTrackedPin:Clear()
        return
    end
    self.SuperTrackedPin:Setup(pinData)
    self.SuperTrackedPin:SetTrackedTexture()
    self.SuperTrackedPin:Show()
end

-- C_Timer.After(1, function()
--     MapPinEnhanced:ToggleEditorWindow()
--     MapPinEnhanced.editorWindow:SetActiveView("optionView")
-- end)
