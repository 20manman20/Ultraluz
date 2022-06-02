var _h_bar_w	= 200
var _h_bar_h	= 30
draw_set_color(c_white)
draw_rectangle(10,10,10+_h_bar_w,10+_h_bar_h,true)
draw_rectangle(10,10,10+_h_bar_w*p_health/100,10+_h_bar_h,false)
//draw_text(10,120,bol_floor)
var _x	= 32
var _y	= 96

draw_rectangle(_x+10*power(im_scale[h],.8),_y+10*power(im_scale[v],.8),_x-10*power(im_scale[h],.8),_y-10*power(im_scale[v],.8),false)
draw_text(10,128,im_scale)
/*
draw_circle(10,60,4,!position_meeting(x+8*hdir,bbox_top+1,o_solid))
draw_circle(10,70,4,position_meeting(x+8*hdir,bbox_top+3,o_solid))

draw_text(5,124,coyote)
draw_circle(25,127,4,!jumped)
draw_text(5,131,buffer)
