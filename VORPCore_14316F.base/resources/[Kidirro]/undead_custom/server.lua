local zoneZombieState = {}

local activeZones = {
    --"benedictpoint",
    "fortmercer"
}

local isPedClearInProgress = false

RegisterNetEvent("zombie:newPlayer")
AddEventHandler("zombie:newPlayer", function()
    for _, value in pairs(activeZones) do
        TriggerClientEvent("zombie:setZone", source, Config.zones[value])        
    end
end)

function tableContains(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then return true end
    end
    return false
end

function tableKeys(tbl)
    local keys = {}
    for k, _ in pairs(tbl) do
        table.insert(keys, k)
    end
    return keys
end

function getPlayersInZone(zoneName)
    local result = {}
    local zone = Config.zones[zoneName]
    if not zone then return result end

    for _, playerId in ipairs(GetPlayers()) do
        local ped = GetPlayerPed(playerId)
        if ped and DoesEntityExist(ped) then
            local pos = GetEntityCoords(ped)
            if #(pos - zone.coords) <= zone.radius then
                table.insert(result, tonumber(playerId))
            end
        end
    end

    return result
end

function startZoneThread(zoneName)
    local zone = Config.zones[zoneName]
    if not zone then return end

    print("[ZoneSystem] Запуск зоны:", zoneName)

    zoneZombieState[zoneName] = {
        totalSpawned = 0,
        cooldown = 0,
        queue = {},
        lastSeenPlayer = GetGameTimer(),
        peds = {}
    }

    Citizen.CreateThread(function()
        while true do
            Wait(1000)

            local state = zoneZombieState[zoneName]
            local players = getPlayersInZone(zoneName)

            if #players > 0 then
                state.lastSeenPlayer = GetGameTimer()

                for _, playerId in ipairs(players) do
                    if not tableContains(state.queue, playerId) then
                        table.insert(state.queue, playerId)
                    end
                end
            else
                if zone.despawnRules.noPlayersTimeout then
                    local delta = GetGameTimer() - state.lastSeenPlayer
                    if delta > (zone.despawnRules.noPlayersTimeout * 1000) then
                        despawnZoneZombies(zoneName)
                        goto continue
                    end
                end
            end

            if state.cooldown > GetGameTimer() then goto continue end
            state.cooldown = GetGameTimer() + zone.spawnCooldown

            if state.totalSpawned < zone.maxZombies and #state.queue > 0 then
                local player = table.remove(state.queue, 1)
                local count = math.min(zone.zombiesPerPlayer, zone.maxZombies - state.totalSpawned)
                if (not isPedClearInProgress) then
                    TriggerClientEvent("zombie:clearNpcInZone", player)
                    isPedClearInProgress = true
                end
                TriggerClientEvent("zombie:spawnRequest", player, zoneName, count)
            end

            ::continue::
        end
    end)
end

RegisterCommand("resetZone", function(source, args,rawcommand)
    local zone = "world"
    if (args[1] ~= nil) then
        zone = args[1]
    end
    despawnZoneZombies(zone)
    zoneZombieState[zone].cooldown = math.mininteger
end, false)

function despawnZoneZombies(zoneName)
    local peds = zoneZombieState[zoneName].peds
    if not peds then return end
    if #peds == 0 then return end

    local players = GetPlayers() 
    if (#players == 0) then return end
    local randomIndex = math.random(1, #players)
    local targetPlayer = players[randomIndex]
    TriggerClientEvent("zombie:despawnZombieRequest", targetPlayer, {
        peds = peds
    })

    if zoneZombieState[zoneName] then
        zoneZombieState[zoneName].totalSpawned = 0
        zoneZombieState[zoneName].peds = {}
    end
end

RegisterNetEvent("zombie:spawned")
AddEventHandler("zombie:spawned", function(zoneName, pedIds)
    local peds = zoneZombieState[zoneName].peds
    if not peds then 
        peds = {}
    end
    local state = zoneZombieState[zoneName] 
    for _, pedId in ipairs(pedIds) do
        table.insert(peds, pedId)
        
        state.totalSpawned = state.totalSpawned + 1
    end
    state.peds = peds
    zoneZombieState[zoneName] = state
end)


RegisterNetEvent("zombie:clearNpcComplete")
AddEventHandler("zombie:clearNpcComplete", function()
    isPedClearInProgress = false
end)

Citizen.CreateThread(function()
    for _, zoneName in ipairs(activeZones) do
        if Config.zones[zoneName] then
            startZoneThread(zoneName)
        end
    end
end)