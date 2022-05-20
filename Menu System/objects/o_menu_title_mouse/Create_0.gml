globalvar mouse_coor;

lan	= 1

#region Idiomas

txt	= [[	"JUGAR",
			"AJUSTES",
			"SALIR",
			"AUDIO",
			"GRAFICOS",
			"CONTROLES",
			"REGRESAR",
			"PRINCIPAL",
			"SONIDOS",
			"MUSICA",
			"P. COMPLETA",
			"RESOLUCION",
			"IZQUIERDA",
			"DERECHA",
			"ARRIBA",
			"ABAJO",
			"SALTAR",
			"IDIOMA",
			"ESPANOL",
			"ENGLISH",
			"SI",
			"NO"],
		[	"PLAY",
			"SETTINGS",
			"EXIT",
			"AUDIO",
			"GRAPHICS",
			"CONTROLS",
			"BACK",
			"MAIN",
			"SOUNDS",
			"MUSIC",
			"FULLSCREEN",
			"RESOLUTION",
			"LEFT",
			"RIGHT",
			"UP",
			"DOWN",
			"JUMP",
			"LANGUAGE",
			"ESPANOL",
			"ENGLISH",
			"ON",
			"OFF"]]

#endregion

var _res;
for (var i = 0; i < 11; ++i) {
	_res[i]	= string((8*i+40)*16) + "x" + string((8*i+40)*9)
}

menu_main		= create_menu_page(
				[t.tjugar,		mn_en_type.room_go,		Sala1],
				[t.tajustes,	mn_en_type.page_trans,	mn_page.settings],
				[t.tsalir,		mn_en_type.room_go,		Sala12]);

menu_settings	= create_menu_page(
				[t.taudio,		mn_en_type.page_trans,	mn_page.audio],
				[t.tgraficos,	mn_en_type.page_trans,	mn_page.graphics],
				[t.tcontroles,	mn_en_type.page_trans,	mn_page.controls],
				[t.tregresar,	mn_en_type.page_trans,	mn_page.main]);
				
menu_audio		= create_menu_page(
				[t.tprincipal,	mn_en_type.slider,		change_volume,		1,	[0,1]],
				[t.tmusica,		mn_en_type.slider,		change_volume,		1,	[0,1]],
				[t.tsonidos,	mn_en_type.slider,		change_volume,		1,	[0,1]],
				[t.tregresar,	mn_en_type.page_trans,	mn_page.settings]);

menu_graphics	= create_menu_page(
				[t.tpcompleta,	mn_en_type.toggle,		change_fullscreen,	0],
				[t.tresolucion,	mn_en_type.shift,		change_resolution,	3,	_res],
				[t.tidioma,		mn_en_type.shift,		change_language,	lan, [t.tesp,t.ting]],
				[t.tregresar,	mn_en_type.page_trans,	mn_page.settings]);
				
menu_controls	= create_menu_page(
				[t.tizq,		mn_en_type.input,		"key_left",		vk_left],
				[t.tder,		mn_en_type.input,		"key_right",	vk_right],
				[t.tarr,		mn_en_type.input,		"key_up",		vk_up],
				[t.tabaj,		mn_en_type.input,		"key_down",		vk_down],
				[t.tsaltar,		mn_en_type.input,		"key_jump",		ord("Z")],
				[t.tregresar,	mn_en_type.page_trans,	mn_page.settings]);

page			= 4;
menu_pages		= [menu_main, menu_settings, menu_audio, menu_graphics, menu_controls];

menu_option		= 0;
menu_suboption	= 0;

window_set_size(1024,576);
alarm[0]		= 1;

bol_input		= false

//Position
menu_opts_w		= 128;
menu_opts_h		= 48;

menu_sub_opts_w	= 162;

menu_left		= room_width-menu_sub_opts_w-14;
menu_top		= 32;

//Other
menu_slider_w	= menu_sub_opts_w-72;
menu_shift_w	= menu_sub_opts_w-72;
