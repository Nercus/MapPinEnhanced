---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@alias MenuEntryType "button" | "title" | "checkbox" | "radio" | "divider" | "spacer" | "template" | "submenu"

---@class MenuEntry
---@field type MenuEntryType
---@field initializer MenuDescriptionInitializer

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
---@field entry AnyMenuEntry
---@field entries AnyMenuEntry[] | fun(): AnyMenuEntry[]
---@field options? MenuOptions


---@alias AnyMenuEntry MenuButtonEntry | MenuTitleEntry | MenuCheckboxEntry | MenuRadioEntry | MenuDividerEntry | MenuSpacerEntry | MenuTemplateEntry | MenuSubmenuEntry

---@class MenuOptions
---@field gridModeColumns? number


---@param rootDescription ElementMenuDescriptionProxy
---@param entry AnyMenuEntry
---@return ElementMenuDescriptionProxy
local function GenerateMenuElement(rootDescription, entry)
    ---@type ElementMenuDescriptionProxy
    local element

    if entry.type == "title" then
        element = rootDescription:CreateTitle(entry.label)
    elseif entry.type == "button" then
        element = rootDescription:CreateButton(entry.label, entry.onClick)
    elseif entry.type == "checkbox" then
        element = rootDescription:CreateCheckbox(entry.label, entry.isSelected, entry.setSelected, entry.data)
    elseif entry.type == "radio" then
        element = rootDescription:CreateRadio(entry.label, entry.isSelected, entry.setSelected, entry.data)
    elseif entry.type == "divider" then
        element = rootDescription:CreateDivider()
    elseif entry.type == "spacer" then
        element = rootDescription:CreateSpacer()
    elseif entry.type == "template" then
        element = rootDescription:CreateTemplate(entry.template)
    elseif entry.type == "submenu" then
        assert(entry.entry, "Entry for the submenu type of the submenu trigger")
        assert(entry.entry.type == "button" or entry.entry.type == "checkbox" or entry.entry.type == "radio" or
            entry.entry.type == "template", "Submenu entry must be a button, checkbox, radio or template")
        ---@diagnostic disable-next-line: missing-parameter for submenus the second and third parameter are not used
        local subMenuButton = GenerateMenuElement(rootDescription, entry.entry)
        if entry.options and entry.options.gridModeColumns then
            subMenuButton:SetGridMode(MenuConstants.VerticalGridDirection, entry.options.gridModeColumns)
        end

        ---@type AnyMenuEntry[]
        local entries = type(entry.entries) == "function" and entry.entries() or entry.entries --[[@as AnyMenuEntry[]]
        for _, subEntry in ipairs(entries) do
            GenerateMenuElement(subMenuButton, subEntry)
        end
        return subMenuButton
    else
        error("Unknown menu entry type received!")
    end

    -- Add initializer if provided (works for any element type)
    if element and entry.initializer then
        element:AddInitializer(entry.initializer)
    end

    return element
end


---Get the menu generator function for a given menu template
---@param menuTemplate AnyMenuEntry[]
---@return function
function MapPinEnhanced:GetGeneratorFunction(menuTemplate)
    assert(type(menuTemplate) == "table", "Menu template not provided or not a table")
    return function(_, rootDescription)
        ---@cast rootDescription ElementMenuDescriptionProxy
        for _, entry in ipairs(menuTemplate) do
            GenerateMenuElement(rootDescription, entry)
        end
    end
end

---Generate a menu for a given parent frame and menu template
---@param parentFrame Region The parent frame to attach the menu to
---@param menuTemplate AnyMenuEntry[] The menu template to use for the menu
---@param options? MenuOptions The options to use for the menu
function MapPinEnhanced:GenerateMenu(parentFrame, menuTemplate, options)
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
