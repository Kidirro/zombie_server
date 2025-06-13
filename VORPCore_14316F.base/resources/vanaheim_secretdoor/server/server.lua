-- server.lua

RegisterNetEvent("syncRotateDoor")
AddEventHandler("syncRotateDoor", function()
    TriggerClientEvent("rotateDoorProp", -1)
end)

RegisterNetEvent("syncRotateTrapdoor")
AddEventHandler("syncRotateTrapdoor", function()
    TriggerClientEvent("rotateTrapdoorProp", -1)
end)

RegisterNetEvent("syncRotateTrapdoor2")
AddEventHandler("syncRotateTrapdoor2", function()
    TriggerClientEvent("rotateTrapdoor2Prop", -1)
end)

RegisterNetEvent("syncRotateTrapdoor3")
AddEventHandler("syncRotateTrapdoor3", function()
    TriggerClientEvent("rotateTrapdoor3Prop", -1)
end)
