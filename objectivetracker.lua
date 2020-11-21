-- local MPH_Frame = CreateFrame ("frame", "MPH_ScreenPanel", UIParent, "BackdropTemplate")
-- MPH_Frame:SetSize (235, 500)
-- MPH_Frame:SetFrameStrata ("LOW")


-- local MPH_ObjectiveTrackerHeader = CreateFrame ("Frame", "MPH_ObjectiveTrackerHeader", MPH_Frame, "ObjectiveTrackerHeaderTemplate")
-- MPH_ObjectiveTrackerHeader.Text:SetText ("Map Pins")
-- MPH_ObjectiveTrackerHeader:ClearAllPoints()
-- MPH_ObjectiveTrackerHeader:SetPoint ("bottom", MPH_Frame, "top", 0, -20)
-- MPH_ObjectiveTrackerHeader:Show()



-- for i = 1, ObjectiveTrackerFrame:GetNumPoints() do
--     local point, relativeTo, relativePoint, xOfs, yOfs = ObjectiveTrackerFrame:GetPoint (i)

--     --note: we're probably missing something here, when the frame anchors to MoveAnything frame 'ObjectiveTrackerFrameMover',
--     --it automatically anchors to MinimapCluster frame.
--     --so the solution we've found was to get the screen position of the MoveAnything frame and anchor our frame to UIParent.

--     --if (relativeTo:GetName() == "ObjectiveTrackerFrameMover") then
--     if (IsAddOnLoaded("MoveAnything") and relativeTo and (relativeTo:GetName() == "ObjectiveTrackerFrameMover")) then
--         local top, left = ObjectiveTrackerFrameMover:GetTop(), ObjectiveTrackerFrameMover:GetLeft()
--         MPH_ScreenPanel:SetPoint ("top", UIParent, "top", 0, (yOfs) - abs (top-GetScreenHeight()))
--         MPH_ScreenPanel:SetPoint ("left", UIParent, "left", -10 + xOfs + left, 0)
--     else
--         MPH_ScreenPanel:SetPoint (point, relativeTo, relativePoint, -10 + xOfs, yOfs-20-20)
--     end

--     --print where the frame is setting its potision
--     --print ("SETTING POS ON:", point, relativeTo:GetName(), relativePoint, -10 + xOfs, yOfs - 20 - 20)
-- end

-- print("run")
