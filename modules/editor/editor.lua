---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Editor
local Editor = MapPinEnhanced:GetModule("Editor")
local L = MapPinEnhanced.L

--- TODO: don't forget to add callbacks to update between the editor and the collection editor

function Editor:GetEditorFrame()
    if not self.editorFrame then
        self.editorFrame = CreateFrame("Frame", "MapPinEnhancedEditor", UIParent, "MapPinEnhancedEditorTemplate")
    end
    return self.editorFrame
end

function Editor:ShowEditor()
    local frame = self:GetEditorFrame()
    frame:ShowFrame()
end

function Editor:HideEditor()
    local frame = self:GetEditorFrame()
    if frame:IsShown() then
        frame:HideFrame()
    end
end

function Editor:IsShown()
    local frame = self:GetEditorFrame()
    return frame and frame:IsShown() or false
end

MapPinEnhanced:AddSlashCommand("editor", function()
    if Editor:IsShown() then
        Editor:HideEditor()
    else
        Editor:ShowEditor()
    end
end, L["Toggle the collection editor."])
