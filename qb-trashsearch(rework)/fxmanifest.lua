fx_version 'cerulean'
game 'gta5'

description 'maked by dufi'
version '2.0.0'
author 'Dofi'

shared_scripts { 'config.lua', '@qb-core/shared/locale.lua', 
'locales/bg.lua' -- Change here to your desired language
}
server_script 'server/server.lua'
client_scripts { 'client/client.lua' }

lua54 'yes'\