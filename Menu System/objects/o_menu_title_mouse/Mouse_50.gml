var ds_grid			= menu_pages[page];

if !bol_input {
	if menu_suboption != -1 {
		switch (ds_grid[# 1,menu_suboption]) {
			case mn_en_type.slider:	
				var _nval	= area_mouse_slider([0,1],menu_left+15,menu_top+10+menu_suboption*menu_opts_h,menu_slider_w)
				if _nval	!= -1 {
					ds_grid[# 3,menu_suboption]	= _nval
				}
				break;
		}
	}
}