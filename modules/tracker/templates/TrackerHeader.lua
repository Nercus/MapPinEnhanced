---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


local Tracker = MapPinEnhanced:GetModule("Tracker")
local Transfer = MapPinEnhanced:GetModule("Transfer")
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L

---@class MapPinEnhancedTrackerHeaderTemplate : Frame
---@field hiddenGroupsButton MapPinEnhancedIconButtonTemplate
---@field closeButton MapPinEnhancedIconButtonTemplate
---@field importButton MapPinEnhancedIconButtonTemplate
---@field headerTextureLeft Texture
---@field headerTextureRight Texture
---@field title FontString
---@field icon MapPinEnhancedIconMixin
MapPinEnhancedTrackerHeaderMixin = {}

local function SortGroupsByOrder(group1, group2)
    local order1 = group1:GetOrder() or 0
    local order2 = group2:GetOrder() or 0

    if order1 ~= order2 then
        return order1 > order2
    end
    return (group1:GetName() or "") < (group2:GetName() or "")
end

function MapPinEnhancedTrackerHeaderMixin:BuildHiddenGroupsMenu()
    local menu = {
        {
            type = "title",
            label = L["Hidden Groups"],
        }
    }

    ---@type MapPinEnhancedGroupMixin[]
    local hiddenGroups = {}

    ---@param group MapPinEnhancedGroupMixin
    for group in Groups:EnumerateGroups() do
        if group:IsHidden() and not group:IsProtected() and group:GetTotalPinCount() > 0 then
            table.insert(hiddenGroups, group)
        end
    end

    table.sort(hiddenGroups, SortGroupsByOrder)



    if #hiddenGroups == 0 then
        return {
            {
                type = "title",
                label = L["No hidden groups"],
            },
        }
    end

    for _, group in ipairs(hiddenGroups) do
        table.insert(menu, {
            type = "button",
            -- TODO: Replace the placeholder pin with a groups/visibility icon.
            label = MapPinEnhanced:Iconize("pin", string.format("%s (%d)", group:GetName(),
                group:GetTotalPinCount())),
            onClick = function() group:ShowGroup() end,
        })
    end

    return menu
end

function MapPinEnhancedTrackerHeaderMixin:OnLoad()
    self.importButton:SetScript("OnClick", function()
        Transfer:ShowImportWindow()
    end)

    self.hiddenGroupsButton:SetScript("OnClick", function()
        MapPinEnhanced:GenerateMenu(self.hiddenGroupsButton, self:BuildHiddenGroupsMenu())
    end)

    self.closeButton:SetScript("OnClick", function()
        Tracker:HideTracker()
    end)
end

function MapPinEnhancedTrackerHeaderMixin:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerHeaderMixin:SetIcon(icon)
    self.icon:SetIconTexture(icon)
end
