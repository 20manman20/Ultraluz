var ds_grid	= menu_pages[page];
var ds_h	= ds_grid_height(ds_grid);

draw_set_halign(fa_right)
draw_set_valign(fa_middle)

/* Dibujar recuadros
for (var i = 0; i < ds_h; ++i) {
	draw_rectangle_width(	menu_left,
					menu_top+(i)*menu_opts_h,
					menu_left-menu_opts_w,
					menu_top+(i+1)*menu_opts_h-1,
					c_white,2)
}
*/

for (var i = 0; i < ds_h ; ++i) {
	draw_set_halign(fa_right)
	draw_set_color(c_white);
	var _opt_me	= (i == menu_option[page]);
	var _type	= ds_grid[# 1,i] == mn_en_type.room_go
	if (!_type && _opt_me && !bol_input) || (_type && _opt_me) {
		draw_set_color(c_aqua);
	}
	
	draw_text(menu_left-15,menu_top+10+i*menu_opts_h,txt[lan,ds_grid[# 0, i]]);
	
	draw_set_color(c_white);
	
	switch (ds_grid[# 1,i]) {
	    case mn_en_type.slider:
			var _bol	= bol_input && _opt_me draw_set_color(c_aqua);
			draw_slider( ds_grid, i, _bol);
			
	        break;
		case mn_en_type.shift:	
			var _bol	= [bol_input && _opt_me, bol_input && _opt_me, bol_input && _opt_me]
			draw_shift(ds_grid,i,_bol)
	        break;
		case mn_en_type.toggle:
			var _bol0	= ds_grid[# 3,i]	
			draw_toggle(ds_grid, i, _bol0, [_opt_me && _bol0,_opt_me && !_bol0])	
			
			break;
		case mn_en_type.input:
			draw_input(ds_grid,i,bol_input && _opt_me,false)
			break;
	}
}
	
draw_set_color(c_white);
draw_line_width(menu_left,menu_top,menu_left,menu_top+ds_h*menu_opts_h,2);
draw_line_width(menu_left-menu_opts_w,menu_top,menu_left-menu_opts_w,menu_top+ds_h*menu_opts_h,2);
draw_line_width(menu_left+menu_sub_opts_w,menu_top,menu_left+menu_sub_opts_w,menu_top+ds_h*menu_opts_h,2);
draw_text(40,50,keyboard_lastkey)