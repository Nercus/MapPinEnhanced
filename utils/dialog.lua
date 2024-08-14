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

local L = MapPinEnhanced.L

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
    local key1 = GetBindingKey("INTERACTTARGET")
    if not key1 then return end
    -- get modifiers
    if string.find(key1, "SHIFT") and not IsShiftKeyDown() then return end
    if string.find(key1, "CTRL") and not IsControlKeyDown() then return end
    if string.find(key1, "ALT") and not IsAltKeyDown() then return end
    -- split by "-" and get the last part
    local keys = { strsplit("-", key1) }
    return keys[#keys]
end

---@type string
local acceptButtonText = L["Accept"]
---@type string
local cancelButtonText = L["Cancel"]

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
    dialog.accept:SetText(acceptButtonText)
    dialog.cancel:SetText(cancelButtonText)
    -- TODO: only propagate the keys that are not used by the dialog
    local function OnInteract(_, key)
        if key == "ESCAPE" then
            OnCancel()
        elseif key == "ENTER" then
            OnAccept()
        elseif key and key == GetInteractKeybind() then
            OnAccept()
        end
    end

    dialog:SetScript("OnKeyDown", OnInteract)
end
