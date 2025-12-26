local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-- Carrega as configurações de grupos do VRP para saber quais são "Jobs"
local cfgGroups = module("vrp", "Config/Groups")
local groups = cfgGroups.groups

RegisterServerEvent("vrp_ponto:trocar")
AddEventHandler("vrp_ponto:trocar", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id then
        local user_groups = vRP.getUserGroups(user_id)
        local trocou = false

        for k,v in pairs(user_groups) do
            local groupData = groups[k]
            
            -- Verifica se é um grupo de trabalho (Job) configurado no Config/Groups.lua
            if groupData and groupData._config and groupData._config.gtype == "job" then
                
                -- SITUAÇÃO 1: ESTÁ DE FOLGA (Começa com "Paisana") -> QUER TRABALHAR
                if string.sub(k, 1, 7) == "Paisana" then
                    local jobOriginal = string.sub(k, 8) -- Tenta remover "Paisana" do nome
                    
                    -- Verifica exceções do Config.lua
                    if Config.Excecoes[k] then jobOriginal = Config.Excecoes[k] end 

                    -- Se o cargo original existir no VRP
                    if groups[jobOriginal] then
                        vRP.addUserGroup(user_id, jobOriginal)
                        TriggerClientEvent("Notify", source, "sucesso", "Você entrou em serviço como <b>"..vRP.getGroupTitle(jobOriginal).."</b>.")
                        trocou = true
                        break
                    end
                
                -- SITUAÇÃO 2: ESTÁ TRABALHANDO -> QUER FOLGA (LIMPAR ARMAS)
                else
                    local jobPaisana = "Paisana"..k
                    
                    -- Verifica exceções do Config.lua
                    if Config.Excecoes[k] then jobPaisana = Config.Excecoes[k] end

                    -- Se o cargo Paisana existir no VRP
                    if groups[jobPaisana] then
                        vRP.addUserGroup(user_id, jobPaisana)
                        
                        -- LIMPEZA DE ARMAS E INVENTÁRIO ILEGAL (Opcional, aqui limpa armas)
                        vRPclient.replaceWeapons(source, {}) 
                        
                        TriggerClientEvent("Notify", source, "aviso", "Você entrou em folga. Suas armas foram guardadas.")
                        trocou = true
                        break
                    end
                end
            end
        end

        if not trocou then
            TriggerClientEvent("Notify", source, "negado", "Você não possui um emprego com ponto disponível ou já está no grupo correto.")
        end
    end
end)