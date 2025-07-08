---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerTemplate
MapPinEnhancedTrackerMixin = {}

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")


function MapPinEnhancedTrackerMixin:OnLoad()
    local dataProvider = CreateTreeDataProvider()
    local scrollView = CreateScrollBoxListTreeListView()
    scrollView:SetDataProvider(dataProvider)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.ScrollBox, self.ScrollBar, scrollView)


    local function Initializer(frame, node)
        if not frame.pin then
            MapPinEnhanced:Debug({ frame, node })
            frame:SetScript("OnClick", function()
                node:ToggleCollapsed()
            end)
        end
    end

    local function CustomFactory(factory, node)
        local data = node:GetData()
        local template = data.Template
        factory(template, Initializer)
    end

    scrollView:SetElementFactory(CustomFactory)

    local button = CreateFrame("Button", nil, UIParent, "MapPinEnhancedButtonTemplate")
    button:SetPoint("CENTER")
    button:SetText("Set Pins")
    button:SetSize(200, 50)
    button:SetScript("OnClick", function()
        ---@param group MapPinEnhancedPinGroupMixin
        for group in Groups:EnumerateGroups() do
            local groupData = {
                ButtonText = group:GetName(),
                Template = "MapPinEnhancedTrackerGroupEntryTemplate",
            }
            local groupElement = dataProvider:Insert(groupData)
            for _, pin in group:EnumeratePins() do
                -- Insert a nested element for each pin in the group
                local pinData = {
                    ButtonText = pin.pinData.title or "Unnamed Pin",
                    Template = "MapPinEnhancedTrackerPinEntryTemplate",
                }
                groupElement:Insert(pinData)
            end
        end
    end)
end
