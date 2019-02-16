-- Midwest Roleplay Boat Anchor - Slavko A. (Jarrett B.) - 2/5/19

local anchoredVehicles = {}

function getVehicleAnchoredStatus(input)
  for i, anchoredVehiclePlate in ipairs(anchoredVehicles) do
    if anchoredVehiclePlate == input then
      return true
    end
  end
  return false
end

RegisterNetEvent("mwrpanchor:syncAnchoredVehicles")
AddEventHandler("mwrpanchor:syncAnchoredVehicles", function(anchoredVehiclesServers)
  anchoredVehicles = anchoredVehiclesServers
end)

AddEventHandler("playerSpawned", function(spawnInfo)
  TriggerServerEvent("mwrpanchor:syncAnchoredVehicles")
end)

RegisterCommand('anchor', function(source, args)
  local playerPed = GetPlayerPed(PlayerId())
  local boat = GetVehiclePedIsIn(playerPed, false)
  local plate = GetVehicleNumberPlateText(boat)
  if (IsPedInAnyBoat(playerPed) and GetPedInVehicleSeat(boat, -1)) then
    local anchorStatus = getVehicleAnchoredStatus(plate)
    anchorStatus = not anchorStatus
    SetBoatAnchor(boat, anchorStatus)
    TriggerServerEvent("mwrpanchor:syncAnchoredVehicle", plate, anchorStatus)
    print(anchorStatus)
    if (anchorStatus == true) then
      TriggerEvent("chatMessage", "^4The boat anchor has been dropped.")
    else
      TriggerEvent("chatMessage", "^4The boat anchor has been lifted.")
    end
  else
    TriggerEvent("chatMessage", "^1You are not inside any boat.")
  end
end, false)