camera_set_view_pos(cam,x-320,y-180)



x	= lerp(x,x_to,.2) +random_range(-shake*1.5,shake*1.5)	
y	= lerp(y,y_to,.2) +random_range(-shake*1.5,shake*1.5)


shake	= lerp(shake,0,.1)
game_spd	= !keyboard_check(vk_space)

x	= clamp(x,320,room_width-320)
y	= clamp(y,180,room_height-180)
