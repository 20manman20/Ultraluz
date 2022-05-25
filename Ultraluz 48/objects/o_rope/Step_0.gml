var _dir	= point_direction(x,y,o_player.x,o_player.y)


for (var i = 0; i < amount_points-1; ++i) {
	rope_dir[i]	+= angle_difference(rope_dir[i+1],rope_dir[i]) * 0.5
}


rope_length					= point_distance(x,y,o_player.x,o_player.y)
amount_points				= max(1,rope_length div 32)
rope_dir[amount_points-1]	= _dir
