---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)



---@class PopupOption
---@field text string
---@field onAccept function
---@field onCancel function?



---@class MapPinEnhancedDialogFrame : Frame
---@field text FontString
---@field accept Button
---@field cancel? Button


---@type MapPinEnhancedDialogFrame?
local dialogFrame = nil

---@return MapPinEnhancedDialogFrame
local function GetPopupDialogFrame()
    if not dialogFrame then
        dialogFrame = CreateFrame("Frame", "MapPinEnhancedPopupDialog", UIParent, "MapPinEnhancedPopupDialogTemplate") --[[@as MapPinEnhancedDialogFrame]]
    end
    return dialogFrame
end


local function GetInteractKeybind()
    local key1, key2 = GetBindingKey("INTERACTTARGET")
    if key1 then
        return key1
    end
    if key2 then
        return key2
    end
    return "SPACE"
end

---@param options PopupOption
function MapPinEnhanced:ShowPopup(options)
    assert(options.text, "The popup must have text")
    assert(options.onAccept, "The popup must have an onAccept function")
    local dialog = GetPopupDialogFrame()

    local function OnAccept()
        options.onAccept()
        dialog:Hide()
    end


    local function OnCancel()
        if options.onCancel then
            options.onCancel()
        end
        dialog:Hide()
    end

    dialog:Show()
    dialog.text:SetText(options.text)
    dialog.accept:SetScript("OnClick", OnAccept)
    dialog.cancel:SetScript("OnClick", OnCancel)

    local function OnInteract(_, key)
        if key == "ESCAPE" then
            OnCancel()
        elseif key == "ENTER" then
            OnAccept()
        elseif key == GetInteractKeybind() then
            OnAccept()
        end
    end

    dialog:SetScript("OnKeyDown", OnInteract)
end
