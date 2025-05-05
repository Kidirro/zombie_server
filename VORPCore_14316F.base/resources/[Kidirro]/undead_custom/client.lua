local zoneBlips = {}

function isPedCanSeeTarget(ped, targetPed, zoneRadius)
    local pedCords = GetEntityCoords(ped)
    local targetCords = GetEntityCoords(targetPed)
  
    return
        IsEntityVisible(ped) and 
        IsEntityVisible(targetPed) and
        not IsPedDeadOrDying(targetPed, true) and                         
        #(pedCords.xy - targetCords.xy) <= zoneRadius
end


RegisterCommand("spawnenemynpc", function(source, args,rawcommand)
    local randomIndex = math.random(#UndeadPeds)
	
	local npcHash = UndeadPeds[randomIndex].model
    local outfitId = UndeadPeds[randomIndex].outfit
    local npcCount = 1
    if (args[1] ~= nil) then
        npcCount = tonumber(args[1])
    end
    -- Проверяем, существует ли модель NPC
    local npcModel = GetHashKey(npcHash)
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(10)
    end
	
    -- Получаем игрока, вызвавшего команду
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
	
    -- Создаем группу отношений для NPC
    local npcRelationshipGroup = "UNDEAD"
    AddRelationshipGroup(npcRelationshipGroup)
    SetRelationshipBetweenGroups(5, npcRelationshipGroup, GetHashKey("PLAYER"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), npcRelationshipGroup)
	SetPedRelationshipGroupHash(playerPed,GetHashKey("PLAYER"))

    -- Спавним NPC
    for i = 1, npcCount do
        local spawnOffsetX = math.random(-3, 3)
        local spawnOffsetY = math.random(-3, 3)

        -- Спавн NPC
        local npcPed = CreatePed(npcModel, playerCoords.x + spawnOffsetX, playerCoords.y + spawnOffsetY, playerCoords.z, 0.0, true, false)
        --GiveWeaponToPed(npcPed, GetHashKey("WEAPON_MELEE_KNIFE"), 1, false, true)
		SetPedOutfitPreset(npcPed, outfitId)

        -- Выставляем походку
        local walkingStyle = Config.walkingStyles[math.random(#Config.walkingStyles)]
        Citizen.InvokeNative(0x923583741DC87BCE, npcPed, walkingStyle[1])
        Citizen.InvokeNative(0x89F5E7ADECCCB49C, npcPed, walkingStyle[2])

        -- Настраиваем боевые атрибуты NPC		
        SetPedCombatAttributes(npcPed, 46, true)
        SetPedCombatAttributes(npcPed, 5, true)
        SetPedCombatAttributes(npcPed, 0, true)
        SetPedFleeAttributes(npcPed, 0, 0)
		SetPedAsCop(npcPed, true)
		SetPedCombatMovement(npcPed, 3	)
        SetPedRelationshipGroupHash(npcPed, GetHashKey(npcRelationshipGroup))

        -- Принудительная задача нападения на всех, кроме спавнера      
		TaskCombatHatedTargetsAroundPed(npcPed, 100.0, 0)

        Citizen.CreateThread(function()            
            local lastAttackPlayer = -1
            while not IsPedDeadOrDying(npcPed, true) do
                Wait(1000) -- проверка каждую секунду
                local players = GetActivePlayers()
				local tempFlagAttack = false

                --Если есть цель атаки, то проверяем радиус преследования
                if (lastAttackPlayer ~= -1) then
                    if isPedCanSeeTarget(npcPed, lastAttackPlayer,Config.stalkingRadius) then
                        tempFlagAttack = true
                    end
                else
                    --Если цели атаки нет, то ищём в округе жертву
                    for _, player in ipairs(players) do
                        if player ~= source then -- если это не спавнер
                            local targetPed = GetPlayerPed(player)
                            if not tempFlagAttack and
                            isPedCanSeeTarget(npcPed, targetPed ,Config.detectionRadius) 
                                then
                                if (lastAttackPlayer ~= targetPed) then
                                    TaskCombatPed(npcPed, targetPed, 0, 16) -- атакуем видимого игрока
                                end
                                lastAttackPlayer = targetPed
                                tempFlagAttack = true
                            end
                        end
                    end
                end
                --Если за цикл не нашли цель - отдыхаем
				if not tempFlagAttack then	
					TaskWanderStandard(npcPed, 10.0, 10)
                    lastAttackPlayer = -1
				end
            end
        end)

       
    end

    -- Освобождаем модель
    SetModelAsNoLongerNeeded(npcModel)
end, false)

local function enumerateEntities(firstFunc, nextFunc, endFunc)
	return coroutine.wrap(function()
		local iter, id = firstFunc()

		if not id or id == 0 then
			endFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = endFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
			coroutine.yield(id)
			next, id = nextFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		endFunc(iter)
	end)
end

local function enumeratePeds()
	return enumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

local function delEnt(entity)
	--SetEntityAsMissionEntity(entity, true, true)
	DeleteEntity(entity)
	SetEntityAsNoLongerNeeded(entity)
end

RegisterCommand("delnpc", function(source, args,rawcommand)
	for ped in enumeratePeds() do
		delEnt(ped)
	end
end, false)

function SetBlipNameFromPlayerString(blip, playerString)
	return Citizen.InvokeNative(0x9CB1A1623062F402, blip, playerString)
end


RegisterNetEvent("zombie:setZone")
AddEventHandler("zombie:setZone", function(zone)
    print("Get zone", zone.name)

    if zoneBlips[zone] then
        return
    end

	local blip = BlipAddForRadius(Config.zoneBlipSprite, zone.coords, zone.radius)
	--SetBlipNameFromPlayerString(zoneBlips[zone], CreateVarString(10, "LITERAL_STRING", "Undead Infestation"))

    zoneBlips[zone] = blip

	--exports.uifeed:showSimpleRightText("An undead infestation has appeared in " .. zone.name, 5000)
end)

Citizen.CreateThread(function ()
    print("Try get zone")
    TriggerServerEvent("zombie:newPlayer")
end)