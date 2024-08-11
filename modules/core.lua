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
    if not self.SuperTrackedPin:IsVisible() then
        self.SuperTrackedPin:Show()
    end
end

function MapPinEnhanced:ToggleMinimapButton(init)
    if not self.minimapIconCreated then
        local MapPinEnhancedBroker = LibStub("LibDataBroker-1.1"):NewDataObject("Bunnies", {
            type = "launcher",
            text = self.addonName,
            icon = "Interface\\Addons\\MapPinEnhanced\\assets\\MPH_Logo.png",
            OnClick = function(owner, button)
                if button == "LeftButton" then
                    self:TogglePinTracker()
                elseif button == "RightButton" then
                    MenuUtil.CreateContextMenu(owner, function(_, rootDescription)
                        rootDescription:CreateTitle(MapPinEnhanced.nameVersionString)
                        rootDescription:CreateButton("Toggle Pin Tracker", function()
                            MapPinEnhanced:TogglePinTracker()
                        end)
                        rootDescription:CreateButton("Toggle Editor", function()
                            MapPinEnhanced:ToggleEditorWindow()
                        end)
                        rootDescription:CreateDivider()
                        rootDescription:CreateButton("Hide Minimap Button", function()
                            MapPinEnhanced:ToggleMinimapButton()
                        end)
                    end)
                end
            end,
        })
        self.minimapIconCreated = true
        if not MapPinEnhancedDB.MinimapIcon then
            MapPinEnhancedDB.MinimapIcon = MapPinEnhanced:GetDefault("MinimapIcon") --[[@as table]]
        end
        self.LDBIcon:Register("MapPinEnhanced", MapPinEnhancedBroker,
            MapPinEnhancedDB.MinimapIcon --[[@as LibDBIcon.button.DB]])
    end
    if init then return end
    local currentState = MapPinEnhanced:GetVar("MinimapIcon", "hide") --[[@as boolean]]
    if currentState then
        MapPinEnhanced:SaveVar("MinimapIcon", "hide", false)
        -- NOTE: notify user here
    else
        MapPinEnhanced:SaveVar("MinimapIcon", "hide", true)
        -- NOTE: notify user here
    end
    self.LDBIcon:Refresh("MapPinEnhanced", MapPinEnhancedDB.MinimapIcon --[[@as LibDBIcon.button.DB]])
end

function MapPinEnhanced:RegisterAddonCompartment()
    AddonCompartmentFrame:RegisterAddon({
        text = self.addonName,
        icon = "Interface\\Addons\\MapPinEnhanced\\assets\\MPH_Logo.png",
        notCheckable = true,
        func = function(_, buttonName, menu)
            self:TogglePinTracker()
        end,
    })
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    MapPinEnhanced:ToggleMinimapButton(true)
    MapPinEnhanced:RegisterAddonCompartment()
end)

MapPinEnhanced:AddSlashCommand("minimap", function()
    MapPinEnhanced:ToggleMinimapButton()
end)

-- C_Timer.After(1, function()
--     local Options = MapPinEnhanced:GetModule("Options")

--     Options:RegisterSlider({
--         category = "Floating Pin",
--         label = "Size",
--         description = "Testing the slider",
--         descriptionImage = "interface/icons/achievement_boss_lichking",
--         default = MapPinEnhanced:GetDefault("Floating Pin", "Size") --[[@as number]],
--         init = MapPinEnhanced:GetVar("Floating Pin", "Size") --[[@as number]],
--         onChange = function(value)
--             print("Slider changed", value)
--             MapPinEnhanced:SaveVar("Floating Pin", "Size", value)
--         end,
--         min = 0,
--         max = 100,
--         step = 1
--     })


--     Options:RegisterCheckbox({
--         category = "General",
--         label = "Testcheckbox",
--         description = "Testing the checkbox",
--         descriptionImage = "Interface/AddOns/MapPinEnhanced/assets/maskedDescriptionImageTest.png",
--         default = true,
--         init = true,
--         onChange = function(value)
--             print("Checkbox changed", value)
--         end
--     })

--     Options:RegisterColorpicker({
--         category = "General",
--         label = "Testcolorpicker",
--         description = "Testing the colorpicker",
--         descriptionImage = "interface/talentframe/talentsclassbackgroundwarrior2",
--         default = { r = 1, g = 0, b = 1, a = 1 },
--         init = { r = 1, g = 1, b = 0, a = 1 },
--         onChange = function(value)
--             print("Colorpicker changed", value.r, value.g, value.b, value.a)
--         end
--     })

--     Options:RegisterInput({
--         category = "General",
--         label = "Testinput",
--         description = "Testing the input",
--         descriptionImage = "interface/dressupframe/dressingroommonk",
--         default = "Test",
--         init = "Test",
--         onChange = function(value)
--             print("Input changed", value)
--         end
--     })


--     Options:RegisterSelect({
--         category = "General",
--         label = "Testselect",
--         description = "Testing the select",
--         descriptionImage = "interface/icons/achievement_boss_lichking",
--         default = "OptionValue 1",
--         init = "OptionValue 1",
--         onChange = function(value)
--             print("Select changed", value)
--         end,
--         options = {
--             {
--                 label = "Option 1",
--                 value = "OptionValue 1",
--                 type = "radio"
--             },
--             {
--                 label = "Option 2",
--                 value = "OptionValue 2",
--                 type = "radio"
--             },
--             {
--                 label = "Option 3",
--                 value = "OptionValue 3",
--                 type = "radio"
--             }
--         }
--     })


--     Options:RegisterSlider({
--         category = "General",
--         label = "Testslider",
--         description = "Testing the slider",
--         descriptionImage = "interface/icons/achievement_boss_lichking",
--         default = 50,
--         init = 50,
--         onChange = function(value)
--             print("Slider changed", value)
--         end,
--         min = 0,
--         max = 100,
--         step = 1
--     })
--     Options:RegisterButton({
--         category = "General",
--         label = "Testbutton",
--         description = "Press this button to print the number",
--         buttonLabel = "Press me",
--         onChange = function()
--             print("Button pressed")
--         end
--     })
--     -- MapPinEnhanced:ToggleEditorWindow()
--     -- MapPinEnhanced.editorWindow:SetActiveView("optionView")
-- end)
