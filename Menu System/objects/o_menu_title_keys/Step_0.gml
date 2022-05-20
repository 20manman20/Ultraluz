key_mn_left		= keyboard_check(vk_left);
key_mn_up		= keyboard_check(vk_up);
key_mn_right	= keyboard_check(vk_right);
key_mn_down		= keyboard_check(vk_down);

key_mn_left_p	= keyboard_check_pressed(vk_left);
key_mn_up_p		= keyboard_check_pressed(vk_up);
key_mn_right_p	= keyboard_check_pressed(vk_right);
key_mn_down_p	= keyboard_check_pressed(vk_down);

key_mn_accept	= keyboard_check_pressed(vk_space);

var menu_op_input	= key_mn_down_p-key_mn_up_p;
var ds_grid			= menu_pages[page];
var ds_h			= ds_grid_height(ds_grid);

if !bol_input {
	menu_option[page]	= (menu_option[page] + ds_h + menu_op_input) % ds_h;
	
	if key_mn_accept {
		switch (ds_grid[# 1,menu_option[page]]) {
		    case mn_en_type.room_go:
				trans_room_to	= ds_grid[# 2,menu_option[page]]
				trans			= 1
		        break;
			case mn_en_type.page_trans:
				page	= ds_grid[# 2,menu_option[page]];
				break;
			case mn_en_type.toggle:
				ds_grid[# 3,menu_option[page]]	= !ds_grid[# 3,menu_option[page]];
				script_execute(ds_grid[# 2,menu_option[page]],ds_grid[# 3,menu_option[page]])
		        break;
		    default:
		        bol_input	= true;
		        break;
		}
		
	}
} else {
	switch (ds_grid[# 1,menu_option[page]]) {
	    case mn_en_type.slider:
			var _limit	= ds_grid[# 4,menu_option[page]]
			var _hinput	= key_mn_right - key_mn_left
			
			ds_grid[# 3,menu_option[page]]	= clamp(ds_grid[# 3,menu_option[page]] + _hinput*0.01, _limit[0],_limit[1]);
			if key_mn_accept	bol_input	= false
	        break;
		
		case mn_en_type.shift:
			var _limit	= array_length(ds_grid[# 4,menu_option[page]])
			var _hinput	= key_mn_right_p - key_mn_left_p
			ds_grid[# 3,menu_option[page]]	= clamp(ds_grid[# 3,menu_option[page]] + _hinput, 0,_limit-1);
			if key_mn_accept	{
				script_execute(ds_grid[# 2,menu_option[page]],ds_grid[# 3,menu_option[page]])
				bol_input	= false
			}
			break;
		case mn_en_type.input:
			var _lastk	= keyboard_lastkey;
			if _lastk != vk_space {
				if _lastk != ds_grid[# 3,menu_option[page]] && valid_key(_lastk) {
					ds_grid[# 3,menu_option[page]]	= _lastk;
				}
				bol_input	= false;
			}
			if key_mn_accept	bol_input	= false;
			break
	}
}

menu_sub_opts_w	+= mouse_wheel_up()-mouse_wheel_down()
menu_slider_w	= menu_sub_opts_w-72;
menu_shift_w	= menu_sub_opts_w-72;