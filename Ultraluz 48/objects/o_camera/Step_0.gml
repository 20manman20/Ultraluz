camera_set_view_pos(cam,x-320,y-180)

if instance_exists(o_target) {
	x_to	= o_player.x
	y_to	= o_player.y
}

if game_spd {
	x	= lerp(x,x_to,.2) +random_range(-shake*1.5,shake*1.5)	
	y	= lerp(y,y_to,.2) +random_range(-shake*1.5,shake*1.5)
}

shake	= lerp(shake,0,.1)

