//draw_text(x,y-48,(spd_final[h]))
function interval_is_off(argument0, argument1) {
	var _value = argument0;
	var _interval = argument1;

	return (_value % _interval) <= _interval/2;


}



if interval_is_off(alarm[0], 16)  {
	gpu_set_fog(false, c_white, 0, 1)
} else {
	gpu_set_fog(true, c_white, 0, 1)
}

draw_sprite_ext(sprite_index,image_index,x,y,hdir*im_scale[h],im_scale[v],im_angle,image_blend,image_alpha)

//draw_sprite_ext(mask_p,0,x,y,1,1,0,c_white,.3)

gpu_set_fog(false, c_white, 0, 1)
