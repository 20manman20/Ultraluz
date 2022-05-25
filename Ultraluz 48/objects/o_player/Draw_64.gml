var _h_bar_w	= 200
var _h_bar_h	= 30
draw_set_color(c_white)
draw_rectangle(10,10,10+_h_bar_w,10+_h_bar_h,true)
draw_rectangle(10,10,10+_h_bar_w*p_health/100,10+_h_bar_h,false)
draw_text(10,120,arr_p_st[state])
draw_text(10,60,coyote)
draw_circle(10,80,4,!jumped)
