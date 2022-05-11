ESX = nil
local PlayerData = {}
local Ped = false
isOpen = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    Citizen.Wait(800)
    PlayerData = ESX.GetPlayerData() -- Setting PlayerData vars
end)


RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(Player)
    PlayerData = Player
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(Job)
    PlayerData.job = Job -- Setting PlayerJob on change or player loaded
end)

function GetBoss(Type)
    if PlayerData ~= nil then
        local IsBoss = false
        if PlayerData.job ~= nil and PlayerData.job.name == Type and PlayerData.job.grade_name == "boss" then
            IsBoss = true
        end
        return IsBoss 
    end
end

function OpenMafiaMenu()
    isOpen = true

    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)

    if Config.Using_Lab_Blackmarket then
        if Config.Blackmarket_Version == 1 then
            ESX.TriggerServerCallback("lab-blackmarket:getXP", function(rep)
                ESX.TriggerServerCallback("lab-MafiaMenu:getScore", function(score)

                    SendNUIMessage({
                        message		 = "show",
                        score        = score,
                        rep          = rep
                    })

                end)
            end)
        elseif Config.Blackmarket_Version == 2 then
            ESX.TriggerServerCallback("lab-blackmarketv2:getXP", function(rep)
                ESX.TriggerServerCallback("lab-MafiaMenu:getScore", function(score)

                    SendNUIMessage({
                        message		 = "show",
                        score        = score,
                        rep          = rep
                    })

                end)
            end)
        end
    else 
        ESX.TriggerServerCallback("lab-MafiaMenu:getScore", function(score)

            SendNUIMessage({
                message		 = "show",
                score        = score,
                rep          = 'NOT AVAILABLE'
            })

        end)
    end

	SetTimecycleModifier('hud_def_blur')
	
	ESX.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)

end

function Leaderboard()

    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
	
	SendNUIMessage({
		message		 = "leaderboard"
	})

    ESX.TriggerServerCallback('lab-TopCriminals:getData', function(cb)
        local count = 0
        for k,v in pairs(cb) do
            if v.type == 'gang' or v.type == 'mafia' or v.type == 'cartel' then
                SendNUIMessage({
                    message		 = "addLeaderboard",
                    label = v.label:gsub("^%l", string.upper),
                    score = v.score,
                    type = v.type:gsub("^%l", string.upper)
                })
                count = count+1
            end
            if count >= 10 then
                break
            end
        end
    end)
	
	ESX.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)

end

function Members()

    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
	
	SendNUIMessage({
		message		 = "members"
	})

    ESX.TriggerServerCallback("lab-CreateMafia:getPlayerList", function(employees)
        for k,v in pairs(employees) do
            SendNUIMessage({
                message		 = "addMembers",
                label = v.fullname,
                value = v.value
            })
        end
    end)

	
	ESX.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)

end

function closeGui()
  SetNuiFocus(false, false)
  SetTimecycleModifier('default')
  SendNUIMessage({message = "hide"})
  isOpen = false
end

RegisterNUICallback('quit', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNUICallback('recruit', function(data, cb)
    if GetBoss(PlayerData.job.name) then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestDistance > 3.0 then
        ESX.ShowNotification("No players nearby.")
        else
            TriggerServerEvent('lab-CreateMafia:recruit', GetPlayerServerId(closestPlayer), PlayerData.job.name)
        end
    else
        ESX.ShowNotification('You are not the boss!')
    end
    cb('ok')
end)

RegisterNUICallback('fire', function(data, cb)
    if GetBoss(PlayerData.job.name) then
        TriggerServerEvent('lab-CreateMafia:fire', data.item)
    else
        ESX.ShowNotification('You are not the boss!')
    end
    cb('ok')
end)

RegisterNUICallback('promote', function(data, cb)
    if GetBoss(PlayerData.job.name) then
        TriggerServerEvent('lab-CreateMafia:promote', data.item)
    else
        ESX.ShowNotification('You are not the boss!')
    end
    cb('ok')
end)

RegisterNUICallback('descend', function(data, cb)
    if GetBoss(PlayerData.job.name) then
        TriggerServerEvent('lab-CreateMafia:descend', data.item)
    else
        ESX.ShowNotification('You are not the boss!')
    end
    cb('ok')
end)

RegisterNUICallback('leaderboard', function(data, cb)
    Leaderboard()
    cb('ok')
end)

RegisterNUICallback('members', function(data, cb)
    Members()
    cb('ok')
end)

RegisterNUICallback('hideout', function(data, cb)
    if GetBoss(PlayerData.job.name) then
        TriggerServerEvent('lab-Hideouts:addHideout')
    else
        ESX.ShowNotification('You are not the boss!')
    end
    cb('ok')
end)


RegisterCommand(Config.MafiaMenuCommand, function()
    local type = exports['lab-CreateMafia']:getType()
    if type == 'gang' or type == 'mafia' or type == 'cartel' then
        if PlayerData.job.grade_name == "boss" then
            OpenMafiaMenu()
        else
            ESX.ShowNotification('You are not the boss!')
        end
    else
        ESX.ShowNotification('You are not a criminal!')
    end
end)

