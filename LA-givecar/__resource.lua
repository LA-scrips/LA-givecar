resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Give Car to Garage Script'

server_scripts {
    '@es_extended/locale.lua',
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'client/main.lua'
}