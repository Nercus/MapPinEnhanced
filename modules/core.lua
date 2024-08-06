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

C_Timer.After(1, function()
    local Options = MapPinEnhanced:GetModule("Options")

    Options:RegisterCheckbox({
        category = "General",
        label = "Testcheckbox",
        description = "Testing the checkbox",
        descriptionImage = "interface/glues/charactercreate/blizzconcc2015dh",
        default = true,
        init = true,
        onChange = function(value)
            print("Checkbox changed", value)
        end
    })

    Options:RegisterColorpicker({
        category = "General",
        label = "Testcolorpicker",
        description = "Testing the colorpicker",
        descriptionImage = "interface/talentframe/talentsclassbackgroundwarrior2",
        default = { r = 1, g = 1, b = 1, a = 1 },
        init = { r = 1, g = 1, b = 1, a = 1 },
        onChange = function(value)
            print("Colorpicker changed", value)
        end
    })

    Options:RegisterInput({
        category = "General",
        label = "Testinput",
        description = "Testing the input",
        descriptionImage = "interface/dressupframe/dressingroommonk",
        default = "Test",
        init = "Test",
        onChange = function(value)
            print("Input changed", value)
        end
    })


    Options:RegisterSelect({
        category = "General",
        label = "Testselect",
        description = "Testing the select",
        descriptionImage = "interface/icons/achievement_boss_lichking",
        default = 1,
        init = 1,
        onChange = function(value)
            print("Select changed", value)
        end,
        options = { "TestA", "TestB", "TestC" }
    })

    Options:RegisterSlider({
        category = "General",
        label = "Testslider",
        description = "Testing the slider",
        descriptionImage = "interface/icons/achievement_boss_lichking",
        default = 50,
        init = 50,
        onChange = function(value)
            print("Slider changed", value)
        end,
        min = 0,
        max = 100,
        step = 1
    })


    for i = 1, 40 do
        Options:RegisterButton({
            category = "General",
            label = "Option" .. i,
            description = "Press this button to print the number " .. i,
            buttonLabel = "Press me",
            onChange = function()
                print(i)
            end
        })
    end

    for i = 1, 40 do
        Options:RegisterColorpicker({
            category = "Tracker",
            label = "Color" .. i,
            description = "Testing the colorpicker",
            descriptionImage = "interface/talentframe/talentsclassbackgroundwarrior2",
            default = { r = 1, g = 1, b = 1, a = 1 },
            init = { r = 1, g = 1, b = 1, a = 1 },
            onChange = function(value)
                print("Colorpicker changed", value)
            end
        })
    end

    MapPinEnhanced:ToggleEditorWindow()
    MapPinEnhanced.editorWindow:SetActiveView("optionView")
end)
