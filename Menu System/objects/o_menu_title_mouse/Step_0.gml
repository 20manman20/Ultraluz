var ds_grid			= menu_pages[page];
var ds_h			= ds_grid_height(ds_grid);

if !bol_input {
	menu_option			= area_mouse_voptions(menu_left-menu_opts_w+2,menu_top,menu_opts_w,menu_opts_h,ds_h);
	menu_suboption		= area_mouse_voptions(menu_left,menu_top,menu_sub_opts_w,menu_opts_h,ds_h);
	window_set_cursor(cr_default)
} else {
	window_set_cursor(cr_none)
	var _lastk	= keyboard_lastkey;
	if  !keyboard_check_pressed(vk_nokey) {
		if valid_key(_lastk) && _lastk != ds_grid[# 3,menu_suboption] {
			ds_grid[# 3,menu_suboption]	= _lastk;
		}
			bol_input	= false;
	}
}

