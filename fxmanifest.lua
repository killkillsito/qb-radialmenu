

fx_version 'adamant'
game 'gta5'

client_scripts {
	"@qb-polyzone/client/cl_main.lua",
	"@qb-garages/config.lua",
	"client/cl_*.lua",
    "config.lua"
}

server_scripts {
	"server/sv_*.lua"
}

ui_page "html/ui.html"

files {
	"html/ui.html",
	"html/css/RadialMenu.css",
	"html/js/RadialMenu.js",
	'html/css/all.min.css',
	'html/js/all.min.js'
	-- 'html/webfonts/fa-brands-400.eot',
	-- 'html/webfonts/fa-brands-400.svg',
	-- 'html/webfonts/fa-brands-400.ttf',
	-- 'html/webfonts/fa-brands-400.woff',
	-- 'html/webfonts/fa-brands-400.woff2',
	-- 'html/webfonts/fa-regular-400.eot',
	-- 'html/webfonts/fa-regular-400.svg',
	-- 'html/webfonts/fa-regular-400.ttf',
	-- 'html/webfonts/fa-regular-400.woff',
	-- 'html/webfonts/fa-regular-400.woff2',
	-- 'html/webfonts/fa-solid-900.eot',
	-- 'html/webfonts/fa-solid-900.svg',
	-- 'html/webfonts/fa-solid-900.ttf',
	-- 'html/webfonts/fa-solid-900.woff',
	-- 'html/webfonts/fa-solid-900.woff2',
}

shared_script "@qb-core/config.lua"