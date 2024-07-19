---@meta

---@class MenuUtil
MenuUtil = {}

function MenuUtil.TraverseMenu(elementDescription, op, condition) end

function MenuUtil.GetSelections(elementDescription, condition) end

function MenuUtil.ShowTooltip(owner, func, ...) end

function MenuUtil.HideTooltip(owner) end

function MenuUtil.HookTooltipScripts(owner, func) end

function MenuUtil.CreateRootMenuDescription(menuMixin) end

function MenuUtil.CreateContextMenu(ownerRegion, generator, ...) end

function MenuUtil.SetElementText(elementDescription, text) end

function MenuUtil.GetElementText(elementDescription) end

function MenuUtil.CreateFrame() end

function MenuUtil.CreateTemplate(template) end

function MenuUtil.CreateTitle(text, color) end

function MenuUtil.CreateButton(text, callback, data) end

function MenuUtil.CreateCheckbox(text, isSelected, setSelected, data) end

function MenuUtil.CreateRadio(text, isSelected, setSelected, data) end

function MenuUtil.CreateColorSwatch(text, callback, colorInfo) end

function MenuUtil.CreateButtonMenu(dropdown, ...) end

function MenuUtil.CreateButtonContextMenu(ownerRegion, ...) end

function MenuUtil.CreateCheckboxMenu(dropdown, isSelected, setSelected, ...) end

function MenuUtil.CreateCheckboxContextMenu(ownerRegion, isSelected, setSelected, ...) end

function MenuUtil.CreateRadioMenu(dropdown, isSelected, setSelected, ...) end

function MenuUtil.CreateRadioContextMenu(ownerRegion, isSelected, setSelected, ...) end

function MenuUtil.CreateEnumRadioMenu(dropdown, enum, enumTranslator, isSelected, setSelected, orderTbl) end

function MenuUtil.CreateEnumRadioContextMenu(dropdown, enum, enumTranslator, isSelected, setSelected, orderTbl) end

function MenuUtil.CreateDivider() end

function MenuUtil.CreateSpacer() end

---@class SubMenuUtil
SubMenuUtil = {}

function SubMenuUtil:TraverseMenu(elementDescription, op, condition) end

function SubMenuUtil:GetSelections(elementDescription, condition) end

function SubMenuUtil:ShowTooltip(owner, func, ...) end

function SubMenuUtil:HideTooltip(owner) end

function SubMenuUtil:HookTooltipScripts(owner, func) end

function SubMenuUtil:CreateRootMenuDescription(menuMixin) end

function SubMenuUtil:CreateContextMenu(ownerRegion, generator, ...) end

function SubMenuUtil:SetElementText(elementDescription, text) end

function SubMenuUtil:GetElementText(elementDescription) end

function SubMenuUtil:CreateFrame() end

function SubMenuUtil:CreateTemplate(template) end

function SubMenuUtil:CreateTitle(text, color) end

function SubMenuUtil:CreateButton(text, callback, data) end

function SubMenuUtil:CreateCheckbox(text, isSelected, setSelected, data) end

function SubMenuUtil:CreateRadio(text, isSelected, setSelected, data) end

function SubMenuUtil:CreateColorSwatch(text, callback, colorInfo) end

function SubMenuUtil:CreateButtonMenu(dropdown, ...) end

function SubMenuUtil:CreateButtonContextMenu(ownerRegion, ...) end

function SubMenuUtil:CreateCheckboxMenu(dropdown, isSelected, setSelected, ...) end

function SubMenuUtil:CreateCheckboxContextMenu(ownerRegion, isSelected, setSelected, ...) end

function SubMenuUtil:CreateRadioMenu(dropdown, isSelected, setSelected, ...) end

function SubMenuUtil:CreateRadioContextMenu(ownerRegion, isSelected, setSelected, ...) end

function SubMenuUtil:CreateEnumRadioMenu(dropdown, enum, enumTranslator, isSelected, setSelected, orderTbl) end

function SubMenuUtil:CreateEnumRadioContextMenu(dropdown, enum, enumTranslator, isSelected, setSelected, orderTbl) end

function SubMenuUtil:CreateDivider() end

function SubMenuUtil:CreateSpacer() end
