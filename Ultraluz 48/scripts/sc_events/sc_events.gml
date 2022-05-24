function event_jump() {
	if key_jump && bol_floor {
		i_scale[h] = .7
		i_scale[v] = 1.5
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

function event_gravity(_fall_st = false) {
	if !bol_floor {
		if _fall_st && spd[v] > 0 p_state	= p_st.fall
		spd[v]	= approach(spd[v],spd_max[v],spd_acc[v])
	}
}
	
function event_dash() {
	if key_dash {
		image_index	= 0
		if (hinput_prev == -hdir) || p_state = p_st.turn_around {
			spd[h]		= 0
			hdir		*= -1
			hinput_prev *= -1
			spd_push[h]	= -dash_spd*hdir
			p_state		= p_st.dash_back
			sprite_index	= s_p_roll_land64
		} else {
			image_index	= 0
			spd[h]		= 0
			spd_push[h]	= dash_spd*hdir
			p_state		= p_st.dash
			sprite_index	= s_p_roll_land
		}
	} return key_dash
	
}

function event_wall_hang() {
	if spd[v] > -2 && !bol_floor && !place_meeting(x+hdir*4,y-sprite_height-3,o_solid) && place_meeting(x+hdir*4,y-sprite_height+1,o_solid) {
		p_state	= p_st.wall_hang
		i_scale[h]	= 1.2
		i_scale[v]	= .8
	}
}
	
function event_p_hinput(_flip = true, _keys = true, _hsp = true, _acc = spd_acc[h], _fric = spd_acc[h]) {
	var _hkey	= (key_right - key_left)
	if hinput == 0 && _hkey != 0 {
		alarm[(5-_hkey)/2]	= 10	
	}
	if	_keys	hinput		= (key_right - key_left)
	if _flip && hinput != 0 && _flip hdir	= hinput
	if _hsp	{
		if hinput != 0 spd[h]	= approach(spd[h], hinput*spd_max[h], _acc)
		else spd[h]	= approach(spd[h], 0, _fric)
	}
}

function event_animation(s_index = sprite_index, i_speed = im_speed, i_index = image_index) {
	sprite_index	= s_index
	im_speed		= i_speed
	image_index		= i_index
}

function event_attack() {
	if key_atk {
		if coyote_atk > 0 {
			var _atk	= instance_create_depth(x,y,depth,o_bullet)
			_atk.image_xscale	= hdir
			p_state		= p_st.atk_00 + coyote_atk_i
		} else {
			var _atk	= instance_create_depth(x,y,depth,o_bullet)
			_atk.image_xscale	= hdir
			p_state		= p_st.atk_00
			sprite_index	= s_p_atk_00
		}
		image_index	= 0
	} return key_atk
}

function event_attack_air() {
	if key_atk {
		var _atk	= instance_create_depth(x,y,depth,o_bullet)
		_atk.image_xscale	= hdir
		sprite_index	= s_p_atk_air_02
		p_state		= p_st.atk_air_02
		image_index	= 0
	} return key_atk

}

function event_insta_flip(_dir) {
	hdir	= _dir
	hdir_r	= _dir
	hdir_d	= _dir
}
