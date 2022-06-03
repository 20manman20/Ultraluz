for (var i = 0; i < 12; ++i) {
	draw_sprite_ext(sprite_index,image_index,trail_coor[i,h],trail_coor[i,v],hdir*im_scale[h],im_scale[v],im_angle,c_gray,trail_alpha*(.6-i/10))
}

shader_set(sh_outline)

var texture		= sprite_get_texture(sprite_index,image_index)
var t_width		= texture_get_texel_width(texture)
var t_height	= texture_get_texel_height(texture)

shader_set_uniform_f(sh_texel_handle,t_width,t_height)

///////////
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

///////////

shader_reset()

draw_set_alpha(1) 
if state == p_st.swing {
	draw_line_width(x,y-16,grapple[h],grapple[v],3)
}
//draw_line_width(x,y,x,y-64*4-32,1)
gpu_set_fog(false, c_white, 0, 1)

draw_text(x,y-64,y)
draw_sprite_ext(mask_index,0,x,y,1,1,0,c_white,.3)
//draw_set_alpha(.2) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)

