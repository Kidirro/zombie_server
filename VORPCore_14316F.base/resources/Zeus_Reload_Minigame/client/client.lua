local MinigameActive = false
local WhitelistWeapon = false
local authorizeReload = false
local currentWeapon = 0
local checkReloadMiniGame = false

local function Minigame()
    MinigameActive = true

    Wait(100)
    local minigame = exports["syn_minigame"]:taskBar(3000, 7) -- You can add your minigame export
    if Config.Debug then
    print("Minigame Result:" .. minigame)
    end

    if minigame == 100 then
        authorizeReload = true
        print("Reload Successful")
        if Config.Debug then
        end
    else
        print("Reload Failed")
        if Config.Debug then
        end
    end

    MinigameActive = false
end

local function checkNewWeaponWhitelist()    
    WhitelistWeapon = false

    for _, weapon in ipairs(Config.WhitelistWeapon) do
        if currentWeapon == GetHashKey(weapon) then
            WhitelistWeapon = true
            if Config.Debug then
                print("Whitelist Weapon:" .. currentWeapon)
            end
            break
        end
    end
end

CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local _, tempCurrentWeapon = GetCurrentPedWeapon(playerPed, true)
        if (currentWeapon ~= tempCurrentWeapon) then
            currentWeapon = tempCurrentWeapon
            checkNewWeaponWhitelist()
        end

        
        if checkReloadMiniGame and not MinigameActive and not WhitelistWeapon and not authorizeReload
        then            
            Minigame()
            checkReloadMiniGame = false
        end

        if authorizeReload then            
            MakePedReload(playerPed)
        end
    end
end)

CreateThread(function ()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        if IsPedReloading(playerPed)
            then         
                if not authorizeReload then
                    checkReloadMiniGame = true
                    ClearPedTasks(playerPed)
                end
            else
                if not MinigameActive then
                    authorizeReload = false
                end
            end
    end
end)