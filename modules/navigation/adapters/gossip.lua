---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

local function GossipPresentation()
    return "ChatBallon", L["Navigation Method NPC Travel"], L["Navigation Talk To NPC"]
end

local function GossipDataprovider(path)
    local gossip = path.gossip ---@type NavigationStaticGossip?
    if type(gossip) ~= "table" or type(gossip.npcID) ~= "number" or
        type(gossip.gossipOptionID) ~= "number" then
        return nil, "missing gossip identity"
    end
    local npcID = gossip.npcID
    local gossipOptionID = gossip.gossipOptionID
    return { npcID = npcID, gossipOptionID = gossipOptionID }
end

local activeContext ---@type NavigationActivePathContext?
local activeReport ---@type NavigationPathReport?
local selectedOptionID ---@type number?
local gossipOpen = false

local function SelectTravelOption()
    local context, report = activeContext, activeReport
    if not gossipOpen or not context or not report or context.phase == "in-transit" or
        selectedOptionID or InCombatLockdown() then
        return
    end
    local guid = UnitGUID("npc")
    if MapPinEnhanced:IsSecretValue(guid) or type(guid) ~= "string" then return end
    local npcID = select(6, strsplit("-", guid))
    local data = context.data ---@type NavigationStaticGossip
    if tonumber(npcID) ~= data.npcID then return end
    for _, option in ipairs(C_GossipInfo.GetOptions()) do
        if not MapPinEnhanced:IsSecretTable(option) and
            not MapPinEnhanced:IsSecretValue(option.gossipOptionID) and
            not MapPinEnhanced:IsSecretValue(option.status) and
            option.gossipOptionID == data.gossipOptionID and option.status == Enum.GossipOptionStatus.Available then
            -- Set the guard before selection: it can synchronously close gossip.
            -- Selection is only an attempt; the destination still proves arrival.
            selectedOptionID = data.gossipOptionID
            C_GossipInfo.SelectOption(data.gossipOptionID)
            report("attempted")
            return
        end
    end
end

local function Activate(context, report)
    activeContext, activeReport = context, report
    SelectTravelOption()
end

local function Deactivate()
    activeContext, activeReport, selectedOptionID = nil, nil, nil
end

MapPinEnhanced:RegisterEvent("GOSSIP_SHOW", function()
    gossipOpen = true
    SelectTravelOption()
end)
MapPinEnhanced:RegisterEvent("GOSSIP_CLOSED", function()
    gossipOpen = false
    selectedOptionID = nil
end)

Navigation:RegisterPathAdapter("gossip", GossipPresentation, GossipDataprovider, nil, Activate, Deactivate)
