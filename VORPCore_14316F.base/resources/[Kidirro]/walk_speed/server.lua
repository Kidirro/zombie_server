RegisterNetEvent("walkstyle:change")
AddEventHandler("walkstyle:change", function(style)
    local src = source
    local animDict = ""

    if style == "generic" then
        animDict = "move_m@generic"
    elseif style == "brave" then
        animDict = "move_m@brave"
    elseif style == "injured" then
        animDict = "move_m@injured"
    else
        print("Неверный стиль: " .. tostring(style))
        return
    end

    -- Отправляем всем игрокам, чтобы они применили стиль к педу игрока
    TriggerClientEvent("walkstyle:apply", -1, src, animDict)
end)
