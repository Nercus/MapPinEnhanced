-- function KethoEditBox_Show(text)
--     if not KethoEditBox then
--         local f = CreateFrame("Frame", "KethoEditBox", UIParent, "DialogBoxFrame")
--         f:SetPoint("CENTER")
--         f:SetSize(600, 500)

--         f:SetBackdrop({
--                 bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
--                 edgeFile = "Interface\\PVPFrame\\UI-Character-PVP-Highlight", -- this one is neat
--                 edgeSize = 16,
--                 insets = { left = 8, right = 6, top = 8, bottom = 8 },
--         })
--         f:SetBackdropBorderColor(1, 1, 1, 1) -- darkblue

--         -- Movable
--         f:SetMovable(true)
--         f:SetClampedToScreen(true)
--         f:SetScript("OnMouseDown", function(self, button)
--                 if button == "LeftButton" then
--                     self:StartMoving()
--                 end
--         end)
--         f:SetScript("OnMouseUp", f.StopMovingOrSizing)

--         -- ScrollFrame
--         local sf = CreateFrame("ScrollFrame", "KethoEditBoxScrollFrame", KethoEditBox, "UIPanelScrollFrameTemplate")
--         sf:SetPoint("LEFT", 16, 0)
--         sf:SetPoint("RIGHT", -32, 0)
--         sf:SetPoint("TOP", 0, -16)
--         sf:SetPoint("BOTTOM", KethoEditBoxButton, "TOP", 0, 0)

--         -- EditBox
--         local eb = CreateFrame("EditBox", "KethoEditBoxEditBox", KethoEditBoxScrollFrame)
--         eb:SetSize(sf:GetSize())
--         eb:SetMultiLine(true)
--         eb:SetAutoFocus(true) -- dont automatically focus
--         eb:SetFontObject("ChatFontNormal")
--         eb:SetScript("OnEscapePressed", function() f:Hide() end)
--         sf:SetScrollChild(eb)

--         -- Resizable
--         f:SetResizable(true)
--         f:SetMinResize(150, 100)

--         local rb = CreateFrame("Button", "KethoEditBoxResizeButton", KethoEditBox)
--         rb:SetPoint("BOTTOMRIGHT", -6, 7)
--         rb:SetSize(16, 16)

--         rb:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
--         rb:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
--         rb:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

--         rb:SetScript("OnMouseDown", function(self, button)
--                 if button == "LeftButton" then
--                     f:StartSizing("BOTTOMRIGHT")
--                     self:GetHighlightTexture():Hide() -- more noticeable
--                 end
--         end)
--         rb:SetScript("OnMouseUp", function(self, button)
--                 f:StopMovingOrSizing()
--                 self:GetHighlightTexture():Show()
--                 eb:SetWidth(sf:GetWidth())
--         end)
--         f:Show()
--     end

--     if text then
--         KethoEditBoxEditBox:SetText(text)
--         KethoEditBoxButton:SetText("Import Map Pins")
--     end
--     KethoEditBox:Show()
-- end

-- KethoEditBox_Show("/way uldum 29.8 20.7 \n/way uldum 29.8 25.1 \n/way uldum 34.3 19.4 \n/way uldum 34.5 21.5 \n/way uldum 45.2 15.9 \n/way uldum 52.1 28.0 \n/way uldum 50.6 31.5 \n/way uldum 46.2 44.8 \n/way uldum 40.2 43.5 \n/way uldum 40.7 49.7 \n/way uldum 38.2 60.5 \n/way uldum 33.1 59.9 \n/way uldum 33.4 62.9 \n/way uldum 30.6 60.7 \n/way uldum 30.3 62.5 \n/way uldum 31.1 66.2 \n/way uldum 52.0 51.1 \n/way uldum 51.2 50.7 \n/way uldum 50.3 72.1 \n/way uldum 72.0 44.1 \n/way uldum 73.3 73.4 \n/way uldum 25.7 65.7 \n/way uldum 31.6 69.3 \n/way uldum 30.3 62.5 \n/way uldum 28.5 63.5 \n/way uldum 33.4 28.2 \n/way uldum 50.4 73.5 \n/way uldum 49.0 75.8 \n/way uldum 69.9 57.9 \n/way uldum 51.9 49.3 \n/way uldum 52.0 51.1 \n/way uldum 51.1 50.6 \n/way uldum 51.0 79.8 \n/way uldum 25.5 51.0 \n/way uldum 33.7 25.5 \n/way uldum 40.2 38.6 \n/way uldum 33.1 71.9 \n/way uldum 32.7 47.9 \n/way uldum 22.2 64.0 \n/way uldum 47.1 76.6 \n/way uldum 47.1 78.6 \n/way uldum 24.6 60.1 \n/way uldum 38.2 60.5 \n/way uldum 64.8 30.3 \n/way uldum 38.3 55.0")
