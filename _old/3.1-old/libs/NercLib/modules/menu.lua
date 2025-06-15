---@class NercLibPrivate : NercLib
local NercLib = _G.NercLib

---@alias MenuEntryType "button" | "title" | "checkbox" | "radio" | "divider" | "spacer" | "template" | "submenu"

---@class MenuEntry
---@field type MenuEntryType

---@class MenuButtonEntry : MenuEntry
---@field type "button"
---@field label string
---@field onClick fun()

---@class MenuTitleEntry : MenuEntry
---@field type "title"
---@field label string

---@class MenuCheckboxEntry : MenuEntry
---@field type "checkbox"
---@field label string
---@field isSelected fun(): boolean
---@field setSelected fun(isSelected: boolean)
---@field data number

---@class MenuRadioEntry : MenuEntry
---@field type "radio"
---@field label string
---@field isSelected fun(): boolean
---@field setSelected fun()
---@field data number

---@class MenuDividerEntry : MenuEntry
---@field type "divider"

---@class MenuSpacerEntry : MenuEntry
---@field type "spacer"

---@class MenuTemplateEntry : MenuEntry
---@field type "template"
---@field template string
---@field initializer fun(frame: Frame)

---@class MenuSubmenuEntry : MenuEntry
---@field type "submenu"
---@field label string
---@field entries AnyMenuEntry[] | fun(): AnyMenuEntry[]


---@alias AnyMenuEntry MenuButtonEntry | MenuTitleEntry | MenuCheckboxEntry | MenuRadioEntry | MenuDividerEntry | MenuSpacerEntry | MenuTemplateEntry | MenuSubmenuEntry


---@param addon NercLibAddon
function NercLib:AddMenuModule(addon)
    ---@class Menu
    local Menu = addon:GetModule("Menu")
    ---@param rootDescription SharedMenuDescriptionProxy
    ---@param entry AnyMenuEntry
    ---@return ElementMenuDescriptionProxy
    local function GenerateMenuElement(rootDescription, entry)
        if entry.type == "title" then
            return rootDescription:CreateTitle(entry.label)
        elseif entry.type == "button" then
            return rootDescription:CreateButton(entry.label, entry.onClick)
        elseif entry.type == "checkbox" then
            return rootDescription:CreateCheckbox(entry.label, entry.isSelected, entry.setSelected, entry.data)
        elseif entry.type == "radio" then
            return rootDescription:CreateRadio(entry.label, entry.isSelected, entry.setSelected, entry.data)
        elseif entry.type == "divider" then
            return rootDescription:CreateDivider()
        elseif entry.type == "spacer" then
            return rootDescription:CreateSpacer()
        elseif entry.type == "template" then
            local templateEl = rootDescription:CreateTemplate(entry.template)
            templateEl:AddInitializer(entry.initializer)
            return templateEl
        elseif entry.type == "submenu" then
            ---@diagnostic disable-next-line: missing-parameter for submenus the second and third parameter are not used
            local subMenuButton = rootDescription:CreateButton(entry.label)
            ---@type AnyMenuEntry[]
            local entries = type(entry.entries) == "function" and entry.entries() or
                entry.entries --[[@as AnyMenuEntry[]]
            for _, subEntry in ipairs(entries) do
                GenerateMenuElement(subMenuButton, subEntry)
            end
            return subMenuButton
        end
        error("Unknown menu entry type received!")
    end


    ---@param menuTemplate AnyMenuEntry[]
    ---@return function
    function Menu:GetGeneratorFunction(menuTemplate)
        assert(type(menuTemplate) == "table", "Menu template not provided or not a table")
        return function(_, rootDescription)
            ---@cast rootDescription ElementMenuDescriptionProxy
            for _, entry in ipairs(menuTemplate) do
                GenerateMenuElement(rootDescription, entry)
            end
        end
    end

    ---@class MenuOptions
    ---@field gridModeColumns? number

    ---@param parentFrame Region
    ---@param menuTemplate AnyMenuEntry[]
    ---@param options? MenuOptions
    function Menu:GenerateMenu(parentFrame, menuTemplate, options)
        assert(type(parentFrame) == "table", "Parent frame not provided orr not a region")
        assert(type(menuTemplate) == "table", "Menu template not provided or not a table")
        options = options or {}
        local gridModeColumns = options.gridModeColumns
        MenuUtil.CreateContextMenu(parentFrame, function(_, rootDescription)
            ---@cast rootDescription ElementMenuDescriptionProxy
            if gridModeColumns then
                rootDescription:SetGridMode(MenuConstants.VerticalGridDirection, gridModeColumns)
            end
            for _, entry in ipairs(menuTemplate) do
                GenerateMenuElement(rootDescription, entry)
            end
        end)
    end
end
