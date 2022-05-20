function event_jump() {
	if key_jump && bol_floor {
		i_scale[h] = .8
		i_scale[v] = 1.4
		p_state	= p_st.jump
		spd[v]	= -spd_max[v]/1.3
	}
	
	if key_jump_r && spd[v] < 0 {
		spd[v]	*= .5
	}
	
	/*
	if !bol_floor {
		if coyote > 0 {
			coyote--
			if !jumped && key_jump {
				spd[v]	= -spd_max[v]/1.3
				i_scale[h] = .8
				i_scale[v] = 1.4
				p_state	= p_st.jump
				jumped	= true
			}
		}
	} else {
		jumped	= false
		coyote	= coyote_max
	}


	if key_jump buffer = buffer_max

	if buffer > 0 {
		buffer--
		if bol_floor {
			spd[v]	= -spd_max[v]/1.3
			i_scale[h] = .8
			i_scale[v] = 1.4
			p_state	= p_st.jump
			buffer = 0
			jumped	= true
		}
	}

	if key_jump_r && spd[v] < 0 {
		spd[v]	*= .5
	}
	*/
}

function event_gravity() {
	if !bol_floor {
		spd[v]	= approach(spd[v],spd_max[v],spd_acc[v])
	}
}
	
function event_wall_hang() {
	if spd[v] > -2 && !bol_floor && !place_meeting(x+hdir*4,y-sprite_height-3,o_solid) && place_meeting(x+hdir*4,y-sprite_height+1,o_solid) {
		p_state	= p_st.wall_hang
		i_scale[h]	= 1.2
		i_scale[v]	= .8
	}
}
