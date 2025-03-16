local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for pedName, v in pairs(Config.CraftPeds) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
            Wait(500)
        end

        local ped = CreatePed(4, GetHashKey(v.model), v.coords.x, v.coords.y, v.coords.z - 1.0, v.coords.w, false, true)
        SetEntityInvincible(ped, true) 
        SetEntityAsMissionEntity(ped, true, true)
        FreezeEntityPosition(ped, true) 
        SetBlockingOfNonTemporaryEvents(ped, true) 
        
        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    icon = "fas fa-hammer",
                    label = v.label,
                    action = function()
                        OpenCraftMenu(v.items)
                    end
                }
            },
            distance = 2.5
        })
    end
end)

function OpenCraftMenu(items)
    local options = {}

    for itemName, itemData in pairs(items) do
        table.insert(options, {
            title = itemData.label,
            description = Locales("required_items").. ' ' .. GetItemRequirements(itemData.requiredItems),
            icon = "fa-solid fa-hammer",
            onSelect = function()
                OpenCraftInput(itemName, itemData)
            end
        })
    end

    lib.registerContext({
        id = "craft_menu",
        title = Locales("menu_header"),
        options = options
    })

    lib.showContext("craft_menu")
end

function GetItemRequirements(items)
    local text = ""
    for _, v in pairs(items) do
        text = text .. v.amount .. "x " .. v.item .. "  "
    end
    return text
end

function OpenCraftInput(itemName, itemData)
    local input = lib.inputDialog(Locales("select_craft_amount"), {
        {type = 'number', label = Locales("enter_craft_amount"), min = 1, default = 1}
    })

    if input and input[1] then
        local craftAmount = tonumber(input[1])
        if craftAmount and craftAmount > 0 then
            StartCrafting(itemName, itemData, craftAmount)
        else
            QBCore.Functions.Notify(Locales("invalid_amount"), "error")
        end
    end
end

function StartCrafting(itemName, itemData, amount)
    QBCore.Functions.TriggerCallback('rook-craft:server:checkmaterials', function(hasMaterials)
        if hasMaterials then
            QBCore.Functions.Progressbar("crafting", Locales("crafting_in_progress"), amount * itemData.time, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                TriggerServerEvent('rook-craft:server:giveitem', itemName, amount, itemData.requiredItems)
                QBCore.Functions.Notify(Locales("craft_complete") .. " " .. amount .. "x " .. itemData.label, "success")
            end)
        else
            QBCore.Functions.Notify(Locales("not_enough_materials"), "error")
        end
    end, itemData.requiredItems, amount)
end



