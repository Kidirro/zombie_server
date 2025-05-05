if Config.Version ~= "VORP" then return end

local Core = exports.vorp_core:GetCore()

if Config.UseScopeItems then
    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_REPEATER_WINCHESTER_SHORT, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeRepeaterWinchesterShort", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeRepeaterWinchesterShort", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_REPEATER_HENRY_SHORT, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeRepeaterHenryShort", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeRepeaterHenryShort", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_REPEATER_EVANS_SHORT, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeRepeaterEvansShort", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeRepeaterEvansShort", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_REPEATER_CARBINE_SHORT, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeRepeaterCarbineShort", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeRepeaterCarbineShort", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_RIFLE_VARMINT_SHORT, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeRifleVarmintShort", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeRifleVarmintShort", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_RIFLE_VARMINT_MEDIUM, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeRifleVarmintMedium", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeRifleVarmintMedium", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_RIFLE_BOLTACTION_SHORT, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeRifleBoltactionShort", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeRifleBoltactionShort", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_RIFLE_BOLTACTION_MEDIM, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeRifleBoltactionMedium", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeRifleBoltactionMedium", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_RIFLE_SPRINGFIELD_SHORT, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeRifleSpringfieldShort", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeRifleSpringfieldShort", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_RIFLE_SPRINGFIELD_MEDIUM, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeRifleSpringfieldMedium", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeRifleSpringfieldMedium", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_SNIPERRIFLE_ROLLINGBLOCK_SHORT, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeSniperRifleRollingblockShort", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeSniperRifleRollingblockShort", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_SNIPERRIFLE_ROLLINGBLOCK_MEDIUM, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeSniperRifleRollingblockMedium", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeSniperRifleRollingblockMedium", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_SNIPERRIFLE_ROLLINGBLOCK_LONG, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeSniperRifleRollingblockLong", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeSniperRifleRollingblockLong", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_SNIPERRIFLE_CARCANO_SHORT, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeSniperRifleCarcanoShort", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeSniperRifleCarcanoShort", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_SNIPERRIFLE_CARCANO_MEDIUM, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeSniperRifleCarcanoMedium", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeSniperRifleCarcanoMedium", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)

    exports.vorp_inventory:registerUsableItem(Config.ScopeItems.WEAPON_SNIPERRIFLE_CARCANO_LONG, function(data)
        if Config.ScopeAttachToolRequire then
            local scopeAttachItem = exports.vorp_inventory:getItemCount(data.source, nil, Config.ScopeAttachToolItem) -- (data.source, Config.ScopeAttachToolItem)
            if scopeAttachItem > 0 then
                TriggerClientEvent("Zeus_Scope:AddScopeSniperRifleCarcanoLong", data.source)
                if Config.RemoveScopeAttachToolAfterUse then
                    exports.vorp_inventory:subItem(data.source, Config.ScopeAttachToolItem, 1)
                end
            else
                if Config.Notification.Enable then
                    Core.NotifyLeft(data.source, Config.Notification.Warning, Config.Notification.NoAttachTool, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
                end
            end
        else
            TriggerClientEvent("Zeus_Scope:AddScopeSniperRifleCarcanoLong", data.source)
        end
        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)
end

if Config.RemoveScopeWithAttachTool then
    exports.vorp_inventory:registerUsableItem(Config.ScopeAttachToolItem, function(data)
        TriggerClientEvent("Zeus_Scope:RemoveScope", data.source)

        if Config.CloseInventory then
            exports.vorp_inventory:closeInventory(data.source)
        end
    end)
end

RegisterNetEvent("Zeus_Scope:AddScopeItem", function(Item)
    if exports.vorp_inventory:canCarryItem(source, Item, 1) then
        exports.vorp_inventory:addItem(source, Item, 1)
    else
        if Config.Notification.Enable then
            Core.NotifyLeft(source, Config.Notification.Warning, Config.Notification.NoSpace, "scoretimer_textures", "scoretimer_generic_cross", Config.Notification.NotificationTime, "COLOR_RED")
        end
    end
end)

RegisterNetEvent("Zeus_Scope:RemoveScopeItem", function(Item)
    exports.vorp_inventory:subItem(source, Item, 1)
end)