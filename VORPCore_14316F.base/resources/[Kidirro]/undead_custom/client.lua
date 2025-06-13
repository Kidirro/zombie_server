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

function getGroundZ(x, y, zStart)
    local success, groundZ = GetGroundZFor_3dCoord(x, y, zStart or 1000.0, 0)
    if success then
        return groundZ
    else
        return zStart or 1000.0 -- если не найден, спавним высоко (пед упадёт)
    end
end

function spawnZombie(centerCoords, radius)
    local randomIndex = math.random(#UndeadPeds)
	
	local npcHash = UndeadPeds[randomIndex].model
    local outfitId = UndeadPeds[randomIndex].outfit
    -- Проверяем, существует ли модель NPC
    local npcModel = GetHashKey(npcHash)
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(10)
    end
	
    -- Получаем игрока, вызвавшего команду
    local playerPed = PlayerPedId()
	
    -- Создаем группу отношений для NPC
    local npcRelationshipGroup = "UNDEAD"
    AddRelationshipGroup(npcRelationshipGroup)
    SetRelationshipBetweenGroups(5, npcRelationshipGroup, GetHashKey("PLAYER"))
    SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), npcRelationshipGroup)
	SetPedRelationshipGroupHash(playerPed,GetHashKey("PLAYER"))

    -- Спавним NPC
    local spawnOffsetX = math.random(-radius, radius)
    local spawnOffsetY = math.random(-radius, radius)

    local spawnX = centerCoords.x + spawnOffsetX
    local spawnY = centerCoords.y + spawnOffsetY;
    local spawnZ = centerCoords.z

    -- Получаем координату Z земли
    local success, groundZ = GetGroundZFor_3dCoord(spawnX, spawnY, spawnZ, 0)

    if success then
        spawnZ = groundZ
    else
        -- fallback если земля не найдена
        -- spawnZ = spawnZ
    end

    -- Спавн NPC
    local npcPed = CreatePed(npcModel, spawnX, spawnY, spawnZ, 0.0, true, false)
    if npcPed == 0 then
        return nil, false
    end

    local netId = NetworkGetNetworkIdFromEntity(npcPed)

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
    
	SetEntityMaxHealth(npcPed, Config.undeadHealth)
	SetEntityHealth(npcPed, Config.undeadHealth, 0)

    -- через Citizen.InvokeNative:
    Citizen.InvokeNative(0xA8A024587329F36A, netId, true) -- SetNetworkIdCanMigrate
    Citizen.InvokeNative(0xE05E81A888FA63C8, npcPed, true, true) -- SetEntityAsMissionEntity
    Citizen.InvokeNative(0x1B5C85C612E5256E, netId, true)      -- виден всем клиентам

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

    -- Освобождаем модель
    SetModelAsNoLongerNeeded(npcModel)
    return npcPed, true
end


RegisterCommand("spawnenemynpc", function(source, args,rawcommand)
    local npcCount = 1
    if (args[1] ~= nil) then
        npcCount = tonumber(args[1])
    end
    local coords = GetEntityCoords(PlayerPedId())
    local radius = 5
    for i = 1, npcCount do
        spawnZombie(coords, radius)
    end
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

    if zoneBlips[zone.name] then
        return
    end

	local blip = BlipAddForRadius(Config.zoneBlipSprite, zone.coords, zone.radius)
	local blip_dev = BlipAddForRadius(Config.zoneBlipSprite, zone.coords, zone.spawnRadius)
	--SetBlipNameFromPlayerString(zoneBlips[zone], CreateVarString(10, "LITERAL_STRING", "Undead Infestation"))
    
    zoneBlips[zone.name] = blip
    table.insert(zoneBlips,blip_dev)
end)

Citizen.CreateThread(function ()
    print("Try get zone")
    TriggerServerEvent("zombie:newPlayer")
end)

RegisterNetEvent("zombie:spawnRequest")
AddEventHandler("zombie:spawnRequest", function(zoneName, count)
    local spawned = {}
    local zone = Config.zones[zoneName]
    for i = 1, count do
        local ped, isSpawned = spawnZombie(zone.coords,zone.spawnRadius ) -- замените на корректный вызов
        if (isSpawned) then            
            table.insert(spawned, ped)        
        end
    end
    TriggerServerEvent("zombie:spawned", zoneName, spawned)
end)

RegisterNetEvent("zombie:despawnRequest")
AddEventHandler("zombie:despawnRequest", function(data)    
    if (#data.peds == 0) then return end
       for _, netId in ipairs(data.peds) do
        local ped = NetworkGetEntityFromNetworkId(netId)
        if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
            if not NetworkHasControlOfEntity(ped) then
                NetworkRequestControlOfEntity(ped)
                local timeout = GetGameTimer() + 2000
                while not NetworkHasControlOfEntity(ped) and GetGameTimer() < timeout do
                    Wait(10)
                    NetworkRequestControlOfEntity(ped)
                end
            end

            if NetworkHasControlOfEntity(ped) then
                DeletePed(ped)
            else
                print("[X] Не удалось получить контроль над педом:", ped)
            end
        end
    end
end)


RegisterCommand("clearBlips", function(source, args,rawcommand)
    for _, blips in ipairs(zoneBlips) do
        RemoveBlip(blips)
    end
end, false)