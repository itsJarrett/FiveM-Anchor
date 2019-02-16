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

function removeByValue(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then
      table.remove(tbl, i)
    end
  end
end

RegisterServerEvent("mwrpanchor:syncAnchoredVehicles")
AddEventHandler("mwrpanchor:syncAnchoredVehicles", function()
  local _source = source
  TriggerClientEvent("mwrpanchor:syncAnchoredVehicles", _source, anchoredVehicles)
end)

RegisterServerEvent("mwrpanchor:syncAnchoredVehicle")
AddEventHandler("mwrpanchor:syncAnchoredVehicle", function(boatPlate, status)
  local _source = source
  if (status == true) then
    table.insert(anchoredVehicles, boatPlate)
  else
    if (getVehicleAnchoredStatus(boatPlate) == false) then return end
    removeByValue(anchoredVehicles, boatPlate)
  end
  TriggerClientEvent("mwrpanchor:syncAnchoredVehicles", -1, anchoredVehicles)
end)