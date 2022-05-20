enum mn_page {
	main, 
	settings, 
	audio, 
	graphics, 
	controls,
	height
}

enum mn_en_type {
	sc_runner,
	page_trans,
	slider,
	shift,
	toggle,
	input,
	room_go
}


enum t {
	tjugar,tajustes,tsalir,taudio, tgraficos, tcontroles, tregresar,tprincipal,tsonidos,tmusica
	,tpcompleta,tresolucion,tizq, tder, tarr, tabaj, tsaltar, tidioma, tesp, ting,tsi,tno, ttheight
}

function create_menu_page() {
	var arg, i = 0;
	
	repeat (argument_count) {
		arg[i]	= argument[i];
		i++;
	}
	
	var ds_grid	= ds_grid_create(5, argument_count);
	var i	= 0;
	repeat (argument_count) {
		var array		= arg[i];
		var array_l		= array_length(array);
		
		var xx = 0
		repeat (array_l) {
			ds_grid[# xx, i] = array[xx];
			xx++;
		}
		i++;
	}
	
	return ds_grid;
}

function resume_game() {
	
}

function exit_game() {
	
}

function change_volume() {
	
}

function change_language(i) {
	lan	= i	
}

function change_difficulty() {

}

function change_resolution(i) {
	window_set_size((8*i+40)*16,(8*i+40)*9)
	alarm[0]	= 1
}

function change_fullscreen(i) {
	window_set_fullscreen(i)
	alarm[0]	= 2
}

function area_mouse_voptions(_area_left, _area_top, _area_opts_w, _area_opts_h, _area_opts_n) {
	var i	= -1
	if (mouse_x > _area_left) && (mouse_x < _area_left+_area_opts_w) && (mouse_y > _area_top) && (mouse_y < (_area_top + _area_opts_h*_area_opts_n)) {
		i	= (mouse_y-_area_top) div _area_opts_h;
	}
	return i
}

function area_mouse_hoptions(_area_left, _area_top, _area_opts_w, _area_opts_h, _area_opts_n) {
	var i	= -1
	if (mouse_x > _area_left) && (mouse_x < _area_left+_area_opts_w*_area_opts_n) && (mouse_y > _area_top-6) && (mouse_y < (_area_top + _area_opts_h)) {
		i	= (mouse_x-_area_left) div _area_opts_w;
	}
	return i
}

function area_mouse_slider(_limit,_area_left, _area_top, area_slider_w) {
	var i	= -1
	if mouse_in_rectangle(_area_left-8, _area_top-3,_area_left+8+area_slider_w, _area_top+10) {
		i	= clamp(lerp(_limit[0],_limit[1],(mouse_x - _area_left)/area_slider_w),_limit[0],_limit[1])
	}
	return	i
}

function area_mouse_shift(_area_left, _area_top, _area_right, _area_bottom, _area_width) {
	var _xx	= _area_right - _area_width;
	var i	= -1;
	if mouse_in_rectangle(_area_left, _area_top,_area_right+_area_width+(_area_right-_area_left), _area_bottom) {
		i	= ((mouse_x-_xx) div _area_width);
	}
	return i;
}

function area_mouse_toggle(_area_center, _area_top, _area_opts_w, _area_opts_h) {
	var i	= -1
	if area_mouse_hoptions(_area_center-_area_opts_w,_area_top,_area_opts_w,_area_opts_h,2) != -1 {
		i	= 1-area_mouse_hoptions(_area_center-_area_opts_w,_area_top,_area_opts_w,_area_opts_h,2)
	}
	return	i
}

function mouse_in_rectangle(_area_left, _area_top, _area_right, _area_bottom) {
	return point_in_rectangle(mouse_x,mouse_y,_area_left, _area_top, _area_right, _area_bottom)
}

function draw_rectangle_width(x1,y1,x2,y2,color,width) {
	draw_set_color(color)
	draw_rectangle(x1,y1,x2,y2,true)

	var i = 0

	do {
		i += 1
		draw_rectangle(x1-i,y1-i,x2+i,y2+i,true)
	} until(i = width)

}

function in_range(_val,_min,_max) {
	return ((_val <= _max) && (_val >= _min))
}

function valid_key(_key) {
	if in_range(_key,8,9) ||
	   in_range(_key,37,40) ||
	   in_range(_key,48,57) || 
	   in_range(_key,65,90) ||
	   in_range(_key,162,164) || 
	   _key	== 13 || _key == 16 || _key == 32 {
		return true
	} else return false
}


