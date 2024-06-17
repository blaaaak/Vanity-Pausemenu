CreateThread(function()
    while true do
        TriggerClientEvent("vanity-pause:currentPlayers", -1, GetNumPlayerIndices())
        Wait(30000)
    end
end)

RegisterNetEvent("vanity-pause:getMaxPlayers", function()
    TriggerClientEvent('vanity-pause:maxPlayers', source, GetConvarInt('sv_maxclients', 64))
end)

RegisterNetEvent('vanity-pause:dropPlayer', function()
    DropPlayer(source, (Config.leaveReason ~= '' and Config.leaveReason) or 'Thank you for playing the server!')
end)
