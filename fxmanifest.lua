author 'Vanity Designs'
description 'Standalone Pause Menu'
version '1.0'

game 'gta5'
fx_version 'cerulean'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

ui_page 'web/build/index.html'

shared_script 'config.lua'
server_script 'server/server.lua'
client_script 'client/client.lua'

files {
  'web/build/index.html',
  'web/build/**/*',
}
