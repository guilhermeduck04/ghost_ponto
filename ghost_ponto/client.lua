local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO 3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD PRINCIPAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local idle = 1000
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)

        for _, localPonto in pairs(Config.Locais) do
            local distance = #(pCoords - vector3(localPonto.x, localPonto.y, localPonto.z))
            
            if distance <= 5.0 then
                idle = 5
                DrawText3D(localPonto.x, localPonto.y, localPonto.z, "~g~[E]~w~ PARA BATER "..localPonto.text)
                
                if distance <= 1.5 then
                    if IsControlJustPressed(0, 38) then -- Tecla E
                        TriggerServerEvent("vrp_ponto:trocar")
                    end
                end
            end
        end
        Citizen.Wait(idle)
    end
end)