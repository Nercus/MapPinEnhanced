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
        self.pinTracker = CreateFrame("Frame", "MapPinEnhancedTracker", UIParent, "MapPinEnhancedTrackerTemplate") --[[@as MapPinEnhancedTrackerMixin]]
        self.pinTracker:Open()
        return
    end
    if forceShow == true then
        self.pinTracker:Open()
    elseif forceShow == false then
        self.pinTracker:Close()
    else
        self.pinTracker:Toggle()
    end
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

---@param options ModalOptions
function MapPinEnhanced:OpenTextModal(options)
    if not self.textModal then
        self.textModal = CreateFrame("Frame", "MapPinEnhancedTextModal", UIParent, "MapPinEnhancedTextModalTemplate") --[[@as MapPinEnhancedTextModalMixin]]
    end
    self.textModal:Open(options)
end
