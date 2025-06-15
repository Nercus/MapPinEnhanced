---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class PinFactory
local PinFactory = MapPinEnhanced:GetModule("PinFactory")
local PinSections = MapPinEnhanced:GetModule("PinSections")
local SetManager = MapPinEnhanced:GetModule("SetManager")

local CONSTANTS = MapPinEnhanced.CONSTANTS
local L = MapPinEnhanced.L

---@param parentFrame Button
---@param pin PinObject
local function ShowMenu(parentFrame, pin)
    local function IsColorSelected(color)
        return pin:IsColorSelected(color)
    end

    local function SetColor(color)
        pin:SetColor(color)
    end

    local function SharePin()
        pin:SharePin()
    end

    local function ShowOnMap()
        pin:ShowOnMap()
    end

    local function ToggleLockState()
        if pin.pinData.lock then
            pin.pinData.lock = false
            pin:DisableLock()
        else
            pin.pinData.lock = true
            pin:EnableLock()
        end
    end



    -- TODO: use the menu templating system
    MenuUtil.CreateContextMenu(parentFrame, function(_, rootDescription)
        local titleElementDescription = rootDescription:CreateTemplate("MapPinEnhancedMenuInputTemplate") --[[@as BaseMenuDescriptionMixin]]
        titleElementDescription:AddInitializer(function(frame)
            ---@cast frame MapPinEnhancedInputMixin
            frame:Setup({
                default = pin.pinData.title or CONSTANTS.DEFAULT_PIN_NAME,
                init = function() return pin.pinData.title or CONSTANTS.DEFAULT_PIN_NAME end,
                onChange = function(value)
                    pin:ChangeTitle(value)
                end
            })
        end);
        rootDescription:CreateDivider()
        if pin.pinData.color ~= "Custom" then
            ---@type SubMenuUtil
            local colorSubmenu = rootDescription:CreateButton(L["Change Color"]);
            for colorIndex, colorTable in ipairs(CONSTANTS.PIN_COLORS) do
                local label = string.format(CONSTANTS.MENU_COLOR_BUTTON_PATTERN, colorTable.color:GetRGBAsBytes())
                colorSubmenu:CreateRadio(label, IsColorSelected, function() SetColor(colorTable.colorName) end,
                    colorIndex)
            end
        end


        ---@type fun(disabled:boolean)?
        local OverrideCreateSetButtonDisabledState

        ---@type SubMenuUtil
        local setSubmenu = rootDescription:CreateButton(L["Add to a Set"]);
        local sets = SetManager:GetSets()
        setSubmenu:CreateTitle(L["Enter New Set Name"])
        local cachedSetName = ""
        local confirmNewSetElementDescription
        local newSetNameElementDescription = setSubmenu:CreateTemplate("MapPinEnhancedMenuInputTemplate") --[[@as BaseMenuDescriptionMixin]]
        newSetNameElementDescription:AddInitializer(function(frame)
            ---@cast frame MapPinEnhancedInputMixin
            frame:SetSize(150, 20)
            frame:SetScript("OnEnterPressed", function()
                if cachedSetName == "" then
                    return
                end
                local newSet = SetManager:AddSet(cachedSetName)
                newSet:AddPin(pin.pinData, nil, true)
                local inputContext = MenuInputContext.MouseButton;
                confirmNewSetElementDescription:Pick(inputContext, "LeftButton");
                frame:ClearFocusOnKey()
            end)
            frame:Setup({
                default = "",
                init = function() return "" end,
                onChange = function(value)
                    cachedSetName = value
                    if not OverrideCreateSetButtonDisabledState then return end
                    if value == "" then
                        OverrideCreateSetButtonDisabledState(true)
                    else
                        OverrideCreateSetButtonDisabledState(false)
                    end
                end
            })
        end)
        setSubmenu:CreateSpacer()

        confirmNewSetElementDescription = setSubmenu:CreateTemplate("MapPinEnhancedButtonTemplate") --[[@as BaseMenuDescriptionMixin]]
        confirmNewSetElementDescription:SetResponder(function()
            return MenuResponse.CloseAll;
        end)
        confirmNewSetElementDescription:AddInitializer(function(frame)
            ---@cast frame MapPinEnhancedButtonMixin
            frame:SetSize(150, 20)
            frame:SetText(L["Create Set"])
            frame:Setup({
                buttonLabel = L["Create Set"],
                onChange = function(buttonName)
                    if cachedSetName == "" then
                        return
                    end
                    local newSet = SetManager:AddSet(cachedSetName)
                    newSet:AddPin(pin.pinData, nil, true)
                    local inputContext = MenuInputContext.MouseButton;
                    confirmNewSetElementDescription:Pick(inputContext, buttonName);
                end,
                disabledState = true
            })

            OverrideCreateSetButtonDisabledState = function(disabled)
                frame:SetDisabled(disabled)
            end
        end)
        setSubmenu:CreateDivider()
        for _, set in pairs(sets) do
            setSubmenu:CreateButton(set.name, function()
                set:AddPin(pin.pinData, nil, true)
            end)
        end

        rootDescription:CreateButton(L["Show on Map"], ShowOnMap)
        local lockToggleLabel = pin.pinData.lock and L["Unlock Pin"] or L["Lock Pin"]
        rootDescription:CreateButton(lockToggleLabel, function()
            ToggleLockState()
        end)

        rootDescription:CreateButton(L["Share to Chat"], function() SharePin() end)
        rootDescription:CreateButton(L["Remove Pin"], function() pin.section:RemovePin(pin.pinID) end)
    end)
end


---@class PinObject
---@field ShowMenu fun(_, parentFrame:Button)

function PinFactory:HandleMenu(pin)
    function pin:ShowMenu(parentFrame)
        ShowMenu(parentFrame, pin)
    end
end
