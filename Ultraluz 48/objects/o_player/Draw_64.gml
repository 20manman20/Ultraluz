var _h_bar_w	= 200
var _h_bar_h	= 30
draw_set_color(c_white)
draw_rectangle(10,10,10+_h_bar_w,10+_h_bar_h,true)
draw_rectangle(10,10,10+_h_bar_w*p_health/100,10+_h_bar_h,false)
//draw_text(10,120,bol_floor)
var _x	= 32
var _y	= 96


draw_rectangle(_x+10*power(im_scale[h],.8),_y+10*power(im_scale[v],.8),_x-10*power(im_scale[h],.8),_y-10*power(im_scale[v],.8),false)
var _dis	= 5+point_distance(0,0,spd_final[h],spd_final[v])
var _dir	= point_direction(0,0,spd_final[h],spd_final[v])

draw_set_color(c_black)
draw_rectangle(_x+10*power(im_scale[h],.8),_y+10*power(im_scale[v],.8),_x-10*power(im_scale[h],.8),_y-10*power(im_scale[v],.8),true)


draw_set_color(c_white)
//draw_text(10,128,im_scale)

draw_text(5,124,y)
