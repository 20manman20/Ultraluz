var _col	= place_meeting(x+lengthdir_x(dis_col,im_dir),y+lengthdir_y(dis_col,im_dir),o_solid)
draw_self()
if _col draw_set_color(c_red)
else draw_set_color(c_white)
//draw_circle(x+lengthdir_x(dis_col,im_dir),y+lengthdir_y(dis_col,im_dir),9,true)
draw_set_color(c_white)

draw_text(x,y+5,en_health)

