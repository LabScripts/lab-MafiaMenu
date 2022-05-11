fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "lab-CreateMafia"
description "Create Mafia"
author "Dogo#1950"
version "1.0.0"

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/*.lua'
}

export 'getType'

server_export 'getJobType'

files {
	'web/ui.html',
	'web/styles.css',
	'web/scripts.js',
	'web/debounce.min.js',
	'web/sound.wav',
	'web/img/*.png',
}

ui_page 'web/ui.html'

escrow_ignore {
	'shared/*.lua',
	'client/main.lua'
}