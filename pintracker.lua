local core = LibStub("AceAddon-3.0"):GetAddon("MapPinEnhanced")
local module = core:NewModule("PinTracker", "AceEvent-3.0")

function module:OnInitialize()
    local MPH_Frame = CreateFrame("Frame", nil, UIParent)
    MPH_Frame:SetFrameStrata("BACKGROUND")
    MPH_Frame:SetWidth(235)
    MPH_Frame:SetHeight(500)
    MPH_Frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", core.db.profile.pintrackerpositon.x, core.db.profile.pintrackerpositon.y-500)
    MPH_Frame:SetClampedToScreen(true)
    MPH_Frame:Hide()
    module.TrackerFrame = MPH_Frame

    local tex = MPH_Frame:CreateTexture("ARTWORK")
    tex:SetAllPoints()
    tex:SetColorTexture(0, 0, 0, 0.5)
    MPH_Frame.movetexture = tex
    MPH_Frame.movetexture:Hide()

    local MPH_ObjectiveTrackerHeader = CreateFrame("frame", "MPH_ObjectiveTrackerHeader", MPH_Frame, "ObjectiveTrackerHeaderTemplate")
    MPH_ObjectiveTrackerHeader.Text:SetText("Map Pins")

    local minimizeButton = CreateFrame("button", "MPH_QuestsHeaderMinimizeButton", MPH_Frame, "BackdropTemplate")
    local minimizeButtonText = minimizeButton:CreateFontString(nil, "overlay", "GameFontNormal")
    minimizeButtonText:SetText("Map Pins")
    minimizeButtonText:SetPoint("right", minimizeButton, "left", -3, 1)
    minimizeButtonText:Hide()
    MPH_ObjectiveTrackerHeader.MinimizeButton:Hide()
    minimizeButton:SetSize(25, 25)
    minimizeButton:SetPoint("topright", MPH_ObjectiveTrackerHeader, "topright", 0, 0)
    minimizeButton:SetScript("OnClick", function() MPH_Frame:Hide() end)
    minimizeButton:SetNormalTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Up]])
    minimizeButton:SetPushedTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Down]])
    minimizeButton:SetHighlightTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]])
    minimizeButton:SetFrameStrata("LOW")

    local MoverButton = CreateFrame("button", "MPH_QuestsHeaderMoverButton", MPH_Frame, "BackdropTemplate")
    local MoverButtonText = MoverButton:CreateFontString(nil, "overlay", "GameFontNormal")
    MoverButtonText:SetText("Map Pins")
    MoverButtonText:SetPoint("right", MoverButton, "left", 0, 1)
    MoverButtonText:Hide()

    MoverButton:SetSize(25, 25)
    MoverButton:SetPoint("right", minimizeButton, "left", 0, 0)
    MoverButton:SetScript("OnClick", function()
        if MPH_Frame.movetexture:IsShown() then
            local x,y = MPH_Frame:GetLeft(), MPH_Frame:GetTop()
            MPH_Frame:ClearAllPoints()
            MPH_Frame:SetMovable(false)
            MPH_Frame:EnableMouse(false)
            if core.db.profile.pintrackerpositon.x ~= x then
                core.db.profile.pintrackerpositon.x = x
            end
            if core.db.profile.pintrackerpositon.y ~= y then
                core.db.profile.pintrackerpositon.y = y
            end
            MPH_Frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", core.db.profile.pintrackerpositon.x, core.db.profile.pintrackerpositon.y-500)
            MPH_Frame.movetexture:Hide()
        else
            MPH_Frame:SetMovable(true)
            MPH_Frame:EnableMouse(true)
            MPH_Frame:RegisterForDrag("LeftButton")
            MPH_Frame:SetScript("OnDragStart", MPH_Frame.StartMoving)
            MPH_Frame:SetScript("OnDragStop", MPH_Frame.StopMovingOrSizing)
            MPH_Frame.movetexture:Show()
        end
    end)
    MoverButton:SetNormalTexture([[Interface\Buttons\UI-Panel-SmallerButton-Up]])
    MoverButton:SetPushedTexture([[Interface\Buttons\UI-Panel-SmallerButton-Down]])
    MoverButton:SetHighlightTexture([[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]])
    MoverButton:SetFrameStrata("LOW")


    MPH_ObjectiveTrackerHeader:ClearAllPoints()
    MPH_ObjectiveTrackerHeader:SetPoint("bottom", MPH_Frame, "top", 0, -20)
    MPH_ObjectiveTrackerHeader:Show()

    function core:TogglePinTrackerWindow()
        if MPH_Frame:IsShown() then
            MPH_Frame:Hide()
        else
            MPH_Frame:Show()
        end
    end
end



function module:CreateObjective(pin)
    local Objective = CreateFrame("button", nil, module.TrackerFrame, "BackdropTemplate")
    Objective:SetSize(235, 25)
    Objective:EnableMouse(true)
    Objective:SetMouseClickEnabled(true)
    Objective.Icon = Objective:CreateTexture (nil, "BORDER")
	Objective.Icon:SetPoint ("right", Objective, "left", 20, 0)
	Objective.Icon:SetSize(25, 25)
    Objective.Title = Objective:CreateFontString(nil,"BORDER", "GameFontNormalMed3")
    Objective.Title:SetPoint ("left", Objective, "left", 23, 0)
    Objective.Icon:SetBlendMode("BLEND")
    Objective.Icon.highlightTexture = Objective:CreateTexture(nil, "HIGHLIGHT")
    Objective.Icon.highlightTexture:SetAllPoints(Objective.Icon)
    Objective.Icon.highlightTexture:SetAtlas("Waypoint-MapPin-Highlight", true)
    return Objective
end

local ObjectiveFramePool = {}
function module:UpdateObjective(pin, emit)
    if emit == "add" then
        local ReusedObjectiveFrame = table.remove(ObjectiveFramePool)
        local Objective

        if not ReusedObjectiveFrame then
            Objective = module:CreateObjective(pin)
            Objective:ClearAllPoints()
            Objective:SetPoint("topleft", module.TrackerFrame, "topleft", 0, -25)
            Objective.Title:SetText(pin.title .. " (" ..  Round(pin.x*100) .. ", " .. Round(pin.y*100) .. ")")
            Objective.Icon:SetAtlas("Waypoint-MapPin-Tracked")
            Objective:Show()
        else
            Objective = ReusedObjectiveFrame
        end
    elseif emit == "track" then
    elseif emit == "untrack" then
    elseif emit == "remove" then
    end



end
