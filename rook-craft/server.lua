local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('rook-craft:server:giveitem')
AddEventHandler('rook-craft:server:giveitem', function(itemName, amount, requiredItems)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    for _, item in pairs(requiredItems) do
        local itemCount = Player.Functions.GetItemByName(item.item)
        local requiredAmount = item.amount * amount

        if not itemCount or itemCount.amount < requiredAmount then
            break
        end
    end

    Player.Functions.AddItem(itemName, amount)
end)


QBCore.Functions.CreateCallback('rook-craft:server:checkmaterials', function(source, cb, items, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    local hasMaterials = true

    for _, item in pairs(items) do
        local itemCount = Player.Functions.GetItemByName(item.item)
        if not itemCount or itemCount.amount < (item.amount * amount) then
            hasMaterials = false
            break
        end
    end


    if hasMaterials then
        for _, item in pairs(items) do
            Player.Functions.RemoveItem(item.item, item.amount * amount)
        end
    end

    cb(hasMaterials)
end)
