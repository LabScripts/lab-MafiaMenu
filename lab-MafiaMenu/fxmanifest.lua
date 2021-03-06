fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "lab-MafiaMenu"
description "Ogranisation Menu"
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

server_export 'getScore'
server_export 'setScore'
server_export 'giveScore'
server_export 'removeScore'

files {
	'web/ui.html',
	'web/styles.css',
	'web/scripts.js',
	'web/debounce.min.js',
	'web/sound.wav',
	'web/img/*.png',
}

ui_page 'web/ui.html'
