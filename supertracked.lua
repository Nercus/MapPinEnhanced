function SuperTrackedFrameMixin:GetTargetAlpha()
    local distance = C_Navigation.GetDistance()
    if distance > 10 then
        return 1
    else
        if distance < 5 then
            return 0
        else
            return distance / 10
        end
    end
end
