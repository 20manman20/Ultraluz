for (var i = 1; i < amount_points; ++i) {
	//draw_circle(x+lengthdir_x((i+1)*rope_length/amount_points,rope_dir[i]),y+lengthdir_y((i+1)*rope_length/amount_points,rope_dir[i]),2,false)
	draw_line(x+lengthdir_x((i)*rope_length/amount_points,rope_dir[i-1]),y+lengthdir_y((i)*rope_length/amount_points,rope_dir[i-1]),
			x+lengthdir_x((i+1)*rope_length/amount_points,rope_dir[i]),y+lengthdir_y((i+1)*rope_length/amount_points,rope_dir[i]))
}


draw_line(x,y,
			x+lengthdir_x(rope_length/amount_points,rope_dir[0]),y+lengthdir_y(rope_length/amount_points,rope_dir[0]))
//draw_circle(x,y,rope_length,true)
