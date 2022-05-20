

globalvar cam,shake;
cam	= view_camera[0]
shake	= 0

o_target	= o_player

if instance_exists(o_player) {
	x	= o_player.x
	y	= o_player.y
}

window_set_size(640*2,360*2)
alarm[0]	= 1

x_to	= x
y_to	= y
