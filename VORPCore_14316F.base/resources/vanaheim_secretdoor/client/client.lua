-- client.lua

local doorCoords   = vector3(2858.86279296875, -1194.91650390625, 47.9914436340332)
local doorModel    = GetHashKey("s_clothingcasedoor01x")
local doorYawFrom  = 94.99993896484375
local doorYawTo    = -174.60012817382812
local isDoorOpen   = false

local trap1Coords    = vector3(1326.0380859375, -1326.38330078125, 76.92235565185547)
local trap1Model     = GetHashKey("p_gunsmithtrapdoor01x")
local trap1PitchFrom = 0.0
local trap1PitchTo   = -89.89913177490234
local trap1Yaw       = 165.00001525878906
local isTrap1Open    = false

local trap2Coords    = vector3(-1790.7442626953125, -390.150390625, 159.28944396972656)
local trap2Model     = GetHashKey("p_trapdoor01x")
local trap2PitchFrom = 0.0
local trap2PitchTo   = -90.0
local trap2Yaw       = 145.08792114257812
local isTrap2Open    = false

local trap3Coords    = vector3(1259.873779296875, -406.4928283691406, 96.62239837646484)
local trap3Model     = GetHashKey("p_gunsmithtrapdoor01x")
local trap3PitchFrom = 0.0
local trap3PitchTo   = -90.0
local trap3Yaw       = 4.99995708465576
local isTrap3Open    = false

local doorGroup   = GetRandomIntInRange(0, 0xffffff)
local trap1Group  = GetRandomIntInRange(0, 0xffffff)
local trap2Group  = GetRandomIntInRange(0, 0xffffff)
local trap3Group  = GetRandomIntInRange(0, 0xffffff)

local doorPrompt, trap1Prompt, trap2Prompt, trap3Prompt

local function CreateAllPrompts()
    doorPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
    PromptSetControlAction(doorPrompt, 0x760A9C6F)
    PromptSetText(doorPrompt, CreateVarString(10, 'LITERAL_STRING', 'Open/Close Door'))
    PromptSetEnabled(doorPrompt, true)
    PromptSetVisible(doorPrompt, true)
    PromptSetHoldMode(doorPrompt, true)
    PromptSetGroup(doorPrompt, doorGroup)
    PromptRegisterEnd(doorPrompt)

    trap1Prompt = Citizen.InvokeNative(0x04F97DE45A519419)
    PromptSetControlAction(trap1Prompt, 0x760A9C6F)
    PromptSetText(trap1Prompt, CreateVarString(10, 'LITERAL_STRING', 'Open/Close TrapDoor'))
    PromptSetEnabled(trap1Prompt, true)
    PromptSetVisible(trap1Prompt, true)
    PromptSetHoldMode(trap1Prompt, true)
    PromptSetGroup(trap1Prompt, trap1Group)
    PromptRegisterEnd(trap1Prompt)

    trap2Prompt = Citizen.InvokeNative(0x04F97DE45A519419)
    PromptSetControlAction(trap2Prompt, 0x760A9C6F)
    PromptSetText(trap2Prompt, CreateVarString(10, 'LITERAL_STRING', 'Open/Close TrapDoor'))
    PromptSetEnabled(trap2Prompt, true)
    PromptSetVisible(trap2Prompt, true)
    PromptSetHoldMode(trap2Prompt, true)
    PromptSetGroup(trap2Prompt, trap2Group)
    PromptRegisterEnd(trap2Prompt)

    trap3Prompt = Citizen.InvokeNative(0x04F97DE45A519419)
    PromptSetControlAction(trap3Prompt, 0x760A9C6F)
    PromptSetText(trap3Prompt, CreateVarString(10, 'LITERAL_STRING', 'Open/Close TrapDoor'))
    PromptSetEnabled(trap3Prompt, true)
    PromptSetVisible(trap3Prompt, true)
    PromptSetHoldMode(trap3Prompt, true)
    PromptSetGroup(trap3Prompt, trap3Group)
    PromptRegisterEnd(trap3Prompt)
