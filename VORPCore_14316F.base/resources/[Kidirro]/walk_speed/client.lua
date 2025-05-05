local oldAnimation = nil
RegisterCommand("set_style", function(source, args, rawcommand)
    local animation = args[1] or "noanim"
    if oldAnimation then
        print("REMOVE ANIM " , oldAnimation);
        Citizen.InvokeNative(0xA6F67BEC53379A32, PlayerPedId(), oldAnimation)    
    end
    print("SET ANIM ", animation)
    Citizen.InvokeNative(0xCB9401F918CB0F75, PlayerPedId(), animation, 1, -1) 
    oldAnimation = animation
end, false) 

local currentSpeed = 3.0--1.2
local sprintSpeed = 3.0
local playerPed

TriggerEvent("chat:addSuggestion", "/set_walkspeed", "test", {})
RegisterCommand("set_walkspeed", function(source, args, rawcommand)    
    local selectedSpeed = tonumber(args[1])
    currentSpeed = selectedSpeed
    print("current speed", currentSpeed, type(currentSpeed))
    print("sprintSpeed speed", sprintSpeed, type(sprintSpeed))
end, false)

local function SetPlayerSpeed(speed)    
    SetPedMaxMoveBlendRatio(playerPed, speed)
end


Citizen.CreateThread(function()
    while true do        
        playerPed = PlayerPedId()
        if IsControlPressed(0, Config.Key1) then
            SetPlayerSpeed(sprintSpeed)
            Citizen.InvokeNative(0xEF5A3D2285D8924B, playerPed, 1.5)
        else    
            Citizen.InvokeNative(0xEF5A3D2285D8924B, playerPed, 1.0)
            SetPlayerSpeed(currentSpeed)
        end        
		Citizen.Wait(0)
    end
end)


RegisterCommand("giveweapon", function(source, args, rawcommand)
    
    playerPed = PlayerPedId();
    local hashWeapon = GetHashKey(args[1])
    local ammovalue = tonumber(args[2])
    if HasPedGotWeapon(playerPed, hashWeapon,false) == false then
        GiveWeaponToPed(playerPed, GetHashKey(args[1]),ammovalue, false,true)
    else
        AddAmmoToPed(playerPed,hashWeapon,ammovalue)
    end
    
end, false)

RegisterCommand("giveammo", function(source, args, rawcommand)
    local ammoType = args[1]
    local ammoTypeHash = GetHashKey(args[1])
    local ammoValue  = tonumber(args[2])
    AddAmmoToPedByType(PlayerPedId(),ammoType,ammoValue)
end, false)