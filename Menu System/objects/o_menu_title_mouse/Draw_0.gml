//Definir variables y posiciones
var ds_grid	= menu_pages[page];
var ds_h	= ds_grid_height(ds_grid);

draw_set_halign(fa_right);
draw_set_valign(fa_middle);

//Comenzar el dibujar las opciones
for (var i = 0; i < ds_h ; ++i) {	
	draw_set_halign(fa_right);
	draw_set_color(c_white);
	
	//Efecto de tocar la opción con el mouse
	if i==menu_option && (
		ds_grid[# 1, i] == mn_en_type.toggle ||
		ds_grid[# 1, i] == mn_en_type.sc_runner ||
		ds_grid[# 1, i] == mn_en_type.page_trans ||
		ds_grid[# 1, i] == mn_en_type.room_go) {	
		draw_set_color(c_aqua);		//Efecto (cambiable)
	}
	draw_text(menu_left-15,menu_top+10+i*menu_opts_h,txt[lan,ds_grid[# 0, i]]);	//Dibujar texto de la opción
	draw_set_color(c_white);													//Resetear color
	
	//Dibujar subopciones
	switch (ds_grid[# 1,i]) {
		case mn_en_type.slider:	
			//Variable para el efecto de tocar la subopción con el mouse
			var _bol	= mouse_in_rectangle(menu_left+15-8,menu_top+10+i*menu_opts_h-3,menu_left+15+menu_slider_w+8,menu_top+10+i*menu_opts_h+10);
			//Dibujar subopción Slider
			draw_slider( ds_grid, i, _bol);
			
			break;
		case mn_en_type.shift:
			//Función para detectar que está seleccionando el mouse
			var _sel	= 	area_mouse_shift(menu_left+5, menu_top+i*menu_opts_h,menu_left+36,menu_top+(i+1)*menu_opts_h,menu_shift_w)
			//Variable para el efecto de tocar la subopción con el mouse
			var _bol	= [_sel-1==-1,false,_sel-1==1]
			//Dibujar subopción Shift
			draw_shift( ds_grid, i, _bol);
			
			break;
			
		case mn_en_type.toggle:
			//Función para detectar que está seleccionando el mouse
			var _toggle	= area_mouse_toggle(menu_left+menu_sub_opts_w/2,menu_top+10+i,48,menu_opts_h-32)
			//Dibujar subopción Toggle
			draw_toggle(ds_grid, i, ds_grid[# 3,i], [_toggle == 1, _toggle == 0])
			
			break
		case mn_en_type.input:
			//Dibujar subopción Input
			draw_input(ds_grid,i,menu_suboption == i,bol_input)
			break
	}
}
	
draw_set_color(c_white);	//Resetear color
//Dibujar las lineas del menú
draw_line_width(menu_left,menu_top,menu_left,menu_top+ds_h*menu_opts_h,2);
draw_line_width(menu_left-menu_opts_w,menu_top,menu_left-menu_opts_w,menu_top+ds_h*menu_opts_h,2);
draw_line_width(menu_left+menu_sub_opts_w,menu_top,menu_left+menu_sub_opts_w,menu_top+ds_h*menu_opts_h,2);