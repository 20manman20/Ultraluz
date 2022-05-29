with other {
	if alarm[0]	== -1 {
		game_spd		= 0
		o_camera.alarm[1]	= 10
		state			= p_st.hit
		hit_time		= HIT_ABS_TIME
		shake			= 5
		p_health		-= 20
		spd_push		= [5*other.image_xscale,-3]
		hdir			= -other.image_xscale
		alarm[0]		= 45
	}
}