end

Citizen.CreateThread(function()
    CreateAllPrompts()

    while true do
        local sleep = 500
        local ped   = PlayerPedId()
        local pos   = GetEntityCoords(ped)

        if #(pos - doorCoords) < 2.5 then -- <<< Distance Do View Prompt
            sleep = 0
            PromptSetActiveGroupThisFrame(doorGroup, CreateVarString(10, 'LITERAL_STRING', 'Open/Close Door'))
            if PromptHasHoldModeCompleted(doorPrompt) then

                -- EXEMPLE TO CREATE A ANIMATIONS TO OPEN DOORS -- 

                -- local playerPed = PlayerPedId()
                -- local animDict = "mech_pickup@loot@cash_register@open"
                -- local animName = "enter_short" 
                -- local speed = 8.0 
                -- local speedX = 3.0 
                -- local duration = 1000
                -- local flags = 1
                -- loadAnimDict(animDict)
                -- TaskPlayAnim(playerPed, animDict, animName, speed, speedX, duration, flags, 0, false, false, false)
                -- Wait(1000)

                TriggerServerEvent("syncRotateDoor")
                Citizen.Wait(2000)
            end
        end

        if #(pos - trap1Coords) < 2.5 then -- <<< Distance Do View Prompt
            sleep = 0
            PromptSetActiveGroupThisFrame(trap1Group, CreateVarString(10, 'LITERAL_STRING', 'Open/Close TrapDoor'))
            if PromptHasHoldModeCompleted(trap1Prompt) then

                -- EXEMPLE TO CREATE A ANIMATIONS TO OPEN DOORS -- 

                -- local playerPed = PlayerPedId()
                -- local animDict = "mech_pickup@loot@cash_register@open"
                -- local animName = "enter_short" 
                -- local speed = 8.0 
                -- local speedX = 3.0 
                -- local duration = 1000
                -- local flags = 1
                -- loadAnimDict(animDict)
                -- TaskPlayAnim(playerPed, animDict, animName, speed, speedX, duration, flags, 0, false, false, false)
                -- Wait(1000)

                TriggerServerEvent("syncRotateTrapdoor")
                Citizen.Wait(2000)
            end
        end

        if #(pos - trap2Coords) < 2.5 then -- <<< Distance Do View Prompt
            sleep = 0
            PromptSetActiveGroupThisFrame(trap2Group, CreateVarString(10, 'LITERAL_STRING', 'Open/Close TrapDoor'))
            if PromptHasHoldModeCompleted(trap2Prompt) then

                -- EXEMPLE TO CREATE A ANIMATIONS TO OPEN DOORS -- 

                -- local playerPed = PlayerPedId()
                -- local animDict = "mech_pickup@loot@cash_register@open"
                -- local animName = "enter_short" 
                -- local speed = 8.0 
                -- local speedX = 3.0 
                -- local duration = 1000
                -- local flags = 1
                -- loadAnimDict(animDict)
                -- TaskPlayAnim(playerPed, animDict, animName, speed, speedX, duration, flags, 0, false, false, false)
                -- Wait(1000)

                TriggerServerEvent("syncRotateTrapdoor2")
                Citizen.Wait(2000)
            end
        end

        if #(pos - trap3Coords) < 2.5 then -- <<< Distance Do View Prompt
            sleep = 0
            PromptSetActiveGroupThisFrame(trap3Group, CreateVarString(10, 'LITERAL_STRING', 'Open/Close TrapDoor'))
            if PromptHasHoldModeCompleted(trap3Prompt) then

                -- EXEMPLE TO CREATE A ANIMATIONS TO OPEN DOORS -- 

                -- local playerPed = PlayerPedId()
                -- local animDict = "mech_pickup@loot@cash_register@open"
                -- local animName = "enter_short" 
                -- local speed = 8.0 
                -- local speedX = 3.0 
                -- local duration = 1000
                -- local flags = 1
                -- loadAnimDict(animDict)
                -- TaskPlayAnim(playerPed, animDict, animName, speed, speedX, duration, flags, 0, false, false, false)
                -- Wait(1000)

                TriggerServerEvent("syncRotateTrapdoor3")
                Citizen.Wait(2000)
            end
        end

        Citizen.Wait(sleep)
    end
end)

