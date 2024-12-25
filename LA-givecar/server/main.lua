ESX = exports['es_extended']:getSharedObject()

-- Register the givecartogarage command
RegisterCommand('givecartogarage', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

    -- Check if the player is an admin
    if xPlayer.getGroup() == Config.AdminGroup then
        -- Check if the correct number of arguments are provided
        if #args == 3 then
            local targetId = tonumber(args[1])
            local model = args[2]
            local plate = args[3]

            -- Check if the target player exists
            local targetPlayer = ESX.GetPlayerFromId(targetId)
            if targetPlayer then
                local playerIdentifier = targetPlayer.getIdentifier()
                
                -- Save the vehicle to the player's garage
                MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
                    ['@owner'] = playerIdentifier,
                    ['@plate'] = plate,
                    ['@vehicle'] = json.encode({model = model, plate = plate})
                }, function(rowsChanged)
                    TriggerClientEvent('esx:showNotification', source, 'Vehicle given to player\'s garage successfully.')
                    TriggerClientEvent('esx:showNotification', targetId, 'You have received a new vehicle in your garage!')
                end)
            else
                TriggerClientEvent('esx:showNotification', source, 'Player not found.')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'Usage: /givecartogarage [id] [model] [plate]')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'You do not have permission to use this command.')
    end
end, false)