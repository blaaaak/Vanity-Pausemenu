local leaveReason = (Config.leaveReason ~= '' and Config.leaveReason) or 'Thank you for playing the server!'

CreateThread(function()
    while true do
        local currentPlayers = GetNumPlayerIndices()
        TriggerClientEvent("vanity-pause:currentPlayers", -1, currentPlayers)
        Wait(30000)
    end
end)

RegisterNetEvent("vanity-pause:getMaxPlayers", function()
    local maxPlayers = GetConvarInt('sv_maxclients', 64)
    TriggerClientEvent('vanity-pause:maxPlayers', source, maxPlayers)
end)

RegisterNetEvent('vanity-pause:dropPlayer', function()
    DropPlayer(source, leaveReason)
end)
