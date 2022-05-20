var ds_grid			= menu_pages[page];

if !bol_input {
	if menu_option != -1 {
		switch (ds_grid[# 1,menu_option]) {
			case mn_en_type.room_go:
				trans_room(ds_grid[# 2,menu_option])
			    break;
			case mn_en_type.page_trans:
				page	= ds_grid[# 2,menu_option];
				break;
			case mn_en_type.toggle:
				ds_grid[# 3,menu_option]	= !ds_grid[# 3,menu_option];	
				script_execute(ds_grid[# 2,menu_option],ds_grid[# 3,menu_option])
				break;
		}
	}

	if menu_suboption != -1 {
		switch (ds_grid[# 1,menu_suboption]) {
			case mn_en_type.toggle:
				var _toggle	= area_mouse_toggle(menu_left+menu_sub_opts_w/2,menu_top+10+menu_suboption,48,menu_opts_h-32)
				ds_grid[# 3,menu_suboption]	= _toggle
				script_execute(ds_grid[# 2,menu_suboption],ds_grid[# 3,menu_suboption])
				break;
			case mn_en_type.shift:
				var _limit	= array_length(ds_grid[# 4,menu_suboption])
				var _sel	= area_mouse_shift(menu_left+5, menu_top+menu_suboption*menu_opts_h,menu_left+36,menu_top+(menu_suboption+1)*menu_opts_h,90)
				if _sel != -1 {
					ds_grid[# 3,menu_suboption]	= clamp(ds_grid[# 3,menu_suboption]+(_sel-1),0,_limit-1);	
					script_execute(ds_grid[# 2,menu_suboption],ds_grid[# 3,menu_suboption])
				}
				break;
			case mn_en_type.input:
				bol_input	= true
				break;
		}
	}

}