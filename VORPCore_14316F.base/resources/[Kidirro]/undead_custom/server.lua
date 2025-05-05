local activeZones = {
    "benedictpoint",
    "fortmercer"
}

local function getPlayersInZones()
        local result = {}
    for _, zoneName in ipairs(activeZones) do
        local zone = Config.zones[zoneName]
        result[zoneName] = {}

        for _, playerId in ipairs(GetPlayers()) do
            local ped = GetPlayerPed(playerId)
            if ped and DoesEntityExist(ped) then
                local pos = GetEntityCoords(ped)
                if #(pos - zone.coords) <= zone.radius then
                    table.insert(result[zoneName], playerId)
                end
            end
        end
    end

    return result
end

Citizen.CreateThread(function ()
    while true do
        Wait(Config.playerListCheckTime)
        local zonePlayers = getPlayersInZones()

--        for zoneName, players in pairs(zonePlayers) do
--            print(("Зона: %s | Игроков внутри: %d"):format(zoneName, #players))
--            for _, playerId in ipairs(players) do
--                print("  - Игрок ID: " .. playerId)
--            end
--        end
    end
end)

RegisterNetEvent("zombie:newPlayer")
AddEventHandler("zombie:newPlayer", function()
    print("get init trying",source)
    for _, value in pairs(activeZones) do
        TriggerClientEvent("zombie:setZone", source, Config.zones[value])        
    end
end)

local zombiePeds = {}
local zoneZombieState = {}

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
        lastSeenPlayer = GetGameTimer()
    }

    zombiePeds[zoneName] = {}

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
                if zone.despawnRules.noPlayers then
                    despawnZoneZombies(zoneName, "noPlayers")
                    goto continue
                end

                if zone.despawnRules.noPlayersTimeout then
                    local delta = GetGameTimer() - state.lastSeenPlayer
                    if delta > (zone.despawnRules.noPlayersTimeout * 1000) then
                        despawnZoneZombies(zoneName, "timeout")
                        goto continue
                    end
                end
            end

            if state.cooldown > GetGameTimer() then goto continue end
            state.cooldown = GetGameTimer() + zone.spawnCooldown

            if state.totalSpawned < zone.maxZombies and #state.queue > 0 then
                local player = table.remove(state.queue, 1)
                local count = math.min(zone.zombiesPerPlayer, zone.maxZombies - state.totalSpawned)
                TriggerClientEvent("zombie:spawnRequest", player, zoneName, count)
            end

            ::continue::
        end
    end)
end