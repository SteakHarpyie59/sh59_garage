ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	if Config.UsePed == true then
    	for _,v in pairs(Config.Garages) do
      		RequestModel(GetHashKey(v[6]))
      		while not HasModelLoaded(GetHashKey(v[6])) do
        	Wait(1)
      	end
  

      	ped =  CreatePed(4, GetHashKey(v[6]), v[1], 3374176, false, true)
      	SetEntityHeading(ped, v[2])
      	FreezeEntityPosition(ped, true)
	  	SetEntityInvincible(ped, true)

      	SetBlockingOfNonTemporaryEvents(ped, true)
		end
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	for _, v in pairs(Config.Garages) do
		if v[5] == true then
			local blip = AddBlipForCoord(v[1]) 						-- BLIP POSITION
        	SetBlipSprite(blip, Config.BlipType) 					-- BLIP TYPE
       		SetBlipScale (blip, Config.BlipSize) 					-- BLIP SIZE
        	SetBlipColour(blip, Config.BlipColour) 					-- BLIP COLOR
        	SetBlipAsShortRange(blip, true)
        	BeginTextCommandSetBlipName('STRING')
        	AddTextComponentString(Config.BlipText) 				-- BLIP TEXT
        	EndTextCommandSetBlipName(blip)
		end
	end
end)

Citizen.CreateThread(function()
	if Config.UsePed == false then
    	while true do
        	Wait(0)
        	for _, v in pairs(Config.Garages) do
        	    DrawMarker(1, v[1], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true, false, false, false)
        	end
    	end
	end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        for key, value in pairs(Config.Garages) do
            local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), value[1])

            if dist <= 2.0 then
                ESX.ShowHelpNotification(Config.Locale.OpenKeyPrompt)

                if IsControlJustReleased(0, 38) then
					OpenGarage(key)
                end
            end
        end
    end
end)

function OpenGarage(garage)
	if Config.UseNUI == true then
		OpenGarageNui(garage)
	else
		OpenGarageEsxMenu(garage)
	end
end

function OpenGarageEsxMenu(garage)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_main_menu', {
		title 		= Config.Locale.MainMenuTitle,
		align		= "top-right",
		elements	= {
			{label = Config.Locale.mmParkOut, value = "park-out"},
			{label = Config.Locale.mmParkIn, value = "park-in"}
		}

	}, function(data, menu)

		if data.current.value == 'park-out' then
			OpenParkOutESXMenu(garage)
		elseif data.current.value == 'park-in' then
			OpenParkInESXMenu(garage)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenParkOutESXMenu(garage)
	local permitted_vehicle_entrys = {}

	ESX.TriggerServerCallback("sh59_Garage:GetPermittedVehicles", function(result) 
		for _,v in pairs(result) do
			props = v.vehicle
			xLabel = '<FONT COLOR="YELLOW">'..v.plate.."</FONT> - "..GetLabelText(GetDisplayNameFromVehicleModel(props.model))
			table.insert(permitted_vehicle_entrys, {label = xLabel, value = "availible_vehs_menu", valdata = props})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'show_owned_vehicles_menu', {
			title 		= Config.Locale.mmParkOut,
			align		= "top-right",
			elements	= permitted_vehicle_entrys
		}, function(data, menu)
	
			if data.current.value == 'availible_vehs_menu' then
				SpawnVehicle(data.current.valdata, garage)
				ESX.UI.Menu.CloseAll()
			end
	
		end, function(data, menu)
			menu.close()
		end)

	end) 
end

function SpawnVehicle(vehdata, garage)
    local props = vehdata

    ESX.Game.SpawnVehicle(props.model, Config.Garages[garage][3], Config.Garages[garage][4], function(callback_vehicle)
        ESX.Game.SetVehicleProperties(callback_vehicle, props)
        SetVehRadioStation(callback_vehicle, "OFF")
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
    end)

	TriggerServerEvent('sh59_Garage:changeState', props.plate, 0)
end

function OpenParkInESXMenu(garage)
	local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)
	local permitted_vehicle_entrys = {}

    for _, v in pairs(vehicles) do
        ESX.TriggerServerCallback('sh59_Garage:CheckIfOwned', function(owned)
		
			if owned then
				xLabel = '<FONT COLOR="YELLOW">'..GetVehicleNumberPlateText(v).."</FONT> - "..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(value)))
				table.insert(permitted_vehicle_entrys, {label = xLabel, value = "availible_parkin_vehs_menu", valdata = GetVehicleNumberPlateText(v)})
            end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'show_parkin_vehs', {
				title 		= Config.Locale.mmParkIn,
				align		= "top-right",
				elements	= permitted_vehicle_entrys
			}, function(data, menu)
		
				if data.current.value == 'availible_parkin_vehs_menu' then
					for key, value in pairs(vehicles) do
						if GetVehicleNumberPlateText(value) == data.current.valdata then
							TriggerServerEvent('sh59_Garage:saveProps', data.current.valdata, ESX.Game.GetVehicleProperties(value))
							TriggerServerEvent('sh59_Garage:changeState', data.current.valdata, 1)
							ESX.Game.DeleteVehicle(value)
						end
					end
					ESX.UI.Menu.CloseAll()
				end
		
			end, function(data, menu)
				menu.close()
			end)
    
        end, GetVehicleNumberPlateText(v))
    end

end