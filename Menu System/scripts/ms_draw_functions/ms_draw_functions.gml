function draw_slider(ds_grid,i, _bol) {
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	if _bol draw_set_color(c_aqua);	
	
	draw_line_width(menu_left+15,menu_top+10+i*menu_opts_h,menu_left+15+menu_slider_w,menu_top+10+i*menu_opts_h,2);
			
	draw_circle(lerp(menu_left+15,menu_left+15+menu_slider_w,ds_grid[# 3,i]),menu_top+10+i*menu_opts_h,4,false);
	draw_text(menu_left+15+menu_slider_w+15,menu_top+10+i*menu_opts_h,string(round(ds_grid[# 3,i]*100)));
}

function draw_shift(ds_grid,i, _bol) {
	draw_set_halign(fa_left);
	draw_set_color(c_white);
			
	var _opt	= ds_grid[# 4,i]
	var _limit	= array_length(ds_grid[# 4,i])
			
			
	if is_string(_opt[ds_grid[# 3,i]]) _st		= _opt[ds_grid[# 3,i]]
	else var _st		= txt[lan,_opt[ds_grid[# 3,i]]]
			
	//var _sel	= 	area_mouse_shift(menu_left+5, menu_top+i*menu_opts_h,menu_left+36,menu_top+(i+1)*menu_opts_h,menu_shift_w)
			
	draw_set_halign(fa_right);
	draw_set_color(c_white);
	if _bol[0] draw_set_color(c_aqua);
	if ds_grid[# 3,i] > 0			draw_text(menu_left+36,menu_top+10+i*menu_opts_h,"<<");
			
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	if _bol[1] draw_set_color(c_aqua);
	draw_text(menu_left+36+menu_shift_w/2,menu_top+10+i*menu_opts_h,_st);
											
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	if _bol[2] draw_set_color(c_aqua);
	if ds_grid[# 3,i] < _limit-1	draw_text(menu_left+36+menu_shift_w,menu_top+10+i*menu_opts_h,">>");
	
}

function draw_toggle(ds_grid, i, _bol0, _bol1) {
	draw_set_halign(fa_right);
	draw_set_color(c_gray);
	if _bol0 draw_set_color(c_white);
	if _bol1[0] draw_set_color(c_aqua)
	
	draw_text(menu_left+menu_sub_opts_w/2-8,menu_top+10+i*menu_opts_h,txt[lan,t.tsi]);
	
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	if _bol0 draw_set_color(c_gray);
	if _bol1[1]	draw_set_color(c_aqua)
	
	
	draw_text(menu_left+menu_sub_opts_w/2+8,menu_top+10+i*menu_opts_h,txt[lan,t.tno]);

}

function draw_input(ds_grid, i, _aqua, _grey) {
	//Definir texto de la tecla
	var _stx;
	switch (ds_grid[# 3,i]) {
		case 8:
			_stx	= "DELETE"
			break;
		case 9:
			_stx	= "TAB"
			break;
		case 13:
			_stx	= "ENTER"
			break;
		case 16:
			_stx	= "SHIFT"
			break;
		case vk_left:
			_stx	= "LEFT KEY"
			break;
		case vk_up:
			_stx	= "UP KEY"
			break;
		case vk_right:
			_stx	= "RIGHT KEY"
			break;
		case vk_down:
			_stx	= "DOWN KEY"
			break;
		case vk_space:
			_stx	= "SPACE"
			break
		case 162:
			_stx	= "LCONTROL"
			break;
		case 163:
			_stx	= "RCONTROL"
			break;
		case 164:
			_stx	= "ALT"
			break
		default:
			_stx	= chr(ds_grid[# 3,i])
			break;
	}
		
	//Posiciones y Color normal
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	
	//Cambiar estilo y dibujar texto
	if _aqua {
		draw_set_color(c_aqua);
		if _grey draw_set_color(c_gray);
	}
	draw_text(menu_left+menu_sub_opts_w/2,menu_top+10+i*menu_opts_h,_stx);
}