//draw_text(x,y-64,(sign(o_player.x-x) != hdir) && alarm[2] == -1 )

function interval_is_off(argument0, argument1) {
	var _value = argument0;
	var _interval = argument1;

	return (_value % _interval) <= _interval/2;


}

if interval_is_off(timer[2], 16)  {
	gpu_set_fog(false, c_white, 0, 1)
} else {
	gpu_set_fog(true, c_white, 0, 1)
}

draw_sprite_ext(sprite_index,image_index,x,y,hdir_d*i_scale[h],i_scale[v],image_angle,image_blend,image_alpha)

gpu_set_fog(false, c_white, 0, 1)


/*

var _front	= det_front + 16*(state == en_st.shield)
var _mid	= (det_behind+_front)/2
var _x		= _front-_mid

draw_rectangle(x+_x*hdir_d-_mid,y-64,x+_x*hdir_d+_mid,y+8,true)
