#region Eventos solo para el jugador
function event_p_jump() {
	if !bol_floor && coyote > 0 && !jumped && key_jump {
		im_scale[h] = .6
		im_scale[v] = 1.7
		state	= p_st.jump
		spd[v]	= -spd_max[v]/1.3
		y--
		jumped	= true  
	}

	if key_jump buffer = buffer_max

	if buffer > 0 && bol_floor {
		im_scale[h] = .6
		im_scale[v] = 1.7
		state	= p_st.jump
		spd[v]	= -spd_max[v]/1.3
		buffer = 0
		y--
		jumped	= true
	}
	
	if key_jump_r && spd[v] < 0 spd[v] *= .5
	
}

function event_p_dash() {
	if key_dash {
		image_index	= 0
		if (hinput_prev == -hdir) || state = p_st.turn_around {
			spd[h]		= 0
			hdir		*= -1
			hinput_prev *= -1
			spd_push[h]	= -dash_spd*hdir
			state		= p_st.dash_back
			sprite_index	= spr[p_sp.roll_land_back]
		} else {
			image_index	= 0
			spd[h]		= 0
			spd_push[h]	= dash_spd*hdir
			state		= p_st.dash
			sprite_index	= spr[p_sp.roll_land]
		}
	} return key_dash
	
}

function event_p_wall_hang() {
	var was_free	= !position_meeting(x+(12+spd[h]*2)*hdir,bbox_top-8,o_solid)
	var isnt_free	= position_meeting(x+(12+spd[h]*2)*hdir,bbox_top-1,o_solid)
	/*
	if spd[v] > -2 && !bol_floor && !place_meeting(x+hdir*6,bbox_top-3,o_solid) && place_meeting(x+hdir*(4),bbox_top+1,o_solid) {
		state	= p_st.wall_hang
		im_scale[h]	= 1.2
		im_scale[v]	= .8
	}
	*/
	
	if was_free && isnt_free && spd[v] > 0  {
		im_scale[h]	= 1.2
		im_scale[v]	= .8
		spd	= [0,0]
		state	= p_st.wall_hang
		while !place_meeting(x+hdir,y,o_solid) {
			x+=hdir
		}

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
	
function event_p_attack() {
	if key_atk {
		timer[1]	= HITBOX_TIMER
		if coyote_atk > 0 {
			state		= p_st.atk_00 + coyote_atk_i
		} else {
			state		= p_st.atk_00
			sprite_index	= spr[p_sp.atk_00]
		}
		image_index	= 0
	} return key_atk
}

function event_p_attack_air() {
	if key_atk {
		timer[1]	= HITBOX_TIMER
		sprite_index	= spr[p_sp.atk_air_02]
		state		= p_st.atk_air_02
		image_index	= 0
	} return key_atk

}

function event_p_collision() {
	repeat (abs(spd_final[h]*COL_TIME)*game_spd) {
		if place_meeting(x+sign(spd_final[h]),y,o_solid) && !place_meeting(x+sign(spd_final[h]),y-1,o_solid) y--
		

		if place_meeting(x+sign(spd_final[h]),y,o_solid) {
			if state	== p_st.swing {
				rope_angle	= point_direction(grapple[h],grapple[v],x,y)
				rope_angle_spd	= 0
			}
			spd[h]	= 0
			break
		} else x += sign(spd_final[h])/COL_TIME
	}

	repeat (abs(spd_final[v]*COL_TIME)*game_spd) {
		if place_meeting(x,y+sign(spd_final[v]),o_solid) {
			spd[v]	= 0
			if state	== p_st.swing {
				rope_angle	= point_direction(grapple[h],grapple[v],x,y)
				rope_angle_spd	= 0
			}
			break
		}  else {
			y += sign(spd_final[v])/COL_TIME
		}
	}

	
	
}

#endregion

function event_gravity(_fall_st = false) {
	if !bol_floor {
		if _fall_st {
			if spd[v] > 0 state	= p_st.fall
			if spd[v] < 0 state = p_st.jump_fall
		}
		spd[v]	= approach(spd[v],spd_max[v],spd_acc[v])
	}
	
	if place_meeting(x,y+1,o_slope) && !key_jump {
		spd[v]	= 0
	}
}

function event_animation(s_index = sprite_index, i_speed = im_speed, i_index = image_index, i_angle = 0) {
	sprite_index	= s_index
	im_speed		= i_speed
	image_index		= i_index
	im_angle		= i_angle
}

function event_insta_flip(_dir) {
	hdir	= _dir
	hdir_r	= _dir
	hdir_d	= _dir
}

function event_damage() {
	if bol_hit && timer[TIMER_DMG]	== -1 {
		damage_to_enemy(10,5,5*bol_hit.image_xscale,-2,-1)

		if en_health <= 0 {
			state	= en_st.death
			image_index		= 0
			sprite_index	= s_en_00_death
		}
	}
	return (bol_hit && timer[TIMER_DMG]	== -1)
}