local function smoothRotate(entity, fromAngle, toAngle, setter)
    local delta = toAngle - fromAngle
    if     delta >  180.0 then delta = delta - 360.0
    elseif delta < -180.0 then delta = delta + 360.0
    end
    local duration = 2000
    local t0       = GetGameTimer()
    Citizen.CreateThread(function()
        while true do
            local elapsed = GetGameTimer() - t0
            local t       = math.min(elapsed / duration, 1.0)
            local angle   = fromAngle + delta * t
            setter(entity, angle)
            if t >= 1.0 then break end
            Wait(0)
        end
    end)
end

local function RotateDoor()
    local ent = GetClosestObjectOfType(doorCoords.x, doorCoords.y, doorCoords.z, 1.0, doorModel, false, false, false)
    if ent == 0 then return end
    local from, to = doorYawFrom, doorYawTo
    if isDoorOpen then from, to = doorYawTo, doorYawFrom end
    smoothRotate(ent, from, to, function(e, a) SetEntityHeading(e, a) end)
    isDoorOpen = not isDoorOpen
end

local function RotateTrap1()
    local ent = GetClosestObjectOfType(trap1Coords.x, trap1Coords.y, trap1Coords.z, 1.0, trap1Model, false, false, false)
    if ent == 0 then return end
    local from, to = trap1PitchFrom, trap1PitchTo
    if isTrap1Open then from, to = trap1PitchTo, trap1PitchFrom end
    smoothRotate(ent, from, to, function(e, a) SetEntityRotation(e, a, 0.0, trap1Yaw, 2, true) end)
    isTrap1Open = not isTrap1Open
end

local function RotateTrap2()
    local ent = GetClosestObjectOfType(trap2Coords.x, trap2Coords.y, trap2Coords.z, 1.0, trap2Model, false, false, false)
    if ent == 0 then return end
    local from, to = trap2PitchFrom, trap2PitchTo
    if isTrap2Open then from, to = trap2PitchTo, trap2PitchFrom end
    smoothRotate(ent, from, to, function(e, a) SetEntityRotation(e, a, 0.0, trap2Yaw, 2, true) end)
    isTrap2Open = not isTrap2Open
end

local function RotateTrap3()
    local ent = GetClosestObjectOfType(trap3Coords.x, trap3Coords.y, trap3Coords.z, 1.0, trap3Model, false, false, false)
    if ent == 0 then return end
    local from, to = trap3PitchFrom, trap3PitchTo
    if isTrap3Open then from, to = trap3PitchTo, trap3PitchFrom end
    smoothRotate(ent, from, to, function(e, a) SetEntityRotation(e, a, 0.0, trap3Yaw, 2, true) end)
    isTrap3Open = not isTrap3Open
end

RegisterNetEvent("rotateDoorProp",         RotateDoor)
RegisterNetEvent("rotateTrapdoorProp",     RotateTrap1)
RegisterNetEvent("rotateTrapdoor2Prop",    RotateTrap2)
RegisterNetEvent("rotateTrapdoor3Prop",    RotateTrap3)

RegisterCommand("passagem",        function() TriggerServerEvent("syncRotateDoor") end,      false)
RegisterCommand("toggletrapdoor",  function() TriggerServerEvent("syncRotateTrapdoor") end,  false)
RegisterCommand("toggletrapdoor2", function() TriggerServerEvent("syncRotateTrapdoor2") end, false)
RegisterCommand("toggletrapdoor3", function() TriggerServerEvent("syncRotateTrapdoor3") end, false)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end
