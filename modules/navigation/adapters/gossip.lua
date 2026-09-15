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

Navigation:RegisterPathAdapter("gossip", GossipPresentation, GossipDataprovider)
