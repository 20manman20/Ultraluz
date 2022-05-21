

globalvar cam,shake;
cam	= view_camera[0]
shake	= 0

o_target	= o_player

if instance_exists(o_player) {
	x	= o_player.x
	y	= o_player.y
}

window_set_fullscreen(true)
window_set_size(640,360)
alarm[0]	= 1

x_to	= x
y_to	= y

globalvar game_spd;
game_spd	= 1

