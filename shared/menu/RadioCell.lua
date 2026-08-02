---@class MapPinEnhancedMenuRadioCellData
---@field owner table
---@field icon PinIcon
---@field isSelected fun(): boolean
---@field onClick fun()

---@class MapPinEnhancedMenuRadioCellTemplate : Button
---@field icon Texture
---@field selectedBackground Texture
---@field hover Texture
---@field data MapPinEnhancedMenuRadioCellData | nil
---@field menuDescription ElementMenuDescriptionProxy | nil
MapPinEnhancedMenuRadioCellMixin = {}

local ICON_SIZE = 24
---@type table<MapPinEnhancedMenuRadioCellTemplate, boolean>
local activeRadioCells = setmetatable({}, { __mode = "k" })

---@param owner table
local function RefreshOwnerCells(owner)
    for cell in pairs(activeRadioCells) do
        if cell.data and cell.data.owner == owner then
            cell:SetSelected(cell.data.isSelected())
        end
    end
end

function MapPinEnhancedMenuRadioCellMixin:OnLoad()
    self.hover:Hide()
end

---@param data MapPinEnhancedMenuRadioCellData
function MapPinEnhancedMenuRadioCellMixin:SetData(data)
    self.data = data
    activeRadioCells[self] = true

    local size = math.floor((data.icon.scale or 1) * ICON_SIZE + 0.5)
    self.icon:SetSize(size, size)
    if data.icon.usesAtlas then
        self.icon:SetAtlas(data.icon.path)
    else
        self.icon:SetTexture(data.icon.path)
    end

    self:SetSelected(data.isSelected())
end

---@param description ElementMenuDescriptionProxy
function MapPinEnhancedMenuRadioCellMixin:SetMenuDescription(description)
    self.menuDescription = description
    description:SetResponder(function()
        if self.data then
            self.data.onClick()
        end
        return MenuResponse.Open
    end)
    self:SetScript("OnClick", function(_, buttonName)
        self:OnClick(buttonName)
    end)
end

---@param isSelected boolean
function MapPinEnhancedMenuRadioCellMixin:SetSelected(isSelected)
    self.selectedBackground:SetShown(isSelected)
end

function MapPinEnhancedMenuRadioCellMixin:OnEnter()
    self.hover:Show()
end

function MapPinEnhancedMenuRadioCellMixin:OnLeave()
    self.hover:Hide()
end

function MapPinEnhancedMenuRadioCellMixin:OnMouseDown()
    self:SetSelected(true)
end

---@param buttonName string
function MapPinEnhancedMenuRadioCellMixin:OnClick(buttonName)
    if not self.data then
        return
    end

    self:SetSelected(true)
    local owner = self.data.owner
    if self.menuDescription then
        self.menuDescription:Pick(MenuInputContext.MouseButton, buttonName)
    else
        self.data.onClick()
    end
    RefreshOwnerCells(owner)
end

function MapPinEnhancedMenuRadioCellMixin:OnHide()
    activeRadioCells[self] = nil
    self.data = nil
    self.menuDescription = nil
    self.hover:Hide()
end
