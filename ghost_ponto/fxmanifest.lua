fx_version 'cerulean'
game 'gta5'

description 'Sistema de Ponto com Troca de Grupo'
version '1.0'

shared_script 'config.lua'

client_scripts {
    '@vrp/Lib/utils.lua',
    'client.lua'
}

server_scripts {
    '@vrp/Lib/utils.lua',
    'server.lua'
}

dependency 'vrp'