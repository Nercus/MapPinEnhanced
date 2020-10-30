do
    function SuperTrackedFrameMixin:GetTargetAlphaBaseValue()
        if C_Navigation.GetDistance() > 10 then
            return 1
        else
            if C_Navigation.GetDistance() <= 3 then
                return 0
            else
                return C_Navigation.GetDistance()/10
            end
        end
    end
    
    local function findZone(z,s)
        for i=0,2000 do
            if C_Map.GetMapInfo(i) then
                local m = C_Map.GetMapInfo(i)
                if string.lower(m.name) == z then
                    if s ~= 0 then
                        if m.parentMapID == s then
                            return i
                        end
                    else
                        return i;
                    end
                end
            end
        end
    end

    SLASH_UMPD1 = "/uway";
    SLASH_UMPD2 = "/pin";

    if not IsAddOnLoaded("TomTom") and not IsAddOnLoaded("SlashPin") then
        SLASH_UMPD3 = "/way";
    end

    SlashCmdList["UMPD"] = function(msg)
        msg = msg and string.lower(msg)
        local c = {}
        local p="player" 
        local u=C_Map.GetBestMapForUnit(p) 
        local m=C_Map.GetPlayerMapPosition(u,p) 
        c.z = string.match(msg, "([a-z%s'`]+)");
        c.s = string.match(msg, ":([a-z%s'`]+)");
        c.x, c.y = string.match(msg, "(%d*%.?%d+)%s(%d*%.?%d+)");
        if not c.y then
            c.x, c.y = string.match(msg, "(%d*%.?%d+),(%d*%.?%d+)");
        end
        if not c.y then
            c.x, c.y = string.match(msg, "(%d*%.?%d+), (%d*%.?%d+)");
        end

        if c.x and c.y then
            if c.z and string.len(c.z) > 1 then
                c.z = string.gsub(c.z, '[ \t]+%f[\r\n%z]', '')
                local sub = 0
                if c.s and string.len(c.s) > 0 then
                    c.s = string.gsub(c.s, '[ \t]+%f[\r\n%z]', '')
                    sub = findZone(c.s,0)
                end
                u = findZone(c.z,sub)
            end

            C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(u,tonumber(c.x)/100,tonumber(c.y)/100));
            C_SuperTrack.SetSuperTrackedUserWaypoint(true);
        end
    end
end