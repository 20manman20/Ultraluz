y = cuadratic(x,init_x,init_y,go_x,go_y)

if point_distance(x,y,o_player.x,o_player.y) > 96 {
	init_x	= x
	init_y	= y

	go_x	= o_player.x + o_player.spd_max[h]*2
	go_y	= o_player.y-32

	hdir	= sign(o_player.x-x)
}

image_xscale	= hdir
x	+= hdir*random_range(1,3)
